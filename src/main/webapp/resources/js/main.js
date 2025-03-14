//배너 script 

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
	
//상품배너 슬라이드

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
	
//하단 부분 스크롤 애니메이션 및 텍스트

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

	