<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 실패</title>
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
            text-align: center;
        }
        
        h1 {
            color: #e74c3c;
            margin-bottom: 20px;
        }
        
        p {
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        .fail-icon {
            font-size: 72px;
            color: #e74c3c;
            margin-bottom: 20px;
        }
        
        .btn-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        
        .btn-primary {
            background-color: #FFEB00;
            color: #333;
        }
        
        .btn-primary:hover {
            background-color: #FFD600;
        }
        
        .btn-secondary {
            background-color: #757575;
            color: white;
        }
        
        .btn-secondary:hover {
            background-color: #616161;
        }
        
        .error-details {
            margin-top: 30px;
            padding: 15px;
            background-color: #f8f8f8;
            border-radius: 5px;
            text-align: left;
            color: #e74c3c;
            font-size: 14px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="fail-icon">❌</div>
    <h1>결제에 실패했습니다</h1>
    <p>카카오페이 결제 과정에서 오류가 발생했습니다.<br>다시 시도하시거나 다른 결제 수단을 선택해주세요.</p>
    
    <div class="btn-container">
        <a href="${pageContext.request.contextPath}/payment/kakao" class="btn btn-primary">결제 다시 시도</a>
        <a href="${pageContext.request.contextPath}/payment/kakao/forpayment" class="btn btn-secondary">다른 결제수단 선택</a>
    </div>
    
    <c:if test="${not empty errorMessage}">
        <div class="error-details">
            <strong>오류 내용:</strong> ${errorMessage}
        </div>
    </c:if>
</div>

<!-- 공통 하단 정보 포함 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
	<script src="${root}/js/main.js"></script>
</body>
</html>