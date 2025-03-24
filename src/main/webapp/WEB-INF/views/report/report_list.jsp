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
        background-color: white;
    }
    .list-container {
        margin-top: 30px;
    }
    .listboard-container {
        background-color: white;
        padding: 50px;
        padding-left: 250px;
        padding-right: 250px;
        box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
    }
    .board-title {
        text-align: center;
        font-weight: bold;
        margin-bottom: 20px;
    }
    table {
        width: 100%;
        background-color: white;
        border-radius: 8px;
        overflow: hidden;
        border-collapse: collapse; /* 추가 */
    }
    th, td {
        text-align: center;
        padding: 10px;
    }
    th {
        background-color: white;
    	color: black;
    }
    tr:nth-child(even) {
        background-color: #faf9f6;
    }
    .btn-container {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
        float: right;
    }
    table, th, td{
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
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

	
	<!-- 목록 출력 -->
<!-- 게시글 리스트 -->
<div class="list-container">
    <div class="listboard-container">
        <h2 class="board-title">📋 게시판 목록</h2>
        
        <div class="btn-container">
            <a href="${root}/report/report_write" class="btn btn-primary">글쓰기</a>
        </div>
        <!-- <table class="table table-bordered"> -->
       
        <table class="test_table" style="text-align: center;">
            <thead>
                <tr class="title_box">
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
	                <c:forEach var="report" items="${report_list}">
	                    <tr>
	                        <td>${report.report_id}</td>
	                        <td><a href="${root }/report/report_detail?report_id=${report.report_id}">${report.report_title}</a></td>
	                        <td>${report.id}</td>
	                        <td>${report.report_date}</td>
	                    </tr>
	                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>