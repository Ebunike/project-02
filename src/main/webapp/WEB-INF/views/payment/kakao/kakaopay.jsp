<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카카오페이 결제 테스트</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        
        input[type="text"], 
        input[type="number"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        
        button {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: #FFEB00;
            color: #333;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        button:hover {
            background-color: #FFD600;
        }
        
        .error-message {
            color: #e74c3c;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }
        
        .loading {
            display: none;
            text-align: center;
            margin-top: 20px;
        }
        
        .loading img {
            width: 50px;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>카카오페이 결제 테스트</h1>
    


	<form:form id="payment-form" modelAttribute="itemBean">
	    <%-- <div class="form-group">
	        <label for="itemName">상품명</label>
	        <form:input path="itemName" id="itemName" value="테스트 상품" required="required" />
	        <div class="error-message" id="itemName-error">상품명을 입력해주세요.</div>
	    </div> --%>
	    
	    <div class="form-group">
	        <label for="quantity">수량</label>
	        <form:input path="quantity" id="quantity" type="number" value="1" min="1" required="required" />
	        <div class="error-message" id="quantity-error">수량은 1개 이상이어야 합니다.</div>
	    </div>
	    
	    <div class="form-group">
	        <label for="totalPrice">총 금액</label>
	        <form:input path="totalAmount" id="totalAmount" type="number" value="10000" min="100" required="required" />
	        <div class="error-message" id="totalAmount-error">금액은 100원 이상이어야 합니다.</div>
	    </div>
	    
	    <%-- <div class="form-group">
	        <label for="taxFreeAmount">비과세 금액</label>
	        <form:input path="taxFreeAmount" id="taxFreeAmount" type="number" value="0" min="0" required="required" />
	        <div class="error-message" id="taxFreeAmount-error">비과세 금액을 입력해주세요.</div>
	    </div> --%>
	    
	    <button type="button" id="kakao-pay-btn">카카오페이로 결제하기</button>
	</form:form>
	    
	    <div class="loading" id="loading">
	        <img src="https://t1.daumcdn.net/kakaopay/static/img/payment/loading.gif" alt="로딩 중">
	        <p>결제 준비 중입니다. 잠시만 기다려주세요...</p>
	    </div>
</div>

<script>
$(document).ready(function() {
    $("#kakao-pay-btn").click(function() {
        // 입력값 검증
        let isValid = true;
        
        const itemName = $("#itemName").val();
        if (!itemName) {
            $("#itemName-error").show();
            isValid = false;
        } else {
            $("#itemName-error").hide();
        }
        
        const quantity = parseInt($("#quantity").val());
        if (isNaN(quantity) || quantity < 1) {
            $("#quantity-error").show();
            isValid = false;
        } else {
            $("#quantity-error").hide();
        }
        
        const totalAmount = parseInt($("#totalAmount").val());
        if (isNaN(totalAmount) || totalAmount < 100) {
            $("#totalAmount-error").show();
            isValid = false;
        } else {
            $("#totalAmount-error").hide();
        }
        
        const taxFreeAmount = parseInt($("#taxFreeAmount").val());
        if (isNaN(taxFreeAmount) || taxFreeAmount < 0) {
            $("#taxFreeAmount-error").show();
            isValid = false;
        } else {
            $("#taxFreeAmount-error").hide();
        }
        
        if (!isValid) {
            return;
        }
        
        // 로딩 표시
        $("#loading").show();
        $("#payment-form").css("opacity", 0.5);
        $("#kakao-pay-btn").prop("disabled", true);
        
        // AJAX 요청 - 컨텍스트 경로 포함
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/payment/kakao/ready",
            data: {
                itemName: itemName,
                quantity: quantity,
                totalAmount: totalAmount,
                taxFreeAmount: taxFreeAmount
            },
            success: function(data) {
                console.log("결제 준비 성공", data);
                // 결제페이지로 이동
                window.location.href = data.next_redirect_pc_url;
            },
            error: function(error) {
                console.error("결제 준비 중 오류 발생", error);
                alert("결제 준비 중 오류가 발생했습니다. 다시 시도해주세요.");
                $("#loading").hide();
                $("#payment-form").css("opacity", 1);
                $("#kakao-pay-btn").prop("disabled", false);
            }
        });
    });
});
</script>

<!-- 공통 하단 정보 포함 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
	<script src="${root}/js/main.js"></script>
</body>
</html>