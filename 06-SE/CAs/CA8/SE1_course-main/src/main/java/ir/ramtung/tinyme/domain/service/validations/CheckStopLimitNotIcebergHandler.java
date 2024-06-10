package ir.ramtung.tinyme.domain.service.validations;

import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;

import java.util.List;

class CheckStopLimitNotIcebergHandler extends ValidationHandler {
    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if ((request.getStopPrice() != 0) && (request.getPeakSize() != 0))
            errors.add(Message.STOP_LIMIT_ORDER_CANT_BE_ICEBERG);
        super.handle(request, errors);
    }
}
