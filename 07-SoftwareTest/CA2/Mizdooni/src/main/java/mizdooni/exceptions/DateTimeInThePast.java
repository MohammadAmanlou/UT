package mizdooni.exceptions;

public class DateTimeInThePast extends Exception {
    public DateTimeInThePast() {
        super("Date time is before current time.");
    }
}
