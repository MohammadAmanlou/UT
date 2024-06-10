package ir.ramtung.tinyme.domain.service.validations;

import java.util.List;

import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;

class CheckAuctionMEQHandler extends ValidationHandler {
    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if (request.getMinimumExecutionQuantity() > 0) {
            errors.add(Message.MEQ_IS_PROHIBITED_IN_AUCTION_MODE);
        }
        super.handle(request, errors);
    }
}
