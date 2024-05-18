package ir.ramtung.tinyme.domain.service;

import ir.ramtung.tinyme.domain.entity.*;
import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.EventPublisher;
import ir.ramtung.tinyme.messaging.TradeDTO;
import ir.ramtung.tinyme.messaging.event.*;
import ir.ramtung.tinyme.messaging.request.ChangeMatchStateRq;
import ir.ramtung.tinyme.messaging.request.DeleteOrderRq;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import ir.ramtung.tinyme.messaging.request.MatchingState;
import ir.ramtung.tinyme.messaging.request.OrderEntryType;
import ir.ramtung.tinyme.repository.BrokerRepository;
import ir.ramtung.tinyme.repository.SecurityRepository;
import ir.ramtung.tinyme.repository.ShareholderRepository;

import org.springframework.boot.availability.ReadinessState;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@Service
public class OrderHandler {
    SecurityRepository securityRepository;
    BrokerRepository brokerRepository;
    ShareholderRepository shareholderRepository;
    EventPublisher eventPublisher;
    Matcher matcher;

    public OrderHandler(SecurityRepository securityRepository, BrokerRepository brokerRepository, ShareholderRepository shareholderRepository, EventPublisher eventPublisher, Matcher matcher) {
        this.securityRepository = securityRepository;
        this.brokerRepository = brokerRepository;
        this.shareholderRepository = shareholderRepository;
        this.eventPublisher = eventPublisher;
        this.matcher = matcher;
    }

    private void publishOutcome(MatchResult matchResult , EnterOrderRq enterOrderRq){
        if (matchResult.outcome() == MatchingOutcome.NOT_ENOUGH_CREDIT) {
            eventPublisher.publish(new OrderRejectedEvent(enterOrderRq.getRequestId(), enterOrderRq.getOrderId(), List.of(Message.BUYER_HAS_NOT_ENOUGH_CREDIT)));
            return;
        }
        if (matchResult.outcome() == MatchingOutcome.NOT_ENOUGH_POSITIONS) {
            eventPublisher.publish(new OrderRejectedEvent(enterOrderRq.getRequestId(), enterOrderRq.getOrderId(), List.of(Message.SELLER_HAS_NOT_ENOUGH_POSITIONS)));
            return;
        }
        if (enterOrderRq.getRequestType() == OrderEntryType.NEW_ORDER){
            if(matchResult.outcome() == MatchingOutcome.ORDER_ENQUEUED_IN_AUCTION_MODE){
                Security currentSecurity = securityRepository.findSecurityByIsin(enterOrderRq.getSecurityIsin());
                eventPublisher.publish(new OpeningPriceEvent(enterOrderRq.getSecurityIsin() ,
                 currentSecurity.getIndicativeOpeningPrice(), currentSecurity.getHighestQuantity()));
            }
            eventPublisher.publish(new OrderAcceptedEvent(enterOrderRq.getRequestId(), enterOrderRq.getOrderId()));
        }
        else{
            Security currentSecurity = securityRepository.findSecurityByIsin(enterOrderRq.getSecurityIsin());
            eventPublisher.publish(new OrderUpdatedEvent(enterOrderRq.getRequestId(), enterOrderRq.getOrderId()));
            if(currentSecurity.getMatchingState() == MatchingState.AUCTION){
                currentSecurity.updateIndicativeOpeningPrice();
                eventPublisher.publish(new OpeningPriceEvent( enterOrderRq.getSecurityIsin() ,
                     currentSecurity.getIndicativeOpeningPrice(), currentSecurity.getHighestQuantity()));
            }
        }
        if (matchResult.outcome() != MatchingOutcome.INACTIVE_ORDER_ENQUEUED && enterOrderRq.getStopPrice() > 0) {
            Security currentSecurity = securityRepository.findSecurityByIsin(enterOrderRq.getSecurityIsin());
            if (currentSecurity.getOrderBook().findByOrderId(enterOrderRq.getSide(), enterOrderRq.getOrderId()) != null){
                eventPublisher.publish(new OrderActivatedEvent(currentSecurity.getOrderBook().findByOrderId(enterOrderRq.getSide(), enterOrderRq.getOrderId()).getRequestId(), enterOrderRq.getOrderId()));
            }
            else if(currentSecurity.getOrderBook().findByOrderId(matchResult.trades().getLast().getBuy().getSide() , matchResult.trades().getLast().getBuy().getOrderId()) != null){
                eventPublisher.publish(new OrderActivatedEvent(matchResult.trades().getLast().getSell().getRequestId(), enterOrderRq.getOrderId()));
            }
            else{
                eventPublisher.publish(new OrderActivatedEvent(matchResult.trades().getLast().getBuy().getRequestId(), enterOrderRq.getOrderId()));
            }
        }
        if (!matchResult.trades().isEmpty() && securityRepository.findSecurityByIsin(enterOrderRq.getSecurityIsin()).getMatchingState() == MatchingState.CONTINUOUS) {
            eventPublisher.publish(new OrderExecutedEvent(enterOrderRq.getRequestId(), enterOrderRq.getOrderId(), matchResult.trades().stream().map(TradeDTO::new).collect(Collectors.toList())));
        }
    }

    public void handleEnterOrder(EnterOrderRq enterOrderRq) {
        try {
            validateEnterOrderRq(enterOrderRq);
            Security security = securityRepository.findSecurityByIsin(enterOrderRq.getSecurityIsin());
            Broker broker = brokerRepository.findBrokerById(enterOrderRq.getBrokerId());
            Shareholder shareholder = shareholderRepository.findShareholderById(enterOrderRq.getShareholderId());

            MatchResult matchResult;

            if (enterOrderRq.getRequestType() == OrderEntryType.NEW_ORDER)
                matchResult = security.newOrder(enterOrderRq, broker, shareholder, matcher);
            else
                matchResult = security.updateOrder(enterOrderRq, matcher);

            publishOutcome(matchResult, enterOrderRq);
            if(security.getMatchingState() == MatchingState.CONTINUOUS){
                execInactiveStopLimitOrders(security , enterOrderRq);
            }
            

        } catch (InvalidRequestException ex) {
            eventPublisher.publish(new OrderRejectedEvent(enterOrderRq.getRequestId(), enterOrderRq.getOrderId(), ex.getReasons()));
        }
    }


    private void execInactiveStopLimitOrders(Security security , EnterOrderRq enterOrderRq){
        while (true) {
            Order executableOrder = security.getOrderBook().dequeueNextStopLimitOrder(enterOrderRq.getSide());
            if(executableOrder == null){
                break;
            }
            if (executableOrder.getSide() == Side.BUY) {
                executableOrder.getBroker().increaseCreditBy(executableOrder.getValue());
            }
            MatchResult matchResult = matcher.execute(executableOrder);
            if(matchResult.outcome() != MatchingOutcome.INACTIVE_ORDER_ENQUEUED && executableOrder.getStopPrice() > 0 ){
                eventPublisher.publish(new OrderActivatedEvent(executableOrder.getRequestId() , executableOrder.getOrderId()));
            }
            if(!matchResult.trades().isEmpty()){
                eventPublisher.publish(new OrderExecutedEvent(enterOrderRq.getRequestId() , executableOrder.getOrderId() , matchResult.trades().stream().map(TradeDTO::new).collect(Collectors.toList())));
            }
        }
    }

    private void execInactiveStopLimitOrders(Security security ){
        while (true) {
            Order executableBuyOrder = security.getOrderBook().dequeueNextStopLimitOrder(Side.BUY);
            Order executableSellOrder = security.getOrderBook().dequeueNextStopLimitOrder(Side.SELL);
            if(executableBuyOrder == null && executableSellOrder == null){
                break;
            }
            if (executableBuyOrder != null) {
                executableBuyOrder.getBroker().increaseCreditBy(executableBuyOrder.getValue());
                MatchResult matchResult = matcher.execute(executableBuyOrder);
                if(matchResult.outcome() != MatchingOutcome.INACTIVE_ORDER_ENQUEUED && executableBuyOrder.getStopPrice() > 0 ){
                    eventPublisher.publish(new OrderActivatedEvent(executableBuyOrder.getRequestId() , executableBuyOrder.getOrderId()));
                }
                if(!matchResult.trades().isEmpty()){
                    eventPublisher.publish(new OrderExecutedEvent(executableBuyOrder.getRequestId() , executableBuyOrder.getOrderId() , matchResult.trades().stream().map(TradeDTO::new).collect(Collectors.toList())));
                }
            }
            else if (executableSellOrder != null) {
                executableSellOrder.getBroker().increaseCreditBy(executableSellOrder.getValue());
                MatchResult matchResult = matcher.execute(executableSellOrder);
                if(matchResult.outcome() != MatchingOutcome.INACTIVE_ORDER_ENQUEUED && executableSellOrder.getStopPrice() > 0 ){
                    eventPublisher.publish(new OrderActivatedEvent(executableSellOrder.getRequestId() , executableSellOrder.getOrderId()));
                }
                if(!matchResult.trades().isEmpty()){
                    eventPublisher.publish(new OrderExecutedEvent(executableSellOrder.getRequestId() , executableSellOrder.getOrderId() , matchResult.trades().stream().map(TradeDTO::new).collect(Collectors.toList())));
                }
            }
            
        }
    }
    private void execInactiveStopLimitOrdersAuction(Security security ){
        while (true) {
            Order executableBuyOrder = security.getOrderBook().dequeueNextStopLimitOrder(Side.BUY);
            Order executableSellOrder = security.getOrderBook().dequeueNextStopLimitOrder(Side.SELL);
            if(executableBuyOrder == null && executableSellOrder == null){
                break;
            }
            if (executableBuyOrder != null) {
                executableBuyOrder.getBroker().increaseCreditBy(executableBuyOrder.getValue());
                MatchResult matchResult = matcher.auctionAddToQueue(executableBuyOrder);
                if(matchResult.outcome() != MatchingOutcome.INACTIVE_ORDER_ENQUEUED && executableBuyOrder.getStopPrice() > 0 ){
                    eventPublisher.publish(new OrderActivatedEvent(executableBuyOrder.getRequestId() , executableBuyOrder.getOrderId()));
                }
            }
            else if (executableSellOrder != null) {
                MatchResult matchResult = matcher.auctionAddToQueue(executableSellOrder);
                if(matchResult.outcome() != MatchingOutcome.INACTIVE_ORDER_ENQUEUED && executableSellOrder.getStopPrice() > 0 ){
                    eventPublisher.publish(new OrderActivatedEvent(executableSellOrder.getRequestId() , executableSellOrder.getOrderId()));
                }
            }
            
        }
    }
    public void handleDeleteOrder(DeleteOrderRq deleteOrderRq) {
        try {
            validateDeleteOrderRq(deleteOrderRq);
            Security security = securityRepository.findSecurityByIsin(deleteOrderRq.getSecurityIsin());
            security.deleteOrder(deleteOrderRq);
            if(security.getMatchingState() == MatchingState.AUCTION && security.getOrderBook().findInActiveByOrderId(deleteOrderRq.getSide(), deleteOrderRq.getOrderId()) != null){
                eventPublisher.publish(new OrderRejectedEvent(2, 200, List.of(Message.STOPLIMIT_ORDER_IN_AUCTION_MODE_CANT_REMOVE)));
            }
            else{
                eventPublisher.publish(new OrderDeletedEvent(deleteOrderRq.getRequestId(), deleteOrderRq.getOrderId()));
            }
            if(security.getMatchingState() == MatchingState.AUCTION){
                security.updateIndicativeOpeningPrice();
                eventPublisher.publish(new OpeningPriceEvent(security.getIsin() , security.getIndicativeOpeningPrice() , security.getHighestQuantity()));
            }
        } catch (InvalidRequestException ex) {
            eventPublisher.publish(new OrderRejectedEvent(deleteOrderRq.getRequestId(), deleteOrderRq.getOrderId(), ex.getReasons()));
        }
    }

    private void validateEnterOrderRq(EnterOrderRq enterOrderRq) throws InvalidRequestException {
        try {
            List<String> errors = new LinkedList<>();
            if (enterOrderRq.getOrderId() <= 0)
                errors.add(Message.INVALID_ORDER_ID);
            if (enterOrderRq.getQuantity() <= 0)
                errors.add(Message.ORDER_QUANTITY_NOT_POSITIVE);
            if (enterOrderRq.getPrice() <= 0)
                errors.add(Message.ORDER_PRICE_NOT_POSITIVE);
            if (enterOrderRq.getMinimumExecutionQuantity() < 0 )
                errors.add(Message.MINIMUM_EXECUTION_QUANTITY_IS_NEGATIVE);
            if (enterOrderRq.getMinimumExecutionQuantity() > enterOrderRq.getQuantity() )
                errors.add(Message.MINIMUM_EXECUTION_QUANTITY_IS_MORE_THAN_QUANTITY);
            if ((enterOrderRq.getStopPrice() != 0) &&  (enterOrderRq.getPeakSize() != 0))
                errors.add(Message.STOP_LIMIT_ORDER_CANT_BE_ICEBERG);
            if ((enterOrderRq.getStopPrice() != 0) &&  (enterOrderRq.getMinimumExecutionQuantity() != 0))
                errors.add(Message.STOP_LIMIT_ORDER_CANT_MEQ);
            
        
            Security security = securityRepository.findSecurityByIsin(enterOrderRq.getSecurityIsin());
            if (security == null){
                errors.add(Message.UNKNOWN_SECURITY_ISIN);
            }
            else {
                if (enterOrderRq.getQuantity() % security.getLotSize() != 0)
                    errors.add(Message.QUANTITY_NOT_MULTIPLE_OF_LOT_SIZE);
                if (enterOrderRq.getPrice() % security.getTickSize() != 0)
                    errors.add(Message.PRICE_NOT_MULTIPLE_OF_TICK_SIZE);
            }
            if (brokerRepository.findBrokerById(enterOrderRq.getBrokerId()) == null)
                errors.add(Message.UNKNOWN_BROKER_ID);
            if (shareholderRepository.findShareholderById(enterOrderRq.getShareholderId()) == null)
                errors.add(Message.UNKNOWN_SHAREHOLDER_ID);
            if (enterOrderRq.getPeakSize() < 0 || enterOrderRq.getPeakSize() >= enterOrderRq.getQuantity())
                errors.add(Message.INVALID_PEAK_SIZE);
            if(security != null && security.getMatchingState() == MatchingState.AUCTION){
                if(enterOrderRq.getMinimumExecutionQuantity() > 0){
                    errors.add(Message.MEQ_IS_PROHIBITED_IN_AUCTION_MODE);
                }
                if(enterOrderRq.getStopPrice() > 0){
                    if (enterOrderRq.getRequestType() == OrderEntryType.NEW_ORDER){
                        errors.add(Message.STOPLIMIT_ORDER_IN_AUCTION_MODE_ERROR);
                    }
                    else{
                        errors.add(Message.STOPLIMIT_ORDER_IN_AUCTION_MODE_CANT_UPDATE);
                    }
                    
                }
            }
            if (!errors.isEmpty())
                throw new InvalidRequestException(errors);
        }
        catch(InvalidRequestException ex){
            throw ex;
        }
        
    }

    private void validateDeleteOrderRq(DeleteOrderRq deleteOrderRq) throws InvalidRequestException {
        List<String> errors = new LinkedList<>();
        if (deleteOrderRq.getOrderId() <= 0)
            errors.add(Message.INVALID_ORDER_ID);
        if (securityRepository.findSecurityByIsin(deleteOrderRq.getSecurityIsin()) == null)
            errors.add(Message.UNKNOWN_SECURITY_ISIN);
        if (!errors.isEmpty())
            throw new InvalidRequestException(errors);
    }



    public void handleChangeMatchStateRq(ChangeMatchStateRq changeMatchStateRq){
       Security security = securityRepository.findSecurityByIsin(changeMatchStateRq.getSecurityIsin());
       MatchingState matchingState = changeMatchStateRq.getState();
       MatchResult matchResult = security.ChangeMatchStateRq(matchingState , matcher);
       if (security.getMatchingState() == MatchingState.CONTINUOUS){
            execInactiveStopLimitOrders(security );
       }
       else {
            execInactiveStopLimitOrdersAuction(security );
       }
       if(matchResult != null){
        eventPublisher.publish(new OpeningPriceEvent(security.getIsin(),security.getIndicativeOpeningPrice() , security.getHighestQuantity() ));
       }
       if (matchResult != null && !matchResult.trades().isEmpty()) {
            for (Trade trade: matchResult.trades()){
                eventPublisher.publish(new TradeEvent(security.getIsin() , trade.getPrice() , trade.getQuantity() , trade.getBuy().getOrderId() , trade.getSell().getOrderId() ));
            }
        }
       eventPublisher.publish(new SecurityStateChangedEvent(security.getIsin() , security.getMatchingState()));
    }
}
