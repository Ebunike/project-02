<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 / 비밀번호 찾기</title>

    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 100px;
        }
        .card {
            width: 100%;
            max-width: 500px;
            margin: auto;
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            text-align: center;
            padding: 20px;
            border-bottom: none;
        }
        .card-body {
            padding: 30px;
            background-color: white;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            height: auto;
            font-size: 16px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 25px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0069d9;
            border-color: #0062cc;
        }
        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }
        .btn-danger:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-8 offset-md-2 col-lg-6 offset-lg-3">
            <div class="card shadow">
                <div class="card-header">
                    <h3>아이디 / 비밀번호 찾기</h3>
                </div>
                <div class="card-body">
                    <!-- 아이디 찾기 -->
                    <h5>아이디 찾기</h5>
                    <form:form action="${root}/member/findid" method="post" modelAttribute="memberBean">
                        <div class="form-group">
                            <form:label path="name">이름</form:label>
                            <form:input path="name" class="form-control" placeholder="이름을 입력하세요" required="true"/>
                        </div>
                        <div class="form-group">
                            <form:label path="tel">전화번호</form:label>
                            <form:input path="tel" class="form-control" placeholder="전화번호를 입력하세요" required="true"/>
                        </div>
                        <div class="form-buttons">
                            <form:button class="btn btn-primary"><i class="fas fa-search mr-2"></i>아이디 찾기</form:button>
                        </div>
                    </form:form>
                    <hr>

                    <!-- 비밀번호 찾기 -->
                    <h5>비밀번호 찾기</h5>
                    <form:form action="${root}/member/findpw" method="post" modelAttribute="memberBean">
                        <div class="form-group">
                            <form:label path="name">이름</form:label>
                            <form:input path="name" class="form-control" placeholder="이름을 입력하세요" required="true"/>
                        </div>
                        <div class="form-group">
                            <form:label path="tel">전화번호</form:label>
                            <form:input path="tel" class="form-control" placeholder="전화번호를 입력하세요" required="true"/>
                        </div>
                        <div class="form-group">
                            <form:label path="id">아이디</form:label>
                            <form:input path="id" class="form-control" placeholder="아이디를 입력하세요" required="true"/>
                        </div>
                        <div class="form-group">
                            <form:label path="pw">새 비밀번호</form:label>
                            <form:input path="pw" class="form-control" placeholder="새로운 비밀번호를 입력하세요" required="true"/>
                            <form:errors path="pw" cssStyle="color:red"/>
                        </div>
                        <div class="form-buttons">
                            <form:button class="btn btn-primary"><i class="fas fa-search mr-2"></i>새 비밀번호 설정하기</form:button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
