package ir.ramtung.tinyme.domain.factory;

import ir.ramtung.tinyme.domain.entity.*;
import ir.ramtung.tinyme.domain.entity.Order;

import java.time.LocalDateTime;

public class GenericOrderFactory implements OrderFactory {

    @Override
    public Order createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, LocalDateTime entryTime, OrderStatus status, int minimumExecutionQuantity,
            long requestId) {
        return new Order(orderId, security, side, quantity, price, broker, shareholder, entryTime, status,
                minimumExecutionQuantity, requestId);
    }

    @Override
    public Order createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, LocalDateTime entryTime, OrderStatus status, int minimumExecutionQuantity) {
        return new Order(orderId, security, side, quantity, price, broker, shareholder, entryTime, status,
                minimumExecutionQuantity);
    }

    @Override
    public Order createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, LocalDateTime entryTime, int minimumExecutionQuantity) {
        return new Order(orderId, security, side, quantity, price, broker, shareholder, entryTime,
                minimumExecutionQuantity);
    }

    @Override
    public Order createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, int minimumExecutionQuantity) {
        return new Order(orderId, security, side, quantity, price, broker, shareholder, minimumExecutionQuantity);
    }
}
