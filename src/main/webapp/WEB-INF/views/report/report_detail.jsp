<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />
<h2>📄 게시글 상세보기</h2>
	<%-- <c:forEach var="report" items="${report_list }"> --%>
	    <p><strong>제목:</strong> ${report.report_title}</p>
	    <p><strong>작성자:</strong> ${report.id}</p>
	    <p><strong>작성일:</strong> ${report.report_date}</p>
	    <p><strong>내용:</strong></p>
	    <p>${report.report_content}</p>
	<%-- </c:forEach> --%>
    <br>
    <c:if test="${report.id == loginUser.id}">
        <a href="report_edit?report_id=${report.report_id}">✏ 수정하기</a>
    </c:if>
    <a href="report_list">🔙 목록으로</a>
    
    <!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>