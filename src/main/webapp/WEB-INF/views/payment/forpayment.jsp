<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <title>결제 페이지</title>
  </head>
  <body>
    <h2>결제 정보</h2>
    
    <!-- Spring Form 태그를 사용하여 PaymentReqDTO 객체를 자동으로 바인딩 -->
    <form:form modelAttribute="paymentReq" action="${root }/payment/forpayment_pro" method="post">
      <label for="orderId">주문 ID:</label>
      <form:input path="orderId" id="orderId" readonly="true"/><br><br>
      
      <label for="amount">결제 금액:</label>
      <form:input path="amount" id="amount" readonly="true"/><br><br>
      
      <label for="pay_Method">결제 방법:</label>
		<form:radiobutton path="pay_Method" id="pay_Method_CARD" value="CARD" />
		<label for="pay_Method_CARD">CARD</label>
		
		<form:radiobutton path="pay_Method" id="pay_Method_VA" value="VIRTUAL_ACCOUNT" />
		<label for="pay_Method_VA">Virtual Account</label>
		<br><br>

      
      <label for="orderName">주문 이름:</label>
      <form:input path="orderName" id="orderName" readonly="true"/><br><br>
      
      <label for="customerEmail">고객 이메일:</label>
      <form:input path="customerEmail" id="customerEmail"/><br><br>
      
      <label for="customerName">고객 이름:</label>
      <form:input path="customerName" id="customerName" readonly="true" /><br><br>

	  <form:hidden path="successUrl" value="/Project_hoon/payment/success" />
	
	
      <label for="customerName">고객 전번:</label>
      <form:input path="customerMobilePhone" id="customerMobilePhone"  /><br><br>
      
      <div>
	      <button type="submit" >결제하기</button>
	      <button type="button" onclick="cancelPayment()">결제취소</button>
	  </div>
    </form:form>
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

		 	// 값 설정 함수
		    function setAmountValue(value) {
		        const amountInput = document.getElementById('amount');
		        if (amountInput) {
		            amountInput.value = value;
		        } else {
		            console.error('amount 요소를 찾을 수 없습니다.');
		        }
		    }
		    const cartTotalPrice = ${cartTotalPrice};
		    setAmountValue(cartTotalPrice); // amount 필드에 장바구니 총 합계 금액을 설정

		    //고객이름 설정하기
		    function setCustomerName(value) {
				const customerNameInput = document.getElementById('customerName');
				if(customerNameInput){
					customerNameInput.value = value;
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
			
			    if (customerNameInput && orderNameInput) {
			        const customerName = customerNameInput.value; // 고객 이름 값 가져오기
			
			        if (customerName) {
			            // 고객 이름에 "의 주문서"를 붙여 주문 이름 설정
			            orderNameInput.value = customerName + "의 주문서";
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
    </script>
  </body>
</html>

