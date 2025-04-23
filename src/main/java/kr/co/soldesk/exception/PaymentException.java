package kr.co.soldesk.exception;

import org.springframework.http.HttpStatus;

public class PaymentException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    private final HttpStatus statusCode;

    public PaymentException(String message) {
        super(message);
        this.statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
    }

    public PaymentException(String message, HttpStatus statusCode) {
        super(message);
        this.statusCode = statusCode;
    }

    public PaymentException(String message, Throwable cause) {
        super(message, cause);
        this.statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
    }

    public PaymentException(String message, Throwable cause, HttpStatus statusCode) {
        super(message, cause);
        this.statusCode = statusCode;
    }

    public HttpStatus getStatusCode() {
        return statusCode;
    }
}