<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>benefit</title>
</head>
<body>
	<div class="side">
        <c:import url="/WEB-INF/views/include/admin_side.jsp" />
    </div>
        <!-- 하단 고정 바 -->
    <div class="bottom">
        <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
    </div>
</body>
</html>