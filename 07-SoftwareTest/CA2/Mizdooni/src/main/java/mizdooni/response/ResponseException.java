package mizdooni.response;

import org.springframework.http.HttpStatus;

public class ResponseException extends RuntimeException {
    private HttpStatus status;
    private String error;

    public ResponseException(HttpStatus status, String message, String error) {
        super(message);
        this.status = status;
        this.error = error;
    }

    public ResponseException(HttpStatus status, String message) {
        this(status, message, (String) null);
    }

    public ResponseException(HttpStatus status, String message, Exception ex) {
        this(status, message, ex.getClass().getSimpleName());
    }

    public ResponseException(HttpStatus status, Exception ex) {
        this(status, ex.getMessage(), ex);
    }

    public HttpStatus getStatus() {
        return status;
    }

    public String getError() {
        return error;
    }
}
