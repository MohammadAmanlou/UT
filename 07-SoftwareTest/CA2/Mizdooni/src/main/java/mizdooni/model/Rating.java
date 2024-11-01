package mizdooni.model;

public class Rating {
    public double food;
    public double service;
    public double ambiance;
    public double overall;

    public int getStarCount() {
        return (int) Math.min(Math.round(overall), 5);
    }
}
