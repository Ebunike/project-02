package kr.co.soldesk.exception;

import org.springframework.http.HttpStatus;

public class ReservationException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    private final HttpStatus statusCode;

    public ReservationException(String message) {
        super(message);
        this.statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
    }

    public ReservationException(String message, HttpStatus statusCode) {
        super(message);
        this.statusCode = statusCode;
    }

    public ReservationException(String message, Throwable cause) {
        super(message, cause);
        this.statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
    }

    public ReservationException(String message, Throwable cause, HttpStatus statusCode) {
        super(message, cause);
        this.statusCode = statusCode;
    }

    public HttpStatus getStatusCode() {
        return statusCode;
    }
}