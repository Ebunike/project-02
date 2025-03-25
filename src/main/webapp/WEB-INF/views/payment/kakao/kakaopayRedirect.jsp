<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>카카오페이 결제 리다이렉트</title>
    <script>
        window.onload = function() {
            location.href = "${nextRedirectPcUrl}";
        }
    </script>
</head>
<body>
    <div style="text-align: center; margin-top: 50px;">
        <h3>카카오페이 결제창으로 이동 중입니다...</h3>
        <p>자동으로 이동하지 않는 경우 아래 버튼을 클릭해 주세요.</p>
        <button onclick="location.href='${nextRedirectPcUrl}'" style="padding: 10px 20px; background-color: #FFEB00; border: none; border-radius: 5px; cursor: pointer;">
            결제창으로 이동
        </button>
    </div>
    
    <!-- 공통 하단 정보 포함 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
	<script src="${root}/js/main.js"></script>
</body>
</html>