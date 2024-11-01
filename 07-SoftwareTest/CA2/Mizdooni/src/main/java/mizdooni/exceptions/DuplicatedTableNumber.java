package mizdooni.exceptions;

public class DuplicatedTableNumber extends Exception {
    public DuplicatedTableNumber() {
        super("Table number is already taken.");
    }
}
