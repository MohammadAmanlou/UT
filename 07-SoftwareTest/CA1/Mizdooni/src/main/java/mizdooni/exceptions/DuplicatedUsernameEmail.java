package mizdooni.exceptions;

public class DuplicatedUsernameEmail extends Exception {
    public DuplicatedUsernameEmail() {
        super("Username or email is already taken.");
    }
}
