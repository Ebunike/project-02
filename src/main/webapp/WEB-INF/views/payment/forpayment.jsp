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
      <form:input path="orderId" id="orderId" /><br><br>
      
      <label for="amount">결제 금액:</label>
      <form:input path="amount" id="amount"/><br><br>
      
      <label for="pay_Method">결제 방법:</label>
      <form:input path="pay_Method" id="pay_Method"/><br><br>
      
      <label for="orderName">주문 이름:</label>
      <form:input path="orderName" id="orderName"/><br><br>
      
      <label for="customerEmail">고객 이메일:</label>
      <form:input path="customerEmail" id="customerEmail"/><br><br>
      
      <label for="customerName">고객 이름:</label>
      <form:input path="customerName" id="customerName"  /><br><br>

	<form:hidden path="successUrl" value="/Project_hoon/payment/success" />
	
	
      <label for="customerName">고객 전번:</label>
      <form:input path="customerMobilePhone" id="customerMobilePhone"  /><br><br>
      
      <button type="submit" >결제하기</button>
    </form:form>
  </body>
</html>
