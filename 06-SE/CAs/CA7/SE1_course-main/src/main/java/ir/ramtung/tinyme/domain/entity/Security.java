package ir.ramtung.tinyme.domain.entity;

import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.DeleteOrderRq;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import ir.ramtung.tinyme.domain.service.Matcher;
import ir.ramtung.tinyme.messaging.Message;
import lombok.Builder;
import lombok.Getter;
import ir.ramtung.tinyme.messaging.request.MatchingState;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedList;
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
    @Builder.Default
    private MatchingState matchingState = MatchingState.CONTINUOUS;
    @Builder.Default
    private int indicativeOpeningPrice = 0 ; ///best auction price
    @Builder.Default
    private int highestQuantity = 0;



    private boolean checkPosition(EnterOrderRq enterOrderRq , Shareholder shareholder){
        if (enterOrderRq.getSide() == Side.SELL &&
                !shareholder.hasEnoughPositionsOn(this,
                        orderBook.totalSellQuantityByShareholder(shareholder) + enterOrderRq.getQuantity())) {
            return false;
        }
        else{
            return true;
        }
    }

    public MatchResult newOrder(EnterOrderRq enterOrderRq, Broker broker, Shareholder shareholder, Matcher matcher) {
        if(!checkPosition(enterOrderRq, shareholder)){
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
            order.setRequestId(enterOrderRq.getRequestId());
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

        if(matchingState == MatchingState.CONTINUOUS){
            MatchResult matchResult = matcher.execute(order);
            return matchResult;
        }
        else {
            MatchResult matchResult = matcher.auctionAddToQueue(order);
            return matchResult;
        }
        
        
    }

    public void deleteOrder(DeleteOrderRq deleteOrderRq) throws InvalidRequestException {
        Order order = orderBook.findByOrderId(deleteOrderRq.getSide(), deleteOrderRq.getOrderId());
        if (order == null) {
            order = orderBook.findInActiveByOrderId(deleteOrderRq.getSide() , deleteOrderRq.getOrderId());
        }
        if (order == null)
            throw new InvalidRequestException(Message.ORDER_ID_NOT_FOUND);
        if (order.getSide() == Side.BUY )
            order.getBroker().increaseCreditBy(order.getValue());
        if (!orderBook.removeByOrderId(deleteOrderRq.getSide(), deleteOrderRq.getOrderId())){
            if (matchingState == MatchingState.CONTINUOUS){
                orderBook.removeInActiveStopLimitByOrderId(deleteOrderRq.getSide(), deleteOrderRq.getOrderId());
            }
            else{
                if (order.getSide() == Side.BUY ){
                    order.getBroker().decreaseCreditBy(order.getValue());
                }
            }
            
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
        if(matchingState == MatchingState.CONTINUOUS){
            MatchResult matchResult = matcher.execute(order);
            if (matchResult.outcome() != MatchingOutcome.EXECUTED) {
                orderBook.enqueueActiveStopLimitOrder(originalOrder);
                if (updateOrderRq.getSide() == Side.BUY) {
                    originalOrder.getBroker().decreaseCreditBy(originalOrder.getValue());
                }
            }
            return matchResult;
        }
        else{
            MatchResult matchResult = matcher.auctionAddToQueue(order);
            return matchResult;
        }

    }

    public void processActivatedStopLimitOrders(Matcher matcher) {
        List<Order>activatedOrders = orderBook.getActiveStopLimitOrders();
        for (Order activatedOrder : activatedOrders) {
            //convert the stop limit order to order?
    
            MatchResult matchResult = matcher.execute(activatedOrder);
            activatedOrders.remove(activatedOrder);
            matchResults.add(matchResult);
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

    public MatchResult ChangeMatchStateRq(MatchingState state , Matcher matcher){
        if (state == MatchingState.CONTINUOUS &&  matchingState == MatchingState.AUCTION){
            updateIndicativeOpeningPrice();
            MatchResult matchResult = openingProcess(matcher);
            matchingState =  MatchingState.CONTINUOUS ;
            return matchResult;
        }
        else if (state == MatchingState.AUCTION &&  matchingState == MatchingState.AUCTION){
            updateIndicativeOpeningPrice();
            MatchResult matchResult = openingProcess(matcher);
            matchingState =  MatchingState.AUCTION ;
            return matchResult ;

        }
        else if (state == MatchingState.AUCTION &&  matchingState == MatchingState.CONTINUOUS){
            updateIndicativeOpeningPrice();
            matchingState =  MatchingState.AUCTION ;
            return null;
        }
        else {
            updateIndicativeOpeningPrice();
            matchingState =  MatchingState.CONTINUOUS ;
            return null;
        }
    }

    private MatchResult openingProcess(Matcher matcher){
        updateIndicativeOpeningPrice();
        LinkedList<Trade> trades = new LinkedList<>();
        int max = orderBook.getSellQueue().size();
        for(int i = 0 ; i < max ; i++){
            MatchResult matchResult = matcher.auctionExecute(orderBook.getSellQueue().get(i), indicativeOpeningPrice);
            if (matchResult.trades().size() == 0){
                continue;
            }
            for (Trade trade : matchResult.trades() ){
                trades.add(trade);
            }
        }
        Iterator<Order> sellIterator = orderBook.getSellQueue().iterator();
        while (sellIterator.hasNext()) {
            Order sellOrder = sellIterator.next();
            if (sellOrder.getQuantity() == 0) {
                sellIterator.remove();
            }
        }
        
        Iterator<Order> buyIterator = orderBook.getBuyQueue().iterator();
        while (buyIterator.hasNext()) {
            Order buyOrder = buyIterator.next();
            if (buyOrder.getQuantity() == 0) {
                buyIterator.remove();
            }
        }
        MatchResult matchResult = MatchResult.traded(trades);
        return matchResult;
    }

    private int getTotalQuantityInOrderList(LinkedList <Order> orders){
        int  sumQuantity = 0;
        for (Order order : orders){
            sumQuantity += order.getTotalQuantity();
        }
        return sumQuantity;
    }

    private int findOverallQuantityTraded(int selectedOpenPrice ){
        LinkedList <Order> selectedBuyOrders = new LinkedList<>();
        for (Order order : orderBook.getBuyQueue()){
            if(order.getPrice() >= selectedOpenPrice){
                selectedBuyOrders.add(order);
            }
        }
        LinkedList <Order> selectedSellOrders = new LinkedList<>();
        for (Order order : orderBook.getSellQueue()){
            if(order.getPrice() <= selectedOpenPrice){
                selectedSellOrders.add(order);
            }
        }
        int sumQuantityInSellQueue = getTotalQuantityInOrderList(selectedSellOrders);
        int sumQuantityInBuyQueue = getTotalQuantityInOrderList(selectedBuyOrders);
        return Math.min(sumQuantityInSellQueue , sumQuantityInBuyQueue);
    }

    private int findClosestToLastTradePrice(LinkedList<Integer> openPrices ){
        int minDistance = Integer.MAX_VALUE;
        int minElement = Integer.MAX_VALUE;
        for (int price : openPrices){
            int distance = Math.abs(price - (int)orderBook.getLastTradePrice());
            if(distance < minDistance){
                minDistance = distance;
                minElement = price;
            }
            else if (distance == minDistance && price < minElement){
                minElement = price;
            }
        }
        return minElement;
    }

    public int findBestAuctionPrice(LinkedList <Integer> allOrdersPrices){
        if (allOrdersPrices.size() == 0){
            return 0;
        }
        System.out.println(allOrdersPrices);
        int min = Collections.min(allOrdersPrices);
        int max = Collections.max(allOrdersPrices);
        int maxQuantityTraded = 0;
        LinkedList<Integer> bestOpenPrices = new LinkedList<>();
        for ( int i = min ; i <= max ; i++){
            int overallQuantityTraded = findOverallQuantityTraded(i);
            if(overallQuantityTraded > maxQuantityTraded){
                maxQuantityTraded = overallQuantityTraded;
                bestOpenPrices.clear();
                bestOpenPrices.add(i);
            }
            else if (overallQuantityTraded == maxQuantityTraded && overallQuantityTraded != 0 ){
                bestOpenPrices.add(i);
            }
        }
        highestQuantity = maxQuantityTraded;
        return findClosestToLastTradePrice(bestOpenPrices );
    }

    public int updateIndicativeOpeningPrice( ){
        //if?
        LinkedList <Integer> allOrdersPrices = new LinkedList<>() ;

        for (Order buyOrder : orderBook.getBuyQueue()) {
            allOrdersPrices.add(buyOrder.getPrice());
        }
        for (Order sellOrder : orderBook.getSellQueue()) {
            allOrdersPrices.add(sellOrder.getPrice());
        }
        int bestAuctionPrice = findBestAuctionPrice(allOrdersPrices);
        if (bestAuctionPrice == Integer.MAX_VALUE){
            bestAuctionPrice = 0;
        }
        indicativeOpeningPrice = bestAuctionPrice;
        return bestAuctionPrice;
    }

    
}


