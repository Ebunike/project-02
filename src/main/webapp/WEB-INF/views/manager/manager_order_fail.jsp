<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var = "root" value="${pageContext.request.contextPath }" />
<script>
   alert("관리자 승인 대기중입니다.")
   location.href = "${root}/"
</script>