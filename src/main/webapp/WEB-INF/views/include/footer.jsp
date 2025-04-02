<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    footer {
        background-color: #f8f9fa;
        padding: 30px 0;
        margin-top: 50px;
        border-top: 1px solid #e5e5e5;
    }
    
    .footer-content {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }
    
    .footer-links {
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
    }
    
    .footer-links a {
        margin: 0 15px;
        color: #555;
        text-decoration: none;
    }
    
    .footer-links a:hover {
        color: #03c75a;
    }
    
    .footer-info {
        text-align: center;
        color: #777;
        font-size: 0.9em;
    }
    
    .footer-info p {
        margin: 5px 0;
    }
    
    .copyright {
        margin-top: 15px;
        font-size: 0.85em;
    }
    
    @media (max-width: 768px) {
        .footer-links {
            flex-direction: column;
            align-items: center;
        }
        
        .footer-links a {
            margin: 5px 0;
        }
    }
</style>

<footer>
    <div class="footer-content">
        <div class="footer-links">
            <a href="${pageContext.request.contextPath}/main">홈</a>
            <a href="${pageContext.request.contextPath}/board/main">게시판</a>
            <a href="${pageContext.request.contextPath}/kakaomap/main">지도</a>
            <a href="#">이용약관</a>
            <a href="#">개인정보처리방침</a>
            <a href="#">고객센터</a>
        </div>
        <div class="footer-info">
            <p>위치 기반 커뮤니티 서비스</p>
            <p>운영자: 관리자 | 이메일: admin@example.com | 전화: 02-123-4567</p>
            <p>주소: 서울특별시 강남구 테헤란로 123</p>
            <p class="copyright">© 2025 Community Project. All rights reserved.</p>
        </div>
    </div>
</footer>