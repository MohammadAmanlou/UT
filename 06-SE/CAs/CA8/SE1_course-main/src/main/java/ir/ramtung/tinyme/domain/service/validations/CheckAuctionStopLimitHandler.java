package ir.ramtung.tinyme.domain.service.validations;

import java.util.List;

import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import ir.ramtung.tinyme.messaging.request.OrderEntryType;

class CheckAuctionStopLimitHandler extends ValidationHandler {
    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if (request.getStopPrice() > 0) {
            if (request.getRequestType() == OrderEntryType.NEW_ORDER) {
                errors.add(Message.STOPLIMIT_ORDER_IN_AUCTION_MODE_ERROR);
            } else {
                errors.add(Message.STOPLIMIT_ORDER_IN_AUCTION_MODE_CANT_UPDATE);
            }
        }
        super.handle(request, errors);
    }
}
