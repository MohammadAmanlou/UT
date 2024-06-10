package ir.ramtung.tinyme.messaging.request;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@Getter
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class ChangeMatchStateRq extends Request {

    private MatchingState state;

    private ChangeMatchStateRq(String securityIsin, MatchingState matchingState) {
        this.securityIsin = securityIsin;
        this.state = matchingState;
    }

    public static ChangeMatchStateRq changeMatchStateRq(String securityIsin, MatchingState matchingState) {
        return new ChangeMatchStateRq(securityIsin, matchingState);
    }
}
