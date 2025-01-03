package mizdooni.exceptions;

public class InvalidReviewRating extends Exception {
    private String parameter;

    public InvalidReviewRating(String parameter) {
        super("Review rating parameter <" + parameter + "> out of range.");
        this.parameter = parameter;
    }

    public String getParameter() {
        return parameter;
    }
}
