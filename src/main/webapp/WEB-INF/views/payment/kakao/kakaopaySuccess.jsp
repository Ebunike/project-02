<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카카오페이 결제 성공</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        
        .success-icon {
            text-align: center;
            font-size: 72px;
            color: #4CAF50;
            margin-bottom: 20px;
        }
        
        .payment-info {
            margin-top: 30px;
            border-top: 1px solid #eee;
            padding-top: 20px;
        }
        
        .payment-info p {
            margin: 10px 0;
            display: flex;
            justify-content: space-between;
        }
        
        .payment-info p span:first-child {
            font-weight: bold;
            color: #666;
        }
        
        .card-info {
            margin-top: 20px;
            border-top: 1px dashed #ddd;
            padding-top: 20px;
        }
        
        .card-info h3 {
            color: #555;
            margin-bottom: 15px;
        }
        
        .total {
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px dashed #ddd;
        }
        
        .btn {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            margin-top: 30px;
            transition: background-color 0.3s;
        }
        
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="success-icon">✓</div>
    <h1>결제가 완료되었습니다!</h1>
    
    <div class="payment-info">
        <p><span>결제 고유번호:</span> <span>${payInfo.aid}</span></p>
        <p><span>상품명:</span> <span>${payInfo.item_name}</span></p>
        <p><span>수량:</span> <span>${quantity}개</span></p>
        <p><span>결제수단:</span> <span>${payInfo.payment_method_type == 'CARD' ? '신용카드' : '카카오페이머니'}</span></p>
        <p><span>결제시간:</span> <span><fmt:formatDate value="${payInfo.approved_at}" pattern="yyyy-MM-dd HH:mm:ss"/></span></p>
        
        <c:if test="${payInfo.card_info != null}">
            <div class="card-info">
                <h3>카드 정보</h3>
                <p><span>카드사:</span> <span>${payInfo.card_info.issuer_corp}</span></p>
                <p><span>카드타입:</span> <span>${payInfo.card_info.card_type}</span></p>
                <p><span>할부개월:</span> <span>${payInfo.card_info.install_month == '0' ? '일시불' : payInfo.card_info.install_month.concat('개월')}</span></p>
            </div>
        </c:if>
        
        <p class="total"><span>결제금액:</span> <span><fmt:formatNumber value="${payInfo.amount.total}" pattern="#,###"/>원</span></p>
    </div>
    
    <a href="${pageContext.request.contextPath}/payment/buyingList" class="btn">메인으로 돌아가기</a>
</div>

<!-- 공통 하단 정보 포함 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
	<script src="${root}/js/main.js"></script>
</body>
</html>