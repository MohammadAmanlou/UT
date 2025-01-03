package mizdooni.service;

import mizdooni.model.Restaurant;
import mizdooni.model.User;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ServiceUtils {
    static final int REVIEW_PAGE_SIZE = 5;
    static final int RESTAURANT_PAGE_SIZE = 12;

    public static boolean validateUsername(String username) {
        String usernameFormat = "^\\w+$";
        return username.matches(usernameFormat);
    }

    public static boolean validateEmail(String email) {
        String emailFormat = "^\\w+@\\w+\\.\\w+$";
        return email.matches(emailFormat);
    }

    static boolean validateWorkingTime(LocalTime time) {
        return time.getMinute() == 0;
    }

    static boolean userIsTaken(String username, String email, List<User> users) {
        return users.stream().anyMatch(u -> u.getUsername().equals(username) || u.getEmail().equals(email));
    }

    static Restaurant findRestaurant(int id, List<Restaurant> restaurants) {
        return restaurants.stream().filter(r -> r.getId() == id).findFirst().orElse(null);
    }
}
