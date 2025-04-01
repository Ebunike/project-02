<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 수정</title>
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
        background-color: #f9f9f9;
        color: #333;
        min-height: 100vh;
        padding: 0;
        margin: 0;
    }
    
    /* 상단 메뉴 스타일 */
    .top_menu {
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 40px;
        position: relative;
        z-index: 10;
    }
    
    /* 컨텐츠 래퍼 */
    .edit-wrapper {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 100%;
        max-width: 900px;
        margin: 0 auto 50px;
        padding: 0 20px;
    }
    
    /* 페이지 헤더 */
    .page-header {
        text-align: center;
        margin-bottom: 30px;
        width: 100%;
        position: relative;
    }
    
    .page-title {
        font-weight: 700;
        color: #333;
        position: relative;
        display: inline-block;
        font-size: 28px;
        padding-bottom: 15px;
    }
    
    .page-title:after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 60px;
        height: 3px;
        background: linear-gradient(90deg, #FF6347, #FF8C69);
        border-radius: 3px;
    }
    
    /* 수정 폼 컨테이너 */
    .edit-container {
        width: 100%;
        background: white;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 5px 30px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        border: none;
    }
    
    .edit-container:hover {
        box-shadow: 0 8px 35px rgba(0, 0, 0, 0.07);
    }
    
    /* 폼 그룹 스타일 */
    .form-group {
        margin-bottom: 25px;
        position: relative;
    }
    
    .form-group label {
        font-weight: 600;
        color: #333;
        margin-bottom: 10px;
        display: block;
        font-size: 16px;
    }
    
    .form-group label i {
        margin-right: 8px;
        color: #FF6347;
    }
    
    /* 입력 필드 스타일 */
    .form-control {
        border: 1px solid #e9ecef;
        border-radius: 8px;
        padding: 15px;
        font-size: 16px;
        transition: all 0.3s ease;
        box-shadow: none;
        background-color: #f8f9fa;
        width: 100%;
    }
    
    .form-control:focus {
        border-color: #FF6347;
        box-shadow: 0 0 0 3px rgba(255, 99, 71, 0.2);
        background-color: #fff;
    }
    
    textarea.form-control {
        min-height: 250px;
        resize: vertical;
        line-height: 1.6;
    }
    
    /* 버튼 스타일 */
    .btn-container {
        display: flex;
        justify-content: center;
        margin-top: 30px;
        gap: 15px;
    }
    
    .btn-edit {
        padding: 12px 25px;
        border-radius: 8px;
        font-weight: 500;
        transition: all 0.3s ease;
        font-size: 16px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        background: linear-gradient(90deg, #FF6347, #FF8C69);
        border: none;
        color: white;
    }
    
    .btn-edit:hover {
        box-shadow: 0 6px 15px rgba(255, 99, 71, 0.3);
        background: linear-gradient(90deg, #FF5847, #FF7C59);
    }
    
    .btn-back {
        padding: 12px 25px;
        border-radius: 8px;
        font-weight: 500;
        transition: all 0.3s ease;
        font-size: 16px;
        background-color: #6c757d;
        border: none;
        color: white;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }
    
    .btn-back:hover {
        box-shadow: 0 6px 15px rgba(108, 117, 125, 0.3);
        background-color: #5a6268;
        color: white;
        text-decoration: none;
    }
    
    .btn i {
        margin-right: 8px;
    }
    
    /* 반응형 조정 */
    @media (max-width: 768px) {
        .edit-container {
            padding: 25px;
        }
        
        .form-control {
            padding: 12px;
            font-size: 15px;
        }
        
        .page-title {
            font-size: 24px;
        }
        
        .btn-edit, .btn-back {
            padding: 10px 20px;
            font-size: 15px;
        }
    }
</style>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<div class="top_menu">
    <c:import url="/WEB-INF/views/include/top_menu.jsp" />
</div>

<div class="edit-wrapper">
    <div class="page-header">
        <h2 class="page-title"><i class="fas fa-edit"></i> 게시글 수정</h2>
    </div>
    
    <div class="edit-container">
        <form action="${root}/report/report_edit_pro" method="post">
            <input type="hidden" name="report_id" value="${report.report_id}">
            
            <div class="form-group">
                <label for="report_title"><i class="fas fa-heading"></i> 제목</label>
                <input type="text" id="report_title" name="report_title" class="form-control" value="${report.report_title}" required>
            </div>
            
            <div class="form-group">
                <label for="report_content"><i class="fas fa-file-alt"></i> 내용</label>
                <textarea id="report_content" name="report_content" class="form-control" required>${report.report_content}</textarea>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-edit">
                    <i class="fas fa-save"></i> 수정 완료
                </button>
                <a href="${root}/report/report_list" class="btn btn-back">
                    <i class="fas fa-arrow-left"></i> 목록으로
                </a>
            </div>
        </form>
    </div>
</div>

<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>