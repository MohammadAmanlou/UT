package mizdooni.model;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;
import java.util.List;

class TableTest {

    private Table table;
    private Reservation reservation1;
    private Reservation reservation2;
    private LocalDateTime dateTime1;
    private LocalDateTime dateTime2;

    @BeforeEach
    public void setUp() {
        table = new Table(1, 1001, 4);
        dateTime1 = LocalDateTime.now().plusDays(1); 
        dateTime2 = LocalDateTime.now().plusDays(2); 

        reservation1 = new Reservation(null, null, table, dateTime1);
        reservation2 = new Reservation(null, null, table, dateTime2);
    }

    @Test
    @DisplayName("Should add a reservation successfully")
    public void testAddReservation() {
        table.addReservation(reservation1);
        List<Reservation> reservations = table.getReservations();

        assertEquals(1, reservations.size());
        assertTrue(reservations.contains(reservation1));
    }

    @Test
    @DisplayName("Should return true when table is reserved at a specific time")
    public void testIsReservedTrue() {
        table.addReservation(reservation1);
        assertTrue(table.isReserved(dateTime1));
    }

    @Test
    @DisplayName("Should return true when table is reserved at a specific time")
    public void testIsReservedFalseForCancelled() {
        reservation1.cancel();
        table.addReservation(reservation1);
        assertFalse(table.isReserved(dateTime1));
    }

    @Test
    @DisplayName("Should return false when table is not reserved at a specific time")
    public void testIsReservedFalse() {
        table.addReservation(reservation1);

        assertFalse(table.isReserved(dateTime2));
    }

    @Test
    @DisplayName("Should return false when reservation is cancelled")
    public void testIsReservedCancelled() {
        reservation1.cancel();
        table.addReservation(reservation1);

        assertFalse(table.isReserved(dateTime1), "Cancelled reservation should not be considered reserved");
    }
}
