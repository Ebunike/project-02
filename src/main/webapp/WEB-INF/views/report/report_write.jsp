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
    .content-wrapper {
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
    
    /* 작성 컨테이너 */
    .write-container {
        width: 100%;
        background: white;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 5px 30px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        border: none;
    }
    
    /* 폼 그룹 스타일 */
    .form-group {
        margin-bottom: 25px;
        border: none;
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
    .action-bar {
        display: flex;
        justify-content: center;
        margin-top: 30px;
        gap: 15px;
    }
    
    .btn-action {
        padding: 12px 25px;
        border-radius: 8px;
        font-weight: 500;
        transition: all 0.3s ease;
        font-size: 16px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }
    
    .btn-submit {
        background: linear-gradient(90deg, #FF6347, #FF8C69);
        border: none;
        color: white;
    }
    
    .btn-submit:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(255, 99, 71, 0.3);
        background: linear-gradient(90deg, #FF5847, #FF7C59);
    }
    
    .btn-back {
        background-color: #6c757d;
        border: none;
        color: white;
    }
    
    .btn-back:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(108, 117, 125, 0.3);
        background-color: #5a6268;
    }
    
    /* 애니메이션 효과 */
    .write-container:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 35px rgba(0, 0, 0, 0.07);
    }
    
    /* 플레이스홀더 스타일 */
    ::placeholder {
        color: #adb5bd;
        opacity: 0.7;
    }
    
    /* 반응형 조정 */
    @media (max-width: 768px) {
        .write-container {
            padding: 25px;
        }
        
        .form-control {
            padding: 12px;
            font-size: 15px;
        }
        
        .page-title {
            font-size: 24px;
        }
        
        .btn-action {
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
                        <i class="fas fa-check mr-2"></i> 등록하기
                    </button>
                    <a href="${root}/report/report_list" class="btn btn-action btn-back">
                        <i class="fas fa-list mr-2"></i> 목록으로
                    </a>
                </div>
            </form>
        </div>
    </div>
    
    <!-- 게시판 하단 부분 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>