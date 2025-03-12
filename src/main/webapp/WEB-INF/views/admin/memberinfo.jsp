<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var ="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 상세 정보</title>
</head>
<body>
    <h1>회원 상세 정보</h1>
    
    <table border="1">
        <tr>
            <th>아이디</th>
            <td>${memberInfo.id}</td>
        </tr>
        <tr>
            <th>이름</th>
            <td>${memberInfo.name}</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>${memberInfo.email}</td>
        </tr>
        <tr>
            <th>전화번호</th>
            <td>${memberInfo.tel}</td>
        </tr>
        <tr>
            <th>나이</th>
            <td>${memberInfo.age}</td>
        </tr>
        <tr>
            <th>성별</th>
            <td>${memberInfo.gender}</td>
        </tr>
        <tr>
            <th>주소</th>
            <td>${memberInfo.address}</td>
        </tr>
        <tr>
    		<th>관심 키워드</th>
   			 <td>
       		 <c:forEach var="keyword" items="${memberInfo.keyword}">
            ${keyword}<br>
       		 </c:forEach>
   			 </td>
		</tr>
        
    </table>

    <br>
    <a href="${root}/admin/delete?id=${memberInfo.id}">회원 제명하기</a>
    <a href="${root}/admin/management">회원 목록으로 돌아가기</a>
</body>
</html>