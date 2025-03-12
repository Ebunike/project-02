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

  <!-- Demo styles -->
  <style>
    html,
    
    body {
      position: relative;
      height: 100%;
    }
    body {
      background: #fffaf0;
      font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
      font-size: 14px;
      color: #000;
      margin: 0;
      padding: 0;
    }
    .top{
    	position: sticky;
  		top: 0px; /* 도달했을때 고정시킬 위치 */
  		z-index: 9999;
    }
    .swiper {
      width: 1000px;
      height: 400px;
    }
    .swiper-slide {
      text-align: center;
      font-size: 18px;
      background: #fff;
      display: flex;
      justify-content: center;
      align-items: center;
    }
	mySwiper .swiper-slide-thumb-active {
      opacity: 3;
      /* 스와이프 속도  */
    }
    .swiper-slide img {
      display: block;
      width: 1000px;
      height: 400px;
      object-fit: cover;
    }
     .swiper2 { /* 상품 배너 크기 조정 */
	  width: 1400px; 
	  height: 325px;
	}
    .item-slide { /* 상품 배너 슬라이드  */
	  text-align: center;
	  font-size: 18px;
	  background: #fff;
	  display: flex;
	  justify-content: center;
	  align-items: center;
    }
    .swiper2 .swiper-slide {
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	    justify-content: flex-start;
	    height: 330px;
	    background-color: #fffaf0; /* 사이트 배경색과 동일하게 설정 */
	}
	.slide-content {
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	    width: 100%;
	    background-color: #fffaf0; /* 이미지 주변 여백을 사이트 배경색과 맞춤 */
	    padding-bottom: 3px; /* 하단 여백 추가 */
	}
    .swiper2 .swiper-slide img { /* 상품 배너 이미지 */
	  display: block;
	  width: 100%;
	  height: 250px;
	  object-fit: cover;
	}
	.slide-info a:link{ /* 상품 배너 하단에 설명란 링크 기본 색깔  */
		color: black;
	}
	.slide-info a:hover{ /* 상품 배너 하단에 설명란 링크 마우스 올렸을 떄 색깔 */
		color: blue;
	}
    .category-menu {
        background-color: #fff;
        padding: 10px 0;
        text-align: center;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        /* margin-top: 60px; /* top_menu 아래로 내림 */
        /* margin-bottom: 10px;  */
        position: relative;
        z-index: 10; /* top_menu보다 위에 위치 */
    }
    .category-menu ul {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        justify-content: center;
        gap: 20px;
    }
    .category-menu li {
        display: inline;
    }
    .category-menu a {
        text-decoration: none;
        color: #333;
        font-size: 16px;
        font-weight: bold;
        padding: 10px 15px;
        transition: 0.3s;
    }
    .category-menu a:hover {
        color: #007bff;
        border-bottom: 2px solid #007bff;
    }
    .item_title {
	    display: flex;
	    justify-content: center; /* 가운데 정렬 */
	    align-items: center;
	    background-color: #fffaf0; /* 배경색 */
	    border: 2px solid #c2a87d; /* 테두리 */
	    border-radius: 15px; /* 둥근 모서리 */
	    padding: 10px 20px; /* 내부 여백 */
	    margin: 30px auto; /* 위아래 여백 + 가운데 정렬 */
	    max-width: 500px; /* 박스 최대 너비 설정 */
	    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 박스 그림자 */
	}
    /* 상품 슬라이더 제목 내 글자 스타일 */
	.item_title h3,
	.item_title h5 {
	    margin: 0 5px; /* 글자 간격 조정 */
	    display: inline-block;
	}
   .scroll-section {
	    position: relative;
	    width: 1400px;
	    height: 350px;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    overflow: hidden;
	}

	/* 배경 이미지 */
	.background-image {
	    position: absolute;
	    width: 100%;
	    height: 100%;
	    background: url('${root}/pic/test1.jpg') no-repeat center center/cover;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    background-size: 1200px 400px; /* 기존 크기 */
	    background-position: center;
	    opacity: 0;
	    transform: translateY(50px);
	    transition: opacity 1s ease-out, transform 1s ease-out;
	}
	/* 텍스트 애니메이션 */
	.animated-text {
	    position: absolute; /* 요소를 부모 요소의 상대 위치에 절대적으로 배치 */
	    text-align: center; /* 텍스트를 가로로 가운데 정렬 */
	    color: black; 		/* 텍스트 색상을 검은색으로 설정 */
	    font-size: 24px; 	/* 글자의 크기를 24px로 설정 */
	    font-weight: bold;  /* 글자의 두께를 굵게 설정 */
	    opacity: 0; 		/* 처음에는 텍스트가 보이지 않도록 설정 (투명) */
	    transform: translateY(50px); /* 텍스트를 50px 아래로 이동 (시작 위치) */
	    transition: opacity 1s ease-out, transform 1s ease-out; /* opacity와 transform 속성의 변화를 1초 동안 부드럽게 처리 */
}
	.animated-text.show {
	    opacity: 1;
	    transform: translateY(0);
	}
	.background-image.show {
	    opacity: 1;
	    transform: translateY(0);
	}
  </style>
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
        <li><a href="report/report_list">고객 문의</a></li>
        <li><a href="#">장재훈</a></li>
    </ul>
</div>
<!-- 배너 슬라이더 -->
  <div class="swiper mySwiper">
    <div class="swiper-wrapper">
      <div class="swiper-slide">
      	<a href="">
      		<img src="${root}/pic/camp1.jpg">
      	</a>
      </div>
      <div class="swiper-slide">
      	<a href="">
      		<img src="${root}/pic/camp2.jpg">
      	</a>
      </div>
      <div class="swiper-slide">
      	<a href="">
      		<img src="${root}/pic/camp3.jpg">
      	</a>
      </div>
      <div class="swiper-slide">
      	<a href="">
      		<img src="${root}/pic/camping.png">
      	</a>
      </div>
     <!--  <div class="swiper-slide">Slide 5</div>
      <div class="swiper-slide">Slide 6</div>
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

  <!-- 배너 script -->
  <script>
  	var swiper = new Swiper(".mySwiper", {
	    spaceBetween: 30,
	    centeredSlides: true,
	    loop: true,
	    autoplay: {
	        delay: 2500,
	        disableOnInteraction: false,
	    },
	    pagination: {
	        el: ".swiper-pagination",
	        clickable: true,
	    },
	    navigation: {
	        nextEl: ".swiper-button-next",
	        prevEl: ".swiper-button-prev",
	    },
	});
  </script>
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

  <!-- 상품배너 슬라이드 -->
  <script>
  var swiper2 = new Swiper(".myItemSwiper", {
	    slidesPerView: 5,  // 한 번에 4개씩 표시
	    spaceBetween: 10,  // 슬라이드 간 간격 조정
	    loop: true, // 무한 루프 기능 활성화
	    
	    autoplay: {
	        delay: 5000, // 5초(5000ms)마다 자동 이동
	        disableOnInteraction: false, // 사용자 조작 후에도 자동 슬라이드 유지
	    },
	    pagination: {
	        el: ".swiper-pagination",
	        clickable: true,
	    },
	});
  </script>
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
	
	<script>
	document.addEventListener("DOMContentLoaded", function () {
	    const animatedText = document.querySelector(".animated-text");
	    const backgroundImage = document.querySelector(".background-image");

	    const observer = new IntersectionObserver(
	        (entries, observer) => {
	            entries.forEach(entry => {
	                if (entry.isIntersecting) {
	                    entry.target.classList.add("show");
	                    observer.unobserve(entry.target); // 한 번 보이면 다시 감시하지 않음
	                }
	            });
	        },
	        { threshold: 0.5 } // 요소가 50% 보일 때 실행
	    );

	    observer.observe(animatedText);
	    observer.observe(backgroundImage);
	});

	</script>
	<!-- 게시판 하단 부분 -->	
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>