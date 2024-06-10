package ir.ramtung.tinyme.domain.service.validations;

import ir.ramtung.tinyme.domain.entity.Order;
import ir.ramtung.tinyme.domain.entity.StopLimitOrder;
import ir.ramtung.tinyme.domain.entity.OrderBook;
import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;

import java.util.List;

public class ValidateUpdateActiveStopLimitHandler extends ValidationHandler {
    private Order order;
    private OrderBook orderBook;

    public ValidateUpdateActiveStopLimitHandler(Order order, OrderBook orderBook) {
        this.order = order;
        this.orderBook = orderBook;
    }

    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if ((order instanceof StopLimitOrder)
                && (orderBook.findByOrderId(request.getSide(), request.getOrderId()) != null)) {
            errors.add(Message.UPDATING_REJECTED_BECAUSE_THE_STOP_LIMIT_ORDER_IS_ACTIVE);
        }
        super.handle(request, errors);
    }
}
