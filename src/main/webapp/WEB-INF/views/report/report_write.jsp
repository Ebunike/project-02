<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 작성</title>
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
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f8f9fa;
        color: #333;
        min-height: 100vh;
        padding: 0;
        margin: 0;
    }
    .content-wrapper {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 100%;
        max-width: 1200px;
        margin: 2rem auto;
        padding: 0 20px;
    }
    .page-header {
        text-align: center;
        margin-bottom: 2rem;
        width: 100%;
        position: relative;
    }
    .page-title {
        font-weight: 700;
        color: #343a40;
        padding-bottom: 0.5rem;
        border-bottom: 3px solid #28a745;
        display: inline-block;
    }
    .write-container {
        width: 100%;
        max-width: 800px;
        background: #ffffff;
        padding: 2rem;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        margin-bottom: 2rem;
        border: 3px solid black;
    }
    .form-group {
    	border: 2px solid black;
    }
    .form-group label {
        font-weight: 700;
        color: #495057;
        margin-bottom: 0.5rem;
        font-size: 1rem;
    }
    .form-control:focus {
        border-color: #28a745;
        box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
    }
    .form-control {
        border: 1px solid #e9ecef;
        padding: 12px;
        transition: all 0.3s ease;
    }
    textarea.form-control {
        min-height: 200px;
        resize: vertical;
    }
    .btn-action {
        padding: 10px 20px;
        border-radius: 5px;
        font-weight: 500;
        transition: all 0.3s ease;
        margin-right: 10px;
    }
    .btn-submit {
        background-color: #28a745;
        border-color: #28a745;
        color: white;
    }
    .btn-submit:hover {
        background-color: #218838;
        border-color: #1e7e34;
    }
    .btn-back {
        background-color: #6c757d;
        border-color: #6c757d;
        color: white;
    }
    .btn-back:hover {
        background-color: #5a6268;
        border-color: #545b62;
    }
    .action-bar {
        display: flex;
        justify-content: center;
        margin-top: 1.5rem;
    }
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .write-container {
            width: 100%;
            padding: 1.5rem;
        }
    }
</style>
</head>
<body>
    <!-- 상단 메뉴 부분 -->
    <div class="top_menu">
        <c:import url="/WEB-INF/views/include/top_menu.jsp" />
    </div>
    
    <div class="content-wrapper">
        <div class="page-header">
            <h2 class="page-title"><i class="fas fa-pen"></i> 게시글 작성</h2>
        </div>
        
        <div class="write-container">
            <form action="report_write_pro" method="post">
                <div class="form-group">
                    <label for="report_title"><i class="fas fa-heading"></i> 제목</label>
                    <input type="text" id="report_title" name="report_title" class="form-control" required placeholder="제목을 입력해주세요">
                </div>
                
                <div class="form-group">
                    <label for="report_content"><i class="fas fa-file-alt"></i> 내용</label>
                    <textarea id="report_content" name="report_content" class="form-control" required placeholder="내용을 입력해주세요"></textarea>
                </div>
                
                <div class="action-bar">
                    <button type="submit" class="btn btn-action btn-submit">
                        <i class="fas fa-check"></i> 등록하기
                    </button>
                    <a href="${root}/report/report_list" class="btn btn-action btn-back">
                        <i class="fas fa-list"></i> 목록으로
                    </a>
                </div>
            </form>
        </div>
    </div>
    
    <!-- 게시판 하단 부분 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>