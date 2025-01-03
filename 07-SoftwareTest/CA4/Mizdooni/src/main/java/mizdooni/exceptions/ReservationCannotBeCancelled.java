package mizdooni.exceptions;

public class ReservationCannotBeCancelled extends Exception {
    public ReservationCannotBeCancelled() {
        super("Reservation cannot be cancelled.");
    }
}
