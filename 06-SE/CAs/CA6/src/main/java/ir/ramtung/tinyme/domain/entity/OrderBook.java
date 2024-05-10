package ir.ramtung.tinyme.domain.entity;

import lombok.Getter;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.ListIterator;
import java.util.function.Predicate;
import java.util.Iterator;

import org.apache.commons.lang3.ObjectUtils.Null;

@Getter
public class OrderBook {
    private final LinkedList<Order> buyQueue;
    private final LinkedList<Order> sellQueue;
    private LinkedList<Order> activeStopLimitOrders ;
    private LinkedList<Order> inactiveBuyStopLimitOrders ;
    private LinkedList<Order> inactiveSellStopLimitOrders ;


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
    
    public void stopLimitOrderEnqueue(StopLimitOrder stopLimitOrder){
        List<Order> queue = getInactiveStopLimitOrdersQueue(stopLimitOrder.getSide() ); 
        ListIterator<Order> it = queue.listIterator();
        while (it.hasNext()) {
            if (stopLimitOrder.queuesBefore(it.next())) {
                it.previous();
                break;
            }
        }
        stopLimitOrder.queue();
        it.add(stopLimitOrder);

    }

    public void activeStopLimitOrderEnqueue(Order stopLimitOrder){
        ListIterator<Order> it = activeStopLimitOrders.listIterator();
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

    private LinkedList<Order> getInactiveStopLimitOrdersQueue(Side side){
        if (side == Side.BUY){
            return inactiveBuyStopLimitOrders;
        }
        else {
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

    public Order findInActiveByOrderId(Side side, long orderId){
        var queue = getInactiveStopLimitOrdersQueue(side);
        for (Order order : queue) {
            if (order.getOrderId() == orderId)
                return order;
        }
        return null;
    }

    public Order dequeueNextStopLimitOrder(Side side){
        ListIterator<Order> it = getInactiveStopLimitOrdersQueue(side).listIterator();
        if(it.hasNext()){
            Order order = it.next();
            if(((StopLimitOrder)order).checkActivation(lastTradePrice) ){
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
        Iterator<Order> iterator = inactiveSellStopLimitOrders.iterator();
        while (iterator.hasNext()) {
            Order order = iterator.next();
            if ((order.getStopPrice() <= lastTradePrice && order.getSide() == Side.SELL && (order instanceof StopLimitOrder))) {
                ((StopLimitOrder)order).setIsActive(true);
                iterator.remove();
                activeStopLimitOrderEnqueue(order);
                // /stopLimitOrderEnqueue(order);
                
        
            }
        }
    }

    public void activateBuyStopLimitOrders() {
        Iterator<Order> iterator = inactiveBuyStopLimitOrders.iterator();
        while (iterator.hasNext()) {
            Order order = iterator.next();
            if ((order.getStopPrice() >= lastTradePrice && order.getSide() == Side.BUY  && (order instanceof StopLimitOrder))) {
                iterator.remove(); // Safe removal of the element
                order.getBroker().increaseCreditBy(order.getPrice() * order.getQuantity());
                ((StopLimitOrder)order).setIsActive(true);
                activeStopLimitOrderEnqueue(order);
                //stopLimitOrderEnqueue(order);
                
            }
        }
    }

    public List<StopLimitOrder> activateStopLimitOrders() {

        List<StopLimitOrder> activatedOrders = new ArrayList<>();
        
        if(inactiveSellStopLimitOrders.size() > 0 )
            activateSellStopLimitOrders();
        if(inactiveBuyStopLimitOrders.size() > 0)
            activateBuyStopLimitOrders();

        return activatedOrders;
    }

    public void enqueueByQueue(Order order , List<Order> queue , Predicate<Order> condition){
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

    public void enqueueInactiveStopLimitOrder(Order order){
        List<Order> queue = getInactiveStopLimitOrdersQueue(order.getSide());
        Predicate<Order> condition = order::inactiveOrderQueuesBefore;
        enqueueByQueue(order, queue, condition);
    }

    public void enqueueActiveStopLimitOrder(Order order){
        List<Order> queue = getQueue(order.getSide());
        Predicate<Order> condition = order::inactiveOrderQueuesBefore;
        enqueueByQueue(order, queue, condition);
    }
    
}
