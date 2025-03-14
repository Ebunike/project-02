<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
   body {
        display: ;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 100vh;
    }
    .report_detail {
        width: 60%;
        text-align: center;
    }
    .report_info {
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        margin-bottom: 20px;
    }
    .report_info input {
        width: 200px;
        margin-bottom: 10px;
    }
    .report_content {
        width: 100%;
        height: 200px;
    }
    .buttons {
        margin-top: 20px;
        text-align: center;
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
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

   
       <div class="report_detail">
           <div class="report_info">
           <h2>📄 게시글 상세보기</h2>
               <label for="report_title">제목:</label>
               <input type="text" id="report_title" name="report_title" class="form-control" value="${report.report_title }" disabled>
               
               <label for="report_id">작성자:</label>
               <input type="text" id="report_id" name="report_id" class="form-control" value="${report.id }" disabled>
               
               <label for="report_date">작성일:</label>
               <input type="text" id="report_date" name="report_date" class="form-control" value="${report.report_date }" disabled>
           </div>

        <label for="report_content">내용:</label>
        <textarea id="report_content" name="report_content" class="form-control report_content" disabled>${report.report_content }</textarea>
    </div>    <br>
    <div class="buttons">
        <button class="btn btn-primary">👍 좋아요</button>
        <button class="btn btn-danger">👎 싫어요</button>
    </div>
    <c:if test="${report.id == loginUser.id}">
        <a href="report_edit?report_id=${report.report_id}">수정하기</a>
    </c:if>
    <a href="report_list">목록으로</a>

    <!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>