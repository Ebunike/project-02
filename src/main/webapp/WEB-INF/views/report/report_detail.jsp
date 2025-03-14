<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<style type="text/css">
    /* body 전체를 flex로 설정하지 않고, 상단 메뉴와 본문을 분리 */
    body {
        background-color: #f8f9fa;
    }
    
    /* 상단 메뉴를 찌그러지지 않게 유지 */
    .top_menu {
        width: 100%;
    }
    
    /* 본문을 flex로 중앙 정렬 */
    .content_wrapper {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-start;
        min-height: 100vh;
    }
    
    /* 게시글 컨테이너 */
    .report_container {
        width: 60%;
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        text-align: center;
        margin-top: 20px;
        border: 1px solid black;
    }
    
    /* 작성자, 제목, 작성일 정보 박스 */
    .report_info {
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        margin-bottom: 20px;
    }
    .report_info input {
        width: 200px;
        margin-bottom: 10px;
        padding: 5px;
        border: 1px solid #ced4da;
        border-radius: 4px;
    }
    
    /* 내용 입력 박스 크기 조절 */
    .report_content {
        width: 100%;
        height: 200px;
        padding: 10px;
        border: 1px solid #ced4da;
        border-radius: 4px;
        resize: none;
    }
    
    /* 버튼 정렬 */
    .buttons {
        margin-top: 20px;
        text-align: center;
        width: 100px; /* 크기 조정 */
	    height: 75px;
	    display: flex; /* flex 사용 */
	    align-items: center;
	    justify-content: center;
	    margin: 0 10px;
    }
    .buttons img {
    	width: 100%; /* 부모 요소 크기와 맞춤 */
	    height: auto;
	    object-fit: contain; /* 이미지 비율 유지 */
    }
    .title_box {
    	border-bottom: 1px solid black;
    }
</style>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<body>
    <!-- 상단 메뉴 부분 (클래스를 추가하여 찌그러짐 방지) -->
    <div class="top_menu">
        <c:import url="/WEB-INF/views/include/top_menu.jsp" />
    </div>
    
    <div class="content_wrapper"> <!-- 본문을 감싸는 div 추가 -->
        <div class="report_container">
        	<div class="title_box">
            	<h2>${report.report_title }</h2>
            </div>
            <div class="report_info">
                <label for="report_id">작성자:</label>
                <input type="text" id="report_id" name="report_id" class="form-control" value="${report.id }" disabled>
                
                <label for="report_date">작성일:</label>
                <input type="text" id="report_date" name="report_date" class="form-control" value="${report.report_date }" disabled>
            </div>

            <label for="report_content">내용:</label>
            <textarea id="report_content" name="report_content" class="form-control report_content" disabled>${report.report_content }</textarea>
        </div>
        
        <div class="buttons">
            <button>
            	<img src="${root }/logo/like_logo.png">
            </button>
            <button>
            	<img src="${root }/logo/unlike_logo.png">
            </button>
        </div>
    </div>
    
    <!-- 하단 부분 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>
