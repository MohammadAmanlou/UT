package mizdooni.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalTime;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Stream;

public class RestaurantTest {

    private Restaurant restaurant;
    private Address address;

    @BeforeEach
    public void setUp() {
        User manager = new User("manager1", "pass123", "manager1@example.com",
                new Address("Country", "City", "Street"), User.Role.manager);
        address = new Address("Country", "City", "Main Street");
        restaurant = new Restaurant("Test Restaurant", manager, "Italian",
                LocalTime.of(9, 0), LocalTime.of(22, 0),
                "Best Italian food", address, "imageLink.jpg");
    }

    @Test
    @DisplayName("Should return existing table with the correct number")
    public void testGetTable() {
        Table table = new Table(1, restaurant.getId(), 4);
        restaurant.addTable(table);

        Table retrievedTable = restaurant.getTable(1);
        assertNotNull(retrievedTable);
        assertEquals(1, retrievedTable.getTableNumber());
    }

    @Test
    @DisplayName("Should return null if table does not exist")
    public void testGetTableReturnsNull() {
        Table retrievedTable = restaurant.getTable(999);
        assertNull(retrievedTable);
    }

    @Test
    @DisplayName("Should correctly add a new table to an empty restaurant")
    public void testAddToEmptyRestaurant() {
        Table firstTable = new Table(0, restaurant.getId(), 4);
        restaurant.addTable(firstTable);

        Table retrievedTable = restaurant.getTable(1);
        List<Table> tables = restaurant.getTables();
        assertEquals(1, tables.size());
        assertNotNull(retrievedTable);
        assertEquals(1, retrievedTable.getTableNumber());
    }

    @Test
    @DisplayName("Should add new tables with correct numbers")
    public void testAddMultipleTables() {
        Table table1 = new Table(0, restaurant.getId(), 4);
        Table table2 = new Table(0, restaurant.getId(), 6);
        restaurant.addTable(table1);
        restaurant.addTable(table2);

        Table retrievedTable1 = restaurant.getTable(1);
        Table retrievedTable2 = restaurant.getTable(2);

        assertNotNull(retrievedTable1);
        assertNotNull(retrievedTable2);
        assertEquals(1, retrievedTable1.getTableNumber());
        assertEquals(2, retrievedTable2.getTableNumber());
    }

    @Test
    @DisplayName("Should correctly add the first review of a user")
    public void testAddNewReview() {
        User user1 = new User("user1", "pass", "user1@example.com", address, User.Role.client);
        Review review1 = new Review(user1, new Rating(), "Great place!", LocalDateTime.now());

        restaurant.addReview(review1);

        List<Review> reviews = restaurant.getReviews();
        assertEquals(1, reviews.size());
        assertEquals(user1, reviews.getFirst().getUser());
    }

    @Test
    @DisplayName("Should replace existing review of a user when adding a new one")
    public void testAddReviewForSameUser() {
        User user1 = new User("user1", "pass", "user1@example.com", address, User.Role.client);

        Rating firstRating = new Rating();
        firstRating.overall = 4.0;
        Review review1 = new Review(user1, firstRating, "Good place", LocalDateTime.now());

        restaurant.addReview(review1);

        Rating secondRating = new Rating();
        secondRating.overall = 5.0;
        Review review2 = new Review(user1, secondRating, "Excellent place", LocalDateTime.now().plusDays(1));

        restaurant.addReview(review2);

        List<Review> reviews = restaurant.getReviews();

        assertEquals(1, reviews.size());
        assertEquals(user1, reviews.getFirst().getUser());
        assertEquals(5.0, reviews.getFirst().getRating().overall);
    }

    @ParameterizedTest
    @MethodSource("provideReviewsAndExpectedAverages")
    @DisplayName("Should correctly calculate average rating")
    void testGetAverageRating(List<Review> reviews, double expectedFood, double expectedService, double expectedAmbiance, double expectedOverall) {
        reviews.forEach(restaurant::addReview);

        Rating averageRating = restaurant.getAverageRating();

        assertEquals(expectedFood, averageRating.food);
        assertEquals(expectedService, averageRating.service);
        assertEquals(expectedAmbiance, averageRating.ambiance);
        assertEquals(expectedOverall, averageRating.overall);
    }

    private static Stream<Arguments> provideReviewsAndExpectedAverages() {
        return Stream.of(
                Arguments.of(List.of(), 0.0, 0.0, 0.0, 0.0),

                Arguments.of(
                        List.of(new Review(new User("user1", "pass", "user1@example.com", new Address("Country", "City", "Street"), User.Role.client),
                                new Rating() {{
                                    food = 4.0;
                                    service = 3.5;
                                    ambiance = 4.0;
                                    overall = 4.5;
                                }}, "Good food", LocalDateTime.now())
                        ),
                        4.0, 3.5, 4.0, 4.5
                ),

                Arguments.of(
                        List.of(
                                new Review(new User("user1", "pass", "user1@example.com", new Address("Country", "City", "Street"), User.Role.client),
                                        new Rating() {{
                                            food = 4.0;
                                            service = 3.5;
                                            ambiance = 3.5;
                                            overall = 2.5;
                                        }}, "Good food", LocalDateTime.now()),
                                new Review(new User("user2", "pass", "user2@example.com", new Address("Country", "City", "Street"), User.Role.client),
                                        new Rating() {{
                                            food = 5.0;
                                            service = 4.5;
                                            ambiance = 4.5;
                                            overall = 4.5;
                                        }}, "Excellent!", LocalDateTime.now()),
                                new Review(new User("user3", "pass", "user3@example.com", new Address("Country", "City", "Street"), User.Role.client),
                                        new Rating() {{
                                            food = 1.8;
                                            service = 1.0;
                                            ambiance = 4.0;
                                            overall = 3.5;
                                        }}, "Decent experience", LocalDateTime.now())
                        ),
                        3.6, 3.0, 4.0, 3.5
                )
        );
    }

    @Test
    public void testGetMaxSeatsNumberNoTables() {
        int maxSeats = restaurant.getMaxSeatsNumber();

        assertEquals(1, maxSeats);
    }

    @Test
    public void testGetMaxSeatsNumberWithTables() {
        Table table1 = new Table(1, restaurant.getId(), 4);
        Table table2 = new Table(2, restaurant.getId(), 6);
        Table table3 = new Table(3, restaurant.getId(), 2);
        restaurant.addTable(table1);
        restaurant.addTable(table2);
        restaurant.addTable(table3);

        int maxSeats = restaurant.getMaxSeatsNumber();

        assertEquals(6, maxSeats);
    }

    @Test
    public void testGetMaxSeatsNumberAllTablesSameSeats() {

        Table table1 = new Table(1, restaurant.getId(), 5);
        Table table2 = new Table(2, restaurant.getId(), 5);
        Table table3 = new Table(3, restaurant.getId(), 5);
        restaurant.addTable(table1);
        restaurant.addTable(table2);
        restaurant.addTable(table3);

        int maxSeats = restaurant.getMaxSeatsNumber();

        assertEquals(5, maxSeats);
    }

}
