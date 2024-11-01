package mizdooni.controllers;

import mizdooni.exceptions.DuplicatedUsernameEmail;
import mizdooni.exceptions.InvalidEmailFormat;
import mizdooni.exceptions.InvalidUsernameFormat;
import mizdooni.model.Address;
import mizdooni.model.User;
import mizdooni.response.Response;
import mizdooni.response.ResponseException;
import mizdooni.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class AuthenticationControllerTest {

    @Mock
    private UserService userService;

    @InjectMocks
    private AuthenticationController authenticationController;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("Test user with logged in user")
    void Should_ReturnCurrentUser_When_UserIsLoggedIn() {
        User mockUser = new User("Fereshte", "123", "f@gmail.com", new Address("Iran", "Tehran", "6-th"), User.Role.client);

        when(userService.getCurrentUser()).thenReturn(mockUser);

        Response response = authenticationController.user();

        assertNotNull(response);
        assertEquals("current user", response.getMessage());
        assertEquals(mockUser, response.getData());
    }

    @Test
    @DisplayName("Test user with no logged in user")
    void Should_ThrowUnauthorizedException_When_NoUserIsLoggedIn() {
        when(userService.getCurrentUser()).thenReturn(null);

        ResponseException exception = assertThrows(ResponseException.class, () -> authenticationController.user());

        assertEquals(HttpStatus.UNAUTHORIZED, exception.getStatus());
        assertEquals("no user logged in", exception.getMessage());
    }

    @Test
    @DisplayName("Test login with correct credentials")
    void Should_ReturnLoginSuccess_When_CredentialsAreCorrect() {
        Map<String, String> params = new HashMap<>();
        params.put("username", "Fereshte");
        params.put("password", "123");
        User mockUser = new User("Fereshte", "123", "f@gmail.com", new Address("Iran", "Tehran", "6-th"), User.Role.client);

        when(userService.login("Fereshte", "123")).thenReturn(true);
        when(userService.getCurrentUser()).thenReturn(mockUser);

        Response response = authenticationController.login(params);

        assertNotNull(response);
        assertEquals("login successful", response.getMessage());
        assertEquals(mockUser, response.getData());
    }

    @Test
    @DisplayName("Test login with incorrect credentials")
    void Should_ThrowUnauthorizedException_When_CredentialsAreIncorrect() {
        Map<String, String> params = new HashMap<>();
        params.put("username", "testuser");
        params.put("password", "wrongpassword");

        when(userService.login("testuser", "wrongpassword")).thenReturn(false);

        ResponseException exception = assertThrows(ResponseException.class, () -> authenticationController.login(params));

        assertEquals(HttpStatus.UNAUTHORIZED, exception.getStatus());
        assertEquals("invalid username or password", exception.getMessage());
    }

    @Test
    @DisplayName("Test login with missing credentials")
    void Should_ThrowBadRequestException_When_CredentialsAreMissing() {
        Map<String, String> params = new HashMap<>();
        params.put("password", "wrongpassword");

        ResponseException exception = assertThrows(ResponseException.class, () -> authenticationController.login(params));

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals(ControllerUtils.PARAMS_MISSING, exception.getMessage());
    }

    @Test
    @DisplayName("Test signup with missing required parameters")
    void Should_ThrowBadRequestException_When_RequiredParametersAreMissingOnSignUp() {
        Map<String, Object> params = new HashMap<>();
        params.put("username", "newuser");

        ResponseException exception = assertThrows(ResponseException.class, () -> authenticationController.signup(params));

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals(ControllerUtils.PARAMS_MISSING, exception.getMessage());
    }

    @Test
    @DisplayName("Test signup with invalid parameter type")
    void Should_ThrowBadRequestException_When_InvalidParameterTypeProvided() {
        Map<String, Object> params = new HashMap<>();
        params.put("username", "Fereshte");
        params.put("password", "pass123");
        params.put("email", "f@gmail.com");
        params.put("role", "client");
        params.put("address", "This should be a map, not a string");

        ResponseException exception = assertThrows(ResponseException.class, () -> authenticationController.signup(params));

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals(ControllerUtils.PARAMS_BAD_TYPE, exception.getMessage());
    }

    @Test
    @DisplayName("Test signup with missing address fields")
    void Should_ThrowBadRequestException_When_AddressFieldsAreMissing() {
        Map<String, Object> params = new HashMap<>();
        params.put("username", "newuser");
        params.put("password", "pass123");
        params.put("email", "f@gmail.com");
        params.put("role", "manager");

        Map<String, String> addressMap = new HashMap<>();
        addressMap.put("country", "Iran");
        params.put("address", addressMap);

        ResponseException exception = assertThrows(ResponseException.class, () -> authenticationController.signup(params));

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals(ControllerUtils.PARAMS_MISSING, exception.getMessage());
    }

    @Test
    @DisplayName("Test signup when signup service throws an exception")
    void Should_ThrowBadRequestException_When_SignupServiceThrowsException() throws DuplicatedUsernameEmail, InvalidUsernameFormat, InvalidEmailFormat {
        Map<String, Object> params = new HashMap<>();
        params.put("username", "Fereshte");
        params.put("password", "pass123");
        params.put("email", "f@gmail.com");

        Map<String, String> addressMap = new HashMap<>();
        addressMap.put("country", "Iran");
        addressMap.put("city", "Tehran");
        addressMap.put("street", "6-th");
        params.put("address", addressMap);
        params.put("role", "manager");

        doThrow(new RuntimeException("Signup failed")).when(userService).signup(anyString(), anyString(), anyString(), any(Address.class), any(User.Role.class));

        ResponseException exception = assertThrows(ResponseException.class, () -> authenticationController.signup(params));

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertTrue(exception.getMessage().contains("Signup failed"), "Expected message to contain 'Signup failed'");
    }

    @Test
    @DisplayName("Test signup with all valid parameters")
    void Should_ReturnSignupSuccess_When_AllParametersAreValid() throws DuplicatedUsernameEmail, InvalidUsernameFormat, InvalidEmailFormat {
        Map<String, Object> params = new HashMap<>();
        params.put("username", "Fereshte");
        params.put("password", "pass123");
        params.put("email", "f@gmail.com");

        Map<String, String> addressMap = new HashMap<>();
        addressMap.put("country", "Iran");
        addressMap.put("city", "Tehran");
        params.put("address", addressMap);
        params.put("role", "manager");

        User mockUser = new User("Fereshte", "pass123", "f@gmail.com", new Address("Iran", "Tehran", "6-th"), User.Role.manager);
        when(userService.getCurrentUser()).thenReturn(mockUser);

        String expectedUsername = "Fereshte";
        String expectedPassword = "pass123";
        String expectedEmail = "f@gmail.com";
        Address expectedAddress = new Address("Iran", "Tehran", null);
        User.Role expectedRole = User.Role.manager;

        Response response = authenticationController.signup(params);

        assertNotNull(response);
        assertEquals("signup successful", response.getMessage());
        assertEquals(mockUser, response.getData());

        verify(userService).signup(eq(expectedUsername), eq(expectedPassword), eq(expectedEmail), refEq(expectedAddress), eq(expectedRole));
        verify(userService).login(expectedUsername, expectedPassword);
    }

    @Test
    @DisplayName("Test signup with missing parameters")
    void Should_ThrowBadRequestException_When_ParametersAreMissingForSignup() {
        Map<String, Object> params = new HashMap<>();
        params.put("username", "Fereshte");

        ResponseException exception = assertThrows(ResponseException.class, () -> authenticationController.signup(params));

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals(ControllerUtils.PARAMS_MISSING, exception.getMessage());
    }

    @Test
    @DisplayName("Test logout with logged in user")
    void Should_ReturnLogoutSuccess_When_UserIsLoggedIn() {
        when(userService.logout()).thenReturn(true);

        Response response = authenticationController.logout();

        assertNotNull(response);
        assertEquals("logout successful", response.getMessage());
    }

    @Test
    @DisplayName("Test logout with no logged in user")
    void Should_ThrowUnauthorizedException_When_NoUserIsLoggedInOnLogout() {
        when(userService.logout()).thenReturn(false);

        ResponseException exception = assertThrows(ResponseException.class, () -> authenticationController.logout());

        assertEquals(HttpStatus.UNAUTHORIZED, exception.getStatus());
        assertEquals("no user logged in", exception.getMessage());
    }

    @Test
    @DisplayName("Test validateUsername with available username")
    void Should_ReturnUsernameAvailable_When_UsernameIsValidAndAvailable() {
        String username = "newuser";

        when(userService.usernameExists(username)).thenReturn(false);

        Response response = authenticationController.validateUsername(username);

        assertNotNull(response);
        assertEquals("username is available", response.getMessage());
    }

    @Test
    @DisplayName("Test validateUsername with existing username")
    void Should_ThrowConflictException_When_UsernameAlreadyExists() {
        String username = "existing_username";

        when(userService.usernameExists(username)).thenReturn(true);

        ResponseException exception = assertThrows(ResponseException.class, () -> authenticationController.validateUsername(username));

        assertEquals(HttpStatus.CONFLICT, exception.getStatus());
        assertEquals("username already exists", exception.getMessage());
    }

    @Test
    @DisplayName("Test validateUsername with invalid format")
    void Should_ThrowBadRequestException_When_UsernameIsInvalid() {
        String username = "invalid@username";

        ResponseException exception = assertThrows(ResponseException.class, () -> authenticationController.validateUsername(username));

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals("invalid username format", exception.getMessage());
    }

    @Test
    @DisplayName("Test validateEmail with unregistered email")
    void Should_ReturnEmailNotRegistered_When_EmailIsValidAndAvailable() {
        String email = "test@yahoo.com";

        when(userService.emailExists(email)).thenReturn(false);

        Response response = authenticationController.validateEmail(email);

        assertNotNull(response);
        assertEquals("email not registered", response.getMessage());
    }

    @Test
    @DisplayName("Test validateEmail with already registered email")
    void Should_ThrowConflictException_When_EmailAlreadyRegistered() {
        String email = "existing@gmail.com";

        when(userService.emailExists(email)).thenReturn(true);

        ResponseException exception = assertThrows(ResponseException.class, () -> authenticationController.validateEmail(email));

        assertEquals(HttpStatus.CONFLICT, exception.getStatus());
        assertEquals("email already registered", exception.getMessage());
    }

    @Test
    @DisplayName("Test validateEmail with invalid format")
    void Should_ThrowBadRequestException_When_EmailFormatIsInvalid() {
        String email = "existinggmail.com";

        ResponseException exception = assertThrows(ResponseException.class, () -> authenticationController.validateEmail(email));

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatus());
        assertEquals("invalid email format", exception.getMessage());
    }
}
