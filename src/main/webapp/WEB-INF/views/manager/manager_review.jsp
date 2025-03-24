<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 관리</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- 네이버 폰트 -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGaRamYeonGgoc.css" rel="stylesheet">
<style type="text/css">
    body {
        background-color: #f8f9fa;
        font-family: 'NanumGaRamYeonGgoc', sans-serif;
    }
    
    .list-container {
        margin-top: 30px;
        margin-bottom: 50px;
    }
    
    .listboard-container {
        background-color: white;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        max-width: 1200px;
        margin: 0 auto;
    }
    
    .board-title {
        text-align: center;
        font-weight: bold;
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
        background: linear-gradient(to right, #4e73df, #36b9cc);
    }
    
    table {
        width: 100%;
        background-color: white;
        border-radius: 8px;
        overflow: hidden;
        border-collapse: collapse;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.03);
    }
    
    thead {
        background-color: #f8f9fa;
    }
    
    th {
        background-color: #f8f9fa;
        color: #333;
        font-weight: bold;
        padding: 15px;
        border-bottom: 2px solid #e9ecef;
    }
    
    td {
        padding: 15px;
        text-align: center;
        border-bottom: 1px solid #e9ecef;
        vertical-align: middle;
    }
    
    tbody tr:hover {
        background-color: #f1f3f9;
        transition: background-color 0.3s ease;
    }
    
    .table-link {
        color: #4e73df;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s ease;
    }
    
    .table-link:hover {
        color: #224abe;
        text-decoration: underline;
    }
    
    .status-badge {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: bold;
    }
    
    .status-pending {
        background-color: #ffecb3;
        color: #e6a700;
    }
    
    .status-completed {
        background-color: #c8e6c9;
        color: #2e7d32;
    }
    
    .search-container {
        display: flex;
        justify-content: flex-end;
        margin-bottom: 20px;
    }
    
    .search-box {
        display: flex;
        border-radius: 5px;
        overflow: hidden;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    
    .search-select {
        border: none;
        padding: 8px 15px;
        border-right: 1px solid #e9ecef;
    }
    
    .search-input {
        border: none;
        padding: 8px 15px;
        width: 200px;
    }
    
    .search-button {
        background-color: #4e73df;
        color: white;
        border: none;
        padding: 8px 15px;
        cursor: pointer;
    }
    
    .search-button:hover {
        background-color: #2e59d9;
    }
    
    .pagination-container {
        display: flex;
        justify-content: center;
        margin-top: 30px;
    }
    
    .pagination {
        display: flex;
        list-style: none;
        padding: 0;
    }
    
    .page-item {
        margin: 0 3px;
    }
    
    .page-link {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        color: #4e73df;
        text-decoration: none;
        transition: all 0.3s ease;
    }
    
    .page-link:hover {
        background-color: #e8eaf6;
    }
    
    .page-item.active .page-link {
        background-color: #4e73df;
        color: white;
    }
    
    .page-item.disabled .page-link {
        color: #6c757d;
        pointer-events: none;
    }
</style>
</head>
<body>
    <div class="side">
        <c:import url="/WEB-INF/views/include/manager_side.jsp" />
    </div>
    
    <!-- 게시글 리스트 -->
    <div class="list-container">
        <div class="listboard-container">
            <h2 class="board-title">리뷰 관리</h2>
            
            <div class="search-container">
                <div class="search-box">
                    <select class="search-select">
                        <option>전체</option>
                        <option>제목</option>
                        <option>작성자</option>
                        <option>내용</option>
                    </select>
                    <input type="text" class="search-input" placeholder="검색어를 입력하세요">
                    <button class="search-button">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th width="8%">번호</th>
                        <th width="15%">질문유형</th>
                        <th width="40%">제목</th>
                        <th width="12%">작성자</th>
                        <th width="15%">작성일</th>
                        <th width="10%">상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="report" items="${report_list}" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td>상품문의</td>
                            <td class="text-left">
                                <a href="${root}/report/report_detail?report_id=${report.id}" class="table-link">
                                    ${empty report.id ? '상품에 대한 문의드립니다.' : report.id}
                                </a>
                            </td>
                            <td>${empty report.report_date ? 'user123' : report.report_date}</td>
                            <td>${empty report.report_date ? '2023-03-15' : report.report_date}</td>
                            <td>
                                <span class="status-badge ${status.count % 2 == 0 ? 'status-completed' : 'status-pending'}">
                                    ${status.count % 2 == 0 ? '답변완료' : '답변대기'}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <!-- 샘플 데이터 (실제 운영시 삭제) -->
                    <tr>
                        <td>1</td>
                        <td>상품문의</td>
                        <td class="text-left"><a href="#" class="table-link">배송일정에 대해 문의드립니다</a></td>
                        <td>홍길동</td>
                        <td>2023-03-18</td>
                        <td><span class="status-badge status-pending">답변대기</span></td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>교환/환불</td>
                        <td class="text-left"><a href="#" class="table-link">사이즈가 맞지 않아 교환 원합니다</a></td>
                        <td>김철수</td>
                        <td>2023-03-17</td>
                        <td><span class="status-badge status-completed">답변완료</span></td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>결제문의</td>
                        <td class="text-left"><a href="#" class="table-link">포인트 적립 관련 문의</a></td>
                        <td>이영희</td>
                        <td>2023-03-16</td>
                        <td><span class="status-badge status-pending">답변대기</span></td>
                    </tr>
                </tbody>
            </table>
            
            <!-- 페이지네이션 -->
            <div class="pagination-container">
                <ul class="pagination">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" aria-label="Previous">
                            <i class="fas fa-angle-left"></i>
                        </a>
                    </li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">4</a></li>
                    <li class="page-item"><a class="page-link" href="#">5</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                            <i class="fas fa-angle-right"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    
    <!-- 게시판 하단 부분 -->    
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>