package ir.ramtung.tinyme.messaging.request;

import ir.ramtung.tinyme.domain.entity.Side;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDateTime;

@Data
@Getter
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@AllArgsConstructor
@NoArgsConstructor
public class DeleteOrderRq extends Request {
    private Side side;
    private long orderId;

    public DeleteOrderRq(long requestId, String securityIsin, Side side, long orderId) {
        this.requestId = requestId;
        this.securityIsin = securityIsin;
        this.side = side;
        this.orderId = orderId;
        this.entryTime = LocalDateTime.now();
    }
}
