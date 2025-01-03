package mizdooni.controllers;

import mizdooni.exceptions.*;
import mizdooni.model.Reservation;
import mizdooni.model.User;
import mizdooni.model.Restaurant;
import mizdooni.model.Table;
import mizdooni.response.Response;
import mizdooni.response.ResponseException;
import mizdooni.service.ReservationService;
import mizdooni.service.RestaurantService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import static mizdooni.controllers.ControllerUtils.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

public class ReservationControllerTest {

    @Mock
    private RestaurantService restaurantService;

    @Mock
    private ReservationService reservationService;

    @InjectMocks
    private ReservationController reservationController;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        Restaurant mockRestaurant = mock(Restaurant.class);
        when(restaurantService.getRestaurant(anyInt())).thenReturn(mockRestaurant);
    }


    @ParameterizedTest
    @CsvSource({
        "1, 1, 2024-01-01",
        "1, 1, ''",
        "1, 1, null"
    })
    @DisplayName("Test successful retrieval of reservations with various dates")
    void should_SuccessfullyRetrieveReservations_When_ValidInput(int restaurantId, int tableId, String date) 
            throws RestaurantNotFound, UserNotManager, InvalidManagerRestaurant, TableNotFound {
    
        List<Reservation> mockReservations = new ArrayList<>();
        mockReservations.add(createMockReservation());
    
        LocalDate parsedDate = ("null".equals(date) || date.isEmpty()) ? null : LocalDate.parse(date);
        when(reservationService.getReservations(eq(restaurantId), eq(tableId), eq(parsedDate))).thenReturn(mockReservations);
    
        Response response = reservationController.getReservations(restaurantId, tableId, parsedDate == null ? null : date);
    
        assertEquals(HttpStatus.OK, response.getStatus());
        assertEquals(mockReservations, response.getData());
        verify(reservationService, times(1)).getReservations(eq(restaurantId), eq(tableId), eq(parsedDate));
    }

    @Test
    @DisplayName("Test retrieval of reservations with invalid date format")
    void should_ThrowException_When_InvalidDateFormat() {
        ResponseException exception = assertThrows(ResponseException.class, () ->
                reservationController.getReservations(1, 1, "invalid-date"));

        assertEquals(PARAMS_BAD_TYPE, exception.getMessage());
        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
    }

    @Test
    @DisplayName("Test retrieval of reservations with exception in getReservations")
    void should_ThrowException_When_ExceptionInGetReservations() 
            throws RestaurantNotFound, UserNotManager, InvalidManagerRestaurant, TableNotFound {
        
        int restaurantId = 1;
        int tableId = 1;
        String date = "2024-01-01";
    
        doThrow(new ResponseException(HttpStatus.BAD_REQUEST, "Unable to retrieve reservations"))
            .when(reservationService).getReservations(anyInt(), anyInt(), any(LocalDate.class));
    
        ResponseException exception = assertThrows(ResponseException.class, () -> {
            reservationController.getReservations(restaurantId, tableId, date);
        });
    
        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals("Unable to retrieve reservations", exception.getMessage());
        verify(reservationService, times(1)).getReservations(anyInt(), anyInt(), any(LocalDate.class));
    }

    @Test
    @DisplayName("Test successful retrieval of customer reservations")
    void should_SuccessfullyRetrieveCustomerReservations_When_ValidInput() throws UserNotFound, UserNoAccess, RestaurantNotFound, UserNotManager, InvalidManagerRestaurant, TableNotFound {
        List<Reservation> mockReservations = new ArrayList<>();
        mockReservations.add(createMockReservation());
        when(reservationService.getCustomerReservations(anyInt())).thenReturn(mockReservations);

        Response response = reservationController.getCustomerReservations(1);

        assertEquals(HttpStatus.OK, response.getStatus());
        assertEquals(mockReservations, response.getData());
        verify(reservationService, times(1)).getCustomerReservations(anyInt());
    }

    @Test
    @DisplayName("Test retrieval of customer reservations with exception in getCustomerReservations")
    void should_ThrowException_When_ExceptionInGetCustomerReservations() 
            throws UserNotFound, UserNoAccess, RestaurantNotFound, UserNotManager, InvalidManagerRestaurant, TableNotFound {

        doThrow(new ResponseException(HttpStatus.BAD_REQUEST, "Unable to retrieve customer reservations"))
            .when(reservationService).getCustomerReservations(anyInt());

        ResponseException exception = assertThrows(ResponseException.class, () -> {
            reservationController.getCustomerReservations(anyInt());
        });

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals("Unable to retrieve customer reservations", exception.getMessage());
        verify(reservationService, times(1)).getCustomerReservations(anyInt());
    }

    @Test
    @DisplayName("Test successful retrieval of available times")
    void should_SuccessfullyRetrieveAvailableTimes_When_ValidInput() throws RestaurantNotFound, UserNotManager, InvalidManagerRestaurant, TableNotFound, BadPeopleNumber, DateTimeInThePast {
        when(restaurantService.getRestaurant(anyInt())).thenReturn(mock(Restaurant.class));
        List<LocalTime> mockAvailableTimes = List.of(LocalTime.of(12, 0), LocalTime.of(14, 0));
        when(reservationService.getAvailableTimes(anyInt(), anyInt(), any(LocalDate.class))).thenReturn(mockAvailableTimes);

        Response response = reservationController.getAvailableTimes(1, 4, "2024-01-01");

        assertEquals(HttpStatus.OK, response.getStatus());
        assertEquals(mockAvailableTimes, response.getData());
        verify(reservationService, times(1)).getAvailableTimes(anyInt(), anyInt(), any(LocalDate.class));
    }

    @Test
    @DisplayName("Test retrieval of available times with invalid date format")
    void should_ThrowException_When_InvalidDateFormatForAvailableTimes() {
        ResponseException exception = assertThrows(ResponseException.class, () ->
                reservationController.getAvailableTimes(1, 4, "invalid-date"));
        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
    }

    @Test
    @DisplayName("Test retrieval of available times with exception in getAvailableTimes")
    void should_ThrowException_When_ExceptionInGetAvailableTimes() 
            throws RestaurantNotFound, UserNotManager, InvalidManagerRestaurant, TableNotFound, BadPeopleNumber, DateTimeInThePast {

        when(restaurantService.getRestaurant(anyInt())).thenReturn(mock(Restaurant.class));

        doThrow(new ResponseException(HttpStatus.BAD_REQUEST, "Unable to retrieve available times"))
            .when(reservationService).getAvailableTimes(anyInt(), anyInt(), any(LocalDate.class));

        ResponseException exception = assertThrows(ResponseException.class, () -> 
            reservationController.getAvailableTimes(1, 4, "2024-01-01")
        );

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals("Unable to retrieve available times", exception.getMessage());
        verify(reservationService, times(1)).getAvailableTimes(anyInt(), anyInt(), any(LocalDate.class));
    }

    @Test
    @DisplayName("Test successful addition of reservation")
    void should_SuccessfullyAddReservation_When_ValidInput() throws UserNotFound, ManagerReservationNotAllowed, InvalidWorkingTime, DateTimeInThePast, ReservationNotInOpenTimes, RestaurantNotFound, UserNotManager, InvalidManagerRestaurant, TableNotFound {
        when(restaurantService.getRestaurant(anyInt())).thenReturn(mock(Restaurant.class));
        Reservation mockReservation = createMockReservation();
        Map<String, String> params = new HashMap<>();
        params.put("people", "4");
        params.put("datetime", "2024-01-01 12:00");
        when(reservationService.reserveTable(anyInt(), anyInt(), any(LocalDateTime.class))).thenReturn(mockReservation);

        Response response = reservationController.addReservation(1, params);

        assertEquals(HttpStatus.OK, response.getStatus());
        assertEquals(mockReservation, response.getData());
        verify(reservationService, times(1)).reserveTable(anyInt(), anyInt(), any(LocalDateTime.class));
    }

    @Test
    @DisplayName("Test addition of reservation with missing parameters")
    void should_ThrowException_When_MissingParamsForReservation() {
        Map<String, String> params = new HashMap<>();
        params.put("people", "4");
        
        ResponseException exception = assertThrows(ResponseException.class, () ->
                reservationController.addReservation(1, params));
        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
    }

    @Test
    @DisplayName("Test addition of reservation with invalid people parameters")
    void should_ThrowException_When_InvalidPeopleParameter() {
        Map<String, String> params = new HashMap<>();
        params.put("people", "P");
        params.put("datetime", "2024-01-01 12:00");
        ResponseException exception = assertThrows(ResponseException.class, () ->
                reservationController.addReservation(1, params));
        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals(PARAMS_BAD_TYPE, exception.getMessage());
    }

    @Test
    @DisplayName("Test addition of reservation with invalid datetime parameters")
    void should_ThrowException_When_InvalidDateTimeParameter() {
        Map<String, String> params = new HashMap<>();
        params.put("people", "4");
        params.put("datetime", "Mewooo");
        ResponseException exception = assertThrows(ResponseException.class, () ->
                reservationController.addReservation(1, params));
        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals(PARAMS_BAD_TYPE, exception.getMessage());
    }

    @Test
    @DisplayName("Test addition of reservation when reserveTable throws exception")
    void should_ThrowException_When_ReserveTableThrowsException() 
            throws UserNotFound, ManagerReservationNotAllowed, InvalidWorkingTime, DateTimeInThePast, ReservationNotInOpenTimes, RestaurantNotFound, UserNotManager, InvalidManagerRestaurant, TableNotFound {

        when(restaurantService.getRestaurant(anyInt())).thenReturn(mock(Restaurant.class));

        Map<String, String> params = new HashMap<>();
        params.put("people", "4");
        params.put("datetime", "2024-01-01 12:00");

        doThrow(new ResponseException(HttpStatus.BAD_REQUEST, "Unable to make reservation"))
            .when(reservationService).reserveTable(anyInt(), anyInt(), any(LocalDateTime.class));

        ResponseException exception = assertThrows(ResponseException.class, () -> 
            reservationController.addReservation(1, params)
        );

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals("Unable to make reservation", exception.getMessage());
        verify(reservationService, times(1)).reserveTable(anyInt(), anyInt(), any(LocalDateTime.class));
    }

    @Test
    @DisplayName("Test successful cancellation of reservation")
    void should_SuccessfullyCancelReservation_When_ValidInput() throws UserNotFound, ReservationNotFound, ReservationCannotBeCancelled {
        Response response = reservationController.cancelReservation(123);

        assertEquals(HttpStatus.OK, response.getStatus());
        verify(reservationService, times(1)).cancelReservation(123);
    }

    @Test
    @DisplayName("Test failure when cancelling a reservation") 
    void should_ThrowException_When_CancellationFails() throws UserNotFound, ReservationNotFound, ReservationCannotBeCancelled {
        doThrow(new ResponseException(HttpStatus.BAD_REQUEST, "can not cancel the reservation")).when(reservationService).cancelReservation(anyInt());

        ResponseException exception = assertThrows(ResponseException.class, () ->
                reservationController.cancelReservation(123));
        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        verify(reservationService, times(1)).cancelReservation(anyInt());
    }

    private Reservation createMockReservation() {
        User mockUser = mock(User.class);
        Restaurant mockRestaurant = mock(Restaurant.class);
        Table mockTable = mock(Table.class);
        LocalDateTime mockDateTime = LocalDateTime.of(2024, 1, 1, 12, 0);
        return new Reservation(mockUser, mockRestaurant, mockTable, mockDateTime);
    }
}
