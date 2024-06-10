package ir.ramtung.tinyme.domain.factory;

import ir.ramtung.tinyme.domain.entity.*;
import ir.ramtung.tinyme.domain.entity.IcebergOrder;
import ir.ramtung.tinyme.domain.entity.Order;

import java.time.LocalDateTime;

public class IcebergOrderFactory implements OrderFactory {

    @Override
    public Order createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, LocalDateTime entryTime, OrderStatus status, int minimumExecutionQuantity,
            long requestId) {
        return new Order(orderId, security, side, quantity, price, broker, shareholder, entryTime,
                minimumExecutionQuantity);
    }

    @Override
    public Order createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, LocalDateTime entryTime, OrderStatus status, int minimumExecutionQuantity) {
        return new Order(orderId, security, side, quantity, price, broker, shareholder, entryTime,
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

    public IcebergOrder createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, LocalDateTime entryTime, int peakSize, int displayedQuantity, OrderStatus status,
            int minimumExecutionQuantity) {
        return new IcebergOrder(orderId, security, side, quantity, price, broker, shareholder, entryTime, peakSize,
                displayedQuantity, status, minimumExecutionQuantity);
    }

    public IcebergOrder createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, LocalDateTime entryTime, int peakSize, OrderStatus status,
            int minimumExecutionQuantity) {
        return new IcebergOrder(orderId, security, side, quantity, price, broker, shareholder, entryTime, peakSize,
                status, minimumExecutionQuantity);
    }

    public IcebergOrder createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, LocalDateTime entryTime, int peakSize, int minimumExecutionQuantity) {
        return new IcebergOrder(orderId, security, side, quantity, price, broker, shareholder, entryTime, peakSize,
                minimumExecutionQuantity);
    }

    public IcebergOrder createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, int peakSize, int minimumExecutionQuantity) {
        return new IcebergOrder(orderId, security, side, quantity, price, broker, shareholder, peakSize,
                minimumExecutionQuantity);
    }
}
