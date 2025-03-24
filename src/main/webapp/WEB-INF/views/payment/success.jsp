<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

성공 

<a href="${root}/payment/account_finished_page">입금확인</a>
 <a href="${root}/payment/cancel?paymentKey=${paymentKey}&cancelReason=테스트용구매자변심등&cancelAmount=1000">환불 요청</a>
 
 ${result} }
 

</body>
</html>