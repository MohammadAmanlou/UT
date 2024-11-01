package mizdooni.model.mixin;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import mizdooni.model.*;
import mizdooni.response.serializer.ListSizeSerializer;
import org.springframework.boot.jackson.JsonMixin;

import java.io.IOException;
import java.time.LocalTime;
import java.util.List;

@JsonMixin(Restaurant.class)
@JsonAutoDetect(
        fieldVisibility = JsonAutoDetect.Visibility.ANY,
        getterVisibility = JsonAutoDetect.Visibility.NONE,
        isGetterVisibility = JsonAutoDetect.Visibility.NONE
)
abstract class RestaurantMixin {
    @JsonProperty("managerUsername")
    @JsonSerialize(using = UsernameSerializer.class)
    private User manager;

    @JsonFormat(pattern = "HH:mm")
    private LocalTime startTime;
    @JsonFormat(pattern = "HH:mm")
    private LocalTime endTime;

    @JsonProperty("image")
    private String imageLink;

    @JsonIgnore
    private List<Table> tables;

    @JsonProperty("totalReviews")
    @JsonSerialize(using = ListSizeSerializer.class)
    private List<Review> reviews;

    @JsonProperty
    abstract int getMaxSeatsNumber();
    @JsonProperty
    abstract int getStarCount();
    @JsonProperty
    abstract Rating getAverageRating();

    static class UsernameSerializer extends JsonSerializer<User> {
        @Override
        public void serialize(User user, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            jsonGenerator.writeString(user.getUsername());
        }
    }
}
