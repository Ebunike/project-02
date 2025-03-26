<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의 목록</title>
</head>
<body>

<h2>내 문의 목록</h2>

<!-- myinquiry 리스트를 반복문으로 나열 -->
<c:if test="${not empty myinquiry}">
    <table border="1">
        <thead>
            <tr>
                <th>문의 제목</th>
                <th>읽음 여부</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="inquiry" items="${myinquiry}">
                <tr>
                    <!-- Title에 링크 추가 -->
                    <td>
                        <a href="${root}/inquiry/inquiry_detail?inquiry_idx=${inquiry.inquiry_idx}">
                            ${inquiry.inquiry_title}
                        </a>
                    </td>
                    <!-- inquiry_read (읽음 여부) 출력 -->
                    <td>${inquiry.inquiry_read}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>

<c:if test="${empty myinquiry}">
    <p>현재 등록된 문의가 없습니다.</p>
</c:if>

</body>
</html>