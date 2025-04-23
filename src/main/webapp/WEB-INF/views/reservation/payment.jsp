<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 - ${oneday.oneday_name}</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

    <div class="container">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="payment-header">
                    <h2>결제 정보</h2>
                    <p>아래 정보를 확인하시고 결제를 진행해주세요.</p>
                </div>

                <div class="payment-summary">
                    <h3>주문 정보</h3>
                    <div class="payment-item">
                    	<span class="label">주문번호</span>
                    	<span class="value" id="orderIdDisplay"></span>
                    </div>
                    <div class="payment-item">
                        <span>클래스명</span>
                        <span>${oneday.oneday_name}</span>
                    </div>
                    <div class="payment-item">
                        <span>일정</span>
                        <span><fmt:formatDate value="${oneday.oneday_date}" pattern="yyyy년 MM월 dd일 HH:mm"/></span>
                    </div>
                    <div class="payment-item">
                        <span>장소</span>
                        <span>${oneday.oneday_location}</span>
                    </div>
                    <div class="payment-item">
                        <span>예약자</span>
                        <span>${loginMember.name} (${loginMember.id})</span>
                    </div>
                    <div class="payment-item">
                        <span>인원</span>
                        <span>${count}명</span>
                    </div>
                    <div class="payment-item">
                        <span>가격</span>
                        <span><fmt:formatNumber value="${oneday.oneday_price}" pattern="#,###"/>원 × ${count}명</span>
                    </div>
                    <c:if test="${not empty specialRequests}">
                        <div class="payment-item">
                            <span>요청사항</span>
                            <span>${specialRequests}</span>
                        </div>
                    </c:if>
                    <div class="payment-total">
                        총 결제금액: <fmt:formatNumber value="${totalAmount}" pattern="#,###"/>원
                    </div>
                </div>

                <div class="payment-method">
                    <h3 class="payment-method-title">결제 수단 선택</h3>
                    <button id="kakaopay-btn" class="payment-button">
                        <img src="<c:url value='/resources/images/payment/kakaopay.png'/>" alt="카카오페이">
                        카카오페이로 결제하기
                    </button>
                </div>

                <div class="text-center">
                    <a href="<c:url value='/oneday/detail/${oneday.oneday_index}'/>" class="btn btn-secondary">뒤로 가기</a>
                </div>
            </div>
        </div>
    </div>

    <script>
    
    function generateOrderId(length) {
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        let orderId = '';
        const orderDate = new Date().toISOString().slice(0, 10); // 현재 날짜 (형식: YYYY-MM-DD)
        // 최소 6자 이상 64자 이하로 생성
        const idLength = Math.max(6, Math.min(length, 64));
        
        for (let i = 0; i < idLength; i++) {
          const randomIndex = Math.floor(Math.random() * characters.length);
          orderId += characters[randomIndex];
        }
        //saveOrderToServer(orderId, orderDate);
        return orderId;
      }
    
  	const orderId = generateOrderId(10);
    
    document.getElementById('orderIdDisplay').textContent = orderId;
    
    
    $(document).ready(function() {
        $('#kakaopay-btn').click(function() {
            $.ajax({
                type: 'POST',
                url: '<c:url value="/oneday/payment/kakaopay"/>', // 경로 수정
                data: {
                    orderId: orderId,
                    onedayIndex: ${oneday.oneday_index},
                    count: ${count},
                    specialRequests: '${specialRequests}'
                },
                dataType: 'json',
                success: function(response) {
                    console.log(response);
                    window.location.href = response.next_redirect_pc_url;
                },
                error: function(error) {
                    console.error(error);
                    alert('결제 준비 중 오류가 발생했습니다. 다시 시도해주세요.');
                }
            });
        });
    });
    
  
    
    
    </script>
</body>
</html>