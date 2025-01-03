package mizdooni.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import mizdooni.exceptions.*;
import mizdooni.model.*;
import mizdooni.service.RestaurantService;
import mizdooni.service.TableService;
import mizdooni.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.junit.jupiter.params.provider.ValueSource;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
@WebMvcTest(TableController.class)
public class TableControllerTest {

    private Restaurant restaurant;
    private Table table;

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private UserService userService;

    @MockBean
    private RestaurantService restaurantService;

    @MockBean
    private TableService tableService;

    @Autowired
    private ObjectMapper objectMapper;

    @BeforeEach
    void setUp() {
        restaurant = new Restaurant(
                "Test",
                null,
                "Food Type",
                LocalTime.of(7, 0),
                LocalTime.of(19, 0),
                "Test Description",
                new Address("Country", "City", "Street"),
                "/sample-image.jpg"
        );
        table = new Table(1, restaurant.getId(), 4);
        when(userService.getCurrentUser()).thenReturn(new User("Manager", "pass", "m@test.com",
                new Address("Country", "City", "Street"), User.Role.manager));
    }

    @ParameterizedTest
    @DisplayName("Should Successfully Get Tables When Valid Restaurant ID")
    @ValueSource(ints = {1, Integer.MAX_VALUE})
    void should_SuccessfullyGetTables_When_ValidRestaurantId(int restaurantId) throws Exception {
        when(tableService.getTables(restaurantId)).thenReturn(List.of(table));
        when(restaurantService.getRestaurant(Mockito.anyInt())).thenReturn(restaurant);

        mockMvc.perform(get("/tables/{restaurantId}", restaurantId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("tables listed"))
                .andExpect(jsonPath("$.data").isArray())
                .andExpect(jsonPath("$.data[0].tableNumber").value(table.getTableNumber()))
                .andExpect(jsonPath("$.data[0].seatsNumber").value(table.getSeatsNumber()));
    }

    @ParameterizedTest
    @DisplayName("Should Return Bad Request When Error Occurs While Fetching Tables")
    @ValueSource(ints = {1, Integer.MAX_VALUE})
    void should_ReturnBadRequest_When_ErrorOccursWhileFetchingTables(int restaurantId) throws Exception {
        when(tableService.getTables(restaurantId)).thenThrow(new RuntimeException("Error Occurs While Fetching Tables"));
        when(restaurantService.getRestaurant(Mockito.anyInt())).thenReturn(restaurant);

        mockMvc.perform(get("/tables/{restaurantId}", restaurantId))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value("Error Occurs While Fetching Tables"));
    }

    @ParameterizedTest
    @DisplayName("Should Return Not Found When Restaurant Not Found")
    @ValueSource(ints = {1, Integer.MIN_VALUE})
    void should_ReturnNotFound_When_RestaurantNotFound(int restaurantId) throws Exception {
        when(restaurantService.getRestaurant(restaurantId)).thenReturn(null);

        mockMvc.perform(get("/tables/{restaurantId}", restaurantId))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.message").value("restaurant not found"));
    }

    @ParameterizedTest
    @CsvSource({"4", "1", "100"})
    @DisplayName("Should Successfully Add Table When Valid Params Provided")
    void should_SuccessfullyAddTable_When_ValidParamsProvided(String seatsNumber) throws Exception {
        Map<String, String> params = createTableParams(seatsNumber);

        when(restaurantService.getRestaurant(Mockito.anyInt())).thenReturn(restaurant);
        doNothing().when(tableService).addTable(restaurant.getId(), Integer.parseInt(seatsNumber));

        mockMvc.perform(post("/tables/{restaurantId}", restaurant.getId())
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(params)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("table added"));
    }

    @Test
    @DisplayName("Should Return Bad Request When Seats Number Missing")
    void should_ReturnBadRequest_When_SeatsNumberMissing() throws Exception {
        Map<String, String> params = new HashMap<>();

        when(restaurantService.getRestaurant(Mockito.anyInt())).thenReturn(restaurant);

        mockMvc.perform(post("/tables/{restaurantId}", restaurant.getId())
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(params)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value(ControllerUtils.PARAMS_MISSING));
    }

    @ParameterizedTest
    @CsvSource({"invalid"})
    @DisplayName("Should Return Bad Request When Invalid Seats Number Provided")
    void should_ReturnBadRequest_When_InvalidSeatsNumberProvided(String seatsNumber) throws Exception {
        Map<String, String> params = createTableParams(seatsNumber);

        when(restaurantService.getRestaurant(Mockito.anyInt())).thenReturn(restaurant);

        mockMvc.perform(post("/tables/{restaurantId}", restaurant.getId())
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(params)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value(ControllerUtils.PARAMS_BAD_TYPE));
    }

    @ParameterizedTest
    @CsvSource({"4", "1"})
    @DisplayName("Should Return Bad Request When User is Not a Manager")
    void should_ReturnBadRequest_When_UserIsNotManager(String seatsNumber) throws Exception {
        Map<String, String> params = createTableParams(seatsNumber);

        when(restaurantService.getRestaurant(Mockito.anyInt())).thenReturn(restaurant);

        doThrow(new UserNotManager()).when(tableService).addTable(restaurant.getId(), Integer.parseInt(seatsNumber));

        mockMvc.perform(post("/tables/{restaurantId}", restaurant.getId())
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(params)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value("User is not a manager."));
    }

    @ParameterizedTest
    @CsvSource({"4", "10"})
    @DisplayName("Should Return Bad Request When User is Not Valid Restaurant Manager")
    void should_ReturnBadRequest_When_UserIsNotValidRestaurantManager(String seatsNumber) throws Exception {
        Map<String, String> params = createTableParams(seatsNumber);

        when(restaurantService.getRestaurant(Mockito.anyInt())).thenReturn(restaurant);

        doThrow(new InvalidManagerRestaurant()).when(tableService).addTable(restaurant.getId(), Integer.parseInt(seatsNumber));

        mockMvc.perform(post("/tables/{restaurantId}", restaurant.getId())
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(params)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value("The manager is not valid for this restaurant."));
    }

    @ParameterizedTest
    @CsvSource({"0", "1000"})
    @DisplayName("Should Return Bad Request When Seats Number is Out of Range")
    void should_ReturnBadRequest_When_SeatsNumberIsOutOfRange(String seatsNumber) throws Exception {
        Map<String, String> params = createTableParams(seatsNumber);

        when(restaurantService.getRestaurant(Mockito.anyInt())).thenReturn(restaurant);

        doThrow(new RuntimeException("Seats number is out of range.")).when(tableService).addTable(restaurant.getId(), Integer.parseInt(seatsNumber));

        mockMvc.perform(post("/tables/{restaurantId}", restaurant.getId())
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(params)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value("Seats number is out of range."));
    }

    private Map<String, String> createTableParams(String seatsNumber) {
        Map<String, String> params = new HashMap<>();
        params.put("seatsNumber", seatsNumber);
        return params;
    }
}
