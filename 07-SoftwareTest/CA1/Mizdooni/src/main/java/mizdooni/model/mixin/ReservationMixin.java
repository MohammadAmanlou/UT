package mizdooni.model.mixin;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import mizdooni.model.Reservation;
import mizdooni.model.Restaurant;
import mizdooni.model.User;
import mizdooni.response.serializer.UserShortSerializer;
import org.springframework.boot.jackson.JsonMixin;

import java.io.IOException;
import java.time.LocalDateTime;

@JsonMixin(Reservation.class)
@JsonAutoDetect(
        fieldVisibility = JsonAutoDetect.Visibility.ANY,
        getterVisibility = JsonAutoDetect.Visibility.NONE,
        isGetterVisibility = JsonAutoDetect.Visibility.NONE
)
abstract class ReservationMixin {
    @JsonSerialize(using = UserShortSerializer.class)
    private User user;

    @JsonSerialize(using = RestaurantShortSerializer.class)
    private Restaurant restaurant;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime datetime;

    @JsonProperty("isPastTime")
    abstract boolean isPastTime();

    static class RestaurantShortSerializer extends JsonSerializer<Restaurant> {
        @Override
        public void serialize(Restaurant restaurant, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            jsonGenerator.writeStartObject();
            jsonGenerator.writeNumberField("id", restaurant.getId());
            jsonGenerator.writeStringField("name", restaurant.getName());
            jsonGenerator.writeEndObject();
        }
    }
}
