<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 검색</title>
</head>
<body>
    <h2>상품 검색</h2>
    
    <!-- form:form을 사용하여 검색 조건을 모델에 바인딩 -->
    <form:form method="post" action="/searchProducts" modelAttribute="searchCriteria">
        <div class="form-group">
            <label for="keywords">테마</label><br>
            <form:checkbox path="keywords" value="programming"/> 프로그래밍
            <form:checkbox path="keywords" value="design"/> 디자인
            <form:checkbox path="keywords" value="marketing"/> 마케팅
            <form:checkbox path="keywords" value="crafts"/> 공예
            <form:checkbox path="keywords" value="cook"/> 요리
        </div>

        <div class="form-group">
            <label for="startDate">시작 날짜</label>
            <form:input type="date" path="startDate" class="form-control"/>
        </div>

        <div class="form-group">
            <label for="endDate">종료 날짜</label>
            <form:input type="date" path="endDate" class="form-control"/>
        </div>

        <button type="submit" class="btn btn-primary">상품 검색</button>
    </form:form>

</body>
</html>