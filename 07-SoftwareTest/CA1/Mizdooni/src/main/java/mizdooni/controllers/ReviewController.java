package mizdooni.controllers;

import mizdooni.model.Rating;
import mizdooni.model.Restaurant;
import mizdooni.model.Review;
import mizdooni.response.PagedList;
import mizdooni.response.Response;
import mizdooni.response.ResponseException;
import mizdooni.service.RestaurantService;
import mizdooni.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

import static mizdooni.controllers.ControllerUtils.PARAMS_BAD_TYPE;
import static mizdooni.controllers.ControllerUtils.PARAMS_MISSING;

@RestController
class ReviewController {
    @Autowired
    private RestaurantService restaurantService;
    @Autowired
    private ReviewService reviewService;

    @GetMapping("/reviews/{restaurantId}")
    public Response getReviews(@PathVariable int restaurantId, @RequestParam int page) {
        Restaurant restaurant = ControllerUtils.checkRestaurant(restaurantId, restaurantService);
        try {
            PagedList<Review> reviews = reviewService.getReviews(restaurant.getId(), page);
            String message = "reviews for restaurant (" + restaurantId + "): " + restaurant.getName();
            return Response.ok(message, reviews);
        } catch (Exception ex) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, ex);
        }
    }

    @PostMapping("/reviews/{restaurantId}")
    public Response addReview(@PathVariable int restaurantId, @RequestBody Map<String, Object> params) {
        ControllerUtils.checkRestaurant(restaurantId, restaurantService);
        if (!ControllerUtils.containsKeys(params, "comment", "rating")) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, PARAMS_MISSING);
        }

        String comment;
        Rating rating = new Rating();

        try {
            comment = (String) params.get("comment");
            Map<String, Number> ratingMap = (Map<String, Number>) params.get("rating");
            rating.food = ratingMap.get("food").doubleValue();
            rating.service = ratingMap.get("service").doubleValue();
            rating.ambiance = ratingMap.get("ambiance").doubleValue();
            rating.overall = ratingMap.get("overall").doubleValue();
        } catch (Exception ex) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, PARAMS_BAD_TYPE);
        }

        try {
            reviewService.addReview(restaurantId, rating, comment);
            return Response.ok("review added successfully");
        } catch (Exception ex) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, ex);
        }
    }
}
