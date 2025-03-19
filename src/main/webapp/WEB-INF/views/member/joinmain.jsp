<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="${root }/member/memberjoin?name=${name}&email=${email}">구매자 회원가입</a>
<a href="${root }/member/sellerjoin?name=${name}&email=${email}">판매자 회원가입</a>

</body>
</html>