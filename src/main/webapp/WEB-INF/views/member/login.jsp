<%@ page import="org.apache.commons.lang3.RandomStringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var ="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>로그인</title>

<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style type="text/css">
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');
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
        overflow: hidden;
    }
    .card-header {
        text-align: center;
        padding: 20px;
        border-bottom: none;
        font-weight: 700;
    }
    .card-header h3 {
        margin: 0;
        font-weight: 500;
    }
    .card-body {
        padding: 30px;
        background-color: white;
        border: none;
    }
    .form-control {
        border-radius: 10px;
        padding: 12px 15px;
        height: auto;
        font-size: 16px;
        border: 1px solid #ced4da;
        transition: all 0.3s ease;
    }
    .form-control:focus {
        border-color: #007bff;
        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    }
    label {
        font-weight: 500;
        margin-bottom: 8px;
        color: #495057;
    }
    .btn {
        border-radius: 10px;
        padding: 10px 20px;
        font-size: 16px;
        font-weight: 500;
        transition: all 0.3s ease;
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
    .login-social {
        text-align: center;
        margin: 25px 0 15px;
        position: relative;
    }
    .login-social:before {
        content: "";
        position: absolute;
        top: 50%;
        left: 0;
        right: 0;
        height: 1px;
        background-color: #e9ecef;
        z-index: 1;
    }
    .login-social-text {
        display: inline-block;
        padding: 0 15px;
        background-color: white;
        position: relative;
        z-index: 2;
        color: #6c757d;
        font-size: 14px;
    }
    .social-icons {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin-top: 20px;
    }
    .social-icons a {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background-color: #f8f9fa;
        transition: all 0.3s ease;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    .social-icons a:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }
    .social-icons img {
        width: 30px;
        height: 30px;
        object-fit: contain;
    }
    .form-group {
        margin-bottom: 20px;
    }
    .alert-danger {
        border-radius: 10px;
        border: none;
        background-color: #f8d7da;
        color: #721c24;
    }
    .form-buttons {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 25px;
    }
    @media (max-width: 576px) {
        .card {
            margin: 0 15px;
        }
        .form-buttons {
            flex-direction: column;
            gap: 10px;
        }
        .form-buttons .btn {
            width: 100%;
        }
    }
</style>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />
<% String state = RandomStringUtils.randomAlphabetic(10); %>
<div class="container">
    <div class="row">
        <div class="col-md-8 offset-md-2 col-lg-6 offset-lg-3">
            <div class="card shadow">
                <div class="card-header">
                    <h3>로그인</h3>
                </div>
                
                <div class="card-body">
                    <c:if test="${fail == true }">
                        <div class="alert alert-danger">
                            <h5>로그인 실패</h5>
                            <p>아이디 비밀번호를 확인해주세요</p>
                        </div>
                    </c:if>
                    
                    <form:form action="${root}/member/login_pro" method='post' modelAttribute="loginUser">
                        <div class="form-group">
                            <form:label path="id">아이디</form:label>
                            <form:input path="id" class='form-control' placeholder="아이디를 입력하세요"/>
                            <form:errors path='id' style='color:red'/>
                        </div>
                        
                        <div class="form-group">
                            <form:label path="pw">비밀번호</form:label>
                            <form:password path="pw" class='form-control' placeholder="비밀번호를 입력하세요"/>
                            <form:errors path='pw' style='color:red'/>
                        </div>
                        
                        <div class="form-buttons">
                            <form:button class='btn btn-primary'><i class="fas fa-sign-in-alt mr-2"></i>로그인</form:button>
                            <a href="${root}/member/joinmain" class="btn btn-danger"><i class="fas fa-user-plus mr-2"></i>회원가입</a>
                        </div>
                        <div class="form-buttons">
                      		<a href="${root}/member/findidpw" class="btn btn-link" style="font-weight: 500; color: #007bff; text-decoration: none;">
                          		<i class="fas fa-search mr-2"></i>아이디/비밀번호 찾기
                         	</a>
                  		</div>
                    </form:form>
                    
                    <div class="login-social">
                        <span class="login-social-text">소셜 계정으로 로그인</span>
                    </div>
                    
                    <div class="social-icons">
                        <a href="https://kauth.kakao.com/oauth/authorize?client_id=9a17de118b1675247f3cd0e91ab90456&redirect_uri=http://localhost:9091/Project_hoon/login/kakao&response_type=code" class="kakao">
                            <img src="${root}/logo/kakao_logo.png" alt="카카오 로그인">
                        </a>
                        <a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=_7r1lFqIcHDabyPs6PkX&redirect_uri=http://localhost:9091/Project_hoon/login/naver&state=<%=state%>" class="naver">
                            <img src="${root}/logo/naver_logo.png" alt="네이버 로그인">
                        </a>
                        <a href="https://accounts.google.com/o/oauth2/v2/auth?scope=openid%20email%20profile&response_type=code&client_id=698222345372-4bdaro205t56cs6r3lfvq1ia8u0lsvr8.apps.googleusercontent.com&redirect_uri=http://localhost:9091/Project_hoon/login/google&state=<%=state%>" class="google">
                            <img src="${root}/logo/google_logo.png" alt="구글 로그인">
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>