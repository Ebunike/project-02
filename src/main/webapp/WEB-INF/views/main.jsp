<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
	<title>DDuk Bae Gi - 홈</title>
	
	<!-- Font Awesome 아이콘 라이브러리 -->
	<script src="https://kit.fontawesome.com/516da99189.js" crossorigin="anonymous"></script>
	
	<!-- Bootstrap CDN - 반응형 디자인을 위한 프레임워크 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
  	
  	<!-- Swiper CSS - 슬라이더 라이브러리 -->
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    
    <!-- Google Fonts - 구글 웹폰트 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <!-- 네이버 폰트 - 나눔손글씨 폰트 -->
    <link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGaRamYeonGgoc.css" rel="stylesheet">
    
    <!-- 외부 CSS 파일 링크 -->
    <link rel="stylesheet" href="${root}/css/main.css" />
</head>
<body>
	<!-- 상단 메뉴 부분 - include로 불러옴 -->
	<div class="top">
		<c:import url="/WEB-INF/views/include/top_menu.jsp" /> 
	</div>
	
    <!-- 카테고리 메뉴 - 가시성 개선을 위해 인라인 스타일 제거 -->
    <div class="category-menu">
        <ul>
            <li><a href="recipe/recipe_main?theme_index=1"><i class="fas fa-utensils fa-fw"></i> 레시피</a></li>
            <li><a href="onedayclass/onedayMain"><i class="fas fa-chalkboard-teacher fa-fw"></i> 원데이클라스</a></li>
            <li><a href="item/kit/kitMain"><i class="fas fa-box-open fa-fw"></i> 키트 메인</a></li>
            <li><a href="report/report_list"><i class="fas fa-comments fa-fw"></i> 자유게시판</a></li>
            <li><a href="#"><i class="fas fa-user fa-fw"></i> 장재훈</a></li>
        </ul>
    </div>
    
    <!-- 메인 배너 슬라이더 - 페이드 효과가 적용된 메인 이미지 슬라이더 -->
    <div class="swiper-container">
        <div class="swiper mySwiper">
            <div class="swiper-wrapper">
                <!-- 동적으로 배너 생성 -->
                <c:choose>
                    <c:when test="${not empty bannerList}">
                        <c:forEach var="banner" items="${bannerList}">
                            <div class="swiper-slide">
                                <a href="${banner.banner_link}">
                                    <img src="${root}/upload/${banner.banner_img}" alt="${banner.banner_name}">
                                </a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- 기본 배너 표시 (데이터베이스에서 배너를 가져오지 못한 경우) -->
                        <div class="swiper-slide">
                            <a href="">
                                <img src="${root}/pic/back.jpg" alt="배너 이미지 1">
                            </a>
                        </div>
                        <div class="swiper-slide">
                            <a href="">
                                <img src="${root}/pic/back2.jpg" alt="배너 이미지 2">
                            </a>
                        </div>
                        <div class="swiper-slide">
                            <a href="">
                                <img src="${root}/pic/back3.png" alt="배너 이미지 3">
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <!-- 배너 슬라이더 네비게이션 버튼 -->
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
            <!-- 배너 슬라이더 페이지네이션(점) -->
            <div class="swiper-pagination"></div>
        </div>
    </div>

    <!-- 상품 슬라이더 제목 - 스타일이 적용된 제목 영역 -->
    <div class="item_title">
        <h3>오늘의 발견 |</h3> <h5>승호가 추천하는 상품!</h5>
    </div>
    
    <!-- 상품 슬라이더 - 여러 상품을 자동으로 슬라이드 표시 -->
    <div class="swiper swiper2 myItemSwiper">
        <div class="swiper-wrapper">
            <!-- 동적으로 상품 생성 -->
            <c:choose>
                <c:when test="${not empty productList}">
                    <c:forEach var="product" items="${productList}">
                        <div class="swiper-slide">
                            <div class="slide-content">
                                <a href="${product.product_link}">
                                    <img src="${root}/upload/${product.product_img}" alt="${product.product_name}">
                                </a>
                                <div class="slide-info">
                                    <a href="${product.product_link}">
                                        <h5>${product.product_name}</h5>
                                        <h6>${product.product_desc} ${product.product_price}원</h6>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- 기본 상품 표시 (데이터베이스에서 상품을 가져오지 못한 경우) -->
                    <div class="swiper-slide">
                        <div class="slide-content">
                            <a href="">
                                <img src="${root}/pic/item1.jpg" alt="쇠고기 샤브샤브">
                            </a>
                            <div class="slide-info">
                                <a href="">
                                    <h5>[쇠고기 샤브샤브]</h5>
                                    <h6>푸드 어셈블 밀키트 35,000원</h6>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="slide-content">
                            <a href="">
                                <img src="${root}/pic/item2.jpg" alt="추천상품">
                            </a>
                            <div class="slide-info">
                                <a href="">
                                    <h5>[추천상품]</h5>
                                    <h6>밀키트 15,000원</h6>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <!-- 상품 슬라이더 페이지네이션(점) -->
        <div class="swiper-pagination"></div>
    </div>

    <!-- 두 번째 상품 슬라이더 제목 -->
    <div class="item_title">
        <h3>오늘의 발견 |</h3> <h5>승호가 추천하는 상품!</h5>
    </div>
    
    <!-- 스크롤 애니메이션 섹션 - 스크롤 시 등장하는 이미지와 텍스트 -->
    <div class="scroll-section">
        <!-- 배경 이미지 - 스크롤에 따라 나타남 -->
        <div class="background-image">
            <!-- 애니메이션 텍스트 - 배경이 나타난 후 등장 -->
            <div class="animated-text">
                <h2>아이와 함께 만드는</h2>
                <p>즐거운 시간!</p>
            </div>
        </div>
    </div>

    <!-- 하단 정보 - include로 불러옴 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
    
    <!-- Swiper JS - 슬라이더 라이브러리 -->
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    
    <!-- 외부 JS 파일 - 애니메이션과 상호작용 효과 -->
    <script src="${root}/js/main.js"></script>
</body>
</html>