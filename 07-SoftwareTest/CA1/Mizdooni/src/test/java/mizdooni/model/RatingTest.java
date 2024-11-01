package mizdooni.model;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

class RatingTest {

    private Rating rating;

    @BeforeEach
    void setUp() {
        rating = new Rating();
    }

    @ParameterizedTest
    @CsvSource({
        "4.2, 4",
        "4.5, 5",
        "5.0, 5",
        "0.0, 0",
        "2.3, 2",
        "5.99, 5"
    })
    @DisplayName("Should return correct star count based on overall rating")
    void testGetStarCount(double overallRating, int expectedStarCount) {
        rating.overall = overallRating;
        assertEquals(expectedStarCount, rating.getStarCount());
    }

    @Test
    @DisplayName("Should never return more than 5 stars")
    void testGetStarCountMaxValue() {
        rating.overall = 6.0;
        assertEquals(5, rating.getStarCount());
    }
}
