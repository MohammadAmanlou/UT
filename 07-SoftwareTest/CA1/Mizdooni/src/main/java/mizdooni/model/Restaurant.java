package mizdooni.model;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class Restaurant {
    private static int idCounter = 0;
    private int id;
    private String name;
    private User manager;
    private String type;
    private LocalTime startTime;
    private LocalTime endTime;
    private String description;
    private Address address;
    private String imageLink;
    private List<Table> tables;
    private List<Review> reviews;

    public Restaurant(String name, User manager, String type, LocalTime startTime, LocalTime endTime,
                      String description, Address address, String imageLink) {
        this.id = idCounter++;
        this.name = name;
        this.manager = manager;
        this.type = type;
        this.startTime = startTime;
        this.endTime = endTime;
        this.description = description;
        this.address = address;
        this.imageLink = imageLink;
        this.tables = new ArrayList<>();
        this.reviews = new ArrayList<>();
    }

    public Table getTable(int tableNumber) {
        return tables.stream().filter(t -> t.getTableNumber() == tableNumber).findFirst().orElse(null);
    }

    public void addTable(Table table) {
        table.setTableNumber(tables.size() + 1);
        tables.add(table);
    }

    public void addReview(Review review) {
        for (Review r : reviews) {
            if (r.getUser().equals(review.getUser())) {
                reviews.remove(r);
                break;
            }
        }
        reviews.add(review);
    }

    public Rating getAverageRating() {
        Rating average = new Rating();

        for (Review r : reviews) {
            average.food += r.getRating().food;
            average.service += r.getRating().service;
            average.ambiance += r.getRating().ambiance;
            average.overall += r.getRating().overall;
        }

        if (!reviews.isEmpty()) {
            average.food /= reviews.size();
            average.service /= reviews.size();
            average.ambiance /= reviews.size();
            average.overall /= reviews.size();
        }

        return average;
    }

    public int getStarCount() {
        return getAverageRating().getStarCount();
    }

    public int getMaxSeatsNumber() {
        return tables.stream().map(Table::getSeatsNumber).max(Integer::compareTo).orElse(1);
    }

    public List<Table> getTables() {
        return tables;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public User getManager() {
        return manager;
    }

    public String getType() {
        return type;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public Address getAddress() {
        return address;
    }

    public List<Review> getReviews() {
        return reviews;
    }
}
