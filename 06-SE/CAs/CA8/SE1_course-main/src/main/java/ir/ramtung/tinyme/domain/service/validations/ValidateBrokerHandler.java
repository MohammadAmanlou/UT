package ir.ramtung.tinyme.domain.service.validations;

import java.util.List;

import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import ir.ramtung.tinyme.repository.BrokerRepository;

class ValidateBrokerHandler extends ValidationHandler {
    private BrokerRepository brokerRepository;

    public ValidateBrokerHandler(BrokerRepository brokerRepository) {
        this.brokerRepository = brokerRepository;
    }

    @Override
    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if (brokerRepository.findBrokerById(request.getBrokerId()) == null)
            errors.add(Message.UNKNOWN_BROKER_ID);
        super.handle(request, errors);
    }
}
