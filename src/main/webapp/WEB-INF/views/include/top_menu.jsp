<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>search</title>
<link rel="stylesheet" href="${root }/css/top.css" />
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
