<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var ="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멤버 관리</title>
</head>
<body>
    <h1>회원 목록</h1>
    
    <table border="1">
        <thead>
            <tr>
                <th>아이디</th>
                <th>이름</th>
                <th>이메일</th>
            </tr>
        </thead>
        <tbody>
            
            <c:forEach var="member" items="${allMember}">
                <tr>
                    <td>
                        <a href="${root}/admin/memberinfo?id=${member.id}">${member.id}</a>
                    </td>
                    <td>${member.name}</td>
                    <td>${member.email}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <br>
    <a href="${root }/admin/adminmain">관리자 페이지로 돌아가기</a>
</body>
</html>