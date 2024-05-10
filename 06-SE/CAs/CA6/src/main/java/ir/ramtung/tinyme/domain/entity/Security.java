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

    public MatchResult newOrder(EnterOrderRq enterOrderRq, Broker broker, Shareholder shareholder, Matcher matcher) {

        if (enterOrderRq.getSide() == Side.SELL &&
                !shareholder.hasEnoughPositionsOn(this,
                        orderBook.totalSellQuantityByShareholder(shareholder) + enterOrderRq.getQuantity())) {
            return MatchResult.notEnoughPositions();
        }
        Order order;

        if ((enterOrderRq.getPeakSize() == 0) && (enterOrderRq.getStopPrice() == 0)){
            order = new Order(enterOrderRq.getOrderId(), this, enterOrderRq.getSide(),
                    enterOrderRq.getQuantity(), enterOrderRq.getPrice(), broker, shareholder, enterOrderRq.getEntryTime(),OrderStatus.NEW ,enterOrderRq.getMinimumExecutionQuantity());
        }
        else if (enterOrderRq.getStopPrice() != 0){
            order = new StopLimitOrder(enterOrderRq.getOrderId(), this, enterOrderRq.getSide(),
                    enterOrderRq.getQuantity(), enterOrderRq.getPrice(), broker, shareholder,
                    enterOrderRq.getEntryTime(), enterOrderRq.getStopPrice() );
            if (!checkOrderPossibility(order)) { //kasif !!!!!!!!!!
                return (order.getSide() == Side.BUY) ? MatchResult.notEnoughCredit() : MatchResult.notEnoughPositions();
            }
            if((order instanceof StopLimitOrder) && !((StopLimitOrder)order).checkActivation(orderBook.getLastTradePrice())){
                return handleInactiveStopLimitOrder(order);
            }
        }
        else {
            order = new IcebergOrder(enterOrderRq.getOrderId(), this, enterOrderRq.getSide(),
                    enterOrderRq.getQuantity(), enterOrderRq.getPrice(), broker, shareholder,
                    enterOrderRq.getEntryTime(), enterOrderRq.getPeakSize(), OrderStatus.NEW,enterOrderRq.getMinimumExecutionQuantity());
        }

        MatchResult matchResult = matcher.execute(order);
        return matchResult;
    }

    public void deleteOrder(DeleteOrderRq deleteOrderRq) throws InvalidRequestException {
        Order order = orderBook.findByOrderId(deleteOrderRq.getSide(), deleteOrderRq.getOrderId());
        if (order == null) {
            order = orderBook.findInActiveByOrderId(deleteOrderRq.getSide() , deleteOrderRq.getOrderId());
        }
        if (order == null)
            throw new InvalidRequestException(Message.ORDER_ID_NOT_FOUND);
        if (order.getSide() == Side.BUY)
            order.getBroker().increaseCreditBy(order.getValue());
        if (!orderBook.removeByOrderId(deleteOrderRq.getSide(), deleteOrderRq.getOrderId())){
            orderBook.removeInActiveStopLimitByOrderId(deleteOrderRq.getSide(), deleteOrderRq.getOrderId());
        }
    }

    private Order getOrderForUpdate(EnterOrderRq upEnterOrderRq) throws InvalidRequestException{
        Order order;
        order = orderBook.findInActiveByOrderId(upEnterOrderRq.getSide(), upEnterOrderRq.getOrderId());
        if (order == null){
            order = orderBook.findByOrderId(upEnterOrderRq.getSide(), upEnterOrderRq.getOrderId());
        }
        if (order == null) {
            throw new InvalidRequestException(Message.ORDER_ID_NOT_FOUND);
        }
        return order;
    }

    public MatchResult updateOrder(EnterOrderRq updateOrderRq, Matcher matcher) throws InvalidRequestException {
        Order order = getOrderForUpdate(updateOrderRq);

        if ((order instanceof IcebergOrder) && updateOrderRq.getPeakSize() == 0)
            throw new InvalidRequestException(Message.INVALID_PEAK_SIZE);
        if (!(order instanceof IcebergOrder) && updateOrderRq.getPeakSize() != 0)
            throw new InvalidRequestException(Message.CANNOT_SPECIFY_PEAK_SIZE_FOR_A_NON_ICEBERG_ORDER);
        if ((order instanceof StopLimitOrder) && (orderBook.findByOrderId(updateOrderRq.getSide(), updateOrderRq.getOrderId()) != null)){ 
            throw new InvalidRequestException(Message.UPDATING_REJECTED_BECAUSE_THE_STOP_LIMIT_ORDER_IS_ACTIVE);
        }
        if ((order instanceof StopLimitOrder) && updateOrderRq.getStopPrice() == 0){
            throw new InvalidRequestException(Message.UPDATING_REJECTED_BECAUSE_IT_IS_NOT_STOP_LIMIT_ORDER);
        }
        if (!(order instanceof StopLimitOrder) && updateOrderRq.getStopPrice() > 0){
            throw new InvalidRequestException(Message.UPDATING_REJECTED_BECAUSE_IT_IS_NOT_STOP_LIMIT_ORDER);
        }
        if ((order instanceof StopLimitOrder) && (updateOrderRq.getMinimumExecutionQuantity() != 0) && (order.getMinimumExecutionQuantity() == 0)){
            throw new InvalidRequestException(Message.STOP_LIMIT_ORDER_CANT_MEQ);
        }
        if ((order instanceof StopLimitOrder) && (updateOrderRq.getPeakSize() != 0) ){
            throw new InvalidRequestException(Message.STOP_LIMIT_ORDER_CANT_BE_ICEBERG);
        }
        if (order.getMinimumExecutionQuantity() != updateOrderRq.getMinimumExecutionQuantity())
            throw new InvalidRequestException(Message.CAN_NOT_UPDATE_ORDER_MINIMUM_EXECUTION_QUANTITY);

        if (updateOrderRq.getSide() == Side.SELL &&
                !order.getShareholder().hasEnoughPositionsOn(this,
                        orderBook.totalSellQuantityByShareholder(order.getShareholder()) - order.getQuantity() + updateOrderRq.getQuantity())) {
            return MatchResult.notEnoughPositions();
        }

        boolean losesPriority = order.isQuantityIncreased(updateOrderRq.getQuantity())
                || updateOrderRq.getPrice() != order.getPrice()
                || ((order instanceof IcebergOrder icebergOrder) && (icebergOrder.getPeakSize() < updateOrderRq.getPeakSize()));

        if (updateOrderRq.getSide() == Side.BUY) {
            order.getBroker().increaseCreditBy(order.getValue());
        }
        Order originalOrder = order.snapshot();
        order.updateFromRequest(updateOrderRq);
        if (!losesPriority && updateOrderRq.getStopPrice() == 0) {
            if (updateOrderRq.getSide() == Side.BUY) {
                order.getBroker().decreaseCreditBy(order.getValue());
            }
            return MatchResult.executed(null, List.of()); //check
        }
        else{
            order.markAsUpdating();
        }
        if (updateOrderRq.getStopPrice() > 0){
            orderBook.removeInActiveStopLimitByOrderId(updateOrderRq.getSide(), updateOrderRq.getOrderId());
            if(!((StopLimitOrder)order).checkActivation(orderBook.getLastTradePrice())){
                return handleInactiveStopLimitOrder(order);
            }
        }
        else{
            orderBook.removeByOrderId(updateOrderRq.getSide(), updateOrderRq.getOrderId());
        }

        MatchResult matchResult = matcher.execute(order);
        if (matchResult.outcome() != MatchingOutcome.EXECUTED) {
            orderBook.enqueueActiveStopLimitOrder(originalOrder);
            if (updateOrderRq.getSide() == Side.BUY) {
                originalOrder.getBroker().decreaseCreditBy(originalOrder.getValue());
            }
        }
        return matchResult;
    }

    public void processActivatedStopLimitOrders(Matcher matcher) {
        List<Order>activatedOrders = orderBook.getActiveStopLimitOrders();
        for (Order activatedOrder : activatedOrders) {
            //convert the stop limit order to order?
    
            MatchResult matchResult = matcher.execute(activatedOrder);
            activatedOrders.remove(activatedOrder);
            matchResults.add(matchResult);
    
            // if (matchResult.outcome() == MatchingOutcome.EXECUTED) {
            //     if (matchResult.getPrice() > 0){
            //         orderBook.setLastTradePrice(matchResult.getPrice());
            //         orderBook.activateStopLimitOrders();
            //     }


            //}
        }
    }

    public boolean checkOrderPossibility(Order order){
        if(order.getSide() == Side.BUY){
            return order.getBroker().hasEnoughCredit(order.getValue());
        }
        else{
            return order.getShareholder().hasEnoughPositionsOn(order.getSecurity(), order.getQuantity());
        }
    }
    
    private MatchResult handleInactiveStopLimitOrder(Order order){
        if(order.getSide()==Side.BUY){
            order.getBroker().decreaseCreditBy(order.getValue());
        }
        orderBook.enqueueInactiveStopLimitOrder(order);
        return MatchResult.inactiveOrderEnqueued();
    }

}

