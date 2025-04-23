<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="root" value="${pageContext.request.contextPath }" /> 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>결제 처리 중...</title>
  <!-- Toss Payments SDK -->
  <script src="https://js.tosspayments.com/v2/standard"></script>
</head>
<body>
  <div style="text-align: center; margin-top: 100px;">
    <h3>결제 처리 중입니다...</h3>
    <p>잠시만 기다려주세요.</p>
  </div>

  <script>
    // 결제 정보 (서버에서 전달받은 값으로 대체할 것)
    const paymentInfo = {
      orderId: "ORDER_" + new Date().getTime(),
      amount: ${cartTotalPrice},  // 결제 금액
      orderName: "제품 주문",
      customerName: "고객명",
      customerEmail: "customer@example.com",
      customerMobilePhone: "01012341234",
      payMethod: "CARD"  // 결제 방법
    };
    
    

    // SDK 초기화
    const clientKey = "test_ck_KNbdOvk5rkDWoW5dWPMo8n07xlzm";
    const tossPayments = TossPayments(clientKey);
    
    // 결제 요청 함수
    async function requestPayment() {
      try {
        await tossPayments.requestPayment(paymentInfo.payMethod, {
          amount: {
            currency: "KRW",
            value: paymentInfo.amount,
          },
          orderId: paymentInfo.orderId,
          orderName: paymentInfo.orderName,
          successUrl: window.location.origin + "/Project_hoon/payment/success",
          failUrl: window.location.origin + "/Project_hoon/payment/fail",
          customerEmail: paymentInfo.customerEmail,
          customerName: paymentInfo.customerName,
          customerMobilePhone: paymentInfo.customerMobilePhone,
          card: {
            useEscrow: false,
            flowMode: "DEFAULT",
            useCardPoint: false,
            useAppCardOnly: false,
          },
        });
      } catch (error) {
        console.error("결제 요청 오류:", error);
        alert("결제 요청 중 오류가 발생했습니다.");
      }
    }
    
    // 페이지 로드 시 자동으로 결제창 호출
    window.onload = function() {
      // 잠시 지연 후 결제창 호출 (UX 향상)
      setTimeout(requestPayment, 500);
    };
  </script>
</body>
</html>