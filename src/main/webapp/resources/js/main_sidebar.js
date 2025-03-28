document.addEventListener('DOMContentLoaded', function() {
    // 사이드바 버튼들 선택
    const sidebarBtns = document.querySelectorAll('.sidebar-btn:not(.scroll-top-btn)');
    const scrollTopBtn = document.querySelector('.scroll-top-btn');

    // 각 카테고리 버튼에 대한 스크롤 기능 추가
    sidebarBtns.forEach(btn => {
        // 타겟 섹션 ID 가져오기
        const targetId = btn.getAttribute('data-target');
        const targetSection = document.getElementById(targetId);

        // 버튼 클릭 시 해당 섹션으로 부드럽게 스크롤
        btn.addEventListener('click', function() {
            if (targetSection) {
                targetSection.scrollIntoView({ 
                    behavior: 'smooth',
                    block: 'start' 
                });
            }
        });
    });

    // 스크롤 top 버튼 클릭 시 페이지 최상단으로 부드럽게 이동
    scrollTopBtn.addEventListener('click', function() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });

    // 각 버튼에 호버 시 텍스트 위치 조정
    sidebarBtns.forEach(btn => {
        const textEl = btn.querySelector('.sidebar-btn-text');
        
        btn.addEventListener('mouseenter', function() {
            const btnRect = btn.getBoundingClientRect();
            textEl.style.top = `${btnRect.top + btnRect.height / 2 - textEl.offsetHeight / 2}px`;
            textEl.style.right = `${window.innerWidth - btnRect.left + 10}px`;
        });
    });
});