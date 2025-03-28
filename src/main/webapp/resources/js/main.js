document.addEventListener("DOMContentLoaded", function() {
    // ===== 메인 배너 슬라이더 초기화 =====
    var mainSwiper = new Swiper(".mySwiper", {
        spaceBetween: 30,
        centeredSlides: true,
        loop: true,
        slidesPerView: 1,
        autoplay: {
            delay: 3500,
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

    // ===== 슬라이더에 마우스 오버 시 일시정지 =====
    document.querySelector('.mySwiper').addEventListener('mouseenter', function() {
        mainSwiper.autoplay.stop();
    });

    // ===== 슬라이더에서 마우스 떠날 시 재생 =====
    document.querySelector('.mySwiper').addEventListener('mouseleave', function() {
        mainSwiper.autoplay.start();
    });

    // ===== 상품 슬라이더 1 초기화 =====
    var itemSwiper1 = new Swiper(".myItemSwiper", {
        slidesPerView: 5,
        spaceBetween: 20,
        loop: true,
        autoplay: {
            delay: 4000,
            disableOnInteraction: false,
        },
        pagination: {
            el: ".swiper-pagination",
            clickable: true,
        },
        breakpoints: {
            320: { slidesPerView: 1, spaceBetween: 10 },
            480: { slidesPerView: 2, spaceBetween: 10 },
            768: { slidesPerView: 3, spaceBetween: 15 },
            992: { slidesPerView: 4, spaceBetween: 20 },
            1200: { slidesPerView: 5, spaceBetween: 20 }
        }
    });

    // ===== 상품 슬라이더 2 초기화 =====
    var itemSwiper2 = new Swiper(".myItemSwiper2", {
        slidesPerView: 5,
        spaceBetween: 20,
        loop: true,
        autoplay: {
            delay: 4500,
            disableOnInteraction: false,
        },
        pagination: {
            el: ".swiper-pagination",
            clickable: true,
        },
        breakpoints: {
            320: { slidesPerView: 1, spaceBetween: 10 },
            480: { slidesPerView: 2, spaceBetween: 10 },
            768: { slidesPerView: 3, spaceBetween: 15 },
            992: { slidesPerView: 4, spaceBetween: 20 },
            1200: { slidesPerView: 5, spaceBetween: 20 }
        }
    });

    // ===== 상품 슬라이더 3 초기화 =====
    var itemSwiper3 = new Swiper(".myItemSwiper3", {
        slidesPerView: 5,
        spaceBetween: 20,
        loop: true,
        autoplay: {
            delay: 5000,
            disableOnInteraction: false,
        },
        pagination: {
            el: ".swiper-pagination",
            clickable: true,
        },
        breakpoints: {
            320: { slidesPerView: 1, spaceBetween: 10 },
            480: { slidesPerView: 2, spaceBetween: 10 },
            768: { slidesPerView: 3, spaceBetween: 15 },
            992: { slidesPerView: 4, spaceBetween: 20 },
            1200: { slidesPerView: 5, spaceBetween: 20 }
        }
    });

    // ===== 상품 슬라이더 4 초기화 =====
    var itemSwiper4 = new Swiper(".myItemSwiper4", {
        slidesPerView: 5,
        spaceBetween: 20,
        loop: true,
        autoplay: {
            delay: 5500,
            disableOnInteraction: false,
        },
        pagination: {
            el: ".swiper-pagination",
            clickable: true,
        },
        breakpoints: {
            320: { slidesPerView: 1, spaceBetween: 10 },
            480: { slidesPerView: 2, spaceBetween: 10 },
            768: { slidesPerView: 3, spaceBetween: 15 },
            992: { slidesPerView: 4, spaceBetween: 20 },
            1200: { slidesPerView: 5, spaceBetween: 20 }
        }
    });

    // ===== 상품 슬라이더 5 초기화 =====
    var itemSwiper5 = new Swiper(".myItemSwiper5", {
        slidesPerView: 5,
        spaceBetween: 20,
        loop: true,
        autoplay: {
            delay: 6000,
            disableOnInteraction: false,
        },
        pagination: {
            el: ".swiper-pagination",
            clickable: true,
        },
        breakpoints: {
            320: { slidesPerView: 1, spaceBetween: 10 },
            480: { slidesPerView: 2, spaceBetween: 10 },
            768: { slidesPerView: 3, spaceBetween: 15 },
            992: { slidesPerView: 4, spaceBetween: 20 },
            1200: { slidesPerView: 5, spaceBetween: 20 }
        }
    });

    // ===== 스크롤 애니메이션 및 텍스트 효과 =====
    const animatedText = document.querySelector(".animated-text");
    const backgroundImage = document.querySelector(".background-image");

    // IntersectionObserver 설정 - 요소가 화면에 나타날 때 감지
    const observer = new IntersectionObserver(
        (entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add("show");
                    
                    if (entry.target === backgroundImage) {
                        setTimeout(() => {
                            animatedText.classList.add("show");
                        }, 300);
                    }
                    
                    observer.unobserve(entry.target);
                }
            });
        },
        { threshold: 0.3 }
    );

    // 배경 이미지 요소 관찰 시작
    observer.observe(backgroundImage);

    // ===== 상품 이미지에 호버 효과 =====
    document.querySelectorAll('.slide-content').forEach(item => {
        item.addEventListener('mouseenter', function() {
            this.querySelector('img').style.transform = 'scale(1.05)';
        });

        item.addEventListener('mouseleave', function() {
            this.querySelector('img').style.transform = 'scale(1)';
        });
    });
});
