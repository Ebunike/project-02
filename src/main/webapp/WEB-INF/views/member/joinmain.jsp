<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DDuk Bae Gi - join</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<style type="text/css">
    .card-body {
        border: 1px solid #e0e0e0;
        padding: 30px;
        width: 600px;
        height: 400px;
        margin: auto;
        border-radius: 20px;
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        background-color: #f8f9fa;
    }
    
    .btn-container {
        display: flex;
        justify-content: space-between;
        height: 100%;
    }
    
    .btn-registration {
        width: 250px;
        height: 300px;
        border-radius: 15px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        transition: all 0.3s ease;
        border: none;
        position: relative;
        overflow: hidden;
    }
    
    .btn-registration:before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 100%);
        z-index: 1;
    }
    
    .btn-registration:hover {
        transform: translateY(-10px);
        box-shadow: 0 15px 25px rgba(0,0,0,0.2);
    }
    
    .seller-btn {
        background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
    }
    
    .buyer-btn {
        background: linear-gradient(135deg, #36b9cc 0%, #1a8a98 100%);
    }
    
    .btn-icon {
        font-size: 60px;
        margin-bottom: 20px;
    }
    
    .btn-title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 15px;
        color: white;
    }
    
    .btn-description {
        font-size: 14px;
        text-align: center;
        padding: 0 20px;
        color: white;
    }
    
    .page-title {
        text-align: center;
        margin-bottom: 30px;
        font-weight: bold;
        color: #333;
    }
</style>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />
<div class="container mt-5 mb-5">
    <h3 class="page-title">회원가입 유형을 선택해주세요</h3>
    <div class="card-body">
        <div class="btn-container">
            <a href="${root }/member/sellerjoin?name=${name}&email=${email}&api=${api}" class="btn btn-registration seller-btn">
                <i class="fas fa-store btn-icon"></i>
                <div class="btn-title">사업자 회원가입</div>
                <div class="btn-description">비즈니스를 위한 다양한 혜택과</div>
                <div class="btn-description"> 서비스를 이용하실 수 있습니다.</div>
            </a>
            <a href="${root }/member/memberjoin?name=${name}&email=${email}&api=${api}" class="btn btn-registration buyer-btn">
                <i class="fas fa-shopping-cart btn-icon"></i>
                <div class="btn-title">구매자 회원가입</div>
                <div class="btn-description">편리한 쇼핑과 다양한 </div>
                <div class="btn-description">구매 혜택을 누리실 수 있습니다.</div>
            </a>
        </div>
    </div>
</div>
<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>