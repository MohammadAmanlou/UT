package mizdooni.config.error;

import jakarta.servlet.http.HttpServletRequest;
import mizdooni.response.Response;
import org.springframework.boot.autoconfigure.web.servlet.error.AbstractErrorController;
import org.springframework.boot.web.error.ErrorAttributeOptions;
import org.springframework.boot.web.servlet.error.ErrorAttributes;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class ErrorController extends AbstractErrorController {
    public ErrorController(ErrorAttributes errorAttributes) {
        super(errorAttributes);
    }

    @RequestMapping("/error")
    public ResponseEntity<Response> error(HttpServletRequest request) {
        ErrorAttributeOptions errorAttributeOptions = ErrorAttributeOptions.of(ErrorAttributeOptions.Include.MESSAGE);
        Map<String, Object> body = this.getErrorAttributes(request, errorAttributeOptions);
        HttpStatus status = this.getStatus(request);
        String message = (String) body.get("message");
        String error = (String) body.get("error");
        return ResponseEntity.status(status).body(new Response(status, message, false, error, null));
    }
}
