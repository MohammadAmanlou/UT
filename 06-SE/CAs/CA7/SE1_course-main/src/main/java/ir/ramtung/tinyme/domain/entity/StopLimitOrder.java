package ir.ramtung.tinyme.domain.entity;

import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Setter
@Getter
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class StopLimitOrder extends Order {
    double stopPrice ;
    Boolean isActive ;

    public StopLimitOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker, Shareholder shareholder, LocalDateTime entryTime, double stopPrice, OrderStatus status) {
        super(orderId, security, side, quantity, price, broker, shareholder, entryTime, status , 0);
        this.stopPrice = stopPrice;
        this.isActive = false ; 
    }

    public StopLimitOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker, Shareholder shareholder, LocalDateTime entryTime, double stopPrice) {
        this(orderId, security, side, quantity, price, broker, shareholder, entryTime, stopPrice, OrderStatus.NEW);
        this.isActive = false ; 
    }

    public StopLimitOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker, Shareholder shareholder, double stopPrice, int minimumExecutionQuantity) {
        super(orderId, security, side, quantity, price, broker, shareholder, minimumExecutionQuantity);
        this.stopPrice = stopPrice;
        this.isActive = false ; 
    }

    @Override
    public Order snapshot() {
        return new StopLimitOrder(orderId, security, side, quantity, price, broker, shareholder, entryTime, stopPrice, OrderStatus.SNAPSHOT);
    }

    @Override
    public Order snapshotWithQuantity(int newQuantity) {
        return new StopLimitOrder(orderId, security, side, newQuantity, price, broker, shareholder, entryTime, stopPrice, OrderStatus.SNAPSHOT);
    }

    @Override
    public void queue() {
        if (isActive)
            super.queue();
        else 
            return ;
    }

    @Override
    public boolean queuesBefore(Order order) {
        if (order.getSide() == Side.BUY) {
            return price > stopPrice;
        } 
        else {
            return price < stopPrice;
        }
    }

    public boolean queuesBefore(StopLimitOrder order) {
        if (order.getSide() == Side.BUY) {
            return order.getStopPrice() < stopPrice;
        } 
        else {
            return order.getStopPrice() > stopPrice;
        }
    }

    public boolean checkActivation(double lastTradePrice){
        if(side == Side.SELL){
            return lastTradePrice <= stopPrice;
        }
        else{
            return lastTradePrice >= stopPrice;
        }
    }
}
