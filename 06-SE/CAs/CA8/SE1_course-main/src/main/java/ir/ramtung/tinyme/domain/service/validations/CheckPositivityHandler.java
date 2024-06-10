package ir.ramtung.tinyme.domain.service.validations;

import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;

import java.util.List;

class CheckPositivityHandler extends ValidationHandler {
    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if (request.getOrderId() <= 0)
            errors.add(Message.INVALID_ORDER_ID);
        if (request.getQuantity() <= 0)
            errors.add(Message.ORDER_QUANTITY_NOT_POSITIVE);
        if (request.getPrice() <= 0)
            errors.add(Message.ORDER_PRICE_NOT_POSITIVE);
        if (request.getMinimumExecutionQuantity() < 0)
            errors.add(Message.MINIMUM_EXECUTION_QUANTITY_IS_NEGATIVE);
        super.handle(request, errors);
    }
}
