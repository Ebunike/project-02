<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        /* 전체 페이지 스타일 */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }
        
        .board-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            background-color: #fff;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .board-header h2 {
            margin: 0;
            font-size: 1.8rem;
            color: #333;
        }
        
        .board-actions {
            display: flex;
            gap: 10px;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        
        .btn-secondary {
            background-color: #f0f0f0;
            color: #333;
        }
        
        .btn:hover {
            opacity: 0.9;
        }
        
        /* 카테고리 필터 */
        .category-filter {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            overflow-x: auto;
            padding-bottom: 10px;
        }
        
        .category-filter button {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 30px;
            padding: 8px 16px;
            cursor: pointer;
            white-space: nowrap;
            transition: all 0.3s;
        }
        
        .category-filter button:hover {
            background-color: #f5f5f5;
        }
        
        .category-filter button.active {
            background-color: #4CAF50;
            color: white;
            border-color: #4CAF50;
        }
        
        /* 검색 폼 */
        .search-form {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .search-form select, .search-form input {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .search-form input {
            flex-grow: 1;
        }
        
        /* 게시글 목록 */
        .board-list {
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .board-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .board-table th, .board-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .board-table th {
            background-color: #f9f9f9;
            font-weight: 600;
        }
        
        .board-table tr:last-child td {
            border-bottom: none;
        }
        
        .board-table tr:hover {
            background-color: #f5f5f5;
        }
        
        .title-link {
            color: #333;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .title-link:hover {
            color: #4CAF50;
        }
        
        .category-badge {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 12px;
            margin-right: 8px;
            background-color: #e0f2e0;
            color: #4CAF50;
        }
        
        .category-lifestyle {
            background-color: #e0f2e0;
            color: #4CAF50;
        }
        
        .category-craft {
            background-color: #e0f2f2;
            color: #00BCD4;
        }
        
        .category-food {
            background-color: #fff0e0;
            color: #FF9800;
        }
        
        .category-fashion {
            background-color: #f2e0f2;
            color: #9C27B0;
        }
        
        .category-beauty {
            background-color: #ffe0e0;
            color: #F44336;
        }
        
        .participants-info {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 14px;
        }
        
        .participants-info i {
            color: #4CAF50;
        }
        
        .participants-full {
            color: #F44336;
        }
        
        /* 페이지네이션 */
        .pagination {
            display: flex;
            justify-content: center;
            list-style: none;
            padding: 0;
            margin: 30px 0 0;
        }
        
        .pagination li {
            margin: 0 5px;
        }
        
        .pagination a {
            display: block;
            padding: 8px 12px;
            background-color: #fff;
            border: 1px solid #ddd;
            color: #333;
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.3s;
        }
        
        .pagination a:hover {
            background-color: #f5f5f5;
        }
        
        .pagination .active a {
            background-color: #4CAF50;
            color: white;
            border-color: #4CAF50;
        }
        
        /* 반응형 테이블 */
        @media (max-width: 768px) {
            .board-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .board-actions {
                width: 100%;
            }
            
            .board-table thead {
                display: none;
            }
            
            .board-table, .board-table tbody, .board-table tr, .board-table td {
                display: block;
                width: 100%;
            }
            
            .board-table tr {
                margin-bottom: 15px;
                border-bottom: 1px solid #ddd;
            }
            
            .board-table td {
                text-align: right;
                padding: 8px 10px;
                border-bottom: 1px solid #eee;
                position: relative;
            }
            
            .board-table td:last-child {
                border-bottom: none;
            }
            
            .board-table td:before {
                content: attr(data-label);
                font-weight: bold;
                float: left;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/header.jsp"/>
    
    <div class="container">
        <div class="board-header">
            <h2>게시판</h2>
            <div class="board-actions">
                <a href="${pageContext.request.contextPath}/board/write" class="btn btn-primary">
                    <i class="fas fa-edit"></i> 글쓰기
                </a>
            </div>
        </div>
        
        <!-- 카테고리 필터 -->
        <div class="category-filter">
            <button class="active" data-category="all">전체</button>
            <button data-category="lifestyle">라이프스타일</button>
            <button data-category="craft">수공예</button>
            <button data-category="food">푸드</button>
            <button data-category="fashion">패션</button>
            <button data-category="beauty">뷰티</button>
        </div>
        
        <!-- 검색 폼 -->
        <form class="search-form" action="${pageContext.request.contextPath}/board/main" method="get">
            <select name="searchType">
<option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
                <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
                <option value="writer" ${searchType == 'writer' ? 'selected' : ''}>작성자</option>
                <option value="all" ${searchType == 'all' ? 'selected' : ''}>전체</option>
            </select>
            <input type="text" name="keyword" value="${keyword}" placeholder="검색어를 입력하세요">
            <button type="submit" class="btn btn-secondary">
                <i class="fas fa-search"></i> 검색
            </button>
        </form>
        
        <!-- 게시글 목록 -->
        <div class="board-list">
            <table class="board-table">
                <thead>
                    <tr>
                        <th width="10%">번호</th>
                        <th width="45%">제목</th>
                        <th width="15%">작성자</th>
                        <th width="15%">작성일</th>
                        <th width="15%">참여 현황</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty posts}">
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 50px 0;">
                                <i class="fas fa-exclamation-circle" style="font-size: 24px; color: #ccc; margin-bottom: 10px;"></i>
                                <p style="margin: 0; color: #888;">게시글이 없습니다.</p>
                            </td>
                        </tr>
                    </c:if>
                    
                    <c:forEach var="post" items="${posts}">
                        <tr>
                            <td data-label="번호">${post.id}</td>
                            <td data-label="제목">
                                <c:if test="${post.markerType != null}">
                                    <span class="category-badge category-${post.markerType}">
                                        <c:choose>
                                            <c:when test="${post.markerType == 'lifestyle'}">라이프스타일</c:when>
                                            <c:when test="${post.markerType == 'craft'}">수공예</c:when>
                                            <c:when test="${post.markerType == 'food'}">푸드</c:when>
                                            <c:when test="${post.markerType == 'fashion'}">패션</c:when>
                                            <c:when test="${post.markerType == 'beauty'}">뷰티</c:when>
                                            <c:otherwise>기타</c:otherwise>
                                        </c:choose>
                                    </span>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/board/read?id=${post.id}" class="title-link">
                                    ${post.title}
                                </a>
                            </td>
                            <td data-label="작성자">${post.writerName}</td>
                            <td data-label="작성일">
                                <fmt:formatDate value="${post.regdate}" pattern="yyyy-MM-dd"/>
                            </td>
                            <td data-label="참여 현황">
                                <div class="participants-info ${post.currentParticipants >= post.maxParticipants ? 'participants-full' : ''}">
                                    <i class="fas fa-users"></i>
                                    <span>${post.currentParticipants} / ${post.maxParticipants}</span>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- 페이지네이션 -->
        <c:if test="${not empty posts}">
            <ul class="pagination">
                <c:if test="${currentPage > 1}">
                    <li><a href="?page=${currentPage - 1}&searchType=${searchType}&keyword=${keyword}"><i class="fas fa-chevron-left"></i></a></li>
                </c:if>
                
                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                    <li class="${pageNum == currentPage ? 'active' : ''}">
                        <a href="?page=${pageNum}&searchType=${searchType}&keyword=${keyword}">${pageNum}</a>
                    </li>
                </c:forEach>
                
                <c:if test="${currentPage < totalPages}">
                    <li><a href="?page=${currentPage + 1}&searchType=${searchType}&keyword=${keyword}"><i class="fas fa-chevron-right"></i></a></li>
                </c:if>
            </ul>
        </c:if>
    </div>
    
    <jsp:include page="/WEB-INF/views/include/footer.jsp"/>
    
    <script>
        $(document).ready(function() {
            // 카테고리 필터링
            $('.category-filter button').click(function() {
                const category = $(this).data('category');
                
                // 버튼 활성화 상태 변경
                $('.category-filter button').removeClass('active');
                $(this).addClass('active');
                
                // 페이지 이동 또는 AJAX 요청
                if (category === 'all') {
                    window.location.href = '${pageContext.request.contextPath}/board/main';
                } else {
                    window.location.href = '${pageContext.request.contextPath}/board/main?category=' + category;
                }
            });
            
            // 현재 카테고리 하이라이트
            if ('${category}') {
                $('.category-filter button').removeClass('active');
                $(`.category-filter button[data-category="${category}"]`).addClass('active');
            }
        });
    </script>
</body>
</html>