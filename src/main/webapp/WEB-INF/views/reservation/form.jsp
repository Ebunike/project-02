<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>원데이 클래스 예약</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <style>
        .reservation-form {
            width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .class-info {
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .class-meta {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
            color: #666;
        }
        .total-price {
            font-size: 18px;
            font-weight: bold;
            text-align: right;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="reservation-form">
            <h2>원데이 클래스 예약</h2>
            
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>
            
            <div class="class-info">
                <h3>${oneday.oneday_name}</h3>
                <p>${oneday.theme_name}</p>
                <div class="class-meta">
                    <span>
                        <fmt:formatDate value="${oneday.oneday_date}" pattern="yyyy년 MM월 dd일"/>
                        ${oneday.oneday_start} ~ ${oneday.oneday_end}
                    </span>
                    <span>
                        ${oneday.oneday_location}
                    </span>
                </div>
                <div class="class-meta">
                    <span>수강료: <fmt:formatNumber value="${oneday.oneday_price}" pattern="#,###"/>원</span>
                    <span>정원: ${oneday.current_participants} / ${oneday.oneday_personnel}명</span>
                </div>
            </div>
            
            <form action="<c:url value='/reservation/reserve'/>" method="post">
                <input type="hidden" name="oneday_index" value="${oneday.oneday_index}">
                
                <div class="form-group">
                    <label for="participantCount">예약 인원</label>
                    <select name="participant_count" id="participantCount" class="form-control" onchange="updateTotalPrice()">
                        <c:forEach var="i" begin="1" end="${oneday.oneday_personnel - oneday.current_participants}">
                            <option value="${i}">${i}명</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="specialRequests">요청사항 (선택)</label>
                    <textarea name="special_requests" id="specialRequests" class="form-control" 
                              placeholder="요청사항이 있으면 입력해주세요." rows="3" maxlength="200"></textarea>
                </div>
                
                <div class="form-group">
                    <label>
                        <input type="checkbox" name="agreeTerms" required> 예약 정보 및 취소 정책에 동의합니다. (필수)
                    </label>
                    <p class="help-text">
                        * 예약 확정 후 수업일 기준 3일 전까지 취소 시 100% 환불, 2일 전 취소 시 50% 환불, 
                        1일 전 취소 시 환불 불가합니다.
                    </p>
                </div>
                
                <div class="total-price">
                    총 결제 금액: <span id="totalPriceDisplay"><fmt:formatNumber value="${oneday.oneday_price}" pattern="#,###"/></span>원
                </div>
                
                <div class="form-group text-center">
                    <button type="submit" class="btn btn-primary">예약하기</button>
                    <a href="<c:url value='/oneday/detail/${oneday.oneday_index}'/>" class="btn">취소</a>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // 총 결제 금액 업데이트
        function updateTotalPrice() {
            var participantCount = document.getElementById('participantCount').value;
            var pricePerPerson = ${oneday.oneday_price};
            var totalPrice = participantCount * pricePerPerson;
            
            // 천 단위 콤마 포맷팅
            var formattedPrice = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            document.getElementById('totalPriceDisplay').textContent = formattedPrice;
        }
        
        // 폼 유효성 검사
        document.querySelector('form').addEventListener('submit', function(e) {
            var agreeTerms = document.querySelector('input[name="agreeTerms"]');
            
            if (!agreeTerms.checked) {
                alert('예약 정보 및 취소 정책에 동의해주세요.');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>