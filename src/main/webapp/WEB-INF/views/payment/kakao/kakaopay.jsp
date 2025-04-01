<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카카오페이 결제</title>
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
        input[type="number"],
        input[type="email"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            margin-bottom: 15px;
        }
        
        .radio-group {
            margin-bottom: 20px;
        }
        
        .radio-group label {
            display: inline-block;
            margin-right: 15px;
            font-weight: normal;
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
            margin-bottom: 10px;
        }
        
        button:hover {
            background-color: #FFD600;
        }
        
        button.cancel-btn {
            background-color: #f1f1f1;
            color: #555;
        }
        
        button.cancel-btn:hover {
            background-color: #e0e0e0;
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
    <h1>카카오페이 결제</h1>
    
    <form:form modelAttribute="paymentReq" action="${root}/payment/kakao/ready" method="post">
        <div class="form-group">
            <label for="orderId">주문 ID:</label>
            <form:input path="orderId" id="orderId" readonly="true"/>
        </div>
        
        <div class="form-group">
            <label for="amount">결제 금액:</label>
            <form:input path="amount" id="amount" readonly="true"/>
        </div>
        
        <div class="form-group">
            <label>결제 방법:</label>
            <div class="radio-group">
                <form:radiobutton path="pay_Method" id="pay_Method_KAKAO" value="KAKAO" checked="checked" />
                <label for="pay_Method_KAKAO">카카오페이</label>
            </div>
        </div>
        
        <div class="form-group">
            <label for="orderName">주문 이름:</label>
            <form:input path="orderName" id="orderName" readonly="true"/>
        </div>
        
        <div class="form-group">
            <label for="customerEmail">고객 이메일:</label>
            <form:input path="customerEmail" id="customerEmail" type="email"/>
        </div>
        
        <div class="form-group">
            <label for="customerName">고객 이름:</label>
            <form:input path="customerName" id="customerName" readonly="true"/>
        </div>
        
        <div class="form-group">
            <label for="customerMobilePhone">고객 전화번호:</label>
            <form:input path="customerMobilePhone" id="customerMobilePhone"/>
        </div>
        
        <form:hidden path="successUrl" value="/Project_hoon/payment/kakao/success" />
        
        <div>
            <button type="button" id="kakao-pay-btn">카카오페이로 결제하기</button>
            <button type="button" class="cancel-btn" onclick="cancelPayment()">결제취소</button>
        </div>
    </form:form>
    
    <div class="loading" id="loading">
        <img src="https://t1.daumcdn.net/kakaopay/static/img/payment/loading.gif" alt="로딩 중">
        <p>결제 준비 중입니다. 잠시만 기다려주세요...</p>
    </div>
</div>

<script>
$(document).ready(function() {
    // 페이지 로드 시 주문 ID 생성
    const orderId = generateOrderId(10);
    $("#orderId").val(orderId);
    
    // 결제금액 설정
    const cartTotalPrice = ${cartTotalPrice};
    setAmountValue(cartTotalPrice);
    
    // 고객 정보 설정
    const customerName = "${loginUser.name}";
    setCustomerName(customerName);
    
    // 고객 이메일 설정
    const loginUserEmail = "${loginUser.email}";
    $("#customerEmail").val(loginUserEmail);
    
    // 주문서 이름 설정
    const orderName = customerName + "의 주문서";
    $("#orderName").val(orderName);
    
    // 고객 전화번호 설정
    const loginUserTel = "${loginUser.tel}";
    $("#customerMobilePhone").val(loginUserTel);
    
    // 카카오페이 버튼 클릭 이벤트
    $("#kakao-pay-btn").click(function() {
        // 로딩 표시
        $("#loading").show();
        $("form").css("opacity", 0.5);
        $("#kakao-pay-btn").prop("disabled", true);
        
        // 결제 요청
        $.ajax({
            type: "POST",
            url: "${root}/payment/kakao/ready",
            data: {
                orderId: $("#orderId").val(),
                itemName: $("#orderName").val(),
                quantity: 1,
                totalAmount: $("#amount").val(),
                taxFreeAmount: 0,
                customerName: $("#customerName").val(),
                customerEmail: $("#customerEmail").val(),
                customerMobilePhone: $("#customerMobilePhone").val()
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
                $("form").css("opacity", 1);
                $("#kakao-pay-btn").prop("disabled", false);
            }
        });
    });
});

// 결제 취소 함수
function cancelPayment() {
    const orderId = document.getElementById('orderId').value;
    const data = { order_id: orderId };

    $.ajax({
        type: "POST",
        url: "${root}/order/cancelPayment",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function() {
            alert("결제가 취소되었습니다.");
            history.pushState({ canceled: true }, null, location.href);
            
            // 이전 페이지로 이동
            if (document.referrer) {
                window.location.href = document.referrer;
            } else {
                window.history.back();
            }
        },
        error: function(xhr) {
            console.error("결제 취소 실패:", xhr.responseText);
            alert("결제 취소에 실패했습니다.");
        }
    });
}

// popstate 이벤트 감지
let isFirstPopstateHandled = false;
window.addEventListener('popstate', function(event) {
    if (event.state && event.state.canceled && !isFirstPopstateHandled) {
        isFirstPopstateHandled = true; // popstate 이벤트를 한 번만 처리
        cancelPayment(true); // 뒤로가기에서 결제 취소 호출
    }
});

// 주문 ID 랜덤 생성 함수
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
    saveOrderToServer(orderId, orderDate);
    return orderId;
}

// 서버에 주문 저장
function saveOrderToServer(orderId, orderDate) {
    const urlParams = new URLSearchParams(window.location.search);
    const selectedItems = urlParams.get('items');
    const data = {
        order_id: orderId,
        order_date: orderDate,
    };

    $.ajax({
        type: "POST",
        url: "${root}/order/saveOrder",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function() {
            console.log("주문이 성공적으로 저장되었습니다!");
        },
        error: function(xhr) {
            console.error("주문 저장 실패:", xhr.responseText);
        }
    });
}

// 값 설정 함수
function setAmountValue(value) {
    const amountInput = document.getElementById('amount');
    if (amountInput) {
        amountInput.value = value;
    } else {
        console.error('amount 요소를 찾을 수 없습니다.');
    }
}

// 고객이름 설정하기
function setCustomerName(value) {
    const customerNameInput = document.getElementById('customerName');
    if(customerNameInput) {
        customerNameInput.value = value;
    } else {
        console.error('customerNameInput를 찾을 수 없습니다')
    }
}
</script>

<!-- 공통 하단 정보 포함 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
<script src="${root}/js/main.js"></script>
</body>
</html>