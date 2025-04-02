package kr.co.soldesk.exception;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(OnedayException.class)
    public ModelAndView handleOnedayException(OnedayException ex) {
        logger.error("원데이 클래스 예외 발생: {}", ex.getMessage(), ex);

        ModelAndView mav = new ModelAndView("error/oneday_error");
        mav.addObject("errorMessage", ex.getMessage());
        mav.addObject("statusCode", ex.getStatusCode());
        return mav;
    }

    @ExceptionHandler(PaymentException.class)
    public ModelAndView handlePaymentException(PaymentException ex) {
        logger.error("결제 관련 예외 발생: {}", ex.getMessage(), ex);

        ModelAndView mav = new ModelAndView("error/payment_error");
        mav.addObject("errorMessage", ex.getMessage());
        mav.addObject("statusCode", ex.getStatusCode());
        return mav;
    }

    @ExceptionHandler(ReservationException.class)
    public ModelAndView handleReservationException(ReservationException ex) {
        logger.error("예약 관련 예외 발생: {}", ex.getMessage(), ex);

        ModelAndView mav = new ModelAndView("error/reservation_error");
        mav.addObject("errorMessage", ex.getMessage());
        mav.addObject("statusCode", ex.getStatusCode());
        return mav;
    }

    @ExceptionHandler(MaxUploadSizeExceededException.class)
    @ResponseStatus(HttpStatus.PAYLOAD_TOO_LARGE)
    public ModelAndView handleMaxUploadSizeExceededException(MaxUploadSizeExceededException ex) {
        logger.error("파일 업로드 크기 초과: {}", ex.getMessage(), ex);

        ModelAndView mav = new ModelAndView("error/upload_error");
        mav.addObject("errorMessage", "업로드 파일의 크기가 제한을 초과했습니다. 5MB 이하의 파일을 선택해주세요.");
        mav.addObject("statusCode", HttpStatus.PAYLOAD_TOO_LARGE.value());
        return mav;
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ModelAndView handleNoHandlerFoundException(NoHandlerFoundException ex) {
        logger.error("페이지를 찾을 수 없음: {}", ex.getMessage(), ex);

        ModelAndView mav = new ModelAndView("error/404");
        mav.addObject("errorMessage", "요청하신 페이지를 찾을 수 없습니다.");
        mav.addObject("statusCode", HttpStatus.NOT_FOUND.value());
        return mav;
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ModelAndView handleException(Exception ex, HttpServletRequest request) {
        logger.error("서버 오류 발생: {}", ex.getMessage(), ex);

        ModelAndView mav = new ModelAndView("error/500");
        mav.addObject("errorMessage", "서버 내부 오류가 발생했습니다.");
        mav.addObject("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
        mav.addObject("exception", ex.getClass().getSimpleName());
        mav.addObject("url", request.getRequestURL());
        return mav;
    }
}