<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var ="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin</title>
<link rel="stylesheet" href="${root }/css/admin.css" />
<script src="${root }/js/admin.js"></script>
    <meta charset="UTF-8">
    <title>관리자 페이지</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- admin.css(외부 css) -->
    <link rel="stylesheet" href="${root}/css/admin.css" />
    
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGarMaesGeur.css" rel="stylesheet">
</head>
<body>
<div class="background_container">
    <!-- 배경 이미지 -->
    <div class="background_image">
        <div class="top_text">
            <div class="tracking-in-contract">
                <h1>DDuk Bae Gi</h1>
                <h1>Admin</h1>
            </div>
        </div>

        <!-- 로고 버튼 (사이드 메뉴 토글) -->
        <button id="menuToggle" class="menu-button">
            <img src="${root }/logo/catalog_logo.png" alt="Menu">
        </button>
    </div>

    <!-- 사이드 메뉴 -->
    <div id="sideMenu">
        <button class="close-btn" onclick="toggleMenu()">&times;</button>
        <div class="menu-items">
            <h1>관리자 페이지</h1>
            <ul>
                <li><a href="${root }/admin/report">고객문의 관리</a></li>
                <li><a href="${root }/admin/management">멤버 관리</a></li>
                <li><a href="${root }/admin/notice">공지사항</a></li>
                <li><a href="${root }/member/logout">로그아웃</a></li>
            </ul>
        </div>
    </div>
    <!-- 두 번째 배경 이미지 -->
    
	   <!-- 배경과 추가 div들을 감싸는 컨테이너 -->
	<div class="background_wrapper">
	    <!-- 두 번째 배경 이미지 컨테이너 (왼쪽에 위치) -->
		    <div class="background_image2">
		        <div class="focus-in-contract-bck">
		            <h1>우태쿤이 사주는</h1>
		            <h2>힘이나는 커피생활</h2>
		        </div>
		    </div>
	    <!-- 오른쪽 이미지 박스 컨테이너 -->
	    <div class="image_boxes">
	        <!-- 위쪽 2개 박스 (나란히 배치) -->
	        <div class="top-boxes">
	            <div class="small-box1">
	            	<a href="">
	                	<img src="${root}/pic/back2.jpg" alt="이미지1">
	                </a>
	            </div>
	            <div class="small-box2">
	            	<a href="">
	                	<img src="${root}/pic/back3.png" alt="이미지2">
	                </a>
	            </div>
	            <div class="small-box3">
	            	<a href="">
	                	<img src="${root}/pic/back4.jpg" alt="이미지3">
	                </a>
	            </div>
	        </div>
	
	        <!-- 아래쪽 큰 박스 -->
	        <div class="slide-in-box">
	            <img src="${root}/pic/back5.jpg" alt="이미지3">
	        </div>
	    </div>
	</div>

    <!-- 하단 고정 바 (이미지 아래로 배치) -->
    <div class="bottom">
        <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
    </div>
</div>

<!-- JavaScript (JS 파일은 body 끝에서 로드) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <script src="${root}/js/admin.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // 배경 이미지 서서히 나타나는 효과
        document.querySelector(".background_image").style.opacity = "1";
    });
</script>
</body>
</html>