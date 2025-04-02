<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Footer Section -->
<footer class="footer-section">
    <div class="container">
        <div class="footer-content pt-5 pb-5">
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="footer-info">
                        <h3>Makeable</h3>
                        <p class="footer-slogan">내가 만드는 취미,</p>
                        <p class="footer-slogan">내가 찾던 레시피</p>
                        <p><i class="fas fa-map-marker-alt mr-2"></i> 서울특별시 종로구 종로12길 15 (관철동 13-13)</p>
                        <p><i class="fas fa-phone mr-2"></i> 02-123-4567</p>
                        <p><i class="fas fa-envelope mr-2"></i> contact@makeable.co.kr</p>
                        <div class="social-links mt-3">
                            <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                            <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-2 col-md-6 mb-4 footer-links-column">
                    <h4>바로가기</h4>
                    <ul class="footer-links">
                        <li><a href="#">홈</a></li>
                        <li><a href="#">서비스</a></li>
                        <li><a href="#">포트폴리오</a></li>
                        <li><a href="#">팀 소개</a></li>
                        <li><a href="#">고객센터</a></li>
                    </ul>
                </div>

                <div class="col-lg-3 col-md-6 mb-4 footer-links-column">
                    <h4>서비스</h4>
                    <ul class="footer-links">
                        <li><a href="#">웹 개발</a></li>
                        <li><a href="#">모바일 앱</a></li>
                        <li><a href="#">UI/UX 디자인</a></li>
                        <li><a href="#">브랜딩</a></li>
                        <li><a href="#">디지털 마케팅</a></li>
                    </ul>
                </div>

                <div class="col-lg-3 col-md-6 mb-4">
                    <h4>뉴스레터 구독</h4>
                    <p>최신 소식과 이벤트 정보를 받아보세요</p>
                    <form action="" method="post" class="newsletter-form">
                        <input type="email" name="email" placeholder="이메일을 입력하세요">
                        <button type="submit"><i class="fas fa-paper-plane"></i></button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <div class="footer-bottom">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p class="copyright mb-0">
                        &copy; <span id="currentYear"></span> Makeable. All Rights Reserved.
                    </p>
                </div>
                <div class="col-md-6">
                    <div class="footer-info-bottom">
                        <p class="mb-0">
                            <span>사업자등록번호: 000-111-222</span> |
                            <span>대표: 신승호</span> |
                            <a href="https://soldesk.com/Jongro" target="_blank">www.soldesk.com</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- CSS Styles -->
<style>
    .footer-section {
        background: linear-gradient(135deg, #2c3e50 0%, #1a252f 100%);
        color: #ffffff;
        position: relative;
        font-family: 'Noto Sans KR', sans-serif;
    }
    
    .footer-content {
        position: relative;
        z-index: 2;
    }
    
    .footer-info h3 {
        margin-bottom: 20px;
        font-weight: 700;
        font-size: 26px;
        color: #fff;
        position: relative;
        display: inline-block;
    }
    
    .footer-info h3:after {
        content: '';
        position: absolute;
        width: 50px;
        height: 3px;
        background: #3498db;
        left: 0;
        bottom: -8px;
    }
    
    .footer-slogan {
        color: #e0e0e0;
        font-size: 15px;
        margin-bottom: 20px;
        font-style: italic;
    }
    
    .footer-info p {
        font-size: 14px;
        line-height: 24px;
        margin-bottom: 10px;
        color: #bdc3c7;
    }
    
    .footer-info p i {
        margin-right: 8px;
        color: #3498db;
    }
    
    .social-links {
        display: flex;
        gap: 12px;
    }
    
    .social-icon {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 36px;
        height: 36px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 50%;
        color: #ffffff;
        transition: all 0.3s ease;
    }
    
    .social-icon:hover {
        background: #3498db;
        color: #ffffff;
        transform: translateY(-3px);
    }
    
    .footer-links-column h4 {
        font-size: 18px;
        font-weight: 600;
        color: #ffffff;
        position: relative;
        margin-bottom: 25px;
        padding-bottom: 10px;
    }
    
    .footer-links-column h4:after {
        content: '';
        position: absolute;
        left: 0;
        bottom: 0;
        height: 2px;
        width: 30px;
        background: #3498db;
    }
    
    .footer-links {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .footer-links li {
        padding: 8px 0;
    }
    
    .footer-links li:first-child {
        padding-top: 0;
    }
    
    .footer-links a {
        color: #bdc3c7;
        text-decoration: none;
        font-size: 14px;
        display: block;
        transition: all 0.3s ease;
        position: relative;
        padding-left: 15px;
    }
    
    .footer-links a:before {
        content: '\f105';
        font-family: 'Font Awesome 5 Free';
        font-weight: 900;
        position: absolute;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        color: #3498db;
    }
    
    .footer-links a:hover {
        color: #ffffff;
        padding-left: 20px;
    }
    
    .newsletter-form {
        position: relative;
        margin-top: 15px;
    }
    
    .newsletter-form input {
        height: 45px;
        border: 1px solid rgba(255, 255, 255, 0.1);
        background: rgba(255, 255, 255, 0.05);
        width: 100%;
        padding: 10px 50px 10px 15px;
        color: #ffffff;
        border-radius: 3px;
        outline: none;
    }
    
    .newsletter-form input::placeholder {
        color: #bdc3c7;
    }
    
    .newsletter-form button {
        position: absolute;
        right: 0;
        top: 0;
        height: 45px;
        width: 45px;
        background: #3498db;
        color: #ffffff;
        border: none;
        border-radius: 0 3px 3px 0;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .newsletter-form button:hover {
        background: #2980b9;
    }
    
    .footer-bottom {
        background: rgba(0, 0, 0, 0.2);
        padding: 20px 0;
        border-top: 1px solid rgba(255, 255, 255, 0.05);
    }
    
    .copyright {
        color: #bdc3c7;
        font-size: 14px;
    }
    
    .footer-info-bottom {
        text-align: right;
    }
    
    .footer-info-bottom p {
        color: #bdc3c7;
        font-size: 14px;
    }
    
    .footer-info-bottom a {
        color: #3498db;
        text-decoration: none;
        transition: all 0.3s ease;
    }
    
    .footer-info-bottom a:hover {
        color: #ffffff;
    }
    
    @media (max-width: 991px) {
        .footer-links-column {
            margin-top: 20px;
        }
    }
    
    @media (max-width: 767px) {
        .footer-info-bottom, 
        .copyright {
            text-align: center;
        }
        
        .footer-info-bottom {
            margin-top: 10px;
        }
    }
</style>

<!-- JS -->
<script>
    document.getElementById('currentYear').textContent = new Date().getFullYear();
</script>