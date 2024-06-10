package ir.ramtung.tinyme.domain.service.validations;

import ir.ramtung.tinyme.domain.entity.Order;
import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;

import java.util.List;

public class ValidateUpdateMEQHandler extends ValidationHandler {
    private Order order;

    public ValidateUpdateMEQHandler(Order order) {
        this.order = order;
    }

    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if (order.getMinimumExecutionQuantity() != request.getMinimumExecutionQuantity()) {
            errors.add(Message.CAN_NOT_UPDATE_ORDER_MINIMUM_EXECUTION_QUANTITY);
        }
        super.handle(request, errors);
    }
}
