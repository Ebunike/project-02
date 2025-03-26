<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var ="root" value="${pageContext.request.contextPath }"/>

<script>
	
	alert("문의가 정상적으로 등록되었습니다")
	
	location.href = "${root}/inquiry/inquiry_list?id=${id}"
</script>