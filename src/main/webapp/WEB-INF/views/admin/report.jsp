<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<c:set var ="root" value="${pageContext.request.contextPath }"/>
<html>
<head>
    <title>고객 문의 목록</title>
</head>
<body>
    <h1>고객 문의 목록</h1>
    
    <h2>읽지 않은 고객 문의</h2>
    <ul>
        <c:forEach var="suggestion" items="${report}">
            <c:if test="${suggestion.report_read == '안읽음'}">
                <li><a href="${root }/admin/viewinquiry?id=${suggestion.report_id}">${suggestion.report_title}</a></li>
            </c:if>
        </c:forEach>
    </ul>

    <h2>읽은 고객 문의</h2>
    <ul>
        <c:forEach var="suggestion" items="${report}">
            <c:if test="${suggestion.report_read == '읽음'}">
                <li><a href="${root }/admin/viewinquiry?id=${suggestion.report_id}">${suggestion.report_title}</a></li>
            </c:if>
        </c:forEach>
    </ul>
    <a href="${root }/admin/adminmain">관리자 페이지로 돌아가기</a>

</body>
</html>
