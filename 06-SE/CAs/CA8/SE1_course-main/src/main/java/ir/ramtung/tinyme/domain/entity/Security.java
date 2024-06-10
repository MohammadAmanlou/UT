package ir.ramtung.tinyme.domain.entity;

import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.DeleteOrderRq;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import ir.ramtung.tinyme.domain.service.Matcher;
import ir.ramtung.tinyme.domain.service.validations.ValidateRq;
import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.request.MatchingState;
import ir.ramtung.tinyme.domain.factory.*;

import lombok.Builder;
import lombok.Getter;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
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
    @Builder.Default
    private ArrayList<MatchResult> matchResults = new ArrayList<>();
    @Builder.Default
    private MatchingState matchingState = MatchingState.CONTINUOUS;
    @Builder.Default
    private int indicativeOpeningPrice = 0; // Best auction price
    @Builder.Default
    private int highestQuantity = 0;

    private boolean checkPosition(EnterOrderRq enterOrderRq, Shareholder shareholder) {
        if (enterOrderRq.getSide() == Side.SELL &&
                !shareholder.hasEnoughPositionsOn(this,
                        orderBook.totalSellQuantityByShareholder(shareholder) + enterOrderRq.getQuantity())) {
            return false;
        } else {
            return true;
        }
    }

    private Order makeNewOrder(EnterOrderRq enterOrderRq, Broker broker, Shareholder shareholder) {
        OrderFactory factory;
        Order order;

        if (enterOrderRq.getPeakSize() == 0 && enterOrderRq.getStopPrice() == 0) {
            factory = new GenericOrderFactory();
            order = factory.createOrder(enterOrderRq.getOrderId(), this, enterOrderRq.getSide(),
                    enterOrderRq.getQuantity(), enterOrderRq.getPrice(), broker, shareholder,
                    enterOrderRq.getEntryTime(),
                    OrderStatus.NEW, enterOrderRq.getMinimumExecutionQuantity());
        } else if (enterOrderRq.getStopPrice() != 0) {
            factory = new StopLimitOrderFactory();
            order = ((StopLimitOrderFactory) factory).createOrder(enterOrderRq.getOrderId(), this,
                    enterOrderRq.getSide(),
                    enterOrderRq.getQuantity(), enterOrderRq.getPrice(), broker, shareholder,
                    enterOrderRq.getEntryTime(), enterOrderRq.getStopPrice());
            order.setRequestId(enterOrderRq.getRequestId());
        } else {
            factory = new IcebergOrderFactory();
            order = ((IcebergOrderFactory) factory).createOrder(enterOrderRq.getOrderId(), this, enterOrderRq.getSide(),
                    enterOrderRq.getQuantity(), enterOrderRq.getPrice(), broker, shareholder,
                    enterOrderRq.getEntryTime(), enterOrderRq.getPeakSize(), OrderStatus.NEW,
                    enterOrderRq.getMinimumExecutionQuantity());
        }
        return order;
    }

    private MatchResult impossibleStopLimitMatchResult(Order order) {
        return (order.getSide() == Side.BUY) ? MatchResult.notEnoughCredit() : MatchResult.notEnoughPositions();
    }

    private MatchResult processOrder(Order order, Matcher matcher) {
        if (matchingState == MatchingState.CONTINUOUS) {
            return matcher.execute(order);
        } else {
            return matcher.auctionAddToQueue(order);
        }
    }

    public MatchResult newOrder(EnterOrderRq enterOrderRq, Broker broker, Shareholder shareholder, Matcher matcher) {
        if (!checkPosition(enterOrderRq, shareholder)) {
            return MatchResult.notEnoughPositions();
        }
        Order order = makeNewOrder(enterOrderRq, broker, shareholder);
        if (order instanceof StopLimitOrder) {
            if (!checkOrderPossibility(order)) {
                return impossibleStopLimitMatchResult(order);
            }
            if (!((StopLimitOrder) order).checkActivation(orderBook.getLastTradePrice())) {
                return handleInactiveStopLimitOrder(order);
            }
        }
        return processOrder(order, matcher);
    }

    private Order findOrder(DeleteOrderRq deleteOrderRq) throws InvalidRequestException {
        Order order = orderBook.findByOrderId(deleteOrderRq.getSide(), deleteOrderRq.getOrderId());
        if (order == null) {
            order = orderBook.findInActiveByOrderId(deleteOrderRq.getSide(), deleteOrderRq.getOrderId());
            if (order == null) {
                throw new InvalidRequestException(Message.ORDER_ID_NOT_FOUND);
            }
        }
        return order;
    }

    private void handleBuyOrderCredit(Order order) {
        if (order.getSide() == Side.BUY)
            order.getBroker().increaseCreditBy(order.getValue());
    }

    private void decreaseBuyCredit(Order order) {
        if (order.getSide() == Side.BUY) {
            order.getBroker().decreaseCreditBy(order.getValue());
        }
    }

    private void removeOrder(Order order, DeleteOrderRq deleteOrderRq) {
        if (!orderBook.removeByOrderId(deleteOrderRq.getSide(), deleteOrderRq.getOrderId())) {
            if (matchingState == MatchingState.CONTINUOUS) {
                orderBook.removeInActiveStopLimitByOrderId(deleteOrderRq.getSide(), deleteOrderRq.getOrderId());
            } else {
                decreaseBuyCredit(order);
            }
        }
    }

    public void deleteOrder(DeleteOrderRq deleteOrderRq) throws InvalidRequestException {
        Order order = findOrder(deleteOrderRq);
        handleBuyOrderCredit(order);
        removeOrder(order, deleteOrderRq);
    }

    private Order getOrderForUpdate(EnterOrderRq upEnterOrderRq) throws InvalidRequestException {
        Order order = orderBook.findInActiveByOrderId(upEnterOrderRq.getSide(), upEnterOrderRq.getOrderId());
        if (order == null) {
            order = orderBook.findByOrderId(upEnterOrderRq.getSide(), upEnterOrderRq.getOrderId());
            if (order == null) {
                throw new InvalidRequestException(Message.ORDER_ID_NOT_FOUND);
            }
        }
        return order;
    }

    private boolean validateUpdateOrder(Order order, EnterOrderRq updateOrderRq) throws InvalidRequestException {
        ValidateRq validateRq = new ValidateRq(updateOrderRq, null, null, null);
        validateRq.validateUpdateOrderRq(order, updateOrderRq, orderBook);
        return !checkUpdateEnoughPosition(order, updateOrderRq);
    }

    private boolean isLosesPriority(Order order, EnterOrderRq updateOrderRq) {
        return order.isQuantityIncreased(updateOrderRq.getQuantity())
                || updateOrderRq.getPrice() != order.getPrice()
                || ((order instanceof IcebergOrder icebergOrder)
                        && (icebergOrder.getPeakSize() < updateOrderRq.getPeakSize()));
    }

    private boolean checkUpdateEnoughPosition(Order order, EnterOrderRq updateOrderRq) {
        return updateOrderRq.getSide() == Side.SELL &&
                !order.getShareholder().hasEnoughPositionsOn(this,
                        orderBook.totalSellQuantityByShareholder(order.getShareholder()) - order.getQuantity()
                                + updateOrderRq.getQuantity());
    }

    private MatchResult executeActiveOrder(Order order, Order originalOrder, EnterOrderRq updateOrderRq) {
        if (!isLosesPriority(originalOrder, updateOrderRq) && updateOrderRq.getStopPrice() == 0) {
            decreaseBuyCredit(order);
            return MatchResult.executed(null, List.of());
        } else {
            order.markAsUpdating();
            return null;
        }
    }

    private MatchResult removePrevOrder(Order order, Order originalOrder, EnterOrderRq updateOrderRq,
            MatchResult matchResult) {
        if (matchResult == null && updateOrderRq.getStopPrice() > 0) {
            orderBook.removeInActiveStopLimitByOrderId(updateOrderRq.getSide(), updateOrderRq.getOrderId());
            if (!((StopLimitOrder) order).checkActivation(orderBook.getLastTradePrice())) {
                return handleInactiveStopLimitOrder(order);
            }
            return null;
        } else if (matchResult == null) {
            orderBook.removeByOrderId(updateOrderRq.getSide(), updateOrderRq.getOrderId());
            return null;
        } else {
            return matchResult;
        }
    }

    private void enqueueUpdatedOrder(MatchResult matchResult, Order originalOrder) {
        if (matchResult.outcome() != MatchingOutcome.EXECUTED) {
            orderBook.enqueueActiveStopLimitOrder(originalOrder);
            decreaseBuyCredit(originalOrder);
        }
    }

    private MatchResult execUpdatedOrder(MatchResult matchResult, Matcher matcher, Order order, Order originalOrder,
            EnterOrderRq updateOrderRq) {
        if (matchResult == null && matchingState == MatchingState.CONTINUOUS) {
            matchResult = matcher.execute(order);
            enqueueUpdatedOrder(matchResult, originalOrder);
            return matchResult;
        } else if (matchResult == null) {
            matchResult = matcher.auctionAddToQueue(order);
            return matchResult;
        } else {
            return matchResult;
        }
    }

    private MatchResult processUpdatedOrder(Order order, Order originalOrder, EnterOrderRq updateOrderRq,
            Matcher matcher) {
        MatchResult matchResult = executeActiveOrder(order, originalOrder, updateOrderRq);
        matchResult = removePrevOrder(order, originalOrder, updateOrderRq, matchResult);
        matchResult = execUpdatedOrder(matchResult, matcher, order, originalOrder, updateOrderRq);
        return matchResult;
    }

    public MatchResult updateOrder(EnterOrderRq updateOrderRq, Matcher matcher) throws InvalidRequestException {
        Order order = getOrderForUpdate(updateOrderRq);
        if (validateUpdateOrder(order, updateOrderRq)) {
            handleBuyOrderCredit(order);
            Order originalOrder = order.snapshot();
            order.updateFromRequest(updateOrderRq);
            MatchResult matchResult = processUpdatedOrder(order, originalOrder, updateOrderRq, matcher);
            return matchResult;
        } else {
            return MatchResult.notEnoughPositions();
        }
    }

    public void processActivatedStopLimitOrders(Matcher matcher) {
        List<Order> activatedOrders = orderBook.getActiveStopLimitOrders();
        for (Order activatedOrder : activatedOrders) {
            MatchResult matchResult = matcher.execute(activatedOrder);
            activatedOrders.remove(activatedOrder);
            matchResults.add(matchResult);
        }
    }

    public boolean checkOrderPossibility(Order order) {
        if (order.getSide() == Side.BUY) {
            return order.getBroker().hasEnoughCredit(order.getValue());
        } else {
            return order.getShareholder().hasEnoughPositionsOn(order.getSecurity(), order.getQuantity());
        }
    }

    private MatchResult handleInactiveStopLimitOrder(Order order) {
        decreaseBuyCredit(order);
        orderBook.enqueueInactiveStopLimitOrder(order);
        return MatchResult.inactiveOrderEnqueued();
    }

    public MatchResult ChangeMatchStateRq(MatchingState state, Matcher matcher) {
        updateIndicativeOpeningPrice();
        MatchResult matchResult = null;
        if (matchingState == MatchingState.AUCTION) {
            matchResult = openingProcess(matcher);
        }
        matchingState = state;
        return matchResult;
    }

    private LinkedList<Trade> openingSellOrders(Matcher matcher) {
        LinkedList<Trade> trades = new LinkedList<>();
        int sellQueueSize = orderBook.getSellQueue().size();
        for (int i = 0; i < sellQueueSize; i++) {
            MatchResult matchResult = matcher.auctionExecute(orderBook.getSellQueue().get(i), indicativeOpeningPrice);
            if (matchResult.trades().size() == 0) {
                continue;
            }
            trades.addAll(matchResult.trades());
        }
        return trades;
    }

    private void removeTradedSells() {
        Iterator<Order> sellIterator = orderBook.getSellQueue().iterator();
        while (sellIterator.hasNext()) {
            Order sellOrder = sellIterator.next();
            if (sellOrder.getQuantity() == 0) {
                sellIterator.remove();
            }
        }
    }

    private void removeTradedBuys() {
        Iterator<Order> buyIterator = orderBook.getBuyQueue().iterator();
        while (buyIterator.hasNext()) {
            Order buyOrder = buyIterator.next();
            if (buyOrder.getQuantity() == 0) {
                buyIterator.remove();
            }
        }
    }

    private void removeTradedOrders() {
        removeTradedSells();
        removeTradedBuys();
    }

    private MatchResult openingProcess(Matcher matcher) {
        updateIndicativeOpeningPrice();
        LinkedList<Trade> trades = openingSellOrders(matcher);
        removeTradedOrders();
        return MatchResult.traded(trades);
    }

    private int getTotalQuantityInOrderList(LinkedList<Order> orders) {
        int sumQuantity = 0;
        for (Order order : orders) {
            sumQuantity += order.getTotalQuantity();
        }
        return sumQuantity;
    }

    private LinkedList<Order> findBuyOrdersToTrade(int selectedOpenPrice) {
        LinkedList<Order> selectedBuyOrders = new LinkedList<>();
        for (Order order : orderBook.getBuyQueue()) {
            if (order.getPrice() >= selectedOpenPrice) {
                selectedBuyOrders.add(order);
            }
        }
        return selectedBuyOrders;
    }

    private LinkedList<Order> findSellOrdersToTrade(int selectedOpenPrice) {
        LinkedList<Order> selectedSellOrders = new LinkedList<>();
        for (Order order : orderBook.getSellQueue()) {
            if (order.getPrice() <= selectedOpenPrice) {
                selectedSellOrders.add(order);
            }
        }
        return selectedSellOrders;
    }

    private int findOverallQuantityTraded(int selectedOpenPrice) {
        LinkedList<Order> selectedBuyOrders = findBuyOrdersToTrade(selectedOpenPrice);
        LinkedList<Order> selectedSellOrders = findSellOrdersToTrade(selectedOpenPrice);
        int sumQuantityInSellQueue = getTotalQuantityInOrderList(selectedSellOrders);
        int sumQuantityInBuyQueue = getTotalQuantityInOrderList(selectedBuyOrders);
        return Math.min(sumQuantityInSellQueue, sumQuantityInBuyQueue);
    }

    private int findDistanceToLastTradePrice(int price) {
        return Math.abs(price - (int) orderBook.getLastTradePrice());
    }

    private int updateMinDistance(int distance, int minDistance) {
        if (distance < minDistance) {
            minDistance = distance;
        }
        return minDistance;
    }

    private int updateMinElement(int distance, int minDistance, int price, int minElement) {
        if (distance < minDistance) {
            minElement = price;
        } else if (distance == minDistance && price < minElement) {
            minElement = price;
        }
        return minElement;
    }

    private int findClosestToLastTradePrice(LinkedList<Integer> openPrices) {
        int minDistance = Integer.MAX_VALUE;
        int minElement = Integer.MAX_VALUE;
        for (int price : openPrices) {
            int distance = findDistanceToLastTradePrice(price);
            minElement = updateMinElement(distance, minDistance, price, minElement);
            minDistance = updateMinDistance(distance, minDistance);
        }
        return minElement;
    }

    private LinkedList<Integer> findCandidatePrices(int minPrice, int maxPrice) {
        List<PriceQuantity> priceQuantities = calculatePriceQuantities(minPrice, maxPrice);
        return getBestOpenPrices(priceQuantities);
    }

    private List<PriceQuantity> calculatePriceQuantities(int minPrice, int maxPrice) {
        List<PriceQuantity> priceQuantities = new ArrayList<>();
        for (int i = minPrice; i <= maxPrice; i++) {
            int overallQuantityTraded = findOverallQuantityTraded(i);
            priceQuantities.add(new PriceQuantity(i, overallQuantityTraded));
        }
        return priceQuantities;
    }

    private LinkedList<Integer> getBestOpenPrices(List<PriceQuantity> priceQuantities) {
        int maxQuantityTraded = 0;
        LinkedList<Integer> bestOpenPrices = new LinkedList<>();
        for (PriceQuantity pq : priceQuantities) {
            int price = pq.getPrice();
            int quantity = pq.getQuantity();
            if (quantity > maxQuantityTraded) {
                maxQuantityTraded = quantity;
                bestOpenPrices.clear();
                bestOpenPrices.add(price);
            } else if (quantity == maxQuantityTraded && quantity != 0) {
                bestOpenPrices.add(price);
            }
        }
        highestQuantity = maxQuantityTraded;
        return bestOpenPrices;
    }

    public int findBestAuctionPrice(LinkedList<Integer> allOrdersPrices) {
        if (allOrdersPrices.size() != 0) {
            int minPrice = Collections.min(allOrdersPrices);
            int maxPrice = Collections.max(allOrdersPrices);
            LinkedList<Integer> bestOpenPrices = findCandidatePrices(minPrice, maxPrice);
            return findClosestToLastTradePrice(bestOpenPrices);
        }
        return 0;
    }

    public int updateIndicativeOpeningPrice() {
        LinkedList<Integer> allOrdersPrices = gatherAllOrderPrices();
        return setIndicativeOpeningPrice(allOrdersPrices);
    }

    private LinkedList<Integer> gatherAllOrderPrices() {
        LinkedList<Integer> allOrdersPrices = new LinkedList<>();
        gatherPricesFromQueue(orderBook.getBuyQueue(), allOrdersPrices);
        gatherPricesFromQueue(orderBook.getSellQueue(), allOrdersPrices);
        return allOrdersPrices;
    }

    private void gatherPricesFromQueue(LinkedList<Order> queue, LinkedList<Integer> allOrdersPrices) {
        for (Order order : queue) {
            allOrdersPrices.add(order.getPrice());
        }
    }

    private int setIndicativeOpeningPrice(LinkedList<Integer> allOrdersPrices) {
        int bestAuctionPrice = findBestAuctionPrice(allOrdersPrices);
        if (bestAuctionPrice == Integer.MAX_VALUE) {
            bestAuctionPrice = 0;
        }
        indicativeOpeningPrice = bestAuctionPrice;
        return bestAuctionPrice;
    }

}
