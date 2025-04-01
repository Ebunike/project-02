document.addEventListener('DOMContentLoaded', function() {
    // 사이드바 버튼들 선택
    const quickBtns = document.querySelectorAll('.quick-btn:not(.scroll-top)');
    const scrollTopBtn = document.querySelector('.scroll-top');
    
    // 각 카테고리 버튼에 대한 스크롤 기능 추가
    quickBtns.forEach(btn => {
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
    if (scrollTopBtn) {
        scrollTopBtn.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }
    
    // 디버깅용 로그
    console.log('Quick nav script loaded!');
});