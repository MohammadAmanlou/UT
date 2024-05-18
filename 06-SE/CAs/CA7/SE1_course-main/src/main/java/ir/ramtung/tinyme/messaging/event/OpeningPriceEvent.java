package ir.ramtung.tinyme.messaging.event;

import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper = false)
@AllArgsConstructor
@NoArgsConstructor
public class OpeningPriceEvent extends Event{
    private String securityIsin;
    private int openingPrice;
    private int tradableQuantity;
}
