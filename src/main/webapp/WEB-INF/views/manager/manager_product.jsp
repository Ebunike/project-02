<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상품 관리</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<!-- 네이버 폰트 -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGaRamYeonGgoc.css" rel="stylesheet">
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
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .page-header h2 {
        font-size: 24px;
        font-weight: 500;
        color: #333;
        margin: 0;
    }
    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
        border-radius: 5px;
        padding: 8px 16px;
        font-weight: 500;
        transition: all 0.2s ease;
    }
    .btn-primary:hover {
        background-color: #0069d9;
        border-color: #0062cc;
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
    .btn-edit {
        background-color: #28a745;
        color: white;
        padding: 5px 12px;
        border-radius: 4px;
        font-size: 13px;
        transition: all 0.2s ease;
        margin-right: 5px;
        border: none;
        display: inline-block;
    }
    .btn-edit:hover {
        background-color: #218838;
        color: white;
        text-decoration: none;
    }
    .btn-delete {
        background-color: #dc3545;
        color: white;
        padding: 5px 12px;
        border-radius: 4px;
        font-size: 13px;
        transition: all 0.2s ease;
        border: none;
        display: inline-block;
    }
    .btn-delete:hover {
        background-color: #c82333;
        color: white;
        text-decoration: none;
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
            <h2>상품 관리</h2>
            <a href="${root}/item/kit/insert_kit?kit=1" class="btn btn-primary"><i class="fas fa-plus mr-2"></i>상품 등록</a>
        </div>
        
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h3>상품 목록</h3>
                <div class="search-form">
                    <form class="form-inline">
                        <div class="form-group mr-2">
                            <select class="form-control">
                                <option>전체</option>
                                <option>재고 있음</option>
                                <option>재고 없음</option>
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
                            <th width="7%">번호</th>
                            <th width="30%">상품 이름</th>
                            <th width="15%">재고량</th>
                            <th width="15%">판매 가격</th>
                            <th width="18%">등록일</th>
                            <th width="15%">관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${itemList}">
                            <tr>
                                <td>${item.item_index}</td>
                                <td><a href="">${item.item_name}</a></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.item_quantity > 0}">${item.item_quantity}</c:when>
                                        <c:otherwise><span class="text-danger">품절</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${item.item_price}원</td>
                                <td>-</td>
                                <td>
                                    <a href="${root}/manager/edit_product?id=${item.item_index}" class="btn-edit">수정 </a>
									<a href="javascript:void(0);" onclick="confirmDelete(${item.item_index})" class="btn-delete">삭제</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="card-footer">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item">
                            <a class="page-link" href="#"><i class="fas fa-angle-left"></i></a>
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
    
    <!-- JavaScript for delete confirmation -->
    <script>
        function confirmDelete(productId) {
            if (confirm('정말로 이 상품을 삭제하시겠습니까?')) {
                window.location.href = '${root}/manager/delete_product?id=' + productId;
            }
        }
    </script>
    
    <!-- 게시판 하단 부분 -->    
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>