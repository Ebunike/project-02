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

<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>
<body>
<nav class="navbar navbar-expand-md fixed-top shadow-lg top-nav-menu">
    <a class="top-logo-item" href="${root }/">
    	<i class="fa-solid fa-house-chimney top-nav-icon"></i>
    </a>
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
            <input type="text" id="search-input" name="result" placeholder="검색어를 입력하세요...">
            <div class="top-logo-item">
	            <button type="submit" class="top-search-btn">
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
                    <a href="${root }/member/my_info">
                    	<i class="fas fa-user-circle top-nav-icon"></i>
                    </a>
                </li>
                <li class="top-logo-item">
                	<%-- 장바구니 아이콘 --%>
                    <a href="${root }/cart/my_cart" >
                    	<i class="fas fa-shopping-cart top-nav-icon"></i>
                    </a>
                </li>
                <li class="top-logo-item">
                	<!-- 로그아웃 아이콘 -->
                    <a href="${root }/member/logout" >
                    	<i class="fas fa-sign-out-alt top-nav-icon"></i>
                    </a>
                </li>
            </c:when>
               <c:when test="${loginUser.login.equals('x') }">
                <li class="top-logo-item">
                	<!-- 로그인 아이콘 -->
                    <a href="${root }/member/login">
                    	<i class="fas fa-sign-in-alt top-nav-icon"></i>
                    </a>
                </li>
                <li class="top-logo-item">
                	<!-- 회원가입 아이콘 -->
                    <a href="${root }/member/joinmain" >
                    	<i class="fas fa-user-plus top-nav-icon"></i>
                    </a>
                </li>
            </c:when>
        </c:choose>
        <li class="top-logo-item">
            <button id="topMenuToggle" class="top-menu-button">
                <i class="fa-solid fa-bars top-nav-icon"></i>
            </button>
        </li>
    </ul>
   
</nav>
	<!-- 사이드 메뉴 -->
	<div id="topSideMenu" class="top-side-menu">
	    <button class="top-close-btn" onclick="toggleTopMenu()"><i class="fas fa-times"></i></button>
	    <c:choose>
	    	<%-- <c:when test="${loginUser.login.equals('s')||loginUser.login.equals('b')}">
			    <div class="top-menu-items">
			        <a href="${root }/member/my_info">내 정보</a>
			        <a href="${root }/cart/my_cart">장바구니</a>
			        <a href="${root }/member/logout">로그아웃</a>
			    </div>
		    </c:when>  --%>
		    <%-- 판매자 전용  --%>
		    <c:when test="${loginUser.login=='seller'}">
		    	<div class="top-menu-items">
			        <h3>운영 모드</h3>
			        <a href="${root }/manager/manager_order"><i class="fas fa-clipboard-list"></i> 주문 내역 확인</a>
			        <a href="${root }/manager/manager_sales"><i class="fas fa-chart-line"></i> 매출 관리</a>
			        <a href="${root }/manager/manager_product"><i class="fas fa-box"></i> 상품 관리</a>
			        <a href="${root }/manager/manager_ask"><i class="fas fa-question-circle"></i> 문의 관리</a>
			        <a href="${root }/manager/manager_review"><i class="fas fa-star"></i> 리뷰 관리</a> <br> <br>
			        <h3></h3>
			        <a href="${root }/member/my_info"><i class="fas fa-user"></i> 내 정보</a>
			        <a href="${root }/cart/my_cart"><i class="fas fa-shopping-cart"></i> 장바구니</a>
			        <a href="${root }/payment/buyingList"><i class="fas fa-comments"></i> 내 구매 목록</a>
			        <a href="${root }/inquiry/inquiry_list?id=${loginUser.id}"><i class="fas fa-question"></i> 내 문의 사항</a>
			        <a href="${root }/chating/main"><i class="fas fa-comments"></i> 채팅</a>
			        <a href="${root }/member/logout"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
			    </div>
		    </c:when>
		    <c:when test="${loginUser.login=='sellerawaiter'}">
		    	<div class="top-menu-items">
			        <h3>운영 모드</h3>
			        <a href="${root }/manager/manager_order"><i class="fas fa-clipboard-list"></i> 주문 내역 확인</a>
			        <a href="${root }/manager/manager_sales"><i class="fas fa-chart-line"></i> 매출 관리</a>
			        <a href="${root }/manager/manager_product"><i class="fas fa-box"></i> 상품 관리</a>
			        <a href="${root }/manager/manager_ask"><i class="fas fa-question-circle"></i> 문의 관리</a>
			        <a href="${root }/manager/manager_review"><i class="fas fa-star"></i> 리뷰 관리</a> <br> <br>
			        <h3></h3>
			        <a href="${root }/member/my_info"><i class="fas fa-user"></i> 내 정보</a>
			        <a href="${root }/cart/my_cart"><i class="fas fa-shopping-cart"></i> 장바구니</a>
			        <a href="${root }/chating/main"><i class="fas fa-comments"></i> 채팅</a>
			        <a href="${root }/member/logout"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
			    </div>
		    </c:when>
		    <%-- 구매자 전용 --%>
		    <c:when test="${loginUser.login.equals('buyer')}">
		    	<div class="top-menu-items">
			        <h3>HOT한 HOT딜 상품!</h3>
			        <a href=""><i class="fas fa-running"></i> 스포츠/레저</a>
			        <a href=""><i class="fas fa-spa"></i> 뷰티</a>
			        <a href=""><i class="fas fa-gamepad"></i> 완구/취미</a>
			        <a href=""><i class="fas fa-utensils"></i> 식품</a>
			        <h3></h3>
			        <a href="${root }/member/my_info"><i class="fas fa-user"></i> 내 정보</a>
			        <a href="${root }/cart/my_cart"><i class="fas fa-shopping-cart"></i> 장바구니</a>
			        <a href="${root }/inquiry/inquiry_list?id=${loginUser.id}"><i class="fas fa-question"></i> 내 문의 사항</a>
			        <a href="${root }/payment/buyingList"><i class="fas fa-comments"></i> 내 구매 목록</a>
			        <a href="${root }/chating/main"><i class="fas fa-comments"></i> 채팅</a>
			        <a href="${root }/member/logout"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
			    </div>
		    </c:when>
		    <%-- 비 로그인 전용 --%>
		    <c:when test="${loginUser.login.equals('x') }">
		    	<div class="top-menu-items">
		    		<a href="${root }/member/login"><i class="fas fa-sign-in-alt"></i> 로그인</a>
		    	</div>
		    </c:when>
		</c:choose>
	</div>
	<style>
	.top-nav-menu {
		background-color: #e67e22;
		height: 73px;
	}
	.top-search-container {
		background-color: #e67e22;
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
		padding: 10px;
	}
	
	.top-search-box {
		display: flex;
		align-items: center;
		background-color: white;
		border: 2px solid #c2a87d;
		border-radius: 25px;
		padding: 5px 10px;
		overflow: hidden;
	}
	
	.top-search-box input {
		padding: 8px;
		border: none;
		outline: none;
		background: transparent;
		width: 200px;
		font-size: 14px;
		color: #5a4635;
	}
	
	.top-search-box input::placeholder {
		color: #8b7765;
	}
	
	.top-search-btn {
		background: none;
		border: none;
		cursor: pointer;
	}
	
	.top-search-btn i {
		font-size: 1.6rem;
		color: #000;
	}
	
	.top-logo-item {
		display: flex;
		align-items: center;
		justify-content: center;
		margin: 0 10px;
	}
	
	.top-logo-item a {
		text-decoration: none;
	}
	
	.top-nav-icon {
		font-size: 1.8rem;
		color: #000;
	}
	
	/* 사이드바 스타일 */
	.top-side-menu {
		position: fixed;
		top: 0;
		right: 0;
		width: 400px;
		height: 100%;
		background-color: white;
		transform: translateX(100%);
		transition: transform 0.3s ease;
		padding: 20px;
		z-index: 1001;
	}
	
	.top-side-menu.active {
		transform: translateX(0);
	}
	
	.top-close-btn {
		background: none;
		border: none;
		font-size: 24px;
		font-weight: bold;
		cursor: pointer;
		float: right;
		color: #000;
	}
	
	.top-menu-items {
		margin-top: 20px;
	}
	
	.top-menu-items a {
		display: block;
		padding: 10px;
		text-decoration: none;
		color: #5a4635;
		font-size: 16px;
	}
	
	.top-menu-items a i {
		margin-right: 10px;
		font-size: 1.2rem;
		color: #000;
	}
	
	.top-menu-items a:hover {
		background-color: #c2a87d;
		color: white;
	}
	
	.top-menu-items a:hover i {
		color: white;
	}
	
	.top-menu-button {
		background: none;
		border: none;
		cursor: pointer;
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