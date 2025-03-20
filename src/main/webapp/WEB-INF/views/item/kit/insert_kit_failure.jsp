<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 권한 제한</title>
</head>
<body>
	<script type="text/javascript">
	var memberType = "${memberType}"
	if(memberType === "sellerawaiter"){
	alert("판매등록 승인 대기중입니다.")	
	location.href = "${root}/"
	}else{
	alert("상품등록에 대한 권한이 없습니다")
	location.href = "${root}/"
	}
	</script>
</body>
</html>