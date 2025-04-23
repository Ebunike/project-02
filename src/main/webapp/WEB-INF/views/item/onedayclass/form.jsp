<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 - ${oneday.oneday_name}</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
 
    <div class="container">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="reservation-container">
                    <h2 class="text-center mb-4">예약 정보 입력</h2>

                    <div class="oneday-summary mb-4">
                        <div class="row align-items-center">
                            <div class="col-md-3">
                                <img src="<c:url value='/upload/${oneday.oneday_imageUrl}'/>" alt="${oneday.oneday_name}" class="img-fluid rounded">
                            </div>
                            <div class="col-md-9">
                                <h4>${oneday.oneday_name}</h4>
                                <p>
                                    <i class="far fa-calendar-alt"></i>
                                    <fmt:formatDate value="${oneday.oneday_date}" pattern="yyyy-MM-dd HH:mm"/>
                                </p>
                                <p>
                                    <i class="fas fa-map-marker-alt"></i> ${oneday.oneday_location}
                                </p>
                                <p>
                                    <i class="fas fa-won-sign"></i> <fmt:formatNumber value="${oneday.oneday_price}" pattern="#,###"/>원
                                </p>
                                <p>
                                    <i class="fas fa-users"></i> 현재 ${oneday.current_participants}명 / ${oneday.oneday_max_participants}명
                                </p>
                            </div>
                        </div>
                    </div>

                    <form action="<c:url value='/oneday/payment/prepare/${oneday.oneday_index}'/>" method="get" id="reservationForm">
                        <div class="form-group">
                            <label class="form-label" for="count">예약 인원</label>
                            <select class="form-control" id="count" name="count">
                                <c:forEach begin="1" end="${oneday.oneday_max_participants - oneday.current_participants}" var="i">
                                    <option value="${i}">${i}명</option>
                                </c:forEach>
                            </select>
                            <small class="form-text text-muted">최대 예약 가능 인원: ${oneday.oneday_max_participants - oneday.current_participants}명</small>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="name">예약자 이름</label>
                            <input type="text" class="form-control" id="name" name="name" value="${loginMember.name}" readonly>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="phone">연락처</label>
                            <input type="text" class="form-control" id="phone" name="phone" value="${loginMember.phone}" placeholder="010-0000-0000">
                            <small class="form-text text-muted">클래스 안내를 위한 연락처입니다.</small>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="specialRequests">요청사항 (선택)</label>
                            <textarea class="form-control" id="specialRequests" name="specialRequests" rows="3" placeholder="알레르기, 주차 등 요청사항을 입력해주세요."></textarea>
                        </div>

                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                            <label class="form-check-label" for="agreeTerms">
                                이용약관 및 개인정보 처리방침에 동의합니다.
                            </label>
                        </div>

                        <div class="reservation-summary">
                            <h4>결제 정보</h4>
                            <table class="table">
                                <tr>
                                    <td>클래스 가격</td>
                                    <td class="text-right"><fmt:formatNumber value="${oneday.oneday_price}" pattern="#,###"/>원 × <span id="selectedCount">1</span>명</td>
                                </tr>
                                <tr class="total-row">
                                    <td><strong>총 결제 금액</strong></td>
                                    <td class="text-right"><strong id="totalAmount"><fmt:formatNumber value="${oneday.oneday_price}" pattern="#,###"/>원</strong></td>
                                </tr>
                            </table>
                        </div>

                        <div class="text-center mt-4">
                            <button type="submit" class="btn btn-primary" id="paymentBtn">결제하기</button>
                            <a href="<c:url value='/oneday/detail/${oneday.oneday_index}'/>" class="btn btn-secondary ml-2">취소</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <script>
    $(document).ready(function() {
        // 가격 계산
        $('#count').on('change', function() {
            updateTotalPrice();
        });

        function updateTotalPrice() {
            const count = $('#count').val();
            $('#selectedCount').text(count);

            const pricePerPerson = ${oneday.oneday_price};
            const totalPrice = count * pricePerPerson;

            $('#totalAmount').text(totalPrice.toLocaleString() + '원');
        }

        // 폼 제출 전 유효성 검사
        $('#reservationForm').on('submit', function(e) {
            if (!$('#agreeTerms').is(':checked')) {
                alert('이용약관 및 개인정보 처리방침에 동의해주세요.');
                e.preventDefault();
                return false;
            }

            const phone = $('#phone').val();
            if (!phone || phone.trim() === '') {
                alert('연락처를 입력해주세요.');
                $('#phone').focus();
                e.preventDefault();
                return false;
            }

            return true;
        });
    });
    </script>
</body>
</html>