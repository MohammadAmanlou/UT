package ir.ramtung.tinyme.domain.service.validations;

import ir.ramtung.tinyme.domain.entity.Order;
import ir.ramtung.tinyme.domain.entity.StopLimitOrder;
import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;

import java.util.List;

public class ValidateStopLimitHaveMEQHandler extends ValidationHandler {
    private Order order;

    public ValidateStopLimitHaveMEQHandler(Order order) {
        this.order = order;
    }

    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if ((order instanceof StopLimitOrder) && (request.getMinimumExecutionQuantity() != 0)
                && (order.getMinimumExecutionQuantity() == 0)) {
            errors.add(Message.STOP_LIMIT_ORDER_CANT_MEQ);
        }
        super.handle(request, errors);
    }
}
