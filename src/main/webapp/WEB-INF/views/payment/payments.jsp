<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <!-- SDK 추가 -->
    <script src="https://js.tosspayments.com/v2/standard"></script>
  </head>
  <body>
    <!-- 결제하기 버튼 -->
    <button class="button" style="margin-top: 30px" onclick="requestPayment()">결제하기</button>
    <script>
      // ------  SDK 초기화 ------
      // @docs https://docs.tosspayments.com/sdk/v2/js#토스페이먼츠-초기화
      const clientKey = "test_ck_KNbdOvk5rkDWoW5dWPMo8n07xlzm";
      const customerKey = "r5OzRALKfL_LwZOGkfzoM";
      const tossPayments = TossPayments(clientKey);
      // 회원 결제
      // @docs https://docs.tosspayments.com/sdk/v2/js#tosspaymentspayment
      const payment = tossPayments.payment({ customerKey });
      // 비회원 결제
      // const payment = tossPayments.payment({customerKey: TossPayments.ANONYMOUS})
      // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
      // @docs https://docs.tosspayments.com/sdk/v2/js#paymentrequestpayment
async function requestPayment() {
       let test = `${paymentRes.orderId}`;
       console.log(test);
 
        // 결제를 요청하기 전에 orderId, amount를 서버에 저장하세요.
        // 결제 과정에서 악의적으로 결제 금액이 바뀌는 것을 확인하는 용도입니다.
        await payment.requestPayment({
          method: `${paymentRes.pay_Method}`, // 카드 결제
          amount: {
            currency: "KRW",
            value:${paymentRes.amount} ,
          },
          //orderId: "t4pAul9BsB4fLnKl_cYjL", // 고유 주문번호
          orderId: `${paymentRes.orderId}`,
          orderName: `${paymentRes.orderName}`,
          successUrl: window.location.origin + "/Project_hoon/payment/success", // 결제 요청이 성공하면 리다이렉트되는 URL
          failUrl: window.location.origin + "/Project_hoon/payment/forpayment", // 결제 요청이 실패하면 리다이렉트되는 URL
          customerEmail: `${paymentRes.customerEmail}`,
          customerName: `${paymentRes.customerName}`,
          customerMobilePhone: "01012341234",
          // 카드 결제에 필요한 정보
          card: {
            useEscrow: false,
            flowMode: "DEFAULT", // 통합결제창 여는 옵션
            useCardPoint: false,
            useAppCardOnly: false,
          },
        });
      }
    </script>
  </body>
</html>
