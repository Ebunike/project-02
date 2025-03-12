<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>search</title>
<style>
    .test-nav {
        background-color: #f5f5dc; 
        position: relative; /* 검색창을 네비게이션 내부에서 정렬할 수 있도록 함 */
        z-index: 1000;
    }
    .search-container {
        position: absolute;  /* 네비게이션 바 내부에서 절대 위치 */
        top: 50%;  /* 세로 중앙 정렬 */
        left: 50%; /* 가로 중앙 정렬 */
        height: 50px;
        transform: translate(-50%, -50%); /* 완벽한 중앙 정렬 */
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #f5f5dc;
        border-radius: 15px;
        /* box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1); */
        padding: 10px;
    }
    .search-box {
        display: flex;
        align-items: center;
        background-color: #fffaf0;
        border: 2px solid #c2a87d;
        border-radius: 25px;
        padding: 5px 10px;
        /* box-shadow: 0 3px 6px rgba(0, 0, 0, 0.15); */
        overflow: hidden;
    }
    .search-box input {
        padding: 8px;
        border: none;
        outline: none;
        background: transparent;
        width: 200px;
        font-size: 14px;
        color: #5a4635;
    }
    .search-box input::placeholder {
        color: #8b7765;
    }
    .search-box button {
        padding: 8px 12px;
        background-color: #b38b6d;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
        border-radius: 15px;
        font-weight: bold;
    }
    .search-box button:hover {
        background-color: #9c7554;
    }
    .logo-item {
	    width: 50px; /* 크기 조정 */
	    height: 45px;
	    display: flex; /* flex 사용 */
	    align-items: center;
	    justify-content: center;
	    margin: 0 10px;
	}

	.logo-item img {
	    width: 100%; /* 부모 요소 크기와 맞춤 */
	    height: auto;
	    object-fit: contain; /* 이미지 비율 유지 */
	}
	.logo-item img[src*="alarm_logo.png"] {
	    max-width: 35px; /* 필요시 크기 조정 */
	    max-height: 35px;
	}
	.logo-item img[src*="join_logo.png"] {
	    width: 55px; /* 필요시 크기 조정 */
	    height: 60px;
	}
	.test-nav {
        background-color: #f5f5dc;
        position: relative;
        z-index: 1000;
    }
    .search-container {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #f5f5dc;
        border-radius: 15px;
        /* box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1); */
        padding: 10px;
    }
    
    /* 사이드바 스타일 */
    #sideMenu {
        position: fixed;
        top: 0;
        right: 0;
        width: 400px;
        height: 100%;
        background-color: #fffaf0;
        /* box-shadow: -3px 0 6px rgba(0, 0, 0, 0.2); */
        transform: translateX(100%);
        transition: transform 0.3s ease;
        padding: 20px;
        z-index: 1001;
    }
    #sideMenu.active {
        transform: translateX(0);
    }
    .close-btn {
        background: none;
        border: none;
        font-size: 20px;
        font-weight: bold;
        cursor: pointer;
        float: right;
    }
    .menu-items {
        margin-top: 20px;
    }
    .menu-items a {
        display: block;
        padding: 10px;
        text-decoration: none;
        color: #5a4635;
        font-size: 16px;
    }
    .menu-items a:hover {
        background-color: #c2a87d;
        color: white;
    }
</style>
</head>
<body>
<nav class="navbar navbar-expand-md fixed-top shadow-lg test-nav">
    <a class="logo-item" href="${root }/">
    	<img src="${root }/logo/home_logo.png">
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
    <div class="search-container">
        <form class="search-box" action="${root}/search/result" method="GET">
            <input type="text" id="search-input" name="query" placeholder="검색어를 입력하세요...">
            <div class="logo-item">
	            <button type="submit">
	            	<img src="${root }/logo/search_logo.png">
	            </button>
            </div>
        </form>
    </div>
    
    <ul class="navbar-nav ml-auto">
        <c:choose>
            <c:when test="${loginUser.login.equals('s')||loginUser.login.equals('b')}">
                <li class="logo-item">
                	<%--내 정보 아이콘 --%>
                    <a href="${root }/member/my_info">
                    	<img src="${root }/logo/info_logo.png">
                    </a>
                </li>
                <li class="logo-item">
                	<%-- 알람 아이콘 --%>
                	<a href="">
                    	<img src="${root }/logo/alarm_logo.png">
                	</a>
                </li>
                <li class="logo-item">
                	<%-- 장바구니 아이콘 --%>
                    <a href="${root }/cart/my_cart" >
                    	<img src="${root }/logo/cart_logo.png">
                    </a>
                </li>
                <li class="logo-item">
                	<!-- 로그아웃 아이콘 -->
                    <a href="${root }/member/logout" >
                    	<img src="${root }/logo/logout_logo.png"> <br>
                    </a>
                </li>
            </c:when>
               <c:when test="${loginUser.login.equals('x') }">
                <li class="logo-item">
                	<!-- 로그인 아이콘 -->
                    <a href="${root }/member/login">
                    	<img src="${root }/logo/login_logo.png"> <br>
                    </a>
                </li>
                <li class="logo-item">
                	<!-- 회원가입 아이콘 -->
                    <a href="${root }/member/join" >
                    	<img src="${root }/logo/join_logo.png">
                    </a>
                </li>
            </c:when>
        </c:choose>
        <li class="logo-item">
            <button id="menuToggle" class="menu-button">
                <img src="${root }/logo/catalog_logo.png">
            </button>
        </li>
    </ul>
   
</nav>
	<!-- 사이드 메뉴 -->
	<div id="sideMenu">
	    <button class="close-btn" onclick="toggleMenu()">&times;</button>
	    <c:choose>
	    	<%-- <c:when test="${loginUser.login.equals('s')||loginUser.login.equals('b')}">
			    <div class="menu-items">
			        <a href="${root }/member/my_info">내 정보</a>
			        <a href="${root }/cart/my_cart">장바구니</a>
			        <a href="${root }/member/logout">로그아웃</a>
			    </div>
		    </c:when>  --%>
		    <%-- 판매자 전용  --%>
		    <c:when test="${loginUser.login.equals('s')}">
		    	<div class="menu-items">
			        <h3>운영 모드</h3>
			        <a href="">주문 내역 확인</a>
			        <a href="">매출 관리</a>
			        <a href="">메뉴 관리</a>
			        <a href="">가게 설정</a>
			        <a></a>
			        <a href="${root }/member/my_info">내 정보</a>
			        <a href="${root }/cart/my_cart">장바구니</a>
			        <a href="${root }/chating/main">채팅</a>
			        <a href="${root }/member/logout">로그아웃</a>
			    </div>
		    </c:when>
		    <%-- 구매자 전용 --%>
		    <c:when test="${loginUser.login.equals('b')}">
		    	<div class="menu-items">
			        <h3>HOT한 HOT딜 상품!</h3>
			        <a href="">스포츠/레저</a>
			        <a href="">뷰티</a>
			        <a href="">완구/취미</a>
			        <a href="">식품</a>
			        <a></a>
			        <a href="${root }/member/my_info">내 정보</a>
			        <a href="${root }/cart/my_cart">장바구니</a>
			        <a href="${root }/chating/main">채팅</a>
			        <a href="${root }/member/logout">로그아웃</a>
			    </div>
		    </c:when>
		    <%-- 비 로그인 전용 --%>
		    <c:when test="${loginUser.login.equals('x') }">
		    	<div class="menu-items">
		    		<a href="${root }/member/login">로그인</a>
		    	</div>
		    </c:when>
		</c:choose>
	</div>
	
	<script>
	    function toggleMenu() {
	        document.getElementById("sideMenu").classList.toggle("active");
	    }
	    document.getElementById("menuToggle").addEventListener("click", toggleMenu);
	</script>
</body>
</html>
