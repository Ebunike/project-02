<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 완료</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <jsp:include page="../include/header.jsp" />

    <div class="container">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="payment-success-container text-center">
                    <div class="success-icon">
                        <i class="fas fa-check-circle fa-5x text-success"></i>
                    </div>
                    <h2 class="mt-4">결제가 완료되었습니다</h2>
                    <p class="lead">예약이 성공적으로 완료되었습니다.</p>

                    <div class="payment-info mt-5">
                        <h4>예약 정보</h4>
                        <div class="payment-details">
                            <div class="row">
                                <div class="col-md-6 text-right">클래스명:</div>
                                <div class="col-md-6 text-left">${reservation.oneday_name}</div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 text-right">예약번호:</div>
                                <div class="col-md-6 text-left">${reservation.reservation_index}</div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 text-right">예약일시:</div>
                                <div class="col-md-6 text-left">
                                    <fmt:formatDate value="${reservation.reservation_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 text-right">클래스 일정:</div>
                                <div class="col-md-6 text-left">
                                    <fmt:formatDate value="${reservation.oneday_date}" pattern="yyyy-MM-dd HH:mm"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 text-right">인원:</div>
                                <div class="col-md-6 text-left">${reservation.participant_count}명</div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 text-right">결제금액:</div>
                                <div class="col-md-6 text-left">
                                    <fmt:formatNumber value="${reservation.total_amount}" pattern="#,###"/>원
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mt-5">
                        <c:if test="${isNaverCalendarConnected}">
                            <p>네이버 캘린더에 일정이 추가되었습니다!</p>
                        </c:if>

                        <div class="mt-4">
                            <a href="<c:url value='/reservation/list'/>" class="btn btn-primary mr-2">내 예약 확인</a>
                            <a href="<c:url value='/oneday/list'/>" class="btn btn-secondary">다른 클래스 보기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</body>
</html>