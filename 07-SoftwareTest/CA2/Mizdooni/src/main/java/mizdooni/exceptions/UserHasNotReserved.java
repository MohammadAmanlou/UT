package mizdooni.exceptions;

public class UserHasNotReserved extends Exception{
    public UserHasNotReserved() {
        super("User cannot review a restaurant without reserving a table first.");
    }
}
