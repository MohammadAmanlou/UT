package mizdooni.model;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;

@ExtendWith(MockitoExtension.class)
public class UserTest {

    @InjectMocks
    private User user;
    private Reservation reservation1;
    private Reservation reservation2;
    private Restaurant restaurant1;
    private Restaurant restaurant2;
    private Table table1;
    private Table table2;

    @BeforeEach
    public void setUp() {
        Address address = new Address("USA", "City", "123 Street");
        user = new User("username", "password", "email@example.com", address, User.Role.client);

        restaurant1 = new Restaurant("The Great Restaurant", null, null, null, null, null, null, null);
        restaurant2 = new Restaurant("Other Restaurant", null, null, null, null, null, null, null);

        table1 = new Table(1, restaurant1.getId(), 4);
        table2 = new Table(2, restaurant2.getId(), 2);

        restaurant1.addTable(table1);
        restaurant2.addTable(table2);

        reservation1 = new Reservation(user, restaurant1, table1, LocalDateTime.now().minusDays(1));
        reservation2 = new Reservation(user, restaurant2, table2, LocalDateTime.now().plusDays(1));

        user.addReservation(reservation1);
        user.addReservation(reservation2);
    }

    @Test
    @DisplayName("Should add a reservation and increment reservation counter")
    public void testAddReservation() {
        Reservation newReservation = new Reservation(user, restaurant1, table1, LocalDateTime.now().plusDays(2));
        user.addReservation(newReservation);

        assertEquals(2, newReservation.getReservationNumber());
        assertEquals(3, user.getReservations().size());
    }

    @ParameterizedTest
    @CsvSource({
            "restaurant1, true",
            "restaurant2, false"
    })
    @DisplayName("Should check if the user has a past reservation at the restaurant")
    public void testCheckReserved(String restaurantName, boolean expectedResult) {
        Restaurant restaurantToCheck = restaurantName.equals("restaurant1") ? restaurant1 : restaurant2;
        boolean reserved = user.checkReserved(restaurantToCheck);
        assertEquals(expectedResult, reserved);
    }

    @Test
    @DisplayName("Should return false if the reservation is cancelled")
    public void testCheckReservedCancelled() {
        reservation1.cancel();
        boolean reserved = user.checkReserved(restaurant1);

        assertFalse(reserved);
    }

    @Test
    @DisplayName("Should return false if the reservation is after the current time")
    public void testCheckReservedAfterCurrentTime() {
        boolean reserved = user.checkReserved(restaurant2);

        assertFalse(reserved);
    }

    @Test
    @DisplayName("Should return false if the reservation is for a different restaurant")
    public void testCheckReservedDifferentRestaurant() {
        Restaurant restaurant3 = new Restaurant("Restaurant 3", null, null, null, null, null, null, null);
        boolean reserved = user.checkReserved(restaurant3);

        assertFalse(reserved);
    }

    @Test
    @DisplayName("Should return correct reservation by number if not cancelled")
    public void testGetReservation() {
        Reservation foundReservation = user.getReservation(0);
        assertNotNull(foundReservation);
        assertEquals(restaurant1, foundReservation.getRestaurant());
    }

    @Test
    @DisplayName("Should return null if reservation is cancelled")
    public void testGetCancelledReservation() {
        reservation1.cancel();
        Reservation foundReservation = user.getReservation(0);
        assertNull(foundReservation);
    }

    @Test
    @DisplayName("Should return null if the reservation is not found")
    public void testGetReservationNotFound() {
        Reservation reservation = user.getReservation(999);

        assertNull(reservation);
    }

    @ParameterizedTest
    @CsvSource({
        "password, true",
        "wrongPassword, false"
    })
    @DisplayName("Should check if the password matches correctly")
    public void testCheckPassword(String inputPassword, boolean expectedResult) {
        assertEquals(expectedResult, user.checkPassword(inputPassword));
    }
}
