package ir.ramtung.tinyme.messaging.event;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import ir.ramtung.tinyme.messaging.request.MatchingState;

@Data
@EqualsAndHashCode(callSuper = false)
@AllArgsConstructor
@NoArgsConstructor
public class SecurityStateChangedEvent extends Event {
    private String securityIsin;
    private MatchingState state;
}
