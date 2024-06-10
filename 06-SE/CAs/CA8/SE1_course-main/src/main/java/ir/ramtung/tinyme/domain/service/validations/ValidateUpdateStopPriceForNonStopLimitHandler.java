package ir.ramtung.tinyme.domain.service.validations;

import ir.ramtung.tinyme.domain.entity.Order;
import ir.ramtung.tinyme.domain.entity.StopLimitOrder;
import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;

import java.util.List;

public class ValidateUpdateStopPriceForNonStopLimitHandler extends ValidationHandler {
    private Order order;

    public ValidateUpdateStopPriceForNonStopLimitHandler(Order order) {
        this.order = order;
    }

    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if (!(order instanceof StopLimitOrder) && request.getStopPrice() > 0) {
            errors.add(Message.UPDATING_REJECTED_BECAUSE_IT_IS_NOT_STOP_LIMIT_ORDER);
        }
        super.handle(request, errors);
    }
}
