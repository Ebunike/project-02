<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>  
<meta charset="UTF-8">
<title>search</title>
<link rel="stylesheet" href="${root }/css/top.css" />
<link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGaRamYeonGgoc.css" rel="stylesheet">
<!-- 기존 폰트만 사용 -->

<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>
<body>
<nav class="navbar navbar-expand-md fixed-top shadow-lg top-nav-menu">
    <div class="top_main_logo">
	    <a class="top-logo-item" href="${root }/" title="홈으로 이동">
			<img  src="${root }/resources/logo/main_logo.png">
	    </a>
    </div>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navMenu">
        <span class="navbar-toggler-icon"></span>        
    </button>
    <div class="collapse navbar-collapse" id="navMenu">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a href="${root }/hoon/main?top_idx=${obj.top_idx}" >${obj.top_name }</a>
            </li>
        </ul>
    </div>
    <div class="top-search-container">
        <form class="top-search-box" action="${root}/search/result" method="GET">
            <input type="text" id="search-input" name="result" placeholder="원하는 요리나 클래스를 검색해보세요">
            <div class="top-logo-item">
	            <button type="submit" class="top-search-btn" title="검색">
	            	<i class="fas fa-search top-nav-icon"></i>
	            </button>
            </div>
        </form>
    </div>
    
    <ul class="navbar-nav ml-auto">
        <c:choose>
            <c:when test="${loginUser.login=='seller'||loginUser.login=='buyer'||loginUser.login =='sellerawaiter'}">
                <li class="top-logo-item">
                	<%--내 정보 아이콘 --%>
                    <a href="${root }/member/my_info" title="내 정보">
                    	<i class="fas fa-user-circle top-nav-icon"></i>
                    </a>
                </li>
                <li class="top-logo-item">
                	<%-- 장바구니 아이콘 --%>
                    <a href="${root }/cart/my_cart" title="장바구니">
                    	<i class="fas fa-shopping-cart top-nav-icon"></i>
                    </a>
                </li>
                <li class="top-logo-item">
                	<!-- 로그아웃 아이콘 -->
                    <a href="${root }/member/logout" title="로그아웃">
                    	<i class="fas fa-sign-out-alt top-nav-icon"></i>
                    </a>
                </li>
            </c:when>
               <c:when test="${loginUser.login.equals('x') }">
                <li class="top-logo-item">
                	<!-- 로그인 아이콘 -->
                    <a href="${root }/member/login" title="로그인">
                    	<i class="fas fa-sign-in-alt top-nav-icon"></i>
                    </a>
                </li>
                <li class="top-logo-item">
                	<!-- 회원가입 아이콘 -->
                    <a href="${root }/member/joinmain" title="회원가입">
                    	<i class="fas fa-user-plus top-nav-icon"></i>
                    </a>
                </li>
            </c:when>
        </c:choose>
        <li class="top-logo-item">
            <button id="topMenuToggle" class="top-menu-button" title="메뉴 열기">
                <i class="fa-solid fa-bars top-nav-icon"></i>
            </button>
        </li>
    </ul>
   
</nav>
	<!-- 사이드 메뉴 -->
	<div id="topSideMenu" class="top-side-menu">
	    <button class="top-close-btn" onclick="toggleTopMenu()" title="메뉴 닫기"><i class="fas fa-times"></i></button>
	    <c:choose>
	    	<%-- 판매자 전용  --%>
		    <c:when test="${loginUser.login=='seller'}">
		    	<div class="top-menu-items">
			        <h3 class="menu-section-title">비즈니스 관리</h3>
			        <a href="${root }/manager/manager_order"><i class="fas fa-clipboard-list"></i> 주문 내역 관리</a>
			        <a href="${root }/manager/manager_sales"><i class="fas fa-chart-line"></i> 매출 분석</a>
			        <a href="${root }/manager/manager_product"><i class="fas fa-box"></i> 상품 등록/관리</a>
			        <a href="${root }/manager/manager_ask"><i class="fas fa-question-circle"></i> 고객 문의 관리</a>
			        <a href="${root }/manager/manager_review"><i class="fas fa-star"></i> 리뷰 모니터링</a>
			        
			        <h3 class="menu-section-title">내 활동</h3>
			        <a href="${root }/member/my_info"><i class="fas fa-user"></i> 프로필 관리</a>
			        <a href="${root }/cart/my_cart"><i class="fas fa-shopping-cart"></i> 장바구니</a>
			        <a href="${root }/payment/buyingList"><i class="fas fa-shopping-bag"></i> 구매 내역</a>
			        <a href="${root }/inquiry/inquiry_list?id=${loginUser.id}"><i class="fas fa-question"></i> 내 문의 내역</a>
			        <a href="${root }/chating/main"><i class="fas fa-comments"></i> 메시지</a>
			        <a href="${root }/member/logout" class="logout-link"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
			    </div>
		    </c:when>
		    <c:when test="${loginUser.login=='sellerawaiter'}">
		    	<div class="top-menu-items">
			        <h3 class="menu-section-title">판매자 인증 대기 중</h3>
			        <div class="seller-awaiter-info">
			            <p>판매자 인증이 진행 중입니다. 승인이 완료되면 판매자 기능을 사용하실 수 있습니다.</p>
			        </div>
			        
			        <a href="${root }/manager/manager_order_fail" class="disabled-link"><i class="fas fa-clipboard-list"></i> 주문 내역 관리</a>
			        <a href="${root }/manager/manager_sales_fail" class="disabled-link"><i class="fas fa-chart-line"></i> 매출 분석</a>
			        <a href="${root }/manager/manager_product_fail" class="disabled-link"><i class="fas fa-box"></i> 상품 등록/관리</a>
			        <a href="${root }/manager/manager_ask_fail" class="disabled-link"><i class="fas fa-question-circle"></i> 고객 문의 관리</a>
			        <a href="${root }/manager/manager_review_fail" class="disabled-link"><i class="fas fa-star"></i> 리뷰 모니터링</a>
			        
			        <h3 class="menu-section-title">내 활동</h3>
			        <a href="${root }/member/my_info"><i class="fas fa-user"></i> 프로필 관리</a>
			        <a href="${root }/cart/my_cart"><i class="fas fa-shopping-cart"></i> 장바구니</a>
			        <a href="${root }/chating/main"><i class="fas fa-comments"></i> 메시지</a>
			        <a href="${root }/member/logout" class="logout-link"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
			    </div>
		    </c:when>
		    <%-- 구매자 전용 --%>
		    <c:when test="${loginUser.login.equals('buyer')}">
		    	<div class="top-menu-items">	
			        <h3 class="menu-section-title">맛있는 발견의 시작</h3>
			        <a href="recipe/recipe_main?theme_index=1"><i class="fas fa-utensils"></i> 레시피 탐색</a>
			        <a href="oneday/list"><i class="fas fa-calendar-day"></i> 원데이 클래스</a>
			        <a href="item/kit/kitMain"><i class="fas fa-box-open"></i> 요리 키트 쇼핑</a>
			        <a href="report/report_list"><i class="fas fa-edit"></i> 커뮤니티</a>
			        <a href="inquiry/inquiry_main"><i class="fas fa-headset"></i> 고객센터</a>
			        
			        <h3 class="menu-section-title">내 쿠킹 스페이스</h3>
			        <a href="${root }/member/my_info"><i class="fas fa-user"></i> 프로필 관리</a>
			        <a href="${root }/cart/my_cart"><i class="fas fa-shopping-cart"></i> 장바구니</a>
			        <a href="${root }/inquiry/inquiry_list?id=${loginUser.id}"><i class="fas fa-question"></i> 내 문의 내역</a>
			        <a href="${root }/payment/buyingList"><i class="fas fa-shopping-bag"></i> 구매 내역</a>
			        <a href="${root }/chating/main"><i class="fas fa-comments"></i> 메시지</a>
			        <a href="${root }/member/logout" class="logout-link"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
			    </div>
		    </c:when>
		    <%-- 비 로그인 전용 --%>
		    <c:when test="${loginUser.login.equals('x') }">
		    	<div class="top-menu-items">
		    	    <h3 class="menu-section-title">맛있는 발견의 시작</h3>
			        <a href="recipe/recipe_main?theme_index=1"><i class="fas fa-utensils"></i> 레시피 탐색</a>
			        <a href="oneday/list"><i class="fas fa-calendar-day"></i> 원데이 클래스</a>
			        <a href="item/kit/kitMain"><i class="fas fa-box-open"></i> 요리 키트 쇼핑</a>
			        <a href="report/report_list"><i class="fas fa-edit"></i> 커뮤니티</a>
			        <a href="inquiry/inquiry_main"><i class="fas fa-headset"></i> 고객센터</a>
			        
			        <div class="login-prompt">
			            <p>로그인하시면 더 많은 서비스를 이용하실 수 있습니다.</p>
			            <div class="login-buttons">
			                <a href="${root }/member/login" class="login-btn"><i class="fas fa-sign-in-alt"></i> 로그인</a>
			                <a href="${root }/member/joinmain" class="join-btn"><i class="fas fa-user-plus"></i> 회원가입</a>
			            </div>
			        </div>
		    	</div>
		    </c:when>
		</c:choose>
	</div>
	<style>
	:root {
	    --primary-color: #FF9F29;
	    --primary-light: #FFD89C;
	    --primary-dark: #E67E22;
	    --text-color: #333333;
	    --text-light: #777777;
	    --bg-light: #FFF9F0;
	    --border-color: #FFD89C;
	}
	
	body {
        font-family: 'NanumGaRamYeonGgoc', sans-serif;
        margin: 0;
        padding: 0;
    }
	
	.top-nav-menu {
		background-color: #FFF1D5;
		height: 73px;
		box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
	}
	
	.top-search-container {
		background-color: #FFF1D5;
	}
	
	/* 기본 스타일 */
	.top-nav-menu {
		position: relative;
		z-index: 1000;
	}
	
	.top-search-container {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		display: flex;
		justify-content: center;
		align-items: center;
		border-radius: 15px;
	}
	
	.top-search-box {
		display: flex;
		align-items: center;
		background-color: white;
		border: 2px solid var(--primary-color);
		border-radius: 30px;
		padding: 5px 15px;
		overflow: hidden;
		transition: all 0.3s ease;
		box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
	}
	
	.top-search-box:focus-within {
	    box-shadow: 0 5px 15px rgba(255, 159, 41, 0.15);
	    transform: translateY(-2px);
	}
	
	.top-search-box input {
		padding: 10px;
		border: none;
		outline: none;
		background: transparent;
		width: 300px;
		font-size: 15px;
		color: var(--text-color);
		font-family: 'NanumGaRamYeonGgoc', sans-serif;
	}
	
	.top-search-box input::placeholder {
		color: var(--text-light);
		font-size: 14px;
	}
	
	.top-search-btn {
		background: none;
		border: none;
		cursor: pointer;
		transition: transform 0.2s;
	}
	
	.top-search-btn:hover {
	    transform: scale(1.1);
	}
	
	.top-search-btn i {
		font-size: 1.3rem;
		color: var(--primary-dark);
	}
	
	.top-logo-item {
		display: flex;
		align-items: center;
		justify-content: center;
		margin: 0 10px;
	}
	
	.top-logo-item a {
		text-decoration: none;
		transition: transform 0.2s ease;
	}
	
	.top-logo-item a:hover {
	    transform: translateY(-3px);
	}
	
	.top-nav-icon {
		font-size: 1.6rem;
		color: var(--primary-dark);
		transition: color 0.2s;
	}
	
	.top-logo-item:hover .top-nav-icon {
	    color: var(--primary-color);
	}
	
	/* 사이드바 스타일 */
	.top-side-menu {
		position: fixed;
		top: 0;
		right: 0;
		width: 320px;
		height: 100%;
		background-color: white;
		transform: translateX(100%);
		transition: transform 0.3s ease;
		padding: 25px;
		z-index: 1001;
		overflow-y: auto;
		box-shadow: -5px 0 25px rgba(0, 0, 0, 0.1);
	}
	
	.top-side-menu.active {
		transform: translateX(0);
	}
	
	.top-close-btn {
		background: none;
		border: none;
		font-size: 22px;
		cursor: pointer;
		float: right;
		color: var(--text-light);
		transition: color 0.2s, transform 0.2s;
	}
	
	.top-close-btn:hover {
	    color: var(--primary-dark);
	    transform: rotate(90deg);
	}
	
	.top-menu-items {
		margin-top: 40px;
	}
	
	.menu-section-title {
	    font-size: 18px;
	    color: var(--primary-dark);
	    margin: 25px 0 15px 0;
	    padding-bottom: 8px;
	    border-bottom: 2px solid var(--primary-light);
	    font-weight: 700;
	}
	
	.top-menu-items a {
		display: block;
		padding: 8px 15px;
		text-decoration: none;
		color: var(--text-color);
		font-size: 15px;
		border-radius: 8px;
		margin-bottom: 5px;
		transition: all 0.2s ease;
	}
	
	.top-menu-items a i {
		margin-right: 12px;
		font-size: 1.1rem;
		color: var(--primary-color);
		width: 20px;
		text-align: center;
		transition: all 0.2s ease;
	}
	
	.top-menu-items a:hover {
		background-color: var(--bg-light);
		color: var(--primary-dark);
		transform: translateX(5px);
	}
	
	.top-menu-items a:hover i {
		color: var(--primary-dark);
	}
	
	.logout-link {
	    margin-top: 15px;
	    border-top: 1px solid var(--border-color);
	    color: #e74c3c !important;
	}
	
	.logout-link i {
	    color: #e74c3c !important;
	}
	
	.top-menu-button {
		background: none;
		border: none;
		cursor: pointer;
	}
	
	/* 추가 스타일 */
	.seller-awaiter-info {
	    background-color: #fff3cd;
	    border-left: 4px solid #ffc107;
	    padding: 12px 15px;
	    margin: 10px 0 20px 0;
	    border-radius: 4px;
	}
	
	.seller-awaiter-info p {
	    margin: 0;
	    font-size: 14px;
	    color: #856404;
	}
	
	.disabled-link {
	    opacity: 0.6;
	    cursor: not-allowed;
	    pointer-events: none;
	}
	
	.login-prompt {
	    background-color: var(--bg-light);
	    padding: 20px;
	    border-radius: 10px;
	    margin-top: 30px;
	    text-align: center;
	    border: 1px dashed var(--border-color);
	}
	
	.login-prompt p {
	    margin-bottom: 15px;
	    color: var(--text-color);
	    font-size: 14px;
	}
	
	.login-buttons {
	    display: flex;
	    gap: 10px;
	}
	
	.login-btn, .join-btn {
	    flex: 1;
	    text-align: center;
	    padding: 12px !important;
	    border-radius: 8px;
	    font-weight: 500;
	    font-size: 14px !important;
	    transition: all 0.3s ease !important;
	}
	
	.login-btn {
	    background-color: var(--primary-color) !important;
	    color: white !important;
	}
	
	.join-btn {
	    background-color: white !important;
	    border: 1px solid var(--primary-color);
	    color: var(--primary-color) !important;
	}
	
	.login-btn:hover, .join-btn:hover {
	    transform: translateY(-3px) !important;
	    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	}
	
	@media (max-width: 768px) {
	    .top-search-box input {
	        width: 180px;
	    }
	    
	    .top-side-menu {
	        width: 85%;
	    }
	}
	.top_main_logo img {
	width: 80px;
	height: 70px;
	
}
	</style>
	<script>
	    function toggleTopMenu() {
	        document.getElementById("topSideMenu").classList.toggle("active");
	    }
	    document.getElementById("topMenuToggle").addEventListener("click", toggleTopMenu);
	</script>
	
</body>
</html>