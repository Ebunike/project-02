<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>

<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f6f9;
        margin: 0;
        padding: 0;
    }

    .container {
        width: 100%;
        max-width: 600px;
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

    .result {
        font-size: 18px;
        font-weight: 600;
        color: #007bff;
        text-align: center;
        margin-bottom: 20px;
    }

    .alert {
        padding: 15px;
        font-size: 16px;
        text-align: center;
        margin-bottom: 30px;
        border-radius: 8px;
    }

    .alert-success {
        background-color: #d4edda;
        color: #155724;
    }

    .alert-danger {
        background-color: #f8d7da;
        color: #721c24;
    }

    .back-button {
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

    .back-button:hover {
        background-color: #0056b3;
    }

</style>

</head>
<body>
<div class="container">
    <div class="header">
        <h3>아이디 찾기 결과</h3>
    </div>
        <div class="alert alert-success">
            <strong>찾으신 아이디는:</strong>
            <p class="result">${id}</p>
        </div>



    <a href="javascript:history.back()" class="back-button">돌아가기</a>
</div>
</body>
</html>
