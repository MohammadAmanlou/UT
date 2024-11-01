package mizdooni.exceptions;

public class ReservationNotInOpenTimes extends Exception {
    public ReservationNotInOpenTimes() {
        super("Reservation hour is not within restaurant's open times.");
    }
}
