package mizdooni.exceptions;

public class UserNoAccess extends Exception{
    public UserNoAccess() {
        super("User has no access to this resource.");
    }
}
