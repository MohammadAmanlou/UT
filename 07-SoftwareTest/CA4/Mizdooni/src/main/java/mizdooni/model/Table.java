package mizdooni.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Table {
    private int tableNumber;
    private int restaurantId;
    private int seatsNumber;
    private List<Reservation> reservations;

    public Table(int tableNumber, int restaurantId, int seatsNumber) {
        this.tableNumber = tableNumber;
        this.restaurantId = restaurantId;
        this.seatsNumber = seatsNumber;
        this.reservations = new ArrayList<>();
    }

    public void addReservation(Reservation reservation) {
        reservations.add(reservation);
    }

    public boolean isReserved(LocalDateTime datetime) {
        return reservations.stream().anyMatch(r -> r.getDateTime().equals(datetime) && !r.isCancelled());
    }

    public int getTableNumber() {
        return tableNumber;
    }

    public void setTableNumber(int tableNumber) {
        this.tableNumber = tableNumber;
    }

    public int getSeatsNumber() {
        return seatsNumber;
    }

    public List<Reservation> getReservations() {
        return reservations;
    }
}
