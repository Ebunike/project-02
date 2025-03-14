<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var ="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin</title>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지</title>
</head>
<body>
    <h1>관리자 페이지</h1>

    <h2>관리자 메뉴</h2>
    <ul>
        <li><a href="${root }/admin/inquiry">고객문의 관리</a></li>
        <li><a href="${root }/admin/management">멤버 관리</a></li>
        <li><a href="${root }/admin/notice">공지사항</a></li>
    </ul>
    
    <a href="${root }/member/logout">로그아웃</a>
</body>
</html>