package ir.ramtung.tinyme.domain.factory;

import ir.ramtung.tinyme.domain.entity.StopLimitOrder;
import ir.ramtung.tinyme.domain.entity.Order;
import ir.ramtung.tinyme.domain.entity.Security;
import ir.ramtung.tinyme.domain.entity.Side;
import ir.ramtung.tinyme.domain.entity.Broker;
import ir.ramtung.tinyme.domain.entity.Shareholder;
import ir.ramtung.tinyme.domain.entity.OrderStatus;

import java.time.LocalDateTime;

public class StopLimitOrderFactory implements OrderFactory {

    @Override
    public StopLimitOrder createOrder(long orderId, Security security, Side side, int quantity, int price,
            Broker broker, Shareholder shareholder, LocalDateTime entryTime, OrderStatus status,
            int minimumExecutionQuantity, long requestId) {
        return new StopLimitOrder(orderId, security, side, quantity, price, broker, shareholder, entryTime,
                minimumExecutionQuantity);
    }

    @Override
    public StopLimitOrder createOrder(long orderId, Security security, Side side, int quantity, int price,
            Broker broker, Shareholder shareholder, LocalDateTime entryTime, OrderStatus status,
            int minimumExecutionQuantity) {
        return new StopLimitOrder(orderId, security, side, quantity, price, broker, shareholder, entryTime,
                minimumExecutionQuantity);
    }

    @Override
    public StopLimitOrder createOrder(long orderId, Security security, Side side, int quantity, int price,
            Broker broker, Shareholder shareholder, LocalDateTime entryTime, int minimumExecutionQuantity) {
        return new StopLimitOrder(orderId, security, side, quantity, price, broker, shareholder, entryTime,
                minimumExecutionQuantity);
    }

    @Override
    public Order createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, int minimumExecutionQuantity) {
        return new Order(orderId, security, side, quantity, price, broker, shareholder, minimumExecutionQuantity);
    }

    public StopLimitOrder createOrder(long orderId, Security security, Side side, int quantity, int price,
            Broker broker, Shareholder shareholder, LocalDateTime entryTime, double stopPrice, OrderStatus status) {
        return new StopLimitOrder(orderId, security, side, quantity, price, broker, shareholder, entryTime, stopPrice,
                status);
    }

    public StopLimitOrder createOrder(long orderId, Security security, Side side, int quantity, int price,
            Broker broker, Shareholder shareholder, LocalDateTime entryTime, double stopPrice) {
        return new StopLimitOrder(orderId, security, side, quantity, price, broker, shareholder, entryTime, stopPrice);
    }

    public StopLimitOrder createOrder(long orderId, Security security, Side side, int quantity, int price,
            Broker broker, Shareholder shareholder, double stopPrice, int minimumExecutionQuantity) {
        return new StopLimitOrder(orderId, security, side, quantity, price, broker, shareholder, stopPrice,
                minimumExecutionQuantity);
    }
}
