<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-color: #6366f1;
            --primary-light: #818cf8;
            --primary-dark: #4f46e5;
            --secondary-color: #f97316;
            --bg-color: #f9fafb;
            --text-color: #1f2937;
            --text-light: #6b7280;
            --border-radius: 12px;
            --box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
            --hover-shadow: 0 20px 30px -10px rgba(0, 0, 0, 0.1);
            --card-bg: #ffffff;
        }
        
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: var(--bg-color);
            margin: 0;
            padding: 0;
            color: var(--text-color);
            line-height: 1.6;
        }
        
        .search-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
        }
        
        .search-header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
        }
        
        .search-header:before {
            content: "";
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }
        
        .search-header h2 {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-dark);
            margin-bottom: 10px;
        }
        
        .search-header p {
            font-size: 1.1rem;
            color: var(--text-light);
            margin-bottom: 0;
        }
        
        .search-highlight {
            background: linear-gradient(120deg, rgba(99, 102, 241, 0.2) 0%, rgba(249, 115, 22, 0.2) 100%);
            padding: 2px 8px;
            border-radius: 4px;
            font-weight: 500;
        }
        
        .section-container {
            margin-bottom: 40px;
            animation: fadeIn 0.5s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .section-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e5e7eb;
            position: relative;
        }
        
        .section-header:after {
            content: "";
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 120px;
            height: 2px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        }
        
        .section-header h3 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-color);
            margin-bottom: 0;
            display: flex;
            align-items: center;
        }
        
        .section-header .section-icon {
            width: 34px;
            height: 34px;
            background: linear-gradient(135deg, var(--primary-light), var(--primary-color));
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            margin-right: 12px;
            color: white;
            box-shadow: 0 3px 8px rgba(99, 102, 241, 0.2);
        }
        
        .section-header .count-badge {
            background-color: var(--primary-light);
            color: white;
            font-size: 0.85rem;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 20px;
            margin-left: 12px;
        }
        
        .result-card {
            background-color: var(--card-bg);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin-bottom: 20px;
            padding: 25px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(229, 231, 235, 0.5);
        }
        
        .result-card:hover {
            box-shadow: var(--hover-shadow);
            border-color: var(--primary-light);
        }
        
        .result-card:before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: linear-gradient(to bottom, var(--primary-color), var(--secondary-color));
            border-radius: 2px 0 0 2px;
        }
        
        .result-card .card-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--primary-dark);
            margin-bottom: 15px;
            transition: color 0.2s ease;
            display: block;
            text-decoration: none;
        }
        
        .result-card .card-title:hover {
            color: var(--secondary-color);
        }
        
        .result-card .card-description {
            font-size: 1rem;
            color: var(--text-light);
            margin-bottom: 0;
            line-height: 1.6;
        }
        
        .no-results {
            background-color: rgba(99, 102, 241, 0.05);
            padding: 20px;
            border-radius: var(--border-radius);
            text-align: center;
            border: 1px dashed var(--primary-light);
        }
        
        .no-results p {
            font-size: 1.1rem;
            color: var(--text-light);
            margin-bottom: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .no-results i {
            font-size: 1.3rem;
            margin-right: 10px;
            color: var(--primary-light);
        }
        
        /* 카테고리별 아이콘 색상 */
        .oneday-icon {
            background: linear-gradient(135deg, #60a5fa, #3b82f6);
        }
        
        .kit-icon {
            background: linear-gradient(135deg, #a78bfa, #8b5cf6);
        }
        
        .recipe-icon {
            background: linear-gradient(135deg, #fb923c, #f97316);
        }
        
        /* 반응형 조정 */
        @media (max-width: 768px) {
            .search-header h2 {
                font-size: 2rem;
            }
            
            .result-card {
                padding: 20px;
            }
            
            .section-header h3 {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>

    <!-- 상단 메뉴 부분 -->
    <c:import url="/WEB-INF/views/include/top_menu.jsp" />
    
    <div class="search-container">
        <!-- 검색결과 헤더 -->
        <div class="search-header">
            <h2>검색 결과</h2>
            <p>총 <span class="search-highlight">${fn:length(oneday) + fn:length(kit) + fn:length(openrecipe)}개</span> 항목이 검색되었습니다.</p>
        </div>

        <!-- Oneday List 출력 -->
        <div class="section-container">
            <div class="section-header">
                <div class="section-icon oneday-icon">
                    <i class="fas fa-calendar-day"></i>
                </div>
                <h3>Oneday 클래스 검색 결과
                    <span class="count-badge">${fn:length(oneday)}</span>
                </h3>
            </div>
            <c:choose>
                <c:when test="${not empty oneday}">
                    <c:forEach var="item" items="${oneday}">
                        <div class="result-card">
                            <a href="${root}/oneday/detail/${item.oneday_id}" class="card-title">
                                ${item.oneday_name}
                            </a>
                            <p class="card-description">${item.oneday_info}</p>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-results">
                        <p><i class="fas fa-search"></i> 검색 결과가 없습니다.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Kit List 출력 -->
        <div class="section-container">
            <div class="section-header">
                <div class="section-icon kit-icon">
                    <i class="fas fa-box-open"></i>
                </div>
                <h3>쇼핑 검색 결과
                    <span class="count-badge">${fn:length(kit)}</span>
                </h3>
            </div>
            <c:choose>
                <c:when test="${not empty kit}">
                    <c:forEach var="item" items="${kit}">
                        <div class="result-card">
                            <a href="${root}/item/kit/kit_detail?item_index=${item.item_index}" class="card-title">
                                ${item.item_name}
                            </a>
                            <p class="card-description">${item.item_info}</p>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-results">
                        <p><i class="fas fa-search"></i> 검색 결과가 없습니다.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- OpenRecipe List 출력 -->
        <div class="section-container">
            <div class="section-header">
                <div class="section-icon recipe-icon">
                    <i class="fas fa-utensils"></i>
                </div>
                <h3>Open Recipe 검색 결과
                    <span class="count-badge">${fn:length(openrecipe)}</span>
                </h3>
            </div>
            <c:choose>
                <c:when test="${not empty openrecipe}">
                    <c:forEach var="item" items="${openrecipe}">
                        <div class="result-card">
                            <a href="${root}/recipe/recipe_read?openRecipe_index=${item.openRecipe_index}" class="card-title">
                                ${item.openRecipe_title}
                            </a>
                            <p class="card-description">${item.openRecipe_intro}</p>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-results">
                        <p><i class="fas fa-search"></i> 검색 결과가 없습니다.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 게시판 하단 부분 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>