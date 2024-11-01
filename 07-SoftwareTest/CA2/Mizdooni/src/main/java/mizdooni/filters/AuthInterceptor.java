package mizdooni.filters;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mizdooni.response.ResponseException;
import mizdooni.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import java.lang.reflect.Method;

public class AuthInterceptor implements HandlerInterceptor {
    private UserService userService;

    public AuthInterceptor(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        if (!(handler instanceof HandlerMethod)) {
            return true;
        }
        Method method = ((HandlerMethod) handler).getMethod();
        if (!method.isAnnotationPresent(LoginRequired.class) &&
                !method.getDeclaringClass().isAnnotationPresent(LoginRequired.class)) {
            return true;
        }
        if (userService.getCurrentUser() == null) {
            throw new ResponseException(HttpStatus.FORBIDDEN, "login required");
        }
        return true;
    }
}
