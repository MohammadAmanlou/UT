package ir.ramtung.tinyme.domain.entity;

import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

import java.time.LocalDateTime;

@Builder
@EqualsAndHashCode
@ToString
@Getter
public class Order {
    protected long orderId;
    protected Security security;
    protected Side side;
    protected int quantity;
    protected int price;
    protected Broker broker;
    protected Shareholder shareholder;
    @Builder.Default
    protected LocalDateTime entryTime = LocalDateTime.now();
    @Builder.Default
    protected OrderStatus status = OrderStatus.NEW;

    public Order(long orderId, Security security, Side side, int quantity, int price, Broker broker, Shareholder shareholder, LocalDateTime entryTime, OrderStatus status) {
        this.orderId = orderId;
        this.security = security;
        this.side = side;
        this.quantity = quantity;
        this.price = price;
        this.entryTime = entryTime;
        this.broker = broker;
        this.shareholder = shareholder;
        this.status = status;
    }

    public Order(long orderId, Security security, Side side, int quantity, int price, Broker broker, Shareholder shareholder, LocalDateTime entryTime) {
        this.orderId = orderId;
        this.security = security;
        this.side = side;
        this.quantity = quantity;
        this.price = price;
        this.entryTime = entryTime;
        this.broker = broker;
        this.shareholder = shareholder;
        this.status = OrderStatus.NEW;
    }

    public Order(long orderId, Security security, Side side, int quantity, int price, Broker broker, Shareholder shareholder) {
        this(orderId, security, side, quantity, price, broker, shareholder, LocalDateTime.now());
    }

    public Order snapshot() {
        return new Order(orderId, security, side, quantity, price, broker, shareholder, entryTime, OrderStatus.SNAPSHOT);
    }

    public Order snapshotWithQuantity(int newQuantity) {
        return new Order(orderId, security, side, newQuantity, price, broker, shareholder, entryTime, OrderStatus.SNAPSHOT);
    }

    public boolean matches(Order other) {
        if (side == Side.BUY)
            return price >= other.price;
        else
            return price <= other.price;
    }

    public void decreaseQuantity(int amount) {
        if (amount > quantity)
            throw new IllegalArgumentException();
        quantity -= amount;
    }

    public void makeQuantityZero() {
        quantity = 0;
    }

    public boolean queuesBefore(Order order) {
        if (order.getSide() == Side.BUY) {
            return price > order.getPrice();
        } else {
            return price < order.getPrice();
        }
    }

    public void queue() {
        status = OrderStatus.QUEUED;
    }

    public boolean isQuantityIncreased(int newQuantity) {
        return newQuantity > quantity;
    }

    public void updateFromRequest(EnterOrderRq updateOrderRq) {
        quantity = updateOrderRq.getQuantity();
        price = updateOrderRq.getPrice();
    }

    public long getValue() {
        return (long)price * quantity;
    }

    public int getTotalQuantity() { return quantity; }
}
