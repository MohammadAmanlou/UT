package ir.ramtung.tinyme.domain.factory;

import ir.ramtung.tinyme.domain.entity.Order;
import ir.ramtung.tinyme.domain.entity.*;

import java.time.LocalDateTime;

public interface OrderFactory {
    Order createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, LocalDateTime entryTime, OrderStatus status, int minimumExecutionQuantity,
            long requestId);

    Order createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, LocalDateTime entryTime, OrderStatus status, int minimumExecutionQuantity);

    Order createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, LocalDateTime entryTime, int minimumExecutionQuantity);

    Order createOrder(long orderId, Security security, Side side, int quantity, int price, Broker broker,
            Shareholder shareholder, int minimumExecutionQuantity);
}
