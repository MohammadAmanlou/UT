package mizdooni.exceptions;

public class InvalidManagerRestaurant extends Exception {
    public InvalidManagerRestaurant() {
        super("The manager is not valid for this restaurant.");
    }
}
