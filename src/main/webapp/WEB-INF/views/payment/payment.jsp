<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <!-- SDK 추가 -->
    <script src="https://js.tosspayments.com/v2/standard"></script>
  </head>
  
<%-- 
카트에서 결제하기 누르면
가격이 바로 PaymentReqDTO객체의 amount로 들어가게 해주고
${paymentRes.amount}
${paymentRes.orderId}
${paymentRes.method}
${paymentRes.orderName}
${paymentRes.customerEmail}
${paymentRes.customerMobilePhone}

1.script에서 JSON으로 받는데 그냥 이렇게 넣어도 괜찮나...? 응답도 JSON으로 올건데...

 --%>
 
  <body>
    <!-- 결제하기 버튼 -->
    <button class="button" style="margin-top: 50px" onclick="requestPayment()">결제하기</button>
    <script>
      // ------  SDK 초기화 ------
      // @docs https://docs.tosspayments.com/sdk/v2/js#토스페이먼츠-초기화
      const clientKey = "test_ck_KNbdOvk5rkDWoW5dWPMo8n07xlzm";
      const customerKey = "v8Ls55xsrhbrOIklamho-";
      const tossPayments = TossPayments(clientKey);
      // 회원 결제
      // @docs https://docs.tosspayments.com/sdk/v2/js#tosspaymentspayment
      const payment = tossPayments.payment({ customerKey });
      // 비회원 결제
      // const payment = tossPayments.payment({customerKey: TossPayments.ANONYMOUS})
      // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
      // @docs https://docs.tosspayments.com/sdk/v2/js#paymentrequestpayment
      async function requestPayment() {
        // 결제를 요청하기 전에 orderId, amount를 서버에 저장하세요.
        // 결제 과정에서 악의적으로 결제 금액이 바뀌는 것을 확인하는 용도입니다.




        await payment.requestPayment({
          method: "${paymentRes.pay_Method}", // 카드 결제
          amount: {
            currency: "KRW",
            value: ${paymentRes.amount},
          },
          orderId: "${paymentRes.orderId}", // 고유 주분번호
          orderName: "${paymentRes.orderName}",
          successUrl: "${root}/payment/success", // 결제 요청이 성공하면 리다이렉트되는 URL
          failUrl: "${root}/payment/fail", // 결제 요청이 실패하면 리다이렉트되는 URL
          customerEmail: "${paymentRes.customerEmail}",
          customerName: "김토스",
          customerMobilePhone: "${paymentRes.customerMobilePhone}",
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
