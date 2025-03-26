document.addEventListener("DOMContentLoaded", function() {
    // ===== 메인 배너 슬라이더 초기화 =====
    var mainSwiper = new Swiper(".mySwiper", {
        spaceBetween: 30,               // 슬라이드 간 간격
        centeredSlides: true,           // 슬라이드 중앙 정렬
        loop: true,                     // 무한 루프 활성화
        slidesPerView: 1,               // 한 번에 하나의 슬라이드 표시
        autoplay: {
            delay: 3500,                // 3.5초마다 자동 전환
            disableOnInteraction: false, // 사용자가 상호작용 후에도 자동 재생 유지
        },
        pagination: {
            el: ".swiper-pagination",   // 페이지네이션(점) 요소
            clickable: true,            // 클릭 가능한 페이지네이션
        },
        navigation: {
            nextEl: ".swiper-button-next", // 다음 버튼 요소
            prevEl: ".swiper-button-prev", // 이전 버튼 요소
        },
    });

    // ===== 슬라이더에 마우스 오버 시 일시정지 =====
    document.querySelector('.mySwiper').addEventListener('mouseenter', function() {
        mainSwiper.autoplay.stop();     // 마우스가 올라가면 자동 재생 중지
    });

    // ===== 슬라이더에서 마우스 떠날 시 재생 =====
    document.querySelector('.mySwiper').addEventListener('mouseleave', function() {
        mainSwiper.autoplay.start();    // 마우스가 떠나면 자동 재생 시작
    });

    // ===== 상품 슬라이더 초기화 =====
    var itemSwiper = new Swiper(".myItemSwiper", {
        slidesPerView: 5,               // 한 화면에 5개의 슬라이드 표시
        spaceBetween: 20,               // 슬라이드 간 간격
        loop: true,                     // 무한 루프 활성화
        autoplay: {
            delay: 4000,                // 4초마다 자동 전환
            disableOnInteraction: false, // 사용자가 상호작용 후에도 자동 재생 유지
        },
        pagination: {
            el: ".swiper-pagination",   // 페이지네이션(점) 요소
            clickable: true,            // 클릭 가능한 페이지네이션
        },
        // ===== 반응형 설정 =====
        breakpoints: {
            320: {
                slidesPerView: 1,       // 320px 이상에서는 1개 표시
                spaceBetween: 10
            },
            480: {
                slidesPerView: 2,       // 480px 이상에서는 2개 표시
                spaceBetween: 10
            },
            768: {
                slidesPerView: 3,       // 768px 이상에서는 3개 표시
                spaceBetween: 15
            },
            992: {
                slidesPerView: 4,       // 992px 이상에서는 4개 표시
                spaceBetween: 20
            },
            1200: {
                slidesPerView: 5,       // 1200px 이상에서는 5개 표시
                spaceBetween: 20
            }
        }
    });

    // ===== 스크롤 애니메이션 및 텍스트 효과 =====
    const animatedText = document.querySelector(".animated-text");
    const backgroundImage = document.querySelector(".background-image");

    // IntersectionObserver 설정 - 요소가 화면에 나타날 때 감지
    const observer = new IntersectionObserver(
        (entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {  // 요소가 화면에 보이는 경우
                    entry.target.classList.add("show");  // show 클래스 추가하여 애니메이션 활성화
                    
                    // 한 번만 실행되도록 해제
                    if (entry.target === backgroundImage) {
                        // 배경 이미지가 표시된 후 텍스트 애니메이션 지연 실행
                        setTimeout(() => {
                            animatedText.classList.add("show");
                        }, 300);  // 300ms 후 텍스트 애니메이션 시작
                    }
                    
                    observer.unobserve(entry.target);  // 한 번 감지 후 더 이상 감시하지 않음
                }
            });
        },
        { threshold: 0.3 }  // 요소가 30% 이상 보일 때 감지
    );

    // 배경 이미지 요소 관찰 시작
    observer.observe(backgroundImage);

    // ===== 상품 이미지에 호버 효과 =====
    document.querySelectorAll('.slide-content').forEach(item => {
        // 마우스 진입 시 이미지 확대
        item.addEventListener('mouseenter', function() {
            this.querySelector('img').style.transform = 'scale(1.05)';
        });

        // 마우스 이탈 시 이미지 원래 크기로
        item.addEventListener('mouseleave', function() {
            this.querySelector('img').style.transform = 'scale(1)';
        });
    });
});
