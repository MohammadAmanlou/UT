package ir.ramtung.tinyme.domain.service.validations;

import java.util.List;

import ir.ramtung.tinyme.domain.entity.Security;
import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import ir.ramtung.tinyme.messaging.request.MatchingState;
import ir.ramtung.tinyme.repository.SecurityRepository;

class ValidateSecurityHandler extends ValidationHandler {
    private SecurityRepository securityRepository;

    public ValidateSecurityHandler(SecurityRepository securityRepository) {
        this.securityRepository = securityRepository;
    }

    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        Security security = securityRepository.findSecurityByIsin(request.getSecurityIsin());
        if (security == null) {
            errors.add(Message.UNKNOWN_SECURITY_ISIN);
        } else {
            if (request.getQuantity() % security.getLotSize() != 0)
                errors.add(Message.QUANTITY_NOT_MULTIPLE_OF_LOT_SIZE);
            if (request.getPrice() % security.getTickSize() != 0)
                errors.add(Message.PRICE_NOT_MULTIPLE_OF_TICK_SIZE);
            if (security.getMatchingState() == MatchingState.AUCTION) {
                new CheckAuctionMEQHandler().handle(request, errors);
                new CheckAuctionStopLimitHandler().handle(request, errors);
            }
        }
        super.handle(request, errors);
    }
}
