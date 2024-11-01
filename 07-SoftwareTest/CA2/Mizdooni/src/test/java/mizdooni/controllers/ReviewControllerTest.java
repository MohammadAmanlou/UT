package mizdooni.controllers;

import mizdooni.exceptions.InvalidReviewRating;
import mizdooni.exceptions.ManagerCannotReview;
import mizdooni.exceptions.RestaurantNotFound;
import mizdooni.exceptions.UserHasNotReserved;
import mizdooni.exceptions.UserNotFound;
import mizdooni.model.Rating;
import mizdooni.model.Restaurant;
import mizdooni.model.Review;
import mizdooni.response.PagedList;
import mizdooni.response.Response;
import mizdooni.response.ResponseException;
import mizdooni.service.RestaurantService;
import mizdooni.service.ReviewService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import static mizdooni.controllers.ControllerUtils.PARAMS_BAD_TYPE;
import static mizdooni.controllers.ControllerUtils.PARAMS_MISSING;

class ReviewControllerTest {
    @Mock
    private RestaurantService restaurantService;

    @Mock
    private ReviewService reviewService;

    @InjectMocks
    private ReviewController reviewController;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("Test getReviews with valid restaurantId and page number")
    void should_SuccessfullyGetReviews_When_ValidRestaurantIdAndPageNumber() throws RestaurantNotFound {
        int restaurantId = 1;
        int page = 1;
        Restaurant restaurant = new Restaurant("Test Restaurant", null, null, null, null, null, null, null);
        PagedList<Review> pagedList = new PagedList<>(new ArrayList<>(), 1, 10);

        when(restaurantService.getRestaurant(restaurantId)).thenReturn(restaurant);
        when(reviewService.getReviews(restaurantId, page)).thenReturn(pagedList);

        Response response = reviewController.getReviews(restaurantId, page);

        assertNotNull(response);
        assertEquals(HttpStatus.OK, response.getStatus());
        assertEquals("reviews for restaurant (1): Test Restaurant", response.getMessage());
    }

    @Test
    @DisplayName("Test getReviews with invalid restaurantId")
    void should_ThrowException_When_InvalidRestaurantId() throws RestaurantNotFound {
        int restaurantId = 1;
        int page = 1;

        doThrow(new ResponseException(HttpStatus.NOT_FOUND, "Restaurant not found")).when(restaurantService).getRestaurant(restaurantId);

        ResponseException exception = assertThrows(ResponseException.class, () -> {
            reviewController.getReviews(restaurantId, page);
        });

        assertEquals(HttpStatus.NOT_FOUND, exception.getStatus());
        assertEquals("Restaurant not found", exception.getMessage());
    }

    @ParameterizedTest
    @CsvSource({
            "1, Great food, 4.5, 4.0, 4.0, 4.2",
            "2, Amazing service, 5.0, 5.0, 4.5, 4.8"
    })
    @DisplayName("Test addReview with valid parameters")
    void should_SuccessfullyAddReview_When_ValidParameters(int restaurantId, String comment, double food, double service, double ambiance, double overall) {
        Restaurant restaurant = new Restaurant("Test Restaurant", null, null, null, null, null, null, null);

        when(restaurantService.getRestaurant(restaurantId)).thenReturn(restaurant);

        Map<String, Object> params = new HashMap<>();
        params.put("comment", comment);
        Map<String, Number> ratingMap = new HashMap<>();
        ratingMap.put("food", food);
        ratingMap.put("service", service);
        ratingMap.put("ambiance", ambiance);
        ratingMap.put("overall", overall);
        params.put("rating", ratingMap);

        Response response = reviewController.addReview(restaurantId, params);

        assertNotNull(response);
        assertEquals(HttpStatus.OK, response.getStatus());
        assertEquals("review added successfully", response.getMessage());
    }

    @Test
    @DisplayName("Test addReview with missing parameters")
    void should_ThrowException_When_MissingParamsForReview() {
        int restaurantId = 1;
        Map<String, Object> params = new HashMap<>();
        Restaurant restaurant = new Restaurant("Test Restaurant", null, null, null, null, null, null, null);
        when(restaurantService.getRestaurant(restaurantId)).thenReturn(restaurant);
        ResponseException exception = assertThrows(ResponseException.class, () -> {
            reviewController.addReview(restaurantId, params);
        });

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals(PARAMS_MISSING, exception.getMessage());
    }

    @Test
    @DisplayName("Test addReview with invalid parameter types")
    void should_ThrowException_When_InvalidParameterTypesForReview() {
        int restaurantId = 1;
        Restaurant restaurant = new Restaurant("Test Restaurant", null, null, null, null, null, null, null);
        when(restaurantService.getRestaurant(restaurantId)).thenReturn(restaurant);
        Map<String, Object> params = new HashMap<>();
        params.put("comment", 12345);  
        params.put("rating", "invalid rating type");

        ResponseException exception = assertThrows(ResponseException.class, () -> {
            reviewController.addReview(restaurantId, params);
        });

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals(PARAMS_BAD_TYPE, exception.getMessage());
    }

    @Test
    @DisplayName("Test addReview with exception in calling reviewService.addReview")
    void should_ThrowException_When_addReviewThrows() 
            throws UserNotFound, ManagerCannotReview, RestaurantNotFound, InvalidReviewRating, UserHasNotReserved {
        
        int restaurantId = 1;
        String comment = "Great food";
        double food = 4.5;
        double service = 4.0;
        double ambiance = 4.0;
        double overall = 4.2;
        
        Restaurant mockRestaurant = mock(Restaurant.class);
        when(restaurantService.getRestaurant(anyInt())).thenReturn(mockRestaurant);
        
        Map<String, Object> params = new HashMap<>();
        params.put("comment", comment);
        
        Rating rating = new Rating();
        rating.food = food;
        rating.service = service;
        rating.ambiance = ambiance;
        rating.overall = overall;
        params.put("rating", rating);
        
        doThrow(new ResponseException(HttpStatus.BAD_REQUEST, "restaurant can not be added"))
            .when(reviewService).addReview(restaurantId, rating, comment);
        
        ResponseException exception = assertThrows(ResponseException.class, () -> {
            reviewController.addReview(restaurantId, params);
        });

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals(PARAMS_BAD_TYPE, exception.getMessage());
    }
}
