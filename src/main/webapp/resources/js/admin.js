document.addEventListener("DOMContentLoaded", function () {
    // 배경 이미지 페이드인
    setTimeout(function() {
        document.querySelector(".background_image").classList.add("active");
    }, 300);
    
    // 사이드 메뉴 토글
    document.getElementById("menuToggle").addEventListener("click", function () {
        document.getElementById("sideMenu").classList.add("active");
    });
    
    document.querySelector(".close-btn").addEventListener("click", function () {
        document.getElementById("sideMenu").classList.remove("active");
    });
    
    // 스크롤 애니메이션
    function checkScroll() {
        let bgImage2 = document.querySelector(".background_image2");
        let textContainer = document.querySelector(".focus-in-contract-bck");
        let smallBox1 = document.querySelector(".small-box1");
        let smallBox2 = document.querySelector(".small-box2");
        let smallBox3 = document.querySelector(".small-box3");
        let slideBox = document.querySelector(".slide-in-box");
        
        let viewportHeight = window.innerHeight;
        let scrollTop = window.scrollY;
        let elementTop = bgImage2.getBoundingClientRect().top + scrollTop;
        let elementVisible = 150;
        
        if (scrollTop > elementTop - viewportHeight + elementVisible) {
            bgImage2.classList.add("active");
            textContainer.classList.add("active");
            smallBox1.classList.add("active");
            smallBox2.classList.add("active");
            smallBox3.classList.add("active");
            slideBox.classList.add("active");
        }
    }
    
    // 초기 로드 시 한 번 확인
    checkScroll();
    
    // 스크롤 이벤트
    window.addEventListener("scroll", checkScroll);
});

// 메뉴 토글 함수 - HTML에서 직접 호출용
function toggleMenu() {
    document.getElementById("sideMenu").classList.toggle("active");
}
