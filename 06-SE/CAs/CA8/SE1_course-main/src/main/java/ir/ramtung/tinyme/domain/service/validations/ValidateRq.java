package ir.ramtung.tinyme.domain.service.validations;

import ir.ramtung.tinyme.domain.entity.*;
import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.DeleteOrderRq;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import ir.ramtung.tinyme.repository.BrokerRepository;
import ir.ramtung.tinyme.repository.SecurityRepository;
import ir.ramtung.tinyme.repository.ShareholderRepository;

import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;

@Service
public class ValidateRq {
    EnterOrderRq request;
    List<String> errors;
    SecurityRepository securityRepository;
    BrokerRepository brokerRepository;
    ShareholderRepository shareholderRepository;

    public ValidateRq(EnterOrderRq request, SecurityRepository securityRepository, BrokerRepository brokerRepository,
            ShareholderRepository shareholderRepository) {
        this.request = request;
        this.errors = new LinkedList<>();
        this.securityRepository = securityRepository;
        this.brokerRepository = brokerRepository;
        this.shareholderRepository = shareholderRepository;
    }

    private ValidationHandler createValidationChain() {
        ValidationHandler checkPositivityHandler = new CheckPositivityHandler();
        ValidationHandler checkMEQLessThanQuantityHandler = new CheckMEQLessThanQuantityHandler();
        ValidationHandler checkStopLimitNotIcebergHandler = new CheckStopLimitNotIcebergHandler();
        ValidationHandler checkPeakSizeHandler = new CheckPeakSizeHandler();
        ValidationHandler checkStopLimitZeroMEQHandler = new CheckStopLimitZeroMEQHandler();
        ValidationHandler validateSecurityHandler = new ValidateSecurityHandler(securityRepository);
        ValidationHandler validateBrokerHandler = new ValidateBrokerHandler(brokerRepository);
        ValidationHandler validateShareholderHandler = new ValidateShareholderHandler(shareholderRepository);

        checkPositivityHandler.setNext(checkMEQLessThanQuantityHandler);
        checkMEQLessThanQuantityHandler.setNext(checkStopLimitNotIcebergHandler);
        checkStopLimitNotIcebergHandler.setNext(checkPeakSizeHandler);
        checkPeakSizeHandler.setNext(checkStopLimitZeroMEQHandler);
        checkStopLimitZeroMEQHandler.setNext(validateSecurityHandler);
        validateSecurityHandler.setNext(validateBrokerHandler);
        validateBrokerHandler.setNext(validateShareholderHandler);

        return checkPositivityHandler; // Return the first handler in the chain
    }

    public void validateEnterOrderRq(EnterOrderRq enterOrderRq) throws InvalidRequestException {
        try {
            ValidationHandler validationChain = createValidationChain();
            validationChain.handle(enterOrderRq, errors);

            if (!errors.isEmpty()) {
                throw new InvalidRequestException(errors);
            }
        } catch (InvalidRequestException ex) {
            throw ex;
        }
    }

    public void validateDeleteOrderRq(DeleteOrderRq deleteOrderRq) throws InvalidRequestException {
        if (deleteOrderRq.getOrderId() <= 0)
            errors.add(Message.INVALID_ORDER_ID);
        if (securityRepository.findSecurityByIsin(deleteOrderRq.getSecurityIsin()) == null)
            errors.add(Message.UNKNOWN_SECURITY_ISIN);
        if (!errors.isEmpty())
            throw new InvalidRequestException(errors);
    }

    private ValidationHandler createUpdateValidationChain(Order order, OrderBook orderBook) {
        ValidationHandler validateInvalidUpdatePeakSizeHandler = new ValidateInvalidUpdatePeakSizeHandler(order);
        ValidationHandler validateNonIcebergHavingPeakSizeHandler = new ValidateNonIcebergHavingPeakSizeHandler(order);
        ValidationHandler validateUpdateActiveStopLimitHandler = new ValidateUpdateActiveStopLimitHandler(order,
                orderBook);
        ValidationHandler validateUpdateStopPriceForNonStopLimitHandler = new ValidateUpdateStopPriceForNonStopLimitHandler(
                order);
        ValidationHandler validateZeroStopPriceForStopLimitHandler = new ValidateZeroStopPriceForStopLimitHandler(
                order);
        ValidationHandler validateStopLimitHaveMEQHandler = new ValidateStopLimitHaveMEQHandler(order);
        ValidationHandler validateStopLimitBeIcebergHandler = new ValidateStopLimitBeIcebergHandler(order);
        ValidationHandler validateUpdateMEQHandler = new ValidateUpdateMEQHandler(order);

        validateInvalidUpdatePeakSizeHandler.setNext(validateNonIcebergHavingPeakSizeHandler);
        validateNonIcebergHavingPeakSizeHandler.setNext(validateUpdateActiveStopLimitHandler);
        validateUpdateActiveStopLimitHandler.setNext(validateUpdateStopPriceForNonStopLimitHandler);
        validateUpdateStopPriceForNonStopLimitHandler.setNext(validateZeroStopPriceForStopLimitHandler);
        validateZeroStopPriceForStopLimitHandler.setNext(validateStopLimitHaveMEQHandler);
        validateStopLimitHaveMEQHandler.setNext(validateStopLimitBeIcebergHandler);
        validateStopLimitBeIcebergHandler.setNext(validateUpdateMEQHandler);

        return validateInvalidUpdatePeakSizeHandler; // Return the first handler in the update chain
    }

    public void validateUpdateOrderRq(Order order, EnterOrderRq updateOrderRq, OrderBook orderBook)
            throws InvalidRequestException {
        try {
            ValidationHandler updateValidationChain = createUpdateValidationChain(order, orderBook);
            updateValidationChain.handle(updateOrderRq, errors);

            if (!errors.isEmpty()) {
                throw new InvalidRequestException(errors);
            }
        } catch (InvalidRequestException ex) {
            throw ex;
        }
    }
}
