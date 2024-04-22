package ir.ramtung.tinyme.domain.entity;

import lombok.Getter;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.ListIterator;
import java.util.Iterator;

import org.apache.commons.lang3.ObjectUtils.Null;

@Getter
public class OrderBook {
    private final LinkedList<Order> buyQueue;
    private final LinkedList<Order> sellQueue;
    private LinkedList<StopLimitOrder> activeStopLimitOrders ;
    private LinkedList<StopLimitOrder> inactiveBuyStopLimitOrders ;
    private LinkedList<StopLimitOrder> inactiveSellStopLimitOrders ;


    private double lastTradePrice;

    public OrderBook() {
        buyQueue = new LinkedList<>();
        sellQueue = new LinkedList<>();
        activeStopLimitOrders = new LinkedList<>();
        inactiveBuyStopLimitOrders = new LinkedList<>();
        inactiveSellStopLimitOrders = new LinkedList<>();
    }

    public void enqueue(Order order) {
        List<Order> queue = getQueue(order.getSide());
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

    private LinkedList<StopLimitOrder> getStopLimitOrderQueue(Side side, boolean isActive) {
        if (side == Side.BUY && !isActive)
            return inactiveBuyStopLimitOrders;
        if (side == Side.SELL && !isActive)
            return inactiveSellStopLimitOrders;
    
        // If none of the conditions match, return null or an empty list, depending on your requirement
        return new LinkedList<StopLimitOrder>(); // Or return new LinkedList<StopLimitOrder>(); if you prefer an empty list
    }

    public void stopLimitOrderEnqueue(StopLimitOrder stopLimitOrder){
        List<StopLimitOrder> queue = getStopLimitOrderQueue(stopLimitOrder.getSide() , stopLimitOrder.getIsActive()); 
        ListIterator<StopLimitOrder> it = queue.listIterator();
        while (it.hasNext()) {
            if (stopLimitOrder.queuesBefore(it.next())) {
                it.previous();
                break;
            }
        }
        stopLimitOrder.queue();
        it.add(stopLimitOrder);

    }

    public void activeStopLimitOrderEnqueue(StopLimitOrder stopLimitOrder){
        ListIterator<StopLimitOrder> it = activeStopLimitOrders.listIterator();
        while (it.hasNext()) {
            if (stopLimitOrder.queuesBefore(it.next())) {
                it.previous();
                break;
            }
        }
        stopLimitOrder.queue();
        it.add(stopLimitOrder);

    }
    

    private LinkedList<Order> getQueue(Side side) {
        return side == Side.BUY ? buyQueue : sellQueue;
    }

    public Order findByOrderId(Side side, long orderId) {
        var queue = getQueue(side);
        for (Order order : queue) {
            if (order.getOrderId() == orderId)
                return order;
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

    public int totalSellQuantityByShareholder(Shareholder shareholder) {
        return (sellQueue.stream()
                .filter(order -> order.getShareholder().equals(shareholder))
                .mapToInt(Order::getTotalQuantity)
                .sum() + 
                inactiveSellStopLimitOrders.stream()
                .filter(order -> order.getShareholder().equals(shareholder))
                .mapToInt(Order::getTotalQuantity)
                .sum());
    }

    public void setLastTradePrice(double lastTradePrice) {
        this.lastTradePrice = lastTradePrice;
    }

    public void activateSellStopLimitOrders() {
        Iterator<StopLimitOrder> iterator = inactiveSellStopLimitOrders.iterator();
        while (iterator.hasNext()) {
            StopLimitOrder order = iterator.next();
            if ((order.getStopPrice() <= lastTradePrice && order.getSide() == Side.SELL)) {
                iterator.remove();
                order.setIsActive(true);
                activeStopLimitOrderEnqueue(order);
                // /stopLimitOrderEnqueue(order);
                
        
            }
        }
    }

    public void activateBuyStopLimitOrders() {
        Iterator<StopLimitOrder> iterator = inactiveBuyStopLimitOrders.iterator();
        while (iterator.hasNext()) {
            StopLimitOrder order = iterator.next();
            if ((order.getStopPrice() >= lastTradePrice && order.getSide() == Side.BUY)) {
                iterator.remove(); // Safe removal of the element
                order.setIsActive(true);
                System.out.println("my id" );
                System.out.println(order.getOrderId());
                activeStopLimitOrderEnqueue(order);
                //stopLimitOrderEnqueue(order);
                
            }
        }

    }

    public List<StopLimitOrder> activateStopLimitOrders() {

        List<StopLimitOrder> activatedOrders = new ArrayList<>();
        
        
        activateSellStopLimitOrders();
        activateBuyStopLimitOrders();

        return activatedOrders;
    }

    
}
