package mizdooni.database;

import com.fasterxml.jackson.databind.JsonNode;
import mizdooni.model.*;

import java.time.LocalDateTime;
import java.time.LocalTime;

public class DataLoader {
    private Database db;

    public DataLoader(Database database) {
        db = database;
    }

    public void read() {
        readUsers();
        readRestaurants();
        readTables();
        readReviews();
    }

    private void readUsers() {
        JsonNode usersList = JsonReader.readData(JsonReader.File.USERS);
        if (usersList == null) {
            return;
        }

        for (JsonNode node : usersList) {
            String role = node.get("role").asText();
            String country = node.get("address").get("country").asText();
            String city = node.get("address").get("city").asText();
            User user = new User(
                    node.get("username").asText(),
                    node.get("password").asText(),
                    node.get("email").asText(),
                    new Address(country, city, null),
                    User.Role.valueOf(role)
            );
            db.users.add(user);
        }
    }

    private void readRestaurants() {
        JsonNode restaurantsList = JsonReader.readData(JsonReader.File.RESTAURANTS);
        if (restaurantsList == null) {
            return;
        }

        for (JsonNode node : restaurantsList) {
            User manager = getUserByUsername(node.get("managerUsername").asText());

            LocalTime startTime = LocalTime.parse(node.get("startTime").asText());
            LocalTime endTime = LocalTime.parse(node.get("endTime").asText());

            String country = node.get("address").get("country").asText();
            String city = node.get("address").get("city").asText();
            String street = node.get("address").get("street").asText();

            Restaurant restaurant = new Restaurant(
                    node.get("name").asText(),
                    manager,
                    node.get("type").asText(),
                    startTime,
                    endTime,
                    node.get("description").asText(),
                    new Address(country, city, street),
                    node.get("image").asText()
            );
            db.restaurants.add(restaurant);
        }
    }

    private void readTables() {
        JsonNode tablesList = JsonReader.readData(JsonReader.File.TABLES);
        if (tablesList == null) {
            return;
        }

        for (JsonNode node : tablesList) {
            Restaurant restaurant = getRestaurantByName(node.get("restaurantName").asText());

            int tableNumber = node.get("tableNumber").asInt();
            int seatsNumber = node.get("seatsNumber").asInt();
            Table table = new Table(tableNumber, restaurant.getId(), seatsNumber);
            restaurant.addTable(table);
        }
    }

    private void readReviews() {
        JsonNode reviewsList = JsonReader.readData(JsonReader.File.REVIEWS);
        if (reviewsList == null) {
            return;
        }

        for (JsonNode node : reviewsList) {
            Restaurant restaurant = getRestaurantByName(node.get("restaurantName").asText());
            User user = getUserByUsername(node.get("username").asText());

            Rating rating = new Rating();
            rating.food = node.get("foodRate").asDouble();
            rating.service = node.get("serviceRate").asDouble();
            rating.ambiance = node.get("ambianceRate").asDouble();
            rating.overall = node.get("overallRate").asDouble();

            String comment = node.get("comment").asText();
            restaurant.addReview(new Review(user, rating, comment, LocalDateTime.now()));
        }
    }

    private User getUserByUsername(String username) {
        return db.users.stream().filter(u -> u.getUsername().equals(username)).findFirst().orElse(null);
    }

    private Restaurant getRestaurantByName(String name) {
        return db.restaurants.stream().filter(r -> r.getName().equals(name)).findFirst().orElse(null);
    }
}
