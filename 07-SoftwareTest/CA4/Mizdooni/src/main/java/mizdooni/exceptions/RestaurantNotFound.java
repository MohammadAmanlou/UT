package mizdooni.exceptions;

public class RestaurantNotFound extends Exception {
    public RestaurantNotFound() {
        super("Restaurant not found.");
    }
}
