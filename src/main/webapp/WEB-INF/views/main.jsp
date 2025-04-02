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
    <!-- 사이드바 버튼 CSS -->
    <link rel="stylesheet" href="${root}/css/main_sidebar.css" />
</head>
<body>

	<c:if test="${not empty param.error}">
        <div class="alert alert-danger">
            <strong> ${param.error}</strong>
        </div>
    </c:if>
	<!-- 상단 메뉴 부분 - include로 불러옴 -->
	<div class="top">
		<c:import url="/WEB-INF/views/include/top_menu.jsp" /> 
	</div>
	
    <!-- 카테고리 메뉴 - 가시성 개선을 위해 인라인 스타일 제거 -->
    <div class="category-menu">
        <ul>
            <li><a href="recipe/recipe_main?theme_index=1"><i class="fas fa-utensils fa-fw"></i> 레시피</a></li>
            <li><a href="oneday/list"><i class="fas fa-chalkboard-teacher fa-fw"></i> 원데이클래스</a></li>
            <li><a href="item/kit/kitMain"><i class="fas fa-box-open fa-fw"></i> 키트 메인</a></li>
            <li><a href="report/report_list"><i class="fas fa-comments fa-fw"></i> 자유게시판</a></li>
            <li><a href="inquiry/inquiry_main"><i class="fa-solid fa-headset"></i> 고객문의</a></li>
        </ul>
    </div>
    
   <!-- 고정 사이드바 버튼 - 제품 카테고리 및 스크롤 top 버튼 -->
<div class="quick-nav">
    <!-- 패션 카테고리 버튼 -->
    <div class="quick-btn" data-target="fashion-section">
        <i class="fas fa-tshirt"></i>
        <span class="quick-tooltip">Fashion | 2025 F/W</span>
    </div>
    <!-- 액세서리 카테고리 버튼 -->
    <div class="quick-btn" data-target="accessories-section">
        <i class="fas fa-gem"></i>
        <span class="quick-tooltip">Accessories | new brand launching!</span>
    </div>
    <!-- 뷰티 카테고리 버튼 -->
    <div class="quick-btn" data-target="beauty-section">
        <i class="fa-solid fa-spray-can-sparkles"></i>
        <span class="quick-tooltip">Beauty | perfume / cosmetics</span>
    </div>
    <!-- DIY 키트 카테고리 버튼 -->
    <div class="quick-btn" data-target="diy-section">
        <i class="fas fa-hammer"></i>
        <span class="quick-tooltip">DIY kit |</span>
    </div>
    <!-- 밀키트 카테고리 버튼 -->
    <div class="quick-btn" data-target="mealkit-section">
        <i class="fas fa-utensils"></i>
        <span class="quick-tooltip">Mealkit | </span>
    </div>
    <!-- 페이지 상단으로 스크롤 버튼 -->
    <div class="quick-btn scroll-top">
        <i class="fas fa-arrow-up"></i>
    </div>
</div>

    <!-- 메인 배너 슬라이더 - 페이드 효과가 적용된 메인 이미지 슬라이더 -->
    <div class="swiper-container">
        <div class="swiper mySwiper">
            <div class="swiper-wrapper">
                <c:forEach var="banner" items="${bannerList}">
                    <div class="swiper-slide">
                        <div class="banner-slide" style="background-image: url('${root}/upload/${banner.banner_img}');">
                            <div class="banner-text-container">
                                <a href="${banner.banner_link}" class="banner-link">
                                <c:if test="${not empty banner.banner_title}">
                                    <h2 class="banner-title">${banner.banner_title}</h2>
                                </c:if>
                                <c:if test="${not empty banner.banner_subtitle}">
                                    <p class="banner-subtitle">${banner.banner_subtitle}</p>
                                </c:if>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="swiper-button-next" style="caret-color: transparent;"></div>
            <div class="swiper-button-prev" style="caret-color: transparent;"></div>
            <div class="swiper-pagination" style="caret-color: transparent;"></div>
        </div>
    </div>

    <!-- 패션 섹션 -->
    <div id="fashion-section" class="section">
        <!-- 상품 슬라이더 제목  -->
        <div class="item_title">
            <h3>Fashion | </h3> <h5 style="color:red;">2025 F/W</h5>
        </div>
        <!-- 첫 번째 상품 슬라이더 - 오늘의 발견 -->
        <div class="swiper swiper2 myItemSwiper">
            <div class="swiper-wrapper">
                <c:choose>
                    <c:when test="${not empty dailyProducts}">
                        <c:forEach var="product" items="${dailyProducts}">
                            <div class="swiper-slide">
                                <div class="slide-content" style="margin-top: 20px;">
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
                        <div class="swiper-slide">
                            <div class="slide-content">
                                <a href="">
                                    <img src="${root}/pic/item1.jpg" alt="샘플 상품">
                                </a>
                                <div class="slide-info">
                                    <a href="">
                                        <h5>[샘플] 상품</h5>
                                        <h6>밀키트 샘플 35,000원</h6>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="swiper-pagination"></div>
        </div>
    </div>

    <!-- 액세서리 섹션 -->
    <div id="accessories-section" class="section">
        <div class="item_title">
            <h3>Accessories | </h3> <h5 style="color:red;">new brand launching!</h5>
        </div>
        <div class="swiper swiper2 myItemSwiper2">
            <div class="swiper-wrapper">
                <c:choose>
                    <c:when test="${not empty bestProducts}">
                        <c:forEach var="product" items="${bestProducts}">
                            <div class="swiper-slide">
                                <div class="slide-content"  style="margin-top: 20px;">
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
                        <div class="swiper-slide">
                            <div class="slide-content">
                                <a href="">
                                    <img src="${root}/pic/item1.jpg" alt="베스트 상품 1">
                                </a>
                                <div class="slide-info">
                                    <a href="">
                                        <h5>[베스트] 상품 1</h5>
                                        <h6>인기 밀키트 32,000원</h6>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="swiper-pagination"></div>
        </div>
    </div>

    <!-- 뷰티 섹션 -->
    <div id="beauty-section" class="section">
        <div class="item_title">
            <h3>Beauty | </h3> <h5 style="color:red;">perfume / cosmetics</h5>
        </div>
        <div class="swiper swiper2 myItemSwiper3">
            <div class="swiper-wrapper">
                <c:choose>
                    <c:when test="${not empty newProducts}">
                        <c:forEach var="product" items="${newProducts}">
                            <div class="swiper-slide">
                                <div class="slide-content" style="margin-top: 20px;">
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
                        <div class="swiper-slide">
                            <div class="slide-content">
                                <a href="">
                                    <img src="${root}/pic/item2.jpg" alt="신규 상품 1">
                                </a>
                                <div class="slide-info">
                                    <a href="">
                                        <h5>[신규] 상품 1</h5>
                                        <h6>신상 밀키트 27,000원</h6>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="swiper-pagination"></div>
        </div>
    </div>

    <!-- DIY 키트 섹션 -->
    <div id="diy-section" class="section">
        <div class="item_title">
            <h3>DIY kit | </h3> <h5 style="color:red;"></h5>
        </div>
        <div class="swiper swiper2 myItemSwiper4">
            <div class="swiper-wrapper">
                <c:choose>
                    <c:when test="${not empty saleProducts}">
                        <c:forEach var="product" items="${saleProducts}">
                            <div class="swiper-slide">
                                <div class="slide-content" style="margin-top: 20px;">
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
                        <div class="swiper-slide">
                            <div class="slide-content">
                                <img src="${root}/pic/item1.jpg" alt="할인 상품 1">
                </a>
                <div class="slide-info">
                    <a href="">
                        <h5>[할인] 상품 1</h5>
                        <h6>특가 밀키트 20,000원</h6>
                    </a>
                </div>
            </div>
        </div>
        </c:otherwise>
    </c:choose>
    </div>
    <div class="swiper-pagination"></div>
    </div>
    </div>

    <!-- 밀키트 섹션 -->
    <div id="mealkit-section" class="section">
        <div class="item_title">
            <h3>Mealkit | </h3> <h5 style="color:red;"></h5>
        </div>	
        <div class="swiper swiper2 myItemSwiper5">
            <div class="swiper-wrapper">
                <c:choose>
                    <c:when test="${not empty seasonalProducts}">
                        <c:forEach var="product" items="${seasonalProducts}">
                            <div class="swiper-slide">
                                <div class="slide-content" style="margin-top: 20px;">
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
                        <div class="swiper-slide">
                            <div class="slide-content">
                                <a href="">
                                    <img src="${root}/pic/item2.jpg" alt="제철 상품 1">
                                </a>
                                <div class="slide-info">
                                    <a href="">
                                        <h5>[제철] 상품 1</h5>
                                        <h6>계절 밀키트 29,000원</h6>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="swiper-pagination"></div>
        </div>
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
    <!-- 사이드바 버튼 JS -->
    <script src="${root}/js/main_sidebar.js"></script>
</body>
</html>