<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제 선택</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        
        .container {
            max-width: 800px;
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
        
        .payment-methods {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        
        .payment-method {
            width: 200px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .payment-method:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .payment-method img {
            max-width: 100px;
            margin-bottom: 15px;
        }
        
        .payment-method h3 {
            margin: 0;
            color: #333;
        }
        
        .payment-method p {
            color: #666;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>결제 수단 선택</h1>
    
    <div class="payment-methods">
        <a href="/payment/kakao" style="text-decoration: none; color: inherit;">
            <div class="payment-method">
                <img src="https://developers.kakao.com/static/images/payment/icon_payment.png" alt="카카오페이">
                <h3>카카오페이</h3>
                <p>카카오페이로 쉽고 빠르게 결제하세요</p>
            </div>
        </a>
        
        <!-- 추가 결제 수단들 -->
        <div class="payment-method" onclick="alert('준비 중인 기능입니다.')">
            <img src="https://pay.naver.com/n/static/img/logos/naverpay.png" alt="네이버페이">
            <h3>네이버페이</h3>
            <p>네이버페이로 간편하게 결제하세요</p>
        </div>
        
        <div class="payment-method" onclick="alert('준비 중인 기능입니다.')">
            <img src="https://cdn-icons-png.flaticon.com/512/196/196578.png" alt="신용카드">
            <h3>신용카드</h3>
            <p>모든 카드사 결제 가능합니다</p>
        </div>
        
        <div class="payment-method" onclick="alert('준비 중인 기능입니다.')">
            <img src="https://cdn-icons-png.flaticon.com/512/2168/2168244.png" alt="계좌이체">
            <h3>계좌이체</h3>
            <p>실시간 계좌이체로 결제하세요</p>
        </div>
    </div>
</div>

<!-- 공통 하단 정보 포함 -->
<%-- <jsp:include page="/include/bottom_info.jsp" /> --%>
</body>
</html>