package ir.ramtung.tinyme.domain.entity;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

@Builder
@Getter
@EqualsAndHashCode
@ToString
public class Trade {
    Security security;
    private int price;
    private int quantity;
    private Order buy;
    private Order sell;

    public Trade(Security security, int price, int quantity, Order order1, Order order2) {
        this.security = security;
        this.price = price;
        this.quantity = quantity;
        Order snapshot1 = order1.snapshot();
        Order snapshot2 = order2.snapshot();
        if (order1.getSide() == Side.BUY) {
            this.buy = snapshot1;
            this.sell = snapshot2;
        } else {
            this.buy = snapshot2;
            this.sell = snapshot1;
        }
    }

    public long getTradedValue() {
        return (long) price * quantity;
    }

    public void increaseSellersCredit() {
        sell.getBroker().increaseCreditBy(getTradedValue());
    }

    public void decreaseBuyersCredit() {
        buy.getBroker().decreaseCreditBy(getTradedValue());
    }

    public boolean buyerHasEnoughCredit() {
        return buy.getBroker().hasEnoughCredit(getTradedValue());
    }

}
