package mizdooni.service;

import mizdooni.database.Database;
import mizdooni.exceptions.*;
import mizdooni.model.Reservation;
import mizdooni.model.Restaurant;
import mizdooni.model.Table;
import mizdooni.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class ReservationService {
    @Autowired
    private Database db;
    @Autowired
    private UserService userService;

    public List<Reservation> getReservations(int restaurantId, int tableNumber, LocalDate date)
            throws RestaurantNotFound, UserNotManager, InvalidManagerRestaurant, TableNotFound {
        Restaurant restaurant = ServiceUtils.findRestaurant(restaurantId, db.restaurants);
        if (restaurant == null) {
            throw new RestaurantNotFound();
        }

        User manager = userService.getCurrentUser();
        if (manager == null || manager.getRole() != User.Role.manager) {
            throw new UserNotManager();
        }
        if (!restaurant.getManager().equals(manager)) {
            throw new InvalidManagerRestaurant();
        }

        Table table = restaurant.getTable(tableNumber);
        if (table == null) {
            throw new TableNotFound();
        }

        List<Reservation> reservations = table.getReservations();
        if (date != null) {
            reservations = reservations.stream().filter(reservation -> reservation.getDateTime().toLocalDate().equals(date)).toList();
        }
        return reservations;
    }

    public List<Reservation> getCustomerReservations(int customerId) throws UserNotFound, UserNoAccess {
        User user = userService.getCurrentUser();
        if (user == null) {
            throw new UserNotFound();
        }
        if (user.getId() != customerId) {
            throw new UserNoAccess();
        }
        return user.getReservations();
    }

    public List<LocalTime> getAvailableTimes(int restaurantId, int people, LocalDate date)
            throws RestaurantNotFound, DateTimeInThePast, BadPeopleNumber {
        Restaurant restaurant = ServiceUtils.findRestaurant(restaurantId, db.restaurants);
        if (restaurant == null) {
            throw new RestaurantNotFound();
        }

        if (date.isBefore(LocalDate.now())) {
            throw new DateTimeInThePast();
        }
        if (people <= 0) {
            throw new BadPeopleNumber();
        }

        Set<LocalTime> availableTimes = restaurant.getTables().stream()
                .filter(table -> table.getSeatsNumber() >= people)
                .flatMap(table -> getAvailableTableTimes(table, date, restaurant).stream())
                .collect(Collectors.toSet());

        return availableTimes.stream().sorted().toList();
    }

    public Reservation reserveTable(int restaurantId, int people, LocalDateTime datetime)
            throws UserNotFound, ManagerReservationNotAllowed, InvalidWorkingTime, RestaurantNotFound, TableNotFound,
            DateTimeInThePast, ReservationNotInOpenTimes {
        User user = userService.getCurrentUser();
        if (user == null) {
            throw new UserNotFound();
        }
        if (user.getRole() == User.Role.manager) {
            throw new ManagerReservationNotAllowed();
        }

        if (!ServiceUtils.validateWorkingTime(datetime.toLocalTime())) {
            throw new InvalidWorkingTime();
        }
        if (datetime.isBefore(LocalDateTime.now())) {
            throw new DateTimeInThePast();
        }

        Restaurant restaurant = ServiceUtils.findRestaurant(restaurantId, db.restaurants);
        if (restaurant == null) {
            throw new RestaurantNotFound();
        }
        if (datetime.toLocalTime().isBefore(restaurant.getStartTime()) ||
                datetime.toLocalTime().isAfter(restaurant.getEndTime())) {
            throw new ReservationNotInOpenTimes();
        }

        Table table = findAvailableTable(restaurant, people, datetime);
        if (table == null) {
            throw new TableNotFound();
        }

        Reservation reservation = new Reservation(user, restaurant, table, datetime);
        user.addReservation(reservation);
        table.addReservation(reservation);
        return reservation;
    }

    public void cancelReservation(int reservationNumber) throws UserNotFound, ReservationNotFound, ReservationCannotBeCancelled {
        User user = userService.getCurrentUser();
        if (user == null) {
            throw new UserNotFound();
        }

        Reservation reservation = user.getReservation(reservationNumber);
        if (reservation == null) {
            throw new ReservationNotFound();
        }

        if (reservation.getDateTime().isBefore(LocalDateTime.now())) {
            throw new ReservationCannotBeCancelled();
        }

        reservation.cancel();
    }

    private List<LocalTime> getAvailableTableTimes(Table table, LocalDate date, Restaurant restaurant) {
        Set<LocalTime> reserves = table.getReservations().stream()
                .filter(r -> r.getDateTime().toLocalDate().equals(date) && !r.isCancelled())
                .map(r -> r.getDateTime().toLocalTime())
                .collect(Collectors.toSet());

        List<LocalTime> availableTimes = new ArrayList<>();
        int startTime = restaurant.getStartTime().getHour();
        int endTime = restaurant.getEndTime().getHour();

        for (int i = startTime; i <= endTime; i++) {
            LocalTime time = LocalTime.of(i, 0);
            if (!reserves.contains(time)) {
                availableTimes.add(time);
            }
        }
        return availableTimes;
    }

    private Table findAvailableTable(Restaurant restaurant, int people, LocalDateTime datetime) {
        return restaurant.getTables().stream()
                .filter(table -> table.getSeatsNumber() >= people && !table.isReserved(datetime))
                .min(Comparator.comparingInt(Table::getSeatsNumber))
                .orElse(null);
    }
}
