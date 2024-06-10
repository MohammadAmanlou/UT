package ir.ramtung.tinyme.domain.service.validations;

import java.util.List;

import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;

class CheckMEQLessThanQuantityHandler extends ValidationHandler {
    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if (request.getMinimumExecutionQuantity() > request.getQuantity())
            errors.add(Message.MINIMUM_EXECUTION_QUANTITY_IS_MORE_THAN_QUANTITY);
        super.handle(request, errors);
    }
}
