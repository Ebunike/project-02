<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
<style type="text/css">
	body {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
        background-color: #f8f9fa;
        padding: 20px;
    }
    .write_container {
        width: 50%;
        background: #f5f5dc;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        text-align: center;
        border: 1px solid black;
    }
    .write_container input,
    .write_container textarea {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ced4da;
        border-radius: 4px;
    }
    .buttons {
        margin-top: 20px;
        text-align: center;
        height: 200px;
    }
    /* 상단 메뉴를 찌그러지지 않게 유지 */
    .top_menu {
        width: 100%;
    }
</style>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 상단 메뉴 부분 -->
 	<div class="top_menu">
        <c:import url="/WEB-INF/views/include/top_menu.jsp" />
    </div>
    
<!-- login 된 회원만 글 작성 가능.  -->
<!-- 목록 출력 -->
	<h2>✏ 게시글 작성</h2>
    <div class="write_container">
        <form action="report_write_pro" method="post">
            <label>제목:</label>
            <input type="text" name="report_title" required>
            
            <label>내용:</label>
            <textarea name="report_content" rows="5" required></textarea>
            
            <div class="buttons">
                <input type="submit" value="등록" class="btn btn-success">
                <a href="${root }/report/report_list" class="btn btn-secondary">🔙 목록으로</a>
            </div>
        </form>
    </div>
<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>