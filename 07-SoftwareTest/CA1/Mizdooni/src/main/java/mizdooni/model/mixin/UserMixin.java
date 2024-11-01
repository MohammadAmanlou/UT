package mizdooni.model.mixin;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonIgnore;
import mizdooni.model.Reservation;
import mizdooni.model.User;
import org.springframework.boot.jackson.JsonMixin;

import java.util.List;

@JsonMixin(User.class)
@JsonAutoDetect(
        fieldVisibility = JsonAutoDetect.Visibility.ANY,
        getterVisibility = JsonAutoDetect.Visibility.NONE,
        isGetterVisibility = JsonAutoDetect.Visibility.NONE
)
abstract class UserMixin {
    @JsonIgnore
    private String password;
    @JsonIgnore
    private int reservationCounter;
    @JsonIgnore
    private List<Reservation> reservations;
}
