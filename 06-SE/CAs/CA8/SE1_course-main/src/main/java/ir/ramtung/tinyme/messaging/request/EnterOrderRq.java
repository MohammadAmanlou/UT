package ir.ramtung.tinyme.messaging.request;

import ir.ramtung.tinyme.domain.entity.Side;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;

@Data
@NoArgsConstructor
@Getter
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Component
public class EnterOrderRq extends Request {
    private OrderEntryType requestType;
    private long orderId;
    private Side side;
    private int quantity;
    private int price;
    private long brokerId;
    private long shareholderId;
    private int peakSize;
    private int minimumExecutionQuantity;
    private int stopPrice;

    private EnterOrderRq(OrderEntryType orderEntryType, long requestId, String securityIsin, long orderId,
            LocalDateTime entryTime, Side side,
            int quantity, int price, long brokerId, long shareholderId, int peakSize, int minimumExecutionQuantity) {
        this(orderEntryType, requestId, securityIsin, orderId, entryTime, side, quantity, price, brokerId,
                shareholderId, peakSize, minimumExecutionQuantity, 0);
    }

    private EnterOrderRq(OrderEntryType orderEntryType, long requestId, String securityIsin, long orderId,
            LocalDateTime entryTime, Side side,
            int quantity, int price, long brokerId, long shareholderId, int peakSize, int minimumExecutionQuantity,
            int stopPrice) {
        this.requestType = orderEntryType;
        this.requestId = requestId;
        this.securityIsin = securityIsin;
        this.orderId = orderId;
        this.entryTime = entryTime;
        this.side = side;
        this.quantity = quantity;
        this.price = price;
        this.brokerId = brokerId;
        this.shareholderId = shareholderId;
        this.peakSize = peakSize;
        this.minimumExecutionQuantity = minimumExecutionQuantity;
        this.stopPrice = stopPrice;
    }

    public static EnterOrderRq createNewOrderRq(long requestId, String securityIsin, long orderId,
            LocalDateTime entryTime, Side side, int quantity, int price, long brokerId, long shareholderId,
            int peakSize, int minimumExecutionQuantity) {
        return new EnterOrderRq(OrderEntryType.NEW_ORDER, requestId, securityIsin, orderId, entryTime, side, quantity,
                price, brokerId, shareholderId, peakSize, minimumExecutionQuantity);
    }

    public static EnterOrderRq createUpdateOrderRq(long requestId, String securityIsin, long orderId,
            LocalDateTime entryTime, Side side, int quantity, int price, long brokerId, long shareholderId,
            int peakSize, int minimumExecutionQuantity) {
        return new EnterOrderRq(OrderEntryType.UPDATE_ORDER, requestId, securityIsin, orderId, entryTime, side,
                quantity, price, brokerId, shareholderId, peakSize, minimumExecutionQuantity);
    }

    public static EnterOrderRq createNewOrderRq(long requestId, String securityIsin, long orderId,
            LocalDateTime entryTime, Side side, int quantity, int price, long brokerId, long shareholderId,
            int peakSize, int minimumExecutionQuantity, int stopPrice) {
        return new EnterOrderRq(OrderEntryType.NEW_ORDER, requestId, securityIsin, orderId, entryTime, side, quantity,
                price, brokerId, shareholderId, peakSize, minimumExecutionQuantity, stopPrice);
    }

    public static EnterOrderRq createUpdateOrderRq(long requestId, String securityIsin, long orderId,
            LocalDateTime entryTime, Side side, int quantity, int price, long brokerId, long shareholderId,
            int peakSize, int minimumExecutionQuantity, int stopPrice) {
        return new EnterOrderRq(OrderEntryType.UPDATE_ORDER, requestId, securityIsin, orderId, entryTime, side,
                quantity, price, brokerId, shareholderId, peakSize, minimumExecutionQuantity, stopPrice);
    }

}
