package mizdooni.exceptions;

public class UserNotManager extends Exception {
    public UserNotManager() {
        super("User is not a manager.");
    }
}
