package mizdooni.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class User {
    public enum Role {
        client,
        manager,
    }

    private static int idCounter = 0;
    private int id;
    private String username;
    private String password;
    private String email;
    private Address address;
    private Role role;
    private int reservationCounter;
    private List<Reservation> reservations;

    public User(String username, String password, String email, Address address, Role role) {
        this.id = idCounter++;
        this.username = username;
        this.password = password;
        this.email = email;
        this.address = address;
        this.role = role;
        this.reservationCounter = 0;
        this.reservations = new ArrayList<>();
    }

    public void addReservation(Reservation reservation) {
        reservation.setReservationNumber(reservationCounter);
        reservationCounter++;
        reservations.add(reservation);
    }

    public boolean checkReserved(Restaurant restaurant) {
        return reservations.stream().anyMatch(r -> !r.isCancelled() &&
                r.getDateTime().isBefore(LocalDateTime.now()) &&
                r.getRestaurant().equals(restaurant));
    }

    public Reservation getReservation(int reservationNumber) {
        for (Reservation r : reservations) {
            if (r.getReservationNumber() == reservationNumber && !r.isCancelled()) {
                return r;
            }
        }
        return null;
    }

    public List<Reservation> getReservations() {
        return reservations;
    }

    public boolean checkPassword(String pass) {
        return password.equals(pass);
    }

    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public Role getRole() {
        return role;
    }
}
