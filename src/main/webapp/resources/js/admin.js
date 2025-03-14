	document.addEventListener("DOMContentLoaded", function () {
    // 배경 이미지 서서히 나타나는 효과
    document.querySelector(".background_image").style.opacity = "1";

    // 사이드 메뉴 토글 기능
    document.getElementById("menuToggle").addEventListener("click", function () {
        document.getElementById("sideMenu").classList.add("active");
    });

    document.querySelector(".close-btn").addEventListener("click", function () {
        document.getElementById("sideMenu").classList.remove("active");
    });
});
	document.addEventListener("DOMContentLoaded", function () {
    // 첫 번째 배경 이미지 페이드인
    document.querySelector(".background_image").style.opacity = "1";

    // 사이드 메뉴 토글
    document.getElementById("menuToggle").addEventListener("click", function () {
        document.getElementById("sideMenu").classList.add("active");
    });
    document.querySelector(".close-btn").addEventListener("click", function () {
        document.getElementById("sideMenu").classList.remove("active");
    });

    // 스크롤 시 두 번째 배경 이미지 및 텍스트 애니메이션
    window.addEventListener("scroll", function () {
        let bgImage2 = document.querySelector(".background_image2");
        let textContainer = document.querySelector(".focus-in-contract-bck");
        let rect = bgImage2.getBoundingClientRect();

        // 화면의 70% 정도에 도달하면 애니메이션 실행
        if (rect.top < window.innerHeight * 0.7) {
            bgImage2.classList.add("active");
            textContainer.classList.add("active");
        }
    });
});

	document.addEventListener("DOMContentLoaded", function () {
    window.addEventListener("scroll", function () {
        let bgImage2 = document.querySelector(".background_image2");
        let smallBox1 = document.querySelector(".small-box1");
        let smallBox2 = document.querySelector(".small-box2");
        let smallBox3 = document.querySelector(".small-box3");
        let slideBox = document.querySelector(".slide-in-box");

        let rect = bgImage2.getBoundingClientRect();

        if (rect.top < window.innerHeight * 0.8) {
            bgImage2.classList.add("active"); // 배경 등장
            smallBox1.classList.add("active"); // 첫 번째 작은 박스 등장
            smallBox2.classList.add("active"); // 두 번째 작은 박스 등장
            smallBox3.classList.add("active"); // 세 번째 작은 박스 등장
            slideBox.classList.add("active"); // 큰 박스 슬라이드 애니메이션
        }
    });
});
