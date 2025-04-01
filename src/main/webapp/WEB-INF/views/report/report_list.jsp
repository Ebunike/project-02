<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style type="text/css">
    /* 기본 스타일 */
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f9f9f9;
        color: #333;
        line-height: 1.6;
    }

    /* 공지 배너 */
    .notice-banner {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        background: linear-gradient(90deg, #FF6347, #FF8C69);
        color: white;
        text-align: center;
        padding: 12px;
        font-weight: 500;
        z-index: 9999;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    /* 관리자 글 하이라이트 */
    .highlight {
        background-color: #fff8f8;
        border-left: 4px solid #FF6347;
        transition: all 0.2s ease;
    }
    
    .highlight:hover {
        background-color: #fff0f0;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
    }
    
    .highlight td {
        color: #333;
        font-weight: 500;
    }
    
    .highlight a {
        color: #FF6347;
        font-weight: 700;
    }

    /* 리스트 컨테이너 */
    .list-container {
        margin-top: 30px;
        padding: 0 15px;
    }

    .listboard-container {
        background-color: white;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 5px 30px rgba(0, 0, 0, 0.05);
        max-width: 1200px;
        margin: 0 auto;
        transition: all 0.3s ease;
    }

    /* 게시판 제목 */
    .board-title {
        text-align: center;
        font-weight: 700;
        font-size: 28px;
        margin-bottom: 30px;
        color: #333;
        position: relative;
        padding-bottom: 15px;
    }
    
    .board-title:after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 80px;
        height: 3px;
        background: linear-gradient(90deg, #FF6347, #FF8C69);
        border-radius: 3px;
    }

    /* 테이블 스타일 */
    table {
        width: 100%;
        background-color: white;
        border-radius: 10px;
        overflow: hidden;
        border-collapse: separate;
        border-spacing: 0;
        margin-top: 20px;
        box-shadow: 0 2px 15px rgba(0, 0, 0, 0.03);
    }

    th {
        background-color: #f8f9fa;
        color: #495057;
        font-weight: 600;
        padding: 15px;
        text-align: center;
        border-bottom: 2px solid #e9ecef;
    }

    td {
        padding: 15px;
        text-align: center;
        border-bottom: 1px solid #e9ecef;
        color: #495057;
        transition: all 0.2s ease;
    }
    
    tr:hover td {
        background-color: #f8f9fa;
    }
    
    tr:last-child td {
        border-bottom: none;
    }

    /* 링크 스타일 */
    a {
        color: #495057;
        text-decoration: none;
        transition: all 0.2s;
    }
    
    a:hover {
        color: #FF6347;
        text-decoration: none;
    }

    /* 버튼 컨테이너 */
    .btn-container {
        display: flex;
        justify-content: flex-end;
        margin: 25px 0 15px;
    }

    /* 버튼 스타일 */
    .btn-primary {
        background: linear-gradient(90deg, #FF6347, #FF8C69);
        border: none;
        border-radius: 5px;
        padding: 10px 20px;
        font-weight: 500;
        transition: all 0.3s ease;
        box-shadow: 0 4px 10px rgba(255, 99, 71, 0.2);
    }
    
    .btn-primary:hover {
        background: linear-gradient(90deg, #FF5847, #FF7C59);
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(255, 99, 71, 0.3);
    }
    
    /* 테이블 헤더 고정 */
    .title_box {
        position: sticky;
        top: 0;
        z-index: 10;
    }
    
    /* 번호 컬럼 너비 */
    th:first-child, td:first-child {
        width: 10%;
    }
    
    /* 제목 컬럼 너비 */
    th:nth-child(2), td:nth-child(2) {
        width: 50%;
        text-align: left;
    }
    
    /* 작성자 컬럼 너비 */
    th:nth-child(3), td:nth-child(3) {
        width: 20%;
    }
    
    /* 날짜 컬럼 너비 */
    th:nth-child(4), td:nth-child(4) {
        width: 20%;
    }
    
    /* 반응형 */
    @media (max-width: 768px) {
        .listboard-container {
            padding: 20px;
        }
        
        th, td {
            padding: 10px 5px;
            font-size: 14px;
        }
        
        .board-title {
            font-size: 24px;
        }
        
        th:first-child, td:first-child {
            width: 15%;
        }
        
        th:nth-child(2), td:nth-child(2) {
            width: 45%;
        }
    }
</style>
</head>
<body>
<!-- 상단 메뉴 또는 관리자 페이지 버튼 출력 -->
<c:if test="${loginUser.id == 'admin'}">
    <!-- 관리자일 경우 '관리자 페이지로 돌아가기' 버튼만 표시 -->
    <div class="btn-container" style="padding: 20px; margin-bottom: 0;">
        <a href="${root}/admin/adminmain" class="btn btn-primary">
            <i class="fas fa-cog mr-2"></i>관리자 페이지로 돌아가기
        </a>
    </div>
</c:if>

<c:if test="${loginUser.id != 'admin'}">
    <!-- 일반 사용자는 상단 메뉴 출력 -->
    <c:import url="/WEB-INF/views/include/top_menu.jsp" />
</c:if>

<!-- 목록 출력 -->
<div class="list-container">
    <div class="listboard-container">
        <h2 class="board-title">
            <i class="fas fa-comments mr-2"></i> 자유게시판
        </h2>
        
        <div class="btn-container">
            <a href="${root}/report/report_write" class="btn btn-primary">
                <i class="fas fa-pen mr-2"></i>글쓰기
            </a>
        </div>

        <table class="test_table">
            <thead>
                <tr class="title_box">
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <!-- admin인 게시글을 먼저 출력 -->
                <c:forEach var="report" items="${report_list}">
                    <c:if test="${report.id == 'admin'}">
                        <tr class="highlight">
                            <td>${report.report_id}</td>
                            <td><a href="${root}/report/report_detail?report_id=${report.report_id}"><i class="fas fa-bullhorn mr-2"></i>${report.report_title}</a></td>
                            <td><i class="fas fa-user-shield mr-1"></i>${report.id}</td>
                            <td><i class="far fa-calendar-alt mr-1"></i>${report.report_date}</td>
                        </tr>
                    </c:if>
                </c:forEach>

                <!-- admin이 아닌 나머지 게시글 출력 -->
                <c:forEach var="report" items="${report_list}">
                    <c:if test="${report.id != 'admin'}">
                        <tr>
                            <td>${report.report_id}</td>
                            <td><a href="${root}/report/report_detail?report_id=${report.report_id}">${report.report_title}</a></td>
                            <td>${report.id}</td>
                            <td>${report.report_date}</td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>