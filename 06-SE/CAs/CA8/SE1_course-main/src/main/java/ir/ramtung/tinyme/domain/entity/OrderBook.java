package ir.ramtung.tinyme.domain.entity;

import lombok.Getter;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.ListIterator;
import java.util.function.Predicate;
import java.util.Iterator;

@Getter
public class OrderBook {
    private final LinkedList<Order> buyQueue;
    private final LinkedList<Order> sellQueue;
    private LinkedList<Order> activeStopLimitOrders;
    private LinkedList<Order> inactiveBuyStopLimitOrders;
    private LinkedList<Order> inactiveSellStopLimitOrders;

    private double lastTradePrice;

    public OrderBook() {
        buyQueue = new LinkedList<>();
        sellQueue = new LinkedList<>();
        activeStopLimitOrders = new LinkedList<>();
        inactiveBuyStopLimitOrders = new LinkedList<>();
        inactiveSellStopLimitOrders = new LinkedList<>();
    }

    private void enqueueOrder(Order order, List<Order> queue) {
        ListIterator<Order> it = queue.listIterator();
        while (it.hasNext()) {
            if (order.queuesBefore(it.next())) {
                it.previous();
                break;
            }
        }
        order.queue();
        it.add(order);
    }

    public void enqueue(Order order) {
        List<Order> queue = getQueue(order.getSide());
        enqueueOrder(order, queue);
    }

    public void stopLimitOrderEnqueue(StopLimitOrder stopLimitOrder) {
        List<Order> queue = getInactiveStopLimitOrdersQueue(stopLimitOrder.getSide());
        enqueueOrder(stopLimitOrder, queue);
    }

    public void activeStopLimitOrderEnqueue(Order stopLimitOrder) {
        enqueueOrder(stopLimitOrder, activeStopLimitOrders);
    }

    public LinkedList<Order> getQueue(Side side) { // changed
        return side == Side.BUY ? buyQueue : sellQueue;
    }

    private LinkedList<Order> getInactiveStopLimitOrdersQueue(Side side) {
        if (side == Side.BUY) {
            return inactiveBuyStopLimitOrders;
        } else {
            return inactiveSellStopLimitOrders;
        }
    }

    public Order findByOrderId(Side side, long orderId) {
        var queue = getQueue(side);
        for (Order order : queue) {
            if (order.getOrderId() == orderId)
                return order;
        }
        return null;
    }

    public Order findInActiveByOrderId(Side side, long orderId) {
        var queue = getInactiveStopLimitOrdersQueue(side);
        for (Order order : queue) {
            if (order.getOrderId() == orderId)
                return order;
        }
        return null;
    }

    public Order dequeueNextStopLimitOrder(Side side) {
        ListIterator<Order> it = getInactiveStopLimitOrdersQueue(side).listIterator();
        if (it.hasNext()) {
            Order order = it.next();
            if (((StopLimitOrder) order).checkActivation(lastTradePrice)) {
                it.remove();
                return order;
            }
        }
        return null;
    }

    public boolean removeByOrderId(Side side, long orderId) {
        var queue = getQueue(side);
        var it = queue.listIterator();
        while (it.hasNext()) {
            if (it.next().getOrderId() == orderId) {
                it.remove();
                return true;
            }
        }
        return false;
    }

    public boolean removeInActiveStopLimitByOrderId(Side side, long orderId) {
        var queue = getInactiveStopLimitOrdersQueue(side);
        var it = queue.listIterator();
        while (it.hasNext()) {
            if (it.next().getOrderId() == orderId) {
                it.remove();
                return true;
            }
        }
        return false;
    }

    public Order matchWithFirst(Order newOrder) {
        var queue = getQueue(newOrder.getSide().opposite());
        if (newOrder.matches(queue.getFirst()))
            return queue.getFirst();
        else
            return null;
    }

    public void putBack(Order order) {
        LinkedList<Order> queue = getQueue(order.getSide());
        order.queue();
        queue.addFirst(order);
    }

    public void restoreSellOrder(Order sellOrder) {
        removeByOrderId(Side.SELL, sellOrder.getOrderId());
        putBack(sellOrder);
    }

    public void restoreBuyOrder(Order buyOrder) {
        removeByOrderId(Side.BUY, buyOrder.getOrderId());
        putBack(buyOrder);
    }

    public boolean hasOrderOfType(Side side) {
        return !getQueue(side).isEmpty();
    }

    public void removeFirst(Side side) {
        getQueue(side).removeFirst();
    }

    private int totalQuantityByShareholder(List<Order> orders, Shareholder shareholder) {
        return orders.stream()
                .filter(order -> order.getShareholder().equals(shareholder))
                .mapToInt(Order::getTotalQuantity)
                .sum();
    }

    public int totalSellQuantityByShareholder(Shareholder shareholder) {
        return totalQuantityByShareholder(sellQueue, shareholder) +
                totalQuantityByShareholder(inactiveSellStopLimitOrders, shareholder);
    }

    public void setLastTradePrice(double lastTradePrice) {
        this.lastTradePrice = lastTradePrice;
    }

    private boolean shouldActivateSellOrder(Order order) {
        return (order.getStopPrice() <= lastTradePrice && order.getSide() == Side.SELL
                && (order instanceof StopLimitOrder));
    }

    private boolean shouldActivateBuyOrder(Order order) {
        return (order.getStopPrice() >= lastTradePrice && order.getSide() == Side.BUY
                && (order instanceof StopLimitOrder));
    }

    public void activateSellStopLimitOrders() {
        Iterator<Order> iterator = inactiveSellStopLimitOrders.iterator();
        while (iterator.hasNext()) {
            Order order = iterator.next();
            if (shouldActivateSellOrder(order)) {
                ((StopLimitOrder) order).setIsActive(true);
                iterator.remove();
                activeStopLimitOrderEnqueue(order);
            }
        }
    }

    public void activateBuyStopLimitOrders() {
        Iterator<Order> iterator = inactiveBuyStopLimitOrders.iterator();
        while (iterator.hasNext()) {
            Order order = iterator.next();
            if (shouldActivateBuyOrder(order)) {
                iterator.remove();
                order.getBroker().increaseCreditBy(order.getPrice() * order.getQuantity());
                ((StopLimitOrder) order).setIsActive(true);
                activeStopLimitOrderEnqueue(order);
            }
        }
    }

    public List<StopLimitOrder> activateStopLimitOrders() {
        List<StopLimitOrder> activatedOrders = new ArrayList<>();
        if (inactiveSellStopLimitOrders.size() > 0)
            activateSellStopLimitOrders();
        if (inactiveBuyStopLimitOrders.size() > 0)
            activateBuyStopLimitOrders();
        return activatedOrders;
    }

    public void enqueueByQueue(Order order, List<Order> queue, Predicate<Order> condition) {
        ListIterator<Order> it = queue.listIterator();
        while (it.hasNext()) {
            Order nexOrder = it.next();
            if (condition.test(nexOrder)) {
                it.previous();
                break;
            }
        }
        order.queue();
        it.add(order);
    }

    public void enqueueInactiveStopLimitOrder(Order order) {
        List<Order> queue = getInactiveStopLimitOrdersQueue(order.getSide());
        Predicate<Order> condition = order::inactiveOrderQueuesBefore;
        enqueueByQueue(order, queue, condition);
    }

    public void enqueueActiveStopLimitOrder(Order order) {
        List<Order> queue = getQueue(order.getSide());
        Predicate<Order> condition = order::inactiveOrderQueuesBefore;
        enqueueByQueue(order, queue, condition);
    }

}
