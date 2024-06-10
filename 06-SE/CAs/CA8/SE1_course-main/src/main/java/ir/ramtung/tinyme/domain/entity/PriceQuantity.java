package ir.ramtung.tinyme.domain.entity;

public class PriceQuantity {
    private int price;
    private int quantity;

    public PriceQuantity(int price, int quantity) {
        this.price = price;
        this.quantity = quantity;
    }

    public int getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }
}
