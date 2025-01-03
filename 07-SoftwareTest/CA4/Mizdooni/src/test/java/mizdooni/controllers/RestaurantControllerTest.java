package mizdooni.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import mizdooni.exceptions.DuplicatedRestaurantName;
import mizdooni.exceptions.InvalidWorkingTime;
import mizdooni.exceptions.UserNotManager;
import mizdooni.model.Address;
import mizdooni.model.Restaurant;
import mizdooni.model.RestaurantSearchFilter;
import mizdooni.model.User;
import mizdooni.response.PagedList;
import mizdooni.service.RestaurantService;
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
import java.util.*;
import java.util.stream.Collectors;

import static mizdooni.controllers.ControllerUtils.PARAMS_BAD_TYPE;
import static mizdooni.controllers.ControllerUtils.PARAMS_MISSING;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@ExtendWith(MockitoExtension.class)
@WebMvcTest(RestaurantController.class)
class RestaurantControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private RestaurantService restaurantService;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private UserService userService;

    private Restaurant sampleRestaurant;

    private Restaurant getAnonymousRestaurant() {
        return new Restaurant(
                "Test",
                null,
                "Food Type",
                LocalTime.of(7, 0),
                LocalTime.of(19, 0),
                "Test Description",
                new Address("Country", "City", "Street"),
                "/sample-image.jpg"
        );
    }

    @BeforeEach
    void setUp() {
        sampleRestaurant = getAnonymousRestaurant();
    }

    @Test
    @DisplayName("Should Successfully Get Restaurant When It Exists")
    void should_SuccessfullyGetRestaurant_When_ItExists() throws Exception {
        when(restaurantService.getRestaurant(Mockito.anyInt())).thenReturn(sampleRestaurant);

        mockMvc.perform(get("/restaurants/{restaurantId}", 1))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("restaurant found"))
                .andExpect(jsonPath("$.data.name").value("Test"));
    }

    @Test
    @DisplayName("Should Return Not Found When Restaurant Does Not Exist")
    void should_ReturnNotFound_When_RestaurantDoesNotExist() throws Exception {
        when(restaurantService.getRestaurant(Mockito.anyInt())).thenReturn(null);

        mockMvc.perform(get("/restaurants/{restaurantId}", 1))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.message").value("restaurant not found"));
    }

    @Test
    @DisplayName("Should Successfully Get Restaurants Without Filter")
    void should_SuccessfullyGetRestaurants_WithoutFilter() throws Exception {
        List<Restaurant> restaurantList = Collections.singletonList(sampleRestaurant);
        when(restaurantService.getRestaurants(eq(1), any(RestaurantSearchFilter.class))).thenReturn(new PagedList<>(restaurantList, 1, 12));

        mockMvc.perform(get("/restaurants")
                        .param("page", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("restaurants listed"))
                .andExpect(jsonPath("$.data.pageList[0].name").value("Test"))
                .andExpect(jsonPath("$.data.pageList[0].type").value("Food Type"))
                .andExpect(jsonPath("$.data.pageList[0].description").value("Test Description"));
    }

    @Test
    @DisplayName("Should Successfully Get Restaurants With Filter")
    void should_SuccessfullyGetRestaurants_WithFilter() throws Exception {
        when(restaurantService.getRestaurants(eq(1), any(RestaurantSearchFilter.class))).thenReturn(null);
        mockMvc.perform(get("/restaurants")
                        .param("page", "1")
                        .param("type", "Irani"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("restaurants listed"))
                .andExpect(jsonPath("$.data").doesNotExist());
    }

    @Test
    @DisplayName("Should Return Bad Request When Error Occurs While Fetching Restaurants")
    void should_ReturnBadRequest_When_ErrorOccursWhileFetchingRestaurants() throws Exception {
        when(restaurantService.getRestaurants(eq(1), any(RestaurantSearchFilter.class)))
                .thenThrow(new RuntimeException("test"));

        mockMvc.perform(get("/restaurants")
                        .param("page", "1"))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value("test"));
    }

    @ParameterizedTest
    @ValueSource(booleans = {true, false})
    @DisplayName("Should Add Restaurant Successfully With Or Without Image")
    void should_AddRestaurantSuccessfully_When_ValidParams(boolean includeImage) throws Exception {
        Map<String, Object> requestParams = createValidRestaurantRequestParams();
        if (includeImage) {
            requestParams.put("image", "/sample-image.jpg");
        }

        when(restaurantService.addRestaurant(
                eq("Test"),
                eq("Food Type"),
                any(),
                any(),
                eq("Test Description"),
                any(),
                eq(includeImage ? "/sample-image.jpg" : ControllerUtils.PLACEHOLDER_IMAGE)
        )).thenReturn(1);

        mockMvc.perform(post("/restaurants")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(requestParams)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("restaurant added"))
                .andExpect(jsonPath("$.data").value(1));
    }

    @ParameterizedTest
    @ValueSource(strings = {"name", "type", "startTime", "endTime", "description", "address"})
    @DisplayName("Should Return Bad Request When Restaurant Parameter Is Missing")
    void should_ReturnBadRequest_When_ParameterIsMissing(String missingParam) throws Exception {
        Map<String, Object> requestParams = createValidRestaurantRequestParams();
        requestParams.remove(missingParam);

        mockMvc.perform(post("/restaurants")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(requestParams)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value(PARAMS_MISSING));
    }

    @ParameterizedTest
    @CsvSource({
            "country, empty",
            "city, empty",
            "street, empty",
            "country, missing",
            "city, missing",
            "street, missing"
    })
    @DisplayName("Should Return Bad Request When Address Parameters Are Missing")
    void should_ReturnBadRequest_When_AddressParameterIsMissing(String field, String scenario) throws Exception {
        Map<String, Object> requestParams = createValidRestaurantRequestParams();

        Map<String, String> addressParams = new HashMap<>();
        addressParams.put("country", "Country");
        addressParams.put("city", "City");
        addressParams.put("street", "Street");

        if ("empty".equals(scenario)) {
            addressParams.put(field, "");
        } else if ("missing".equals(scenario)) {
            addressParams.remove(field);
        }

        requestParams.put("address", addressParams);

        mockMvc.perform(post("/restaurants")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(requestParams)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value(PARAMS_MISSING));
    }

    @ParameterizedTest
    @ValueSource(strings = {"startTime", "endTime"})
    @DisplayName("Should Return Bad Request When Time Parameter Is Invalid")
    void should_ReturnBadRequest_When_TimeParameterIsInvalid(String timeField) throws Exception {
        Map<String, Object> requestParams = createValidRestaurantRequestParams();
        requestParams.put(timeField, "invalid-time");

        mockMvc.perform(post("/restaurants")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(requestParams)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value(PARAMS_BAD_TYPE));
    }

    @Test
    @DisplayName("Should Return Restaurant Locations Successfully")
    void should_ReturnRestaurantLocationsSuccessfully() throws Exception {
        Map<String, Set<String>> mockLocations = new HashMap<>();
        mockLocations.put("Country", new HashSet<>(Collections.singletonList("City")));
    
        when(restaurantService.getRestaurantLocations()).thenReturn(mockLocations);
    
        mockMvc.perform(get("/restaurants/locations"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("restaurant locations"))
                .andExpect(jsonPath("$.data.Country").isArray())
                .andExpect(jsonPath("$.data.Country[0]").value("City"));
    }
    

    @Test
    @DisplayName("Should Return Bad Request When Fetching Restaurant Locations Fails")
    void should_ReturnBadRequest_When_FetchingRestaurantLocationsFails() throws Exception {
        when(restaurantService.getRestaurantLocations()).thenThrow(new RuntimeException("test"));
    
        mockMvc.perform(get("/restaurants/locations"))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value("test"));
    }
    

    @Test
    @DisplayName("Should Return Bad Request When Restaurant Name Already Exists")
    void should_ReturnBadRequest_When_RestaurantNameExists() throws Exception {
        when(restaurantService.addRestaurant(any(), any(), any(), any(), any(), any(), any()))
                .thenThrow(new DuplicatedRestaurantName());

        mockMvc.perform(post("/restaurants")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(getAnonymousRestaurant())))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value("Restaurant name is already taken."));
    }

    @Test
    @DisplayName("Should Return Forbidden When User Is Not Manager")
    void should_ReturnForbidden_When_UserIsNotManager() throws Exception {
        when(restaurantService.addRestaurant(any(), any(), any(), any(), any(), any(), any()))
                .thenThrow(new UserNotManager());

        mockMvc.perform(post("/restaurants")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(getAnonymousRestaurant())))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value("User is not a manager."));
    }

    @Test
    @DisplayName("Should Return Bad Request When Working Time Is Invalid")
    void should_ReturnBadRequest_When_WorkingTimeIsInvalid() throws Exception {
        when(restaurantService.addRestaurant(any(), any(), any(), any(), any(), any(), any()))
                .thenThrow(new InvalidWorkingTime());

        mockMvc.perform(post("/restaurants")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(getAnonymousRestaurant())))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value("Invalid working time."));
    }

    @Test
    @DisplayName("Should Return Error When getManagerRestaurants Throws Exception")
    void should_ReturnError_When_getManagerRestaurantsThrowsException() throws Exception {
        int managerId = 3;  
        when(restaurantService.getManagerRestaurants(eq(managerId))).thenThrow(new RuntimeException("Some error occurred"));
            mockMvc.perform(get("/restaurants/manager/{managerId}", managerId))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value("Some error occurred"));
    }

    @Test
    @DisplayName("Should Return List of Restaurants When Manager Restaurants Found")
    void should_ReturnListOfRestaurants_When_ManagerRestaurantsFound() throws Exception {
        int managerId = 3;
        Restaurant restaurant1 = new Restaurant("Restaurant 1", new User("manager1", null, null, null, User.Role.manager), "Italian", LocalTime.of(9, 0), LocalTime.of(22, 0), "Delicious Italian food", new Address("USA", "New York", "5th Avenue"), "image1.jpg");
        Restaurant restaurant2 = new Restaurant("Restaurant 2", new User("manager1", null, null, null, User.Role.manager), "French", LocalTime.of(10, 0), LocalTime.of(23, 0), "Authentic French cuisine", new Address("USA", "Los Angeles", "Sunset Blvd"), "image2.jpg");
    
        List<Restaurant> managerRestaurants = Arrays.asList(restaurant1, restaurant2);
            when(restaurantService.getManagerRestaurants(managerId)).thenReturn(managerRestaurants);
    
        mockMvc.perform(get("/restaurants/manager/{managerId}", managerId))
                .andExpect(status().isOk())  
                .andExpect(jsonPath("$.message").value("manager restaurants listed"))
                .andExpect(jsonPath("$.data.size()").value(2))  
                .andExpect(jsonPath("$.data[0].name").value("Restaurant 1")) 
                .andExpect(jsonPath("$.data[1].name").value("Restaurant 2")); 
    }

    @Test
    @DisplayName("Should Return Bad Request When Fetching Restaurant Types Fails")
    void should_ReturnBadRequest_When_FetchingRestaurantTypesFails() throws Exception {
        when(restaurantService.getRestaurantTypes()).thenThrow(new RuntimeException("Fetching Restaurant Types Fails"));
    
        mockMvc.perform(get("/restaurants/types"))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value("Fetching Restaurant Types Fails"));
    }
    
    @Test
    @DisplayName("Should Return Conflict When Restaurant Name Already Exists")
    void should_ReturnConflict_When_RestaurantNameAlreadyExists() throws Exception {
        when(restaurantService.restaurantExists("Existing Restaurant")).thenReturn(true);
    
        mockMvc.perform(get("/validate/restaurant-name").param("data", "Existing Restaurant"))
                .andExpect(status().isConflict())
                .andExpect(jsonPath("$.message").value("restaurant name is taken"));
    }
    
    @Test
    @DisplayName("Should Return Ok When Restaurant Name Is Available")
    void should_ReturnOk_When_RestaurantNameIsAvailable() throws Exception {
        when(restaurantService.restaurantExists("Available Restaurant")).thenReturn(false);
    
        mockMvc.perform(get("/validate/restaurant-name").param("data", "Available Restaurant"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("restaurant name is available"));
    }

    @Test
    @DisplayName("Should Return Restaurant Types Successfully")
    void should_ReturnRestaurantTypesSuccessfully() throws Exception {
        Set<String> types = Set.of("Italian", "Chinese", "Mexican");
        when(restaurantService.getRestaurantTypes()).thenReturn(types);

        mockMvc.perform(get("/restaurants/types"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("restaurant types"))
                .andExpect(jsonPath("$.data").isArray())
                .andExpect(jsonPath("$.data").value(types.stream().collect(Collectors.toList())));
        }

    
    private Map<String, Object> createValidRestaurantRequestParams() {
        Map<String, Object> requestParams = new HashMap<>();
        requestParams.put("name", "Test");
        requestParams.put("type", "Food Type");
        requestParams.put("startTime", "07:00");
        requestParams.put("endTime", "19:00");
        requestParams.put("description", "Test Description");
        requestParams.put("address", Map.of("country", "Country", "city", "City", "street", "Street"));
        return requestParams;
    }

}
