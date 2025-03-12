<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var ="root" value="${pageContext.request.contextPath }"/>

<script>
	alert("정상적으로 탈퇴가 되었습니다. 이용해주셔서 감사합니다.")
	location.href = "${root}/"
</script>