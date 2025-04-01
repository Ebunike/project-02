<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Q&A 관리</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<style type="text/css">
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');
    
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }
    
    /* 사이드바 스타일 */
    .sidebar {
        position: fixed;
        left: 0;
        top: 0;
        width: 220px;
        height: 100vh;
        background-color: #ffffff;
        box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
        padding: 30px 0;
        transition: all 0.3s ease;
        z-index: 999;
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
    }
    
    .sidebar ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }
    
    .sidebar li {
        margin: 5px 0;
    }
    
    .sidebar a {
        display: flex;
        align-items: center;
        color: #555;
        text-decoration: none;
        padding: 12px 20px;
        font-size: 14px;
        transition: all 0.2s ease;
        border-left: 3px solid transparent;
    }
    
    .sidebar a:hover {
        background-color: #f8f9fa;
        color: #007bff;
        border-left: 3px solid #007bff;
    }
    
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
    }
    
    .sidebar-footer {
        position: absolute;
        bottom: 20px;
        width: 100%;
        text-align: center;
        font-size: 12px;
        color: #999;
        padding: 10px 0;
        border-top: 1px solid #f0f0f0;
    }
    
    /* 컨텐츠 영역 스타일 */
    .content-wrapper {
        margin-left: 220px;
        padding: 30px;
        transition: all 0.3s ease;
    }
    
    .page-header {
        margin-bottom: 30px;
        border-bottom: 1px solid #e9ecef;
        padding-bottom: 15px;
    }
    
    .page-header h2 {
        font-size: 24px;
        font-weight: 500;
        color: #333;
        margin: 0;
    }
    
    /* 테이블 스타일 */
    .card {
        border: none;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
        margin-bottom: 30px;
    }
    
    .card-header {
        background-color: #fff;
        border-bottom: 1px solid #f0f0f0;
        padding: 15px 20px;
    }
    
    .card-header h3 {
        margin: 0;
        font-size: 18px;
        font-weight: 500;
    }
    
    .table {
        margin-bottom: 0;
    }
    
    .table th {
        font-weight: 500;
        color: #495057;
        border-top: none;
        background-color: #f8f9fa;
    }
    
    .table td {
        vertical-align: middle;
    }
    
    .table a {
        color: #495057;
        text-decoration: none;
    }
    
    .table a:hover {
        color: #007bff;
    }
    
    .status-badge {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 50px;
        font-size: 12px;
        font-weight: 500;
    }
    
    .status-pending {
        background-color: #fff3cd;
        color: #856404;
    }
    
    .status-completed {
        background-color: #d4edda;
        color: #155724;
    }
    
    /* 페이지네이션 스타일 */
    .pagination {
        justify-content: center;
    }
    
    .page-item .page-link {
        color: #495057;
        border-radius: 5px;
        margin: 0 3px;
    }
    
    .page-item.active .page-link {
        background-color: #007bff;
        border-color: #007bff;
    }
    
    .page-item.disabled .page-link {
        color: #adb5bd;
    }
    
    /* 검색 폼 스타일 */
    .search-form {
        margin-bottom: 20px;
    }
    
    .search-form .form-group {
        margin-bottom: 0;
    }
    
    .search-form .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
    }
    
    /* 반응형 설정 */
    @media (max-width: 768px) {
        .sidebar {
            width: 70px;
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
</head>
<body>
    <div class="side">
        <c:import url="/WEB-INF/views/include/manager_side.jsp" />
    </div>
    <div class="content-wrapper">
        <div class="page-header">
            <h2>Q&A 관리</h2>
        </div>
        
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h3>문의 목록</h3>
                <div class="search-form">
                    <form class="form-inline">
                        <div class="form-group mr-2">
                            <select class="form-control">
                                <option>전체</option>
                                <option>답변 대기중</option>
                                <option>답변 완료</option>
                            </select>
                        </div>
                        <div class="form-group mr-2">
                            <input type="text" class="form-control" placeholder="검색어를 입력하세요">
                        </div>
                        <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
                    </form>
                </div>
            </div>
            <div class="card-body p-0">
                <table class="table">
                    <thead>
                        <tr>
                            <th width="8%">번호</th>
                            <th width="15%">질문유형</th>
                            <th width="40%">제목</th>
                            <th width="15%">작성자</th>
                            <th width="15%">작성일</th>
                            <th width="10%">상태</th>
                        </tr>
                    </thead>
                   <tbody>
				    <c:forEach var="inquiry" items="${inquiryList}" varStatus="status">
				        <tr>
				            <td>${status.count}</td>
				            <td>${inquiry.inquiry_category}</td>
				            
				            <td> <a href="${root}/manager/viewInquiry?idx=${inquiry.inquiry_idx}">${inquiry.inquiry_title}</a></td>
				            <td>${inquiry.id}</td>
				            <td>${inquiry.inquiry_date}</td> <!-- 여기서 fmt 제거하고 문자열 그대로 출력 -->
				            <td>
				                <c:choose>
				                    <c:when test="${empty inquiry.inquiry_reply}">
				                        <span class="status-badge status-pending">답변대기중</span>
				                    </c:when>
				                    <c:otherwise>
				                        <span class="status-badge status-completed">답변완료</span>
				                    </c:otherwise>
				                </c:choose>
				            </td>
				        </tr>
				    </c:forEach>
				</tbody>

                </table>
            </div>
            <div class="card-footer">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1"><i class="fas fa-angle-left"></i></a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#"><i class="fas fa-angle-right"></i></a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
     <!-- 게시판 하단 부분 -->    
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>