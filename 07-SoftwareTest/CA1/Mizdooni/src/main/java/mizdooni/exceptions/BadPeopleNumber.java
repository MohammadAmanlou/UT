package mizdooni.exceptions;

public class BadPeopleNumber extends Exception {
    public BadPeopleNumber() {
        super("People number should be positive.");
    }
}
