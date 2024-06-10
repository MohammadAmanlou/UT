package ir.ramtung.tinyme.domain.service;

import ir.ramtung.tinyme.domain.entity.*;
import ir.ramtung.tinyme.domain.service.validations.ValidateRq;
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

import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderHandler {
    SecurityRepository securityRepository;
    BrokerRepository brokerRepository;
    ShareholderRepository shareholderRepository;
    EventPublisher eventPublisher;
    Matcher matcher;

    public OrderHandler(SecurityRepository securityRepository, BrokerRepository brokerRepository,
            ShareholderRepository shareholderRepository, EventPublisher eventPublisher, Matcher matcher) {
        this.securityRepository = securityRepository;
        this.brokerRepository = brokerRepository;
        this.shareholderRepository = shareholderRepository;
        this.eventPublisher = eventPublisher;
        this.matcher = matcher;
    }

    private boolean isDeleteStopLimitInAuction(Security security, DeleteOrderRq deleteOrderRq) {
        return security.getMatchingState() == MatchingState.AUCTION && security.getOrderBook()
                .findInActiveByOrderId(deleteOrderRq.getSide(), deleteOrderRq.getOrderId()) != null;
    }

    public void handleDeleteOrder(DeleteOrderRq deleteOrderRq) {
        try {
            validateDeleteOrderRq(deleteOrderRq);
            Security security = securityRepository.findSecurityByIsin(deleteOrderRq.getSecurityIsin());
            security.deleteOrder(deleteOrderRq);
            if (isDeleteStopLimitInAuction(security, deleteOrderRq)) {
                publishOrderRejectedEvent(deleteOrderRq, List.of(Message.STOPLIMIT_ORDER_IN_AUCTION_MODE_CANT_REMOVE));
            } else {
                publishOrderDeletedEvent(deleteOrderRq);
            }
            if (security.getMatchingState() == MatchingState.AUCTION) {
                security.updateIndicativeOpeningPrice();
                publishOpeningPriceEvent(security);
            }
        } catch (InvalidRequestException ex) {
            publishOrderRejectedEvent(deleteOrderRq, ex.getReasons());
        }
    }

    public void handleEnterOrder(EnterOrderRq enterOrderRq) {
        try {
            validateOrder(enterOrderRq);
            ProcessOrder(enterOrderRq);
        } catch (InvalidRequestException ex) {
            publishOrderRejectedEvent(enterOrderRq, ex.getReasons());
        }
    }

    public void handleChangeMatchStateRq(ChangeMatchStateRq changeMatchStateRq) {
        Security security = securityRepository.findSecurityByIsin(changeMatchStateRq.getSecurityIsin());
        MatchingState matchingState = changeMatchStateRq.getState();
        MatchResult matchResult = security.ChangeMatchStateRq(matchingState, matcher);

        processMatchStateChange(security, matchResult);
    }

    private void publishEvent(Event event) {
        eventPublisher.publish(event);
    }

    private void publishNotEnoughCredit(EnterOrderRq enterOrderRq) {
        publishEvent(new OrderRejectedEvent(enterOrderRq.getRequestId(), enterOrderRq.getOrderId(),
                List.of(Message.BUYER_HAS_NOT_ENOUGH_CREDIT)));
    }

    private void publishNotEnoughPositions(EnterOrderRq enterOrderRq) {
        publishEvent(new OrderRejectedEvent(enterOrderRq.getRequestId(), enterOrderRq.getOrderId(),
                List.of(Message.SELLER_HAS_NOT_ENOUGH_POSITIONS)));
    }

    private void publishOpeningPriceEvent(Security security) {
        publishEvent(new OpeningPriceEvent(security.getIsin(), security.getIndicativeOpeningPrice(),
                security.getHighestQuantity()));
    }

    private void publishOpeningPriceEvent(Security security, EnterOrderRq enterOrderRq) {
        publishEvent(new OpeningPriceEvent(enterOrderRq.getSecurityIsin(), security.getIndicativeOpeningPrice(),
                security.getHighestQuantity()));
    }

    private void publishOrderAcceptedEvent(EnterOrderRq enterOrderRq) {
        publishEvent(new OrderAcceptedEvent(enterOrderRq.getRequestId(), enterOrderRq.getOrderId()));
    }

    private void publishOrderUpdatedEvent(EnterOrderRq enterOrderRq) {
        eventPublisher.publish(new OrderUpdatedEvent(enterOrderRq.getRequestId(), enterOrderRq.getOrderId()));
    }

    private void publishOrderActivatedEvent(Order order, EnterOrderRq enterOrderRq) {
        eventPublisher.publish(new OrderActivatedEvent(order.getRequestId(), enterOrderRq.getOrderId()));
    }

    private void publishOrderActivatedEvent(Order order) {
        eventPublisher.publish(new OrderActivatedEvent(order.getRequestId(), order.getOrderId()));
    }

    private void publishOrderExecutedEvent(EnterOrderRq enterOrderRq, MatchResult matchResult) {
        publishEvent(new OrderExecutedEvent(enterOrderRq.getRequestId(), enterOrderRq.getOrderId(),
                matchResult.trades().stream().map(TradeDTO::new).collect(Collectors.toList())));
    }

    private void publishOrderExecutedEvent(EnterOrderRq enterOrderRq, Order order, MatchResult matchResult) {
        if (enterOrderRq != null) {
            publishEvent(new OrderExecutedEvent(enterOrderRq.getRequestId(), order.getOrderId(),
                    matchResult.trades().stream().map(TradeDTO::new).collect(Collectors.toList())));
        } else {
            publishEvent(new OrderExecutedEvent(order.getRequestId(), order.getOrderId(),
                    matchResult.trades().stream().map(TradeDTO::new).collect(Collectors.toList())));
        }

    }

    private void publishOrderRejectedEvent(DeleteOrderRq deleteOrderRq, List<String> reasons) {
        eventPublisher
                .publish(new OrderRejectedEvent(deleteOrderRq.getRequestId(), deleteOrderRq.getOrderId(), reasons));
    }

    private void publishOrderRejectedEvent(EnterOrderRq enterOrderRq, List<String> reasons) {
        eventPublisher.publish(new OrderRejectedEvent(enterOrderRq.getRequestId(), enterOrderRq.getOrderId(), reasons));
    }

    private void publishOrderDeletedEvent(DeleteOrderRq deleteOrderRq) {
        eventPublisher.publish(new OrderDeletedEvent(deleteOrderRq.getRequestId(), deleteOrderRq.getOrderId()));
    }

    private void publishTradeEvent(Security security, Trade trade) {
        publishEvent(new TradeEvent(security.getIsin(), trade.getPrice(), trade.getQuantity(),
                trade.getBuy().getOrderId(), trade.getSell().getOrderId()));
    }

    private void publishSecurityStateChangedEvent(Security security, MatchingState matchingState) {
        eventPublisher.publish(new SecurityStateChangedEvent(security.getIsin(), matchingState));
    }

    private void publishEnterOrderRqOutcome(MatchResult matchResult, EnterOrderRq enterOrderRq) {
        switch (matchResult.outcome()) {
            case NOT_ENOUGH_CREDIT:
                publishNotEnoughCredit(enterOrderRq);
                return;
            case NOT_ENOUGH_POSITIONS:
                publishNotEnoughPositions(enterOrderRq);
                return;
            default:
                handleOrder(matchResult, enterOrderRq);
                publishStopPriceOutcome(matchResult, enterOrderRq);
        }
    }

    private void publishStopPriceOutcome(MatchResult matchResult, EnterOrderRq enterOrderRq) {
        if (matchResult.outcome() != MatchingOutcome.INACTIVE_ORDER_ENQUEUED && enterOrderRq.getStopPrice() > 0) {
            publishActivations(matchResult, enterOrderRq);
        }
        publishExecutions(matchResult, enterOrderRq);
    }

    private void publishExecutions(MatchResult matchResult, EnterOrderRq enterOrderRq) {
        if (!matchResult.trades().isEmpty() &&
                securityRepository.findSecurityByIsin(enterOrderRq.getSecurityIsin())
                        .getMatchingState() == MatchingState.CONTINUOUS) {
            publishOrderExecutedEvent(enterOrderRq, matchResult);
        }
    }

    private void publishActivations(MatchResult matchResult, EnterOrderRq enterOrderRq) {
        Security currentSecurity = securityRepository.findSecurityByIsin(enterOrderRq.getSecurityIsin());
        Order order = currentSecurity.getOrderBook().findByOrderId(enterOrderRq.getSide(), enterOrderRq.getOrderId());
        if (order != null) {
            publishOrderActivatedEvent(order, enterOrderRq);
        } else {
            Trade lastTrade = matchResult.trades().getLast();
            Order matchedOrder = currentSecurity.getOrderBook().findByOrderId(lastTrade.getBuy().getSide(),
                    lastTrade.getBuy().getOrderId());
            if (matchedOrder != null) {
                publishOrderActivatedEvent(matchedOrder, enterOrderRq);
            }
        }
    }

    private void handleOrder(MatchResult matchResult, EnterOrderRq enterOrderRq) {
        if (enterOrderRq.getRequestType() == OrderEntryType.NEW_ORDER) {
            handleNewOrder(matchResult, enterOrderRq);
        } else {
            handleOrderUpdate(matchResult, enterOrderRq);
        }
    }

    private void handleNewOrder(MatchResult matchResult, EnterOrderRq enterOrderRq) {
        if (matchResult.outcome() == MatchingOutcome.ORDER_ENQUEUED_IN_AUCTION_MODE) {
            Security currentSecurity = securityRepository.findSecurityByIsin(enterOrderRq.getSecurityIsin());
            publishOpeningPriceEvent(currentSecurity, enterOrderRq);
        }
        publishOrderAcceptedEvent(enterOrderRq);
    }

    private void handleOrderUpdate(MatchResult matchResult, EnterOrderRq enterOrderRq) {
        Security currentSecurity = securityRepository.findSecurityByIsin(enterOrderRq.getSecurityIsin());
        publishOrderUpdatedEvent(enterOrderRq);
        if (currentSecurity.getMatchingState() == MatchingState.AUCTION) {
            currentSecurity.updateIndicativeOpeningPrice();
            publishOpeningPriceEvent(currentSecurity, enterOrderRq);
        }
    }

    private void activateStopLimitOrders(Security security, EnterOrderRq enterOrderRq) {
        if (security.getMatchingState() == MatchingState.CONTINUOUS) {
            execInactiveStopLimitOrders(security, enterOrderRq);
        }
    }

    private void validateOrder(EnterOrderRq enterOrderRq) throws InvalidRequestException {
        ValidateRq validateRq = new ValidateRq(enterOrderRq, securityRepository, brokerRepository,
                shareholderRepository);
        validateRq.validateEnterOrderRq(enterOrderRq);
    }

    private void ProcessOrder(EnterOrderRq enterOrderRq) throws InvalidRequestException {
        Security security = securityRepository.findSecurityByIsin(enterOrderRq.getSecurityIsin());
        Broker broker = brokerRepository.findBrokerById(enterOrderRq.getBrokerId());
        Shareholder shareholder = shareholderRepository.findShareholderById(enterOrderRq.getShareholderId());

        MatchResult matchResult;
        if (enterOrderRq.getRequestType() == OrderEntryType.NEW_ORDER)
            matchResult = security.newOrder(enterOrderRq, broker, shareholder, matcher);
        else
            matchResult = security.updateOrder(enterOrderRq, matcher);

        publishEnterOrderRqOutcome(matchResult, enterOrderRq);
        activateStopLimitOrders(security, enterOrderRq);
    }

    private void execInactiveStopLimitOrders(Security security, EnterOrderRq enterOrderRq) {
        while (true) {
            Order executableOrder = security.getOrderBook().dequeueNextStopLimitOrder(enterOrderRq.getSide());
            if (executableOrder == null) {
                break;
            }
            processExecutableOrder(executableOrder, enterOrderRq);
        }
    }

    private void execInactiveStopLimitOrders(Security security) {
        while (true) {
            Order executableBuyOrder = security.getOrderBook().dequeueNextStopLimitOrder(Side.BUY);
            Order executableSellOrder = security.getOrderBook().dequeueNextStopLimitOrder(Side.SELL);
            if (executableBuyOrder == null && executableSellOrder == null) {
                break;
            }
            if (executableBuyOrder != null) {
                processExecutableOrder(executableBuyOrder, null);
            }
            if (executableSellOrder != null) {
                processExecutableOrder(executableSellOrder, null);
            }
        }
    }

    private void processExecutableOrder(Order executableOrder, EnterOrderRq enterOrderRq) {
        executableOrder.getBroker().increaseCreditBy(executableOrder.getValue());
        MatchResult matchResult = matcher.execute(executableOrder);
        if (matchResult.outcome() != MatchingOutcome.INACTIVE_ORDER_ENQUEUED && executableOrder.getStopPrice() > 0) {
            publishOrderActivatedEvent(executableOrder);
        }
        if (!matchResult.trades().isEmpty()) {
            publishOrderExecutedEvent(enterOrderRq, executableOrder, matchResult);
        }
    }

    private void execInactiveStopLimitOrdersAuction(Security security) {
        while (true) {
            Order executableBuyOrder = security.getOrderBook().dequeueNextStopLimitOrder(Side.BUY);
            Order executableSellOrder = security.getOrderBook().dequeueNextStopLimitOrder(Side.SELL);
            if (executableBuyOrder == null && executableSellOrder == null) {
                break;
            }
            processAuctionOrder(executableBuyOrder, Side.BUY);
            processAuctionOrder(executableSellOrder, Side.SELL);
        }
    }

    private void processAuctionOrder(Order executableOrder, Side side) {
        if (executableOrder != null) {
            if (side == Side.BUY) {
                executableOrder.getBroker().increaseCreditBy(executableOrder.getValue());
            }
            MatchResult matchResult = matcher.auctionAddToQueue(executableOrder);
            if (matchResult.outcome() != MatchingOutcome.INACTIVE_ORDER_ENQUEUED
                    && executableOrder.getStopPrice() > 0) {
                publishOrderActivatedEvent(executableOrder);
            }
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

    private void processMatchStateChange(Security security, MatchResult matchResult) {
        if (security.getMatchingState() == MatchingState.CONTINUOUS) {
            execInactiveStopLimitOrders(security);
        } else {
            execInactiveStopLimitOrdersAuction(security);
        }
        if (matchResult != null) {
            publishOpeningPriceEvent(security);
        }
        if (matchResult != null && !matchResult.trades().isEmpty()) {
            matchResult.trades().forEach(trade -> publishTradeEvent(security, trade));
        }
        publishSecurityStateChangedEvent(security, security.getMatchingState());
    }

}