package mizdooni.service;

import mizdooni.database.Database;
import mizdooni.exceptions.*;
import mizdooni.model.Rating;
import mizdooni.model.Restaurant;
import mizdooni.model.Review;
import mizdooni.model.User;
import mizdooni.response.PagedList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class ReviewService {
    @Autowired
    private Database db;
    @Autowired
    private UserService userService;

    public PagedList<Review> getReviews(int restaurantId, int page) throws RestaurantNotFound {
        Restaurant restaurant = ServiceUtils.findRestaurant(restaurantId, db.restaurants);
        if (restaurant == null) {
            throw new RestaurantNotFound();
        }
        PagedList<Review> reviews = new PagedList<>(restaurant.getReviews(), page, ServiceUtils.REVIEW_PAGE_SIZE);
        return reviews;
    }

    public void addReview(int restaurantId, Rating rating, String comment)
            throws UserNotFound, ManagerCannotReview, RestaurantNotFound, InvalidReviewRating, UserHasNotReserved {
        User user = userService.getCurrentUser();
        if (user == null) {
            throw new UserNotFound();
        }
        if (user.getRole() == User.Role.manager) {
            throw new ManagerCannotReview();
        }

        Restaurant restaurant = ServiceUtils.findRestaurant(restaurantId, db.restaurants);
        if (restaurant == null) {
            throw new RestaurantNotFound();
        }
        if (!user.checkReserved(restaurant)) {
            throw new UserHasNotReserved();
        }

        if (rating.food < 0 || rating.food > 5) {
            throw new InvalidReviewRating("Food");
        }
        if (rating.service < 0 || rating.service > 5) {
            throw new InvalidReviewRating("Service");
        }
        if (rating.ambiance < 0 || rating.ambiance > 5) {
            throw new InvalidReviewRating("Ambiance");
        }
        if (rating.overall < 0 || rating.overall > 5) {
            throw new InvalidReviewRating("Overall");
        }

        Review review = new Review(user, rating, comment, LocalDateTime.now());
        restaurant.addReview(review);
    }
}
