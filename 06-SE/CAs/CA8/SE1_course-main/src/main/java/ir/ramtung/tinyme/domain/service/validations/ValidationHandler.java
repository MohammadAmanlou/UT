package ir.ramtung.tinyme.domain.service.validations;

import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;

import java.util.List;

abstract class ValidationHandler {
    protected ValidationHandler next;

    public void setNext(ValidationHandler next) {
        this.next = next;
    }

    public void handle(EnterOrderRq request, List<String> errors) throws InvalidRequestException {
        if (next != null) {
            next.handle(request, errors);
        }
    }
}
