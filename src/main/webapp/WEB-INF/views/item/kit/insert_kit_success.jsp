<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>키트상품 등록성공</title>
</head>
<body>
<script>
alert("상품등록에 성공했습니다")
location.href = "${root}/"
</script>
</body>
</html>