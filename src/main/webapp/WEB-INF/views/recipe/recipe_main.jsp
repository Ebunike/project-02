<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value='${pageContext.request.contextPath}'/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<title>DDuk Bae Gi - 레시피</title>

<!-- Font Awesome 아이콘 라이브러리 -->
<script src="https://kit.fontawesome.com/516da99189.js" crossorigin="anonymous"></script>

<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<!-- Google Fonts - 구글 웹폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<!-- 네이버 폰트 - 나눔손글씨 폰트 -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGaRamYeonGgoc.css" rel="stylesheet">

<!-- 외부 CSS 파일 링크 -->
<link rel="stylesheet" href="${root}/css/main.css" />

<style>
/* 레시피 페이지 스타일 */
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f9f9f9;
}

.recipe-container {
    max-width: 1200px;
    margin: 30px auto;
    padding: 0 15px;
}

.category-nav {
    display: flex;
    justify-content: center;
    margin: 20px 0;
    padding-bottom: 15px;
    flex-wrap: wrap;
}

.category-nav a {
    display: inline-block;
    margin: 5px 10px;
    padding: 8px 20px;
    color: #e67e22;
    font-weight: 500;
    text-decoration: none;
    transition: all 0.3s ease;
    border-radius: 5px;
    background-color: #f0f0f0;
}

.category-nav a:hover, .category-nav a.active {
    background-color: #e67e22;
    color: white;
}

.category-title {
    text-align: center;
    margin: 20px 0;
    font-weight: 700;
    color: #333;
    font-family: 'NanumGaRamYeonGgoc', cursive;
}

.recipe-list {
    list-style-type: none;
    padding: 0;
    margin: 0;
}

.recipe-list .recipe_list1 {
    margin-bottom: 15px;
    padding: 15px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    display: flex;
    align-items: center;
}

.recipe-list .recipe_list1 img {
    width: 120px;
    height: 120px;
    object-fit: cover;
    border-radius: 8px;
    margin-right: 15px;
}

.recipe-list .recipe_list1 a.recipe_read-link {
    color: #333;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.2s;
}

.recipe-list .recipe_list1 a.recipe_read-link:hover {
    color: #f8b400;
}

.pagination {
    margin: 30px 0;
}

.pagination .page-link {
    color: #555;
    background-color: #fff;
    border: 1px solid #ddd;
    margin: 0 3px;
    border-radius: 4px;
    transition: all 0.3s ease;
}

.pagination .page-link:hover {
    background-color: #f8b400;
    color: white;
    border-color: #f8b400;
}

.btn-write {
    background-color: #e67e22;
    color: white;
    border: none;
    padding: 8px 20px;
    border-radius: 5px;
    margin-top: 20px;
    transition: all 0.3s ease;
    float: right;
}

.btn-write:hover {
    background-color: #e67e22;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

@media (max-width: 768px) {
    .recipe-list .recipe_list1 {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .recipe-list .recipe_list1 img {
        width: 100%;
        height: 180px;
        margin-right: 0;
        margin-bottom: 10px;
    }
}
</style>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<!-- 레시피 메인 컨테이너 -->
<div class="recipe-container">
    <!-- 카테고리 네비게이션 -->
    <div class="category-nav">
        <a href="${root}/recipe/recipe_main?theme_index=1" class="${theme_index eq '1' ? 'active' : ''}">
            <i class="fas fa-utensils"></i> 푸드
        </a>
        <a href="${root}/recipe/recipe_main?theme_index=2" class="${theme_index eq '2' ? 'active' : ''}">
            <i class="fas fa-spa"></i> 뷰티
        </a>
        <a href="${root}/recipe/recipe_main?theme_index=3" class="${theme_index eq '3' ? 'active' : ''}">
            <i class="fas fa-pencil-alt"></i> 문구
        </a>
        <a href="${root}/recipe/recipe_main?theme_index=4" class="${theme_index eq '4' ? 'active' : ''}">
            <i class="fas fa-home"></i> 리빙
        </a>
        <a href="${root}/recipe/recipe_main?theme_index=5" class="${theme_index eq '5' ? 'active' : ''}">
            <i class="fas fa-tshirt"></i> 패션
        </a>
    </div>

    <!-- 카테고리 타이틀 -->
    <c:choose>
        <c:when test="${theme_index eq '1'}">
            <h2 class="category-title">푸드 카테고리</h2>
            <ul class="recipe-list">
                <c:forEach var="obj" items="${openRecipeList}">
                    <li class="recipe_list1">
                        <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">
                            <img src="${root}/upload/${obj.openRecipe_picture}" alt="${obj.openRecipe_title}" />
                        </a>
                        <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title}</a>
                    </li>
                </c:forEach>
            </ul>
        </c:when>
        
        <c:when test="${theme_index eq '2'}">
            <h2 class="category-title">뷰티 카테고리</h2>
            <ul class="recipe-list">
                <c:forEach var="obj" items="${openRecipeList}">
                    <li class="recipe_list1">
                        <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title}</a>
                    </li>
                </c:forEach>
            </ul>
        </c:when>
        
        <c:when test="${theme_index eq '3'}">
            <h2 class="category-title">문구 카테고리</h2>
            <ul class="recipe-list">
                <c:forEach var="obj" items="${openRecipeList}">
                    <li class="recipe_list1">
                        <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title}</a>
                    </li>
                </c:forEach>
            </ul>
        </c:when>
        
        <c:when test="${theme_index eq '4'}">
            <h2 class="category-title">리빙 카테고리</h2>
            <ul class="recipe-list">
                <c:forEach var="obj" items="${openRecipeList}">
                    <li class="recipe_list1">
                        <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title}</a>
                    </li>
                </c:forEach>
            </ul>
        </c:when>
        
        <c:when test="${theme_index eq '5'}">
            <h2 class="category-title">패션 카테고리</h2>
            <ul class="recipe-list">
                <c:forEach var="obj" items="${openRecipeList}">
                    <li class="recipe_list1">
                        <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title}</a>
                    </li>
                </c:forEach>
            </ul>
        </c:when>
                    
        <c:otherwise>
            <h2 class="category-title">모든 항목 최고 좋아요 카테고리</h2>
            <ul class="recipe-list">
                <c:forEach var="obj" items="${allRecipeList}">
                    <li class="recipe_list1">
                        <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title}</a>
                    </li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>

    <!-- 페이지네이션 - PC 버전 -->
    <div class="d-none d-md-block">
        <ul class="pagination justify-content-center">
            <c:choose>
                <c:when test="${pageBean.prevPage <= 0}">
                    <li class="page-item disabled">
                        <a href="#" class="page-link">이전</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item">
                        <a href="${root}/recipe/recipe_main?theme_index=${theme_index}&page=${pageBean.prevPage}" 
                        class="page-link">이전</a>
                    </li>
                </c:otherwise>
            </c:choose>
            
            <c:forEach var="idx" begin="${pageBean.min}" end="${pageBean.max}">
                <li class="page-item ${pageBean.currentPage == idx ? 'active' : ''}">
                    <a href="${root}/recipe/recipe_main?theme_index=${theme_index}&page=${idx}" 
                    class="page-link">${idx}</a>
                </li>
            </c:forEach>
            
            <c:choose>
                <c:when test="${pageBean.max >= pageBean.pageCnt}">
                    <li class="page-item disabled">
                        <a href="#" class="page-link">다음</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item">
                        <a href="${root}/recipe/recipe_main?theme_index=${theme_index}&page=${pageBean.nextPage}" 
                        class="page-link">다음</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
    
    <!-- 페이지네이션 - 모바일 버전 -->
    <div class="d-block d-md-none">
        <ul class="pagination justify-content-center">
            <c:choose>
                <c:when test="${pageBean.prevPage <= 0}">
                    <li class="page-item disabled">
                        <a href="#" class="page-link">이전</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item">
                        <a href="${root}/recipe/recipe_main?theme_index=${theme_index}&page=${pageBean.prevPage}" 
                        class="page-link">이전</a>
                    </li>
                </c:otherwise>
            </c:choose>
            
            <c:choose>
                <c:when test="${pageBean.max >= pageBean.pageCnt}">
                    <li class="page-item disabled">
                        <a href="#" class="page-link">다음</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item">
                        <a href="${root}/recipe/recipe_main?theme_index=${theme_index}&page=${pageBean.nextPage}" 
                        class="page-link">다음</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>

    <!-- 글쓰기 버튼 -->
    <a href="${root}/recipe/recipe_write" class="btn btn-write">
        <i class="fas fa-pencil-alt"></i> 글쓰기
    </a>
    
    <div style="clear: both;"></div>
</div>

<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

<script>
    // 현재 활성화된 카테고리 강조
    $(document).ready(function() {
        $('.category-nav a').each(function() {
            var href = $(this).attr('href');
            if(href.indexOf('theme_index=${theme_index}') > -1) {
                $(this).addClass('active');
            }
        });
    });
</script>
</body>
</html>