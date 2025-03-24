<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DDuk Bae Gi Admin</title>
    
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGarMaesGeur.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- 외부 CSS -->
    <link rel="stylesheet" href="${root}/css/admin.css" />
</head>
<body>
<div class="background_container">
    <!-- 메인 히어로 섹션 -->
    <div class="hero-section">
        <div class="background_image"></div>
        <div class="overlay"></div>
        <div class="tracking-in-contract">
            <h1>DDuk Bae Gi</h1>
            <h1>Admin</h1>
        </div>
        
        <!-- 스크롤 다운 표시 -->
        <div class="scroll-down">
            <span>Scroll Down</span>
            <i class="fas fa-chevron-down scroll-arrow"></i>
        </div>
    </div>
    
    <!-- 메뉴 버튼 -->
    <button id="menuToggle" class="menu-button">
        <img src="${root}/logo/catalog_logo.png" alt="Menu">
    </button>
    
    <!-- 사이드 메뉴 -->
    <div id="sideMenu">
        <button class="close-btn" onclick="toggleMenu()">
            <i class="fas fa-times"></i>
        </button>
        <div class="menu-items">
            <h1>관리자 페이지</h1>
            <ul>
                <li><a href="${root}/admin/inquiry"><i class="fas fa-comments mr-2"></i>고객문의 관리</a></li>
                <li><a href="${root}/admin/management"><i class="fas fa-users mr-2"></i>멤버 관리</a></li>
                <li><a href="${root}/admin/notice"><i class="fas fa-bullhorn mr-2"></i>공지사항</a></li>
                <li><a href="${root}/admin/benefit"><i class="fas fa-bullhorn mr-2"></i><span>쿠폰 및 혜택</span></a></li>
                <li><a href="${root}/member/logout"><i class="fas fa-sign-out-alt mr-2"></i>로그아웃</a></li>
            </ul>
        </div>
    </div>
    
    <!-- 콘텐츠 섹션 -->
    <section class="content-section">
        <!-- 배경과 추가 div들을 감싸는 컨테이너 -->
        <div class="background_wrapper">
            <!-- 왼쪽 이미지 섹션 -->
            <div class="background_image2">
                <div class="focus-in-contract-bck">
                    <h1>우태쿤이 사주는</h1>
                    <h2>힘이나는 </h2>
                    <h2>커피생활</h2>
                </div>
            </div>
            
            <!-- 오른쪽 이미지 그리드 -->
            <div class="image_boxes">
                <!-- 위쪽 3개 박스 -->
                <div class="top-boxes">
                    <div class="small-box1">
                        <a href="">
                            <img src="${root}/pic/back2.jpg" alt="이미지1">
                            <div class="image-overlay">
                                <h5>쿠폰 및 혜택</h5>
                                <p>쿠폰 & 포인트</p>
                            </div>
                        </a>
                    </div>
                    <div class="small-box2">
                        <a href="">
                            <img src="${root}/pic/back3.png" alt="이미지2">
                            <div class="image-overlay">
                                <h5>상품 관리</h5>
                                <p>상품 정보 관리 및 재고 현황을 확인하세요</p>
                            </div>
                        </a>
                    </div>
                    <div class="small-box3">
                        <a href="">
                            <img src="${root}/pic/back4.jpg" alt="이미지3">
                            <div class="image-overlay">
                                <h5>판매 보고서</h5>
                                <p>매출 및 판매 현황을 분석하세요</p>
                            </div>
                        </a>
                    </div>
                </div>
                
                <!-- 아래쪽 큰 박스 -->
                <div class="slide-in-box">
                    <a href="${root }/admin/system">
                        <img src="${root}/pic/back5.jpg" alt="이미지4">
                        <div class="image-overlay">
                            <h5>시스템 설정</h5>
                            <p>관리자 시스템 설정 및 환경 구성을 관리하세요</p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </section>
    
    <!-- 하단 고정 바 -->
    <div class="bottom">
        <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
    </div>
</div>

<!-- JavaScript -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<!-- 외부 JavaScript -->
<script src="${root}/js/admin.js"></script>
</body>
</html>