package ir.ramtung.tinyme.domain.service.validations;

import java.util.List;

import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;

class CheckPeakSizeHandler extends ValidationHandler {
    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if (request.getPeakSize() < 0 || request.getPeakSize() >= request.getQuantity())
            errors.add(Message.INVALID_PEAK_SIZE);
        super.handle(request, errors);
    }
}
