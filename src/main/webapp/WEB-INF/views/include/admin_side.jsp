<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">  
<title>관리자 메뉴</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');
    
    body {
        font-family: 'Noto Sans KR', sans-serif;
        margin: 0;
        padding: 0;
    }
    .sidebar {
        position: fixed;
        left: 0;
        top: 0;
        width: 200px;
        height: 550px;
        background-color: #ffffff;
        box-shadow: 3px 0 15px rgba(0, 0, 0, 0.1);
        padding: 30px 0;
        transition: all 0.3s ease;
        border: 1px solid #e0e0e0;
        border-radius: 0 15px 15px 0;
    }
    .sidebar-header {
        text-align: center;
        padding: 0 20px 20px;
        border-bottom: 1px solid #f0f0f0;
        margin-bottom: 20px;
    }
    .sidebar-header h3 {
        margin: 0;
        color: #333;
        font-weight: 500;
        font-size: 18px;
    }
    .sidebar ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }
    .sidebar li {
        margin: 8px 0;
    }
    .sidebar a {
        display: flex;
        align-items: center;
        color: #555;
        text-decoration: none;
        padding: 12px 20px;
        font-size: 14px;
        transition: all 0.3s ease;
        border-left: 3px solid transparent;
        position: relative;
        overflow: hidden;
    }
    .sidebar a:hover {
        background-color: #f8f9fa;
        color: #007bff;
        border-left: 3px solid #007bff;
    }
    /* 페이지 ID를 기반으로 현재 페이지 표시 */
    .sidebar a.active {
        background-color: #f0f7ff;
        color: #007bff;
        border-left: 3px solid #007bff;
        font-weight: 500;
    }
    .sidebar i {
        margin-right: 10px;
        width: 20px;
        text-align: center;
        font-size: 16px;
    }
    .sidebar-footer {
        position: absolute;
        bottom: 20px;
        width: 100%;
        font-size: 13px;
        color: #777;
        padding: 15px 0;
        border-top: 1px solid #f0f0f0;
    }
    .sidebar-footer a {
        color: #555;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 8px 12px;
        border-radius: 5px;
        transition: all 0.3s ease;
        background-color: #f8f9fa;
        margin: 0 auto;
        width: 120px;
    }
    .sidebar-footer a:hover {
        background-color: #e9ecef;
        color: #007bff;
    }
    .content-wrapper {
        margin-left: 220px;
        padding: 20px;
    }
    /* 호버 효과 개선 */
    .sidebar a::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 0;
        height: 1px;
        background-color: #007bff;
        transition: width 0.3s ease;
    }
    .sidebar a:hover::after {
        width: 100%;
    }
    @media (max-width: 768px) {
        .sidebar {
            width: 70px;
            overflow: hidden;
        }
        .sidebar a span {
            display: none;
        }
        .sidebar i {
            margin-right: 0;
            font-size: 18px;
        }
        .sidebar-header {
            padding: 10px 0;
        }
        .sidebar-header h3 {
            display: none;
        }
        .content-wrapper {
            margin-left: 70px;
        }
    }
</style>

<script>
    /* 현재 URL 기반으로 해당 메뉴 활성화 */
    document.addEventListener("DOMContentLoaded", function() {
        // 현재 페이지 URL 가져오기
        var currentPage = window.location.pathname;
        
        // 모든 메뉴 링크 가져오기
        var menuLinks = document.querySelectorAll('.sidebar ul a');
        
        // 모든 active 클래스 제거
        menuLinks.forEach(function(link) {
            link.classList.remove('active');
        });
        
        // 현재 페이지와 일치하는 메뉴에 active 클래스 추가
        menuLinks.forEach(function(link) {
            var href = link.getAttribute('href');
            
            // href의 마지막 부분만 추출 (예: manager_product)
            var pageName = href.split('/').pop();
            
            // 현재 URL에 해당 pageName이 포함되어 있는지 확인
            if (currentPage.includes(pageName)) {
                link.classList.add('active');
            }
        });
    });
</script>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h3>관리자 메뉴</h3>
        </div>
        <ul>
        	<li><a href="${root}/admin/inquiry"><i class="fas fa-comments mr-2"></i><span>고객문의 관리</span></a></li>
        	<li><a href="${root}/admin/management"><i class="fas fa-users mr-2"></i><span>멤버 관리</span></a></li>
        	<li><a href="${root}/admin/notice"><i class="fas fa-bullhorn mr-2"></i><span>공지사항</span></a></li>
        	<li><a href="${root}/admin/benefit"><i class="fas fa-ticket-alt mr-2"></i><span>쿠폰 및 혜택</span></a></li>
        	<li><a href="${root}/admin/system"><i class="fas fa-ticket-alt mr-2"></i><span>배너 관리</span></a></li>
        	<li><a href="${root}/admin/salesapproval"><i class="fas fa-check-circle mr-2"></i><span>판매승인관리</span></a></li>
        	<li><a href="${root}/member/logout"><i class="fas fa-sign-out-alt mr-2"></i><span>로그아웃</span></a></li>
        </ul>
        <div class="sidebar-footer">
            <a href="${root}/admin/adminmain"><i class="fas fa-home"></i><span>홈 화면</span></a>
        </div>
    </div>
    
    <div class="content-wrapper">
        <!-- 여기에 페이지 내용이 들어갑니다 -->
    </div>
</body>
</html>