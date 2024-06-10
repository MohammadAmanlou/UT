package ir.ramtung.tinyme.domain.service.validations;

import ir.ramtung.tinyme.domain.entity.IcebergOrder;
import ir.ramtung.tinyme.domain.entity.Order;
import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;

import java.util.List;

public class ValidateInvalidUpdatePeakSizeHandler extends ValidationHandler {
    private Order order;

    public ValidateInvalidUpdatePeakSizeHandler(Order order) {
        this.order = order;
    }

    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if ((order instanceof IcebergOrder) && request.getPeakSize() == 0)
            errors.add(Message.INVALID_PEAK_SIZE);
        super.handle(request, errors);
    }
}
