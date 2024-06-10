package ir.ramtung.tinyme.domain.service.validations;

import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;

import java.util.List;

class CheckStopLimitZeroMEQHandler extends ValidationHandler {
    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if ((request.getStopPrice() != 0) && (request.getMinimumExecutionQuantity() != 0))
            errors.add(Message.STOP_LIMIT_ORDER_CANT_MEQ);
        super.handle(request, errors);
    }
}
