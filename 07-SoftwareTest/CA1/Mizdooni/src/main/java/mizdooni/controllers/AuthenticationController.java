package mizdooni.controllers;

import mizdooni.model.Address;
import mizdooni.model.User;
import mizdooni.response.Response;
import mizdooni.response.ResponseException;
import mizdooni.service.ServiceUtils;
import mizdooni.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

import static mizdooni.controllers.ControllerUtils.PARAMS_BAD_TYPE;
import static mizdooni.controllers.ControllerUtils.PARAMS_MISSING;

@RestController
public class AuthenticationController {
    @Autowired
    private UserService userService;

    @GetMapping("/user")
    public Response user() {
        User user = userService.getCurrentUser();
        if (user == null) {
            throw new ResponseException(HttpStatus.UNAUTHORIZED, "no user logged in");
        }
        return Response.ok("current user", user);
    }

    @PostMapping("/login")
    public Response login(@RequestBody Map<String, String> params) {
        String username = params.get("username");
        String password = params.get("password");

        if (!ControllerUtils.doExist(username, password)) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, PARAMS_MISSING);
        }

        if (userService.login(username, password)) {
            return Response.ok("login successful", userService.getCurrentUser());
        }
        throw new ResponseException(HttpStatus.UNAUTHORIZED, "invalid username or password");
    }

    @PostMapping("/signup")
    public Response signup(@RequestBody Map<String, Object> params) {
        if (!ControllerUtils.containsKeys(params, "username", "password", "email", "address", "role")) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, PARAMS_MISSING);
        }

        String username, password, email;
        Address address;
        User.Role role;

        try {
            username = (String) params.get("username");
            password = (String) params.get("password");
            email = (String) params.get("email");
            role = User.Role.valueOf((String) params.get("role"));
            Map<String, String> addr = (Map<String, String>) params.get("address");
            address = new Address(addr.get("country"), addr.get("city"), null);
        } catch (Exception ex) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, PARAMS_BAD_TYPE);
        }

        if (!ControllerUtils.doExist(username, password, email, address.getCountry(), address.getCity())) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, PARAMS_MISSING);
        }

        try {
            userService.signup(username, password, email, address, role);
            userService.login(username, password);
            return Response.ok("signup successful", userService.getCurrentUser());
        } catch (Exception ex) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, ex);
        }
    }

    @PostMapping("/logout")
    public Response logout() {
        if (userService.logout()) {
            return Response.ok("logout successful");
        }
        throw new ResponseException(HttpStatus.UNAUTHORIZED, "no user logged in");
    }

    @GetMapping("/validate/username")
    public Response validateUsername(@RequestParam("data") String username) {
        if (!ServiceUtils.validateUsername(username)) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, "invalid username format");
        }
        if (userService.usernameExists(username)) {
            throw new ResponseException(HttpStatus.CONFLICT, "username already exists");
        }
        return Response.ok("username is available");
    }

    @GetMapping("/validate/email")
    public Response validateEmail(@RequestParam("data") String email) {
        if (!ServiceUtils.validateEmail(email)) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, "invalid email format");
        }
        if (userService.emailExists(email)) {
            throw new ResponseException(HttpStatus.CONFLICT, "email already registered");
        }
        return Response.ok("email not registered");
    }
}
