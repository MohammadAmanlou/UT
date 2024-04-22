package ir.ramtung.tinyme.domain.entity;

import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.DeleteOrderRq;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import ir.ramtung.tinyme.domain.service.Matcher;
import ir.ramtung.tinyme.messaging.Message;
import lombok.Builder;
import lombok.Getter;

import java.util.Collections;
import java.util.List;

import org.apache.commons.lang3.ObjectUtils.Null;

import java.util.ArrayList;

@Getter
@Builder
public class Security {
    private String isin;
    @Builder.Default
    private int tickSize = 1;
    @Builder.Default
    private int lotSize = 1;
    @Builder.Default
    private OrderBook orderBook = new OrderBook();
    //private double lastTradePrice;
    @Builder.Default
    private ArrayList<MatchResult> matchResults = new ArrayList<>();

    public List<MatchResult> newOrder(EnterOrderRq enterOrderRq, Broker broker, Shareholder shareholder, Matcher matcher) {

        if (enterOrderRq.getSide() == Side.SELL &&
                !shareholder.hasEnoughPositionsOn(this,
                        orderBook.totalSellQuantityByShareholder(shareholder) + enterOrderRq.getQuantity())) {
            matchResults.add(MatchResult.notEnoughPositions());
            return matchResults;
        }
        long orderValue = enterOrderRq.getPrice() * enterOrderRq.getQuantity();
        if (enterOrderRq.getSide() == Side.BUY && (enterOrderRq.getStopPrice() > 0)) {
            broker.decreaseCreditBy(orderValue);
            if(broker.getCredit() < 0){
                broker.increaseCreditBy(orderValue);
                matchResults.add(MatchResult.notEnoughCredit());
                return matchResults;
            }
        }

        Order order;

        if ((enterOrderRq.getPeakSize() == 0) && (enterOrderRq.getStopPrice() == 0)){
            order = new Order(enterOrderRq.getOrderId(), this, enterOrderRq.getSide(),
                    enterOrderRq.getQuantity(), enterOrderRq.getPrice(), broker, shareholder, enterOrderRq.getEntryTime(), enterOrderRq.getMinimumExecutionQuantity());
        }

        else if (enterOrderRq.getStopPrice() != 0){
            broker.increaseCreditBy(orderValue);
            order = new StopLimitOrder(enterOrderRq.getOrderId(), this, enterOrderRq.getSide(),
                    enterOrderRq.getQuantity(), enterOrderRq.getPrice(), broker, shareholder,
                    enterOrderRq.getEntryTime(), enterOrderRq.getStopPrice() );
        }
        else {
            order = new IcebergOrder(enterOrderRq.getOrderId(), this, enterOrderRq.getSide(),
                    enterOrderRq.getQuantity(), enterOrderRq.getPrice(), broker, shareholder,
                    enterOrderRq.getEntryTime(), enterOrderRq.getPeakSize(), enterOrderRq.getMinimumExecutionQuantity());

        }


        MatchResult matchResult = matcher.execute(order);

        if (matchResult.outcome() == MatchingOutcome.EXECUTED) {
            if(matchResult.getPrice() > 0){
                orderBook.setLastTradePrice(matchResult.getPrice());
            }
            System.out.println(orderBook.getInactiveBuyStopLimitOrders().size() );
            orderBook.activateStopLimitOrders();
            System.out.println(orderBook.getActiveStopLimitOrders().size() );
            processActivatedStopLimitOrders(matcher);
        }

        matchResults.add(matchResult);

        return matchResults;

    }

    public void deleteOrder(DeleteOrderRq deleteOrderRq) throws InvalidRequestException {
        Order order = orderBook.findByOrderId(deleteOrderRq.getSide(), deleteOrderRq.getOrderId());
        if (order == null)
            throw new InvalidRequestException(Message.ORDER_ID_NOT_FOUND);
        if (order.getSide() == Side.BUY)
            order.getBroker().increaseCreditBy(order.getValue());
        orderBook.removeByOrderId(deleteOrderRq.getSide(), deleteOrderRq.getOrderId());
    }

    public List<MatchResult> updateOrder(EnterOrderRq updateOrderRq, Matcher matcher) throws InvalidRequestException {
        Order order = orderBook.findByOrderId(updateOrderRq.getSide(), updateOrderRq.getOrderId());
        if (order == null)
            throw new InvalidRequestException(Message.ORDER_ID_NOT_FOUND);
        if ((order instanceof IcebergOrder) && updateOrderRq.getPeakSize() == 0)
            throw new InvalidRequestException(Message.INVALID_PEAK_SIZE);
        if (!(order instanceof IcebergOrder) && updateOrderRq.getPeakSize() != 0)
            throw new InvalidRequestException(Message.CANNOT_SPECIFY_PEAK_SIZE_FOR_A_NON_ICEBERG_ORDER);
        if ((order instanceof StopLimitOrder) && ((StopLimitOrder) order).getIsActive() == true){ 
            throw new InvalidRequestException(Message.UPDATING_REJECTED_BECAUSE_THE_STOP_LIMIT_ORDER_IS_ACTIVE);
        }
        if ((order instanceof StopLimitOrder) && updateOrderRq.getStopPrice() == 0){
            throw new InvalidRequestException(Message.UPDATING_REJECTED_BECAUSE_IT_IS_NOT_STOP_LIMIT_ORDER);
        }
        if (!(order instanceof StopLimitOrder) && updateOrderRq.getStopPrice() > 0){
            throw new InvalidRequestException(Message.UPDATING_REJECTED_BECAUSE_IT_IS_NOT_STOP_LIMIT_ORDER);
        }
        if ((order instanceof StopLimitOrder) && (updateOrderRq.getMinimumExecutionQuantity() == 0) && (order.getMinimumExecutionQuantity() == 0)){
            throw new InvalidRequestException(Message.STOP_LIMIT_ORDER_CANT_MEQ);
        }
        if ((order instanceof StopLimitOrder) && (updateOrderRq.getPeakSize() != 0) ){
            throw new InvalidRequestException(Message.STOP_LIMIT_ORDER_CANT_ICEBERG);
        }

        if (order.getMinimumExecutionQuantity() != updateOrderRq.getMinimumExecutionQuantity())
            throw new InvalidRequestException(Message.CAN_NOT_UPDATE_ORDER_MINIMUM_EXECUTION_QUANTITY);

        if (updateOrderRq.getSide() == Side.SELL &&
                !order.getShareholder().hasEnoughPositionsOn(this,
                        orderBook.totalSellQuantityByShareholder(order.getShareholder()) - order.getQuantity() + updateOrderRq.getQuantity())) {
            matchResults.add(MatchResult.notEnoughPositions());
            return matchResults;
        }

        boolean losesPriority = order.isQuantityIncreased(updateOrderRq.getQuantity())
                || updateOrderRq.getPrice() != order.getPrice()
                || ((order instanceof IcebergOrder icebergOrder) && (icebergOrder.getPeakSize() < updateOrderRq.getPeakSize()));

        if (updateOrderRq.getSide() == Side.BUY) {
            order.getBroker().increaseCreditBy(order.getValue());
        }
        Order originalOrder = order.snapshot();
        order.updateFromRequest(updateOrderRq);
        if (!losesPriority) {
            if (updateOrderRq.getSide() == Side.BUY) {
                order.getBroker().decreaseCreditBy(order.getValue());
            }
            matchResults.add(MatchResult.executed(null, List.of())); //check
        }
        else
            order.markAsNew();

        orderBook.removeByOrderId(updateOrderRq.getSide(), updateOrderRq.getOrderId());
        MatchResult matchResult = matcher.execute(order);
        if (matchResult.outcome() != MatchingOutcome.EXECUTED) {
            orderBook.enqueue(originalOrder);
            if (updateOrderRq.getSide() == Side.BUY) {
                originalOrder.getBroker().decreaseCreditBy(originalOrder.getValue());
            }
        }
        matchResults.add(MatchResult.notEnoughPositions());
        return matchResults;
    }

    public void processActivatedStopLimitOrders(Matcher matcher) {
        List<StopLimitOrder>activatedOrders = orderBook.getActiveStopLimitOrders();
        for (StopLimitOrder activatedOrder : activatedOrders) {
            //convert the stop limit order to order?
    
            MatchResult matchResult = matcher.execute(activatedOrder);
            activatedOrders.remove(activatedOrder);
            matchResults.add(matchResult);
    
            if (matchResult.outcome() == MatchingOutcome.EXECUTED) {
                orderBook.setLastTradePrice(matchResult.getPrice());
                orderBook.activateStopLimitOrders();
            }
        }
    }
    

}

