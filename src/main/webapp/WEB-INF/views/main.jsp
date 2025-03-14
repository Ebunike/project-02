<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://kit.fontawesome.com/516da99189.js" crossorigin="anonymous"></script>
	<title>main</title>
	<!-- Bootstrap CDN -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
  	
  	<!-- Link Swiper's CSS -->
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

	<!-- main.css(외부 css) -->
    <link rel="stylesheet" href="${root}/css/main.css" />
 
</head>
<body>
	<!-- 상단 메뉴 부분 -->
	<div class="top">
		<c:import url="/WEB-INF/views/include/top_menu.jsp"  /> 
	</div>
	
<!-- 게시판 미리보기 부분 -->
<div class="category-menu">
    <ul>
        <li><a href="recipe/recipe_kit_main?theme_index=1">레시피</a></li>
        <li><a href="item/onedayclass/onedayMain">원데이클라스</a></li>
        <li><a href="item/kit/kitMain">키트 메인</a></li>
        <li><a href="report/report_list">자유게시판</a></li>
        <li><a href="#">장재훈</a></li>
    </ul>
</div>
<!-- 배너 슬라이더 -->
  <div class="swiper mySwiper">
    <div class="swiper-wrapper">
      <div class="swiper-slide">
      	<a href="">
      		<img src="${root}/pic/back.jpg">
      	</a>
      </div>
      <div class="swiper-slide">
      	<a href="">
      		<img src="${root}/pic/back2.jpg">
      	</a>
      </div>
      <div class="swiper-slide">
      	<a href="">
      		<img src="${root}/pic/back3.png">
      	</a>
      </div>
      <div class="swiper-slide">
      	<a href="">
      		<img src="${root}/pic/back4.jpg">
      	</a>
      </div>
      <div class="swiper-slide">
      	<a href="">
      		<img src="${root}/pic/back5.jpg">
      	</a>
      </div>
     <!-- <div class="swiper-slide">Slide 6</div>
      <div class="swiper-slide">Slide 7</div>
      <div class="swiper-slide">Slide 8</div>
      <div class="swiper-slide">Slide 9</div> -->
      <!-- 배너 갯수 -->
    </div>
    <div class="swiper-button-next"></div> <!-- 배너 앞으로 이동 버튼 -->
    <div class="swiper-button-prev"></div> <!-- 배너 뒤로 이동 버튼 -->
    <div class="swiper-pagination"></div>
  </div>

  <!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

  	<!-- 상품 슬라이더 제목  -->
	 	<div class="item_title">
	 		<h3>오늘의 발견 | </h3> <h5 style="color:red;">승호가 추천하는 상품!</h5>
	 	</div>
  	<!-- 상품 슬라이더 -->
	<div class="swiper swiper2 myItemSwiper">
    <div class="swiper-wrapper">
        <div class="swiper-slide">
            <div class="slide-content">
                <a href="">
                <img src="${root}/pic/item1.jpg">
                </a>
                <div class="slide-info">
                	<a href=""> <h5>[쇠고기 샤브샤브]</h5>
                    <h6>푸드 어셈블 밀키트 35,000원</h6>
                    </a>
                </div>
            </div>
        </div>
        <div class="swiper-slide">
            <div class="slide-content">
                <a href="">
                <img src="${root}/pic/item2.jpg">
                </a>
                <div class="slide-info">
                   <a href=""> <h5>[추천상품]</h5>
                    <h6> 밀키트 15,000원</h6>
                    </a>
                </div>
            </div>
        </div>
        <div class="swiper-slide">
            <div class="slide-content">
                <a href="">
                <img src="${root}/pic/item3.jpg">
                </a>
                <div class="slide-info">
                   <a href=""> <h5>[임도엽 푸드]</h5>
                    <h6>사장도 모르는 밀키트 17,000원</h6>
                    </a>
                </div>
            </div>
        </div>
        <div class="swiper-slide">
            <div class="slide-content">
                <a href="">
                <img src="${root}/pic/item4.jpg">
                </a>
                <div class="slide-info">
                    <a href=""> <h5>[청년 푸드]</h5>
                    <h6>전복이 아주 실한 완도 코시롱 전복죽, 190g, 6개 65,170원</h6>
                    </a>
                </div>
            </div>
        </div>
        <div class="swiper-slide">
            <div class="slide-content">
                <a href="">
                <img src="${root}/pic/item5.png">
                </a>
                <div class="slide-info">
                    <a href=""> <h5>[풀무원]</h5>
                    <h6>통 가래떡볶이 키트 12,000원</h6>
                    </a>
                </div>
            </div>
        </div>
        <div class="swiper-slide">
            <div class="slide-content">
            	<a href="">
                <img src="${root}/pic/item6.jpg">
                </a>
                <div class="slide-info">
                    <a href=""> <h5>[핫딜! 마감임박!]</h5>
                    <h6>각종 밀키트 최저가 기본 11,900원 부터!</h6>
                    </a>
                </div>
            </div>
        </div>
        <div class="swiper-slide">
            <div class="slide-content">
            	<a href="">
                <img src="${root}/pic/item3.jpg">
                </a>
                <div class="slide-info">
                    <a href=""> <h5>[핫딜! 마감임박!]</h5>
                    <h6>각종 밀키트 최저가 기본 11,900원 부터!</h6>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="swiper-pagination"></div>
</div>
  <!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

  		<div class="item_title">
	 		<h3>오늘의 발견 | </h3> <h5 style="color:red;">승호가 추천하는 상품!</h5>
	 	</div>
  <!-- 스크롤 애니메이션 -->
	<div class="scroll-section">
	    <div class="background-image">
	        <div class="animated-text">
	            <h2>아이와 함께 만드는</h2>
	            <p>즐거운 시간!</p>
	        </div>
	    </div>
	</div>

	<!-- 게시판 하단 부분 -->	
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
	<script src="${root}/js/main.js"></script>
</body>
</html>