<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  <!-- fn 라이브러리 추가 -->
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>검색 결과</title>
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
    <!-- Swiper CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        
        .container {
            padding: 30px;
        }

        .search-results-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .search-results-header h5 {
            font-size: 1.8em;
            color: #343a40;
        }

        .search-results-header p {
            font-size: 1.2em;
            color: #6c757d;
        }

        .result-item {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            padding: 20px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .result-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .result-item h6 {
            font-size: 1.5em;
            color: #007bff;
            margin-bottom: 10px;
        }

        .result-item p {
            font-size: 1.1em;
            color: #495057;
        }

        .section-title {
            font-size: 1.6em;
            color: #343a40;
            border-bottom: 2px solid #007bff;
            padding-bottom: 5px;
            margin-bottom: 20px;
        }

    </style>
</head>
<body>

    <!-- 상단 메뉴 부분 -->
    <c:import url="/WEB-INF/views/include/top_menu.jsp" />
    
    <div class="container">
        <!-- 검색결과 헤더 -->
        <div class="search-results-header">
            <h5>검색 결과</h5>
            <!-- 검색된 항목 수 동적 출력 -->
            <p>총 
                <!-- Oneday, Kit, OpenRecipe 항목 개수를 합산 -->
                ${fn:length(oneday) + fn:length(kit) + fn:length(openrecipe)}개 항목이 검색되었습니다.
            </p>
        </div>

        <!-- Oneday List 출력 -->
        <div class="section-title">Oneday 검색 결과</div>
        <c:choose>
            <c:when test="${not empty oneday}">
                <c:forEach var="item" items="${oneday}">
                    <div class="result-item">
                        <a href="${root}/oneday/detail/${item.oneday_id}">
                            <h6>${item.oneday_name}</h6>  <!-- 제목 출력 -->
                        </a>
                        <p>${item.oneday_info}</p>  <!-- 내용 출력 -->
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>검색 결과가 없습니다.</p>
            </c:otherwise>
        </c:choose>

        <!-- Kit List 출력 -->
        <div class="section-title">Kit 검색 결과</div>
        <c:choose>
            <c:when test="${not empty kit}">
                <c:forEach var="item" items="${kit}">
                    <div class="result-item">
                        <a href="${root}/item/kit/kit_detail?item_index=${item.item_index}">
                            <h6>${item.item_name}</h6>  <!-- 제목 출력 -->
                        </a>
                        <p>${item.item_info}</p>  <!-- 설명 출력 -->
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>검색 결과가 없습니다.</p>
            </c:otherwise>
        </c:choose>

        <!-- OpenRecipe List 출력 -->
        <div class="section-title">OpenRecipe 검색 결과</div>
        <c:choose>
            <c:when test="${not empty openrecipe}">
                <c:forEach var="item" items="${openrecipe}">
                    <div class="result-item">
                        <a href="${root}/recipe/recipe_read?openRecipe_index=${item.openRecipe_index}">
                            <h6>${item.openRecipe_title}</h6>  <!-- 제목 출력 -->
                        </a>
                        <p>${item.openRecipe_intro}</p>  <!-- 내용 출력 -->
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>검색 결과가 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 게시판 하단 부분 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>
