package ir.ramtung.tinyme.messaging.request;


import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
public class ChangeMatchStateRq {

    private String securityIsin;
    private MatchingState state;


    private ChangeMatchStateRq(String securityIsin , MatchingState matchingState ){
        this.securityIsin = securityIsin;
        this.state = matchingState;
    }

    public static ChangeMatchStateRq changeMatchStateRq(String securityIsin , MatchingState matchingState){
        return new ChangeMatchStateRq(securityIsin, matchingState);
    }
}
