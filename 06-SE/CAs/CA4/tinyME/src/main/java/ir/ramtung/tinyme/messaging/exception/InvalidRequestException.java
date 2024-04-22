package ir.ramtung.tinyme.messaging.exception;

import lombok.Getter;
import lombok.ToString;

import java.util.List;

@ToString
public class InvalidRequestException extends Exception {
    @Getter
    private final List<String> reasons;

    public InvalidRequestException(List<String> reasons) {
        this.reasons = reasons;
    }

    public InvalidRequestException(String reason) {
        this.reasons = List.of(reason);
    }


}
