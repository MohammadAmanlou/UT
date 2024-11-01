package mizdooni.response;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ResponseExceptionHandler {
    @ExceptionHandler(ResponseException.class)
    private ResponseEntity<Response> handleException(ResponseException ex) {
        return ResponseEntity.status(ex.getStatus())
                .body(new Response(ex.getStatus(), ex.getMessage(), false, ex.getError(), null));
    }
}
