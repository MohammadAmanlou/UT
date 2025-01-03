package mizdooni.database;

import mizdooni.model.Restaurant;
import mizdooni.model.User;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class Database {
    public List<User> users;
    public List<Restaurant> restaurants;

    public Database() {
        users = new ArrayList<>();
        restaurants = new ArrayList<>();
        new DataLoader(this).read();
    }
}
