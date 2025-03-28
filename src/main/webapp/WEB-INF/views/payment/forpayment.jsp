<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>결제하기</title>
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
  <!-- Toss 결제 스타일 모방 -->
  <style>
    :root {
      --toss-blue: #3182f6;
      --toss-blue-hover: #2b7ae2;
      --light-gray: #f9f9fb;
      --border-color: #e5e5e5;
      --text-color: #333333;
      --text-secondary: #8b95a1;
    }
    
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }
    
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f9f9fb;
      color: var(--text-color);
      line-height: 1.5;
      -webkit-font-smoothing: antialiased;
    }
    
    .container {
      max-width: 480px;
      margin: 0 auto;
      padding: 24px;
      background-color: white;
      border-radius: 16px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
      border: 3px solid #0064FF;
    }
    
    .header {
      text-align: center;
      margin-bottom: 24px;
    }
    
    .header h2 {
      font-size: 22px;
      font-weight: 700;
      color: #191f28;
      margin-bottom: 8px;
    }
    
    .payment-form {
      display: flex;
      flex-direction: column;
      gap: 20px;
    }
    
    .form-group {
      display: flex;
      flex-direction: column;
      gap: 8px;
    }
    
    .form-group label {
      font-size: 14px;
      font-weight: 700;
      color: #0064FF;
    }
    
    .form-control {
      width: 100%;
      padding: 12px 16px;
      font-size: 16px;
      border: 1px solid var(--border-color);
      border-radius: 8px;
      background-color: white;
      transition: border-color 0.2s;
    }
    
    .form-control:focus {
      outline: none;
      border-color: var(--toss-blue);
      box-shadow: 0 0 0 2px rgba(49, 130, 246, 0.2);
    }
    
    .form-control[readonly] {
      background-color: var(--light-gray);
      color: black;
    }
    
    .radio-group {
      display: flex;
      gap: 16px;
      margin-top: 8px;
    }
    
    .radio-option {
      position: relative;
      flex: 1;
    }
    
    .radio-input {
      position: absolute;
      opacity: 0;
      width: 0;
      height: 0;
    }
    
    .radio-label {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 16px;
      border: 1px solid var(--border-color);
      border-radius: 8px;
      font-size: 14px;
      cursor: pointer;
      transition: all 0.2s;
      height: 100%;
    }
    
    .radio-input:checked + .radio-label {
      border-color: var(--toss-blue);
      background-color: rgba(49, 130, 246, 0.08);
      font-weight: 500;
      color: black;
    }
    
    .radio-label svg {
      margin-bottom: 8px;
      width: 24px;
      height: 24px;
    }
    
    .button-group {
      display: flex;
      gap: 12px;
      margin-top: 16px;
    }
    
    .button {
      flex: 1;
      padding: 16px;
      font-size: 16px;
      font-weight: 500;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.2s;
    }
    
    .button-primary {
      background-color: var(--toss-blue);
      color: white;
    }
    
    .button-primary:hover {
      background-color: var(--toss-blue-hover);
    }
    
    .button-secondary {
      background-color: var(--light-gray);
      color: var(--text-color);
    }
    
    .button-secondary:hover {
      background-color: #e9e9e9;
    }
    
    .amount-display {
      font-size: 24px;
      font-weight: 700;
      color: #191f28;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 16px;
      background-color: var(--light-gray);
      border-radius: 8px;
      margin-bottom: 20px;
    }
    
    .amount-display .label {
      font-size: 16px;
      font-weight: 700;
      color: #0064FF;
    }
    
    .divider {
      height: 1px;
      background-color: var(--border-color);
      margin: 8px 0;
    }
    
    .order-info {
      border: 1px solid var(--border-color);
      border-radius: 8px;
      padding: 16px;
      margin-bottom: 24px;
    }
    
    .order-row {
      display: flex;
      justify-content: space-between;
      margin-bottom: 8px;
    }
    
    .order-row .label {
      font-size: 14px;
      font-weight: 700;
      color: #0064FF;
    }
    
    .order-row .value {
      font-weight: 500;
    }
    
    @media (max-width: 480px) {
      .container {
        border-radius: 0;
        padding: 16px;
      }
    }
    img {
    	width: 140px;
    	height: 70px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <img src="${root }/logo/toss_logo.png" alt="토스 로고">
    </div>
    
    <!-- 주문 정보 요약 -->
    <div class="order-info">
      <div class="order-row">
        <span class="label">주문명</span>
        <span class="value" id="orderNameDisplay"></span>
      </div>
      <div class="order-row">
        <span class="label">주문번호</span>
        <span class="value" id="orderIdDisplay"></span>
      </div>
      <div class="divider"></div>
      <div class="order-row">
        <span class="label">주문자</span>
        <span class="value" id="customerNameDisplay"></span>
      </div>
    </div>
    
    <!-- 최종 결제 금액 표시 -->
    <div class="amount-display">
      <span class="label">최종 결제 금액</span>
      <span class="amount" id="amountDisplay"></span>
    </div>
    
    <!-- Spring Form 태그를 사용하여 PaymentReqDTO 객체를 자동으로 바인딩 -->
    <form:form modelAttribute="paymentReq" action="${root}/payment/forpayment_pro" method="post" cssClass="payment-form">
      <div class="form-group" style="display: none;">
        <label for="orderId">주문 ID:</label>
        <form:input path="orderId" id="orderId" cssClass="form-control" readonly="true"/>
      </div>
      
      <div class="form-group" style="display: none;">
        <label for="amount">결제 금액:</label>
        <form:input path="amount" id="amount" cssClass="form-control" readonly="true"/>
      </div>
      
      <div class="form-group">
        <label>결제 방법</label>
        <div class="radio-group">
          <div class="radio-option">
            <form:radiobutton path="pay_Method" id="pay_Method_CARD" value="CARD" cssClass="radio-input"/>
            <label for="pay_Method_CARD" class="radio-label">
              <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M3 5C3 3.89543 3.89543 3 5 3H19C20.1046 3 21 3.89543 21 5V19C21 20.1046 20.1046 21 19 21H5C3.89543 21 3 20.1046 3 19V5Z" stroke="currentColor" stroke-width="2"/>
                <path d="M3 8H21" stroke="currentColor" stroke-width="2"/>
                <path d="M7 15H9" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
              </svg>
              <span>카드 결제</span>
            </label>
          </div>
          
          <div class="radio-option">
            <form:radiobutton path="pay_Method" id="pay_Method_VA" value="VIRTUAL_ACCOUNT" cssClass="radio-input"/>
            <label for="pay_Method_VA" class="radio-label">
              <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M19 5H5C3.89543 5 3 5.89543 3 7V17C3 18.1046 3.89543 19 5 19H19C20.1046 19 21 18.1046 21 17V7C21 5.89543 20.1046 5 19 5Z" stroke="currentColor" stroke-width="2"/>
                <path d="M3 9H21" stroke="currentColor" stroke-width="2"/>
                <path d="M7 15H17" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
              </svg>
              <span>가상계좌</span>
            </label>
          </div>
        </div>
      </div>
      
      <div class="form-group" style="display: none;">
        <label for="orderName">주문명:</label>
        <form:input path="orderName" id="orderName" cssClass="form-control" readonly="true"/>
      </div>
      
      <div class="form-group">
        <label for="customerEmail">이메일</label>
        <form:input path="customerEmail" id="customerEmail" cssClass="form-control" readonly="true"/>
      </div>
      
      <div class="form-group" style="display: none;">
        <label for="customerName">고객 이름:</label>
        <form:input path="customerName" id="customerName" cssClass="form-control" readonly="true"/>
      </div>

      <form:hidden path="successUrl" value="/Project_hoon/payment/success" />
    
      <div class="form-group">
        <label for="customerMobilePhone">휴대폰 번호</label>
        <form:input path="customerMobilePhone" id="customerMobilePhone" cssClass="form-control" readonly="true"/>
      </div>
      
      <div class="button-group">
        <button type="button" onclick="cancelPayment()" class="button button-secondary" style="border: 2px solid #0064FF;">취소하기</button>
        <button type="submit" class="button button-primary">결제하기</button>
      </div>
    </form:form>
  </div>

  <script type="text/javascript">
    // 결제 취소 함수
    function cancelPayment(isTriggeredByPopstate = false) {
      const orderId = document.getElementById('orderId').value;
      const data = { order_id: orderId };

      const xhr = new XMLHttpRequest();
      xhr.open("POST", `${root}/order/cancelPayment`, true);
      xhr.setRequestHeader("Content-Type", "application/json");
      xhr.onload = function () {
        if (xhr.status === 200) {
          if (!isTriggeredByPopstate) { // 뒤로가기 이벤트가 아니라면 실행
            alert("결제가 취소되었습니다.");
          	//window.location.href = "${root}/cart/my_cart"
            history.pushState({ canceled: true }, null, location.href); // 상태 추가

            // 대체 로직: 이전 페이지로 이동
            if (document.referrer) {
              window.location.href = document.referrer;
            } else {
              window.history.back(); // 브라우저가 참조 페이지를 가지고 있지 않을 경우
            }
          }
        } else {
          console.error("결제 취소 실패:", xhr.responseText);
          alert("결제 취소에 실패했습니다.");
        }
      };
      xhr.onerror = function () {
        console.error("AJAX 요청 실패");
        alert("서버에 연결할 수 없습니다.");
      };
      xhr.send(JSON.stringify(data));
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
      
    // 이미 my_cart에서 저장된 items 문자열 활용
    const urlParams = new URLSearchParams(window.location.search);
    function saveOrderToServer(orderId, orderDate) {
      const selectedItems = urlParams.get('items');
      const data = {
        order_id: orderId,
        order_date: orderDate,
      };

        
      const xhr = new XMLHttpRequest();
      xhr.open("POST", "${root}/order/saveOrder", true);
      xhr.setRequestHeader("Content-Type", "application/json");
      xhr.onload = function () {
        if (xhr.status === 200) {
          console.log("주문이 성공적으로 저장되었습니다!");
        } else {
          console.error("주문 저장 실패:", xhr.responseText);
        }
      };
      xhr.send(JSON.stringify(data));
    }
    
    // 예제 사용
    const orderId = generateOrderId(10); // 원하는 길이를 파라미터로 전달 (예: 10자)
    console.log(orderId);

    // HTML 폼 필드에 주문 ID를 자동으로 삽입
    document.getElementById('orderId').value = orderId;
    document.getElementById('orderIdDisplay').textContent = orderId;

    // 값 설정 함수
    function setAmountValue(value) {
      const amountInput = document.getElementById('amount');
      const amountDisplay = document.getElementById('amountDisplay');
      if (amountInput) {
        amountInput.value = value;
        if (amountDisplay) {
          amountDisplay.textContent = new Intl.NumberFormat('ko-KR').format(value) + '원';
        }
      } else {
        console.error('amount 요소를 찾을 수 없습니다.');
      }
    }
    const cartTotalPrice = ${cartTotalPrice};
    setAmountValue(cartTotalPrice); // amount 필드에 장바구니 총 합계 금액을 설정

    //고객이름 설정하기
    function setCustomerName(value) {
      const customerNameInput = document.getElementById('customerName');
      const customerNameDisplay = document.getElementById('customerNameDisplay');
      if(customerNameInput){
        customerNameInput.value = value;
        if (customerNameDisplay) {
          customerNameDisplay.textContent = value;
        }
      } else {
        console.error('customerNameInput를 찾을 수 없습니다')
      }
    }
    const customerName = "${loginUser.name}";
    console.log(customerName);
    setCustomerName(customerName); //customerName에 로그인된 유저 이름 설정
    
    //고객 이메일 설정하기
    // 서버에서 전달된 loginUser의 이메일을 스크립트 변수로 설정
    const loginUserEmail = "${loginUser.email}";
    console.log(loginUserEmail);
    // 이메일을 customerEmail 필드에 설정
    document.addEventListener("DOMContentLoaded", function () {
      const emailInput = document.getElementById('customerEmail');
      if (emailInput) {
        emailInput.value = loginUserEmail;
      }
    });
      
    //고객이름으로 주문서 이름 설정하기
    document.addEventListener("DOMContentLoaded", function () {
      const customerNameInput = document.getElementById('customerName'); // 고객 이름 필드
      const orderNameInput = document.getElementById('orderName'); // 주문 이름 필드
      const orderNameDisplay = document.getElementById('orderNameDisplay'); // 주문 이름 표시 요소
    
      if (customerNameInput && orderNameInput) {
        const customerName = customerNameInput.value; // 고객 이름 값 가져오기
    
        if (customerName) {
          // 고객 이름에 "의 주문서"를 붙여 주문 이름 설정
          const orderName = customerName + "의 주문서";
          orderNameInput.value = orderName;
          if (orderNameDisplay) {
            orderNameDisplay.textContent = orderName;
          }
        } else {
          console.error("고객 이름 값이 비어 있습니다.");
        }
      } else {
        console.error("customerName 또는 orderName 요소를 찾을 수 없습니다.");
      }
    });
      
    //고객전화번호 설정하기
    const loginUserTel = "${loginUser.tel}";
    console.log(loginUserTel);
    document.addEventListener("DOMContentLoaded", function () {
      const telInput = document.getElementById('customerMobilePhone');
      if (telInput) {
        telInput.value = loginUserTel;
      }
    });
    
    // 라디오 버튼 기본값 설정 (카드 결제)
    document.addEventListener("DOMContentLoaded", function() {
      const cardRadio = document.getElementById('pay_Method_CARD');
      if (cardRadio) {
        cardRadio.checked = true;
      }
    });
  </script>
</body>
</html>