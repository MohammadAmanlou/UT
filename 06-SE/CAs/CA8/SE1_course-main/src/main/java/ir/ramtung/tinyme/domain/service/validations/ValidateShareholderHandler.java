package ir.ramtung.tinyme.domain.service.validations;

import java.util.List;

import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import ir.ramtung.tinyme.repository.ShareholderRepository;

class ValidateShareholderHandler extends ValidationHandler {
    private ShareholderRepository shareholderRepository;

    public ValidateShareholderHandler(ShareholderRepository shareholderRepository) {
        this.shareholderRepository = shareholderRepository;
    }

    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if (shareholderRepository.findShareholderById(request.getShareholderId()) == null)
            errors.add(Message.UNKNOWN_SHAREHOLDER_ID);
        super.handle(request, errors);
    }
}
