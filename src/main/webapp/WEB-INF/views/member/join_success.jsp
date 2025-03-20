<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var ="root" value="${pageContext.request.contextPath }"/>

<script>
	var memberType = "${memberType}";
	alert("회원가입이 되었습니다")
	if(memberType === seller){
		alert("판매 승인 대기중입니다.")	
	}
	location.href = "${root}/"
</script>