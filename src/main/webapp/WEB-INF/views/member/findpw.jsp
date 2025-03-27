<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value='${pageContext.request.contextPath}/'/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 설정 완료</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f6f9;
        margin: 0;
        padding: 0;
    }
    .container {
        width: 100%;
        max-width: 500px;
        margin: 100px auto;
        padding: 20px;
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .header {
        text-align: center;
        font-size: 24px;
        font-weight: 700;
        color: #333;
        margin-bottom: 30px;
    }
    .message {
        font-size: 18px;
        font-weight: 600;
        color: #007bff;
        text-align: center;
        margin-bottom: 30px;
    }
    .btn-login {
        display: block;
        width: 100%;
        padding: 12px;
        text-align: center;
        font-size: 16px;
        font-weight: 500;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 8px;
        text-decoration: none;
    }
    .btn-login:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
<div class="container">
    <div class="header">
        <h3>비밀번호 설정 완료</h3>
    </div>
    <div class="message">
        <p>정상적으로 비밀번호 설정이 완료되었습니다.</p>
    </div>
    <a href="${root}/member/login" class="btn-login">로그인하러 가기</a>
</div>
</body>
</html>