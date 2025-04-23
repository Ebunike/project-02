<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${categoryName} 관련 게시글</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <style>
        .category-title {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #03c75a;
            color: #333;
        }
        
        .post-list {
            list-style-type: none;
            padding: 0;
        }
        
        .post-item {
            padding: 15px;
            margin-bottom: 15px;
            border: 1px solid #eee;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        
        .post-item:hover {
            background-color: #f9f9f9;
        }
        
        .post-title a {
            color: #333;
            font-weight: bold;
            text-decoration: none;
            font-size: 1.1em;
        }
        
        .post-title a:hover {
            color: #03c75a;
        }
        
        .post-meta {
            margin-top: 5px;
            font-size: 0.9em;
            color: #666;
            display: flex;
            justify-content: space-between;
        }
        
        .post-participation {
            margin-top: 10px;
            font-size: 0.9em;
            color: #03c75a;
        }
        
        .progress-bar-container {
            width: 100%;
            height: 5px;
            background-color: #e0e0e0;
            border-radius: 2px;
            margin-top: 5px;
        }
        
        .progress-bar {
            height: 100%;
            background-color: #03c75a;
            border-radius: 2px;
        }
        
        .no-posts {
            padding: 30px;
            text-align: center;
            color: #888;
            background-color: #f9f9f9;
            border-radius: 4px;
        }
        
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 8px 16px;
            background-color: #03c75a;
            color: white;
            border-radius: 4px;
            text-decoration: none;
        }
        
        .back-btn:hover {
            background-color: #02ad4e;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/header.jsp"/>
    <main>
        <div class="container">
            <h2 class="category-title">${categoryName} 관련 게시글</h2>
            
            <c:if test="${empty posts}">
                <div class="no-posts">
                    해당 카테고리의 게시글이 없습니다.
                </div>
            </c:if>
            
            <c:if test="${not empty posts}">
                <ul class="post-list">
                    <c:forEach var="post" items="${posts}">
                        <li class="post-item">
                            <div class="post-title">
                                <a href="${pageContext.request.contextPath}/board/read?id=${post.id}">${post.title}</a>
                            </div>
                            <div class="post-meta">
                                <span>작성자: ${post.writer_id}</span>
                                <span>등록일: <fmt:formatDate value="${post.regdate}" pattern="yyyy-MM-dd"/></span>
                            </div>
                            <div class="post-participation">
                                참여자: ${post.currentParticipants}/${post.maxParticipants}
                                <div class="progress-bar-container">
                                    <div class="progress-bar" style="width: ${(post.currentParticipants / post.maxParticipants) * 100}%;"></div>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
            
            <a href="${pageContext.request.contextPath}/kakaomap/main" class="back-btn">지도로 돌아가기</a>
        </div>
    </main>
    <%-- <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>
</body>
</html>