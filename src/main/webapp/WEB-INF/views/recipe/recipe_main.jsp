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
/* 레시피 페이지 기본 스타일 */
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f9f9f9;
}

.recipe-container {
    max-width: 1200px;
    margin: 30px auto;
    padding: 0 15px;
}

/* 기존 카테고리 네비게이션 스타일은 그대로 */
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

/* 그리드 레이아웃: 기존의 리스트 대신 사용 */
.recipe-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    padding: 15px;
}

.recipe-item {
    /* 한 행에 5개씩 배치 (반응형 필요 시 조정) */
    flex: 0 0 calc(20% - 15px);
    box-sizing: border-box;
}

/* 이미지 영역: 정사각형 비율 유지 */
.recipe-item .image-wrapper {
    position: relative;
    width: 100%;
    padding-top: 100%; /* 1:1 비율 */
}

.recipe-item .image-wrapper a img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 8px;
}

/* 하단 정보 영역 (제목, 조회수, 좋아요) */
.recipe-item .info {
    margin-top: 10px;
    text-align: center;
}

.recipe-item .info a.recipe_read-link {
    color: #333;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.2s;
}

.recipe-item .info a.recipe_read-link:hover {
    color: #e67e22;
}

.recipe-item .info .badge {
    font-size: 0.8rem;
    padding: 5px 8px;
    border-radius: 4px;
    margin-top: 5px;
}

/* 좋아요 배지는 기본 테마색(#e67e22)와 다르게 설정 */
.badge-primary {
    background-color: #e67e22;
    color: white;
}
</style>
</head>
<body>
<!-- 상단 메뉴 부분 (건드리지 않음) -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<!-- 레시피 메인 컨테이너 -->
<div class="recipe-container">
    <!-- 카테고리 네비게이션 (건드리지 않음) -->
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

    <!-- 카테고리 타이틀과 콘텐츠 -->
    <c:choose>
        <c:when test="${theme_index eq '1'}">
            <h2 class="category-title">푸드 카테고리</h2>
            <div class="recipe-grid">
                <c:forEach var="obj" items="${openRecipeList}">
                    <div class="recipe-item">
                        <div class="image-wrapper">
                            <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">
                                <img src="${root}/upload/${obj.openRecipe_picture}" alt="${obj.openRecipe_title}" class="img-thumbnail" />
                            </a>
                        </div>
                        <div class="info">
                            <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title}</a>
                            <div>
                                <span class="badge badge-secondary">
                                    <i class="fas fa-eye"></i> 조회수: ${recipeViewCounts[obj.openRecipe_index] != null ? recipeViewCounts[obj.openRecipe_index] : 0}
                                </span>
                                <span class="badge badge-primary ml-2">
                                    좋아요: ${obj.openRecipe_like}
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
                
        <c:when test="${theme_index eq '2'}">
            <h2 class="category-title">뷰티 카테고리</h2>
            <div class="recipe-grid">
                <c:forEach var="obj" items="${openRecipeList}">
                    <div class="recipe-item">
                        <div class="image-wrapper">
                            <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">
                                <img src="${root}/upload/${obj.openRecipe_picture}" alt="${obj.openRecipe_title}" class="img-thumbnail" />
                            </a>
                        </div>
                        <div class="info">
                            <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title}</a>
                            <div>
                                <span class="badge badge-secondary">
                                    <i class="fas fa-eye"></i> 조회수: ${recipeViewCounts[obj.openRecipe_index] != null ? recipeViewCounts[obj.openRecipe_index] : 0}
                                </span>
                                <span class="badge badge-primary ml-2">
                                    좋아요: ${obj.openRecipe_like}
                                    
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
            
        <c:when test="${theme_index eq '3'}">
            <h2 class="category-title">문구 카테고리</h2>
            <div class="recipe-grid">
                <c:forEach var="obj" items="${openRecipeList}">
                    <div class="recipe-item">
                        <div class="image-wrapper">
                            <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">
                                <img src="${root}/upload/${obj.openRecipe_picture}" alt="${obj.openRecipe_title}" class="img-thumbnail" />
                            </a>
                        </div>
                        <div class="info">
                            <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title}</a>
                            <div>
                                <span class="badge badge-secondary">
                                    <i class="fas fa-eye"></i> 조회수: ${recipeViewCounts[obj.openRecipe_index] != null ? recipeViewCounts[obj.openRecipe_index] : 0}
                                </span>
                                <span class="badge badge-primary ml-2">
                                    좋아요: ${obj.openRecipe_like}
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        
        <c:when test="${theme_index eq '4'}">
            <h2 class="category-title">리빙 카테고리</h2>
            <div class="recipe-grid">
                <c:forEach var="obj" items="${openRecipeList}">
                    <div class="recipe-item">
                        <div class="image-wrapper">
                            <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">
                                <img src="${root}/upload/${obj.openRecipe_picture}" alt="${obj.openRecipe_title}" class="img-thumbnail" />
                            </a>
                        </div>
                        <div class="info">
                            <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title}</a>
                            <div>
                                <span class="badge badge-secondary">
                                    <i class="fas fa-eye"></i> 조회수: ${recipeViewCounts[obj.openRecipe_index] != null ? recipeViewCounts[obj.openRecipe_index] : 0}
                                </span>
                                <span class="badge badge-primary ml-2">
                                    좋아요: ${obj.openRecipe_like}
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        
        <c:when test="${theme_index eq '5'}">
            <h2 class="category-title">패션 카테고리</h2>
            <div class="recipe-grid">
                <c:forEach var="obj" items="${openRecipeList}">
                    <div class="recipe-item">
                        <div class="image-wrapper">
                            <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">
                                <img src="${root}/upload/${obj.openRecipe_picture}" alt="${obj.openRecipe_title}" class="img-thumbnail" />
                            </a>
                        </div>
                        <div class="info">
                            <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title}</a>
                            <div>
                                <span class="badge badge-secondary">
                                    <i class="fas fa-eye"></i> 조회수: ${recipeViewCounts[obj.openRecipe_index] != null ? recipeViewCounts[obj.openRecipe_index] : 0}
                                </span>
                                <span class="badge badge-primary ml-2">
                                    좋아요: ${obj.openRecipe_like}
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
                        
        <c:otherwise>
            <h2 class="category-title">모든 항목 최고 좋아요 카테고리</h2>
            <div class="recipe-grid">
                <c:forEach var="obj" items="${allRecipeList}">
                    <div class="recipe-item">
                        <div class="image-wrapper">
                            <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">
                                <img src="${root}/upload/${obj.openRecipe_picture}" alt="${obj.openRecipe_title}" class="img-thumbnail" />
                            </a>
                        </div>
                        <div class="info">
                            <a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title}</a>
                            <div>
                                <span class="badge badge-secondary">
                                    <i class="fas fa-eye"></i> 조회수: ${recipeViewCounts[obj.openRecipe_index] != null ? recipeViewCounts[obj.openRecipe_index] : 0}
                                </span>
                                <span class="badge badge-primary ml-2">
                                    좋아요: ${obj.openRecipe_like}
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- 페이지네이션 - PC 버전 (건드리지 않음) -->
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
    
    <!-- 페이지네이션 - 모바일 버전 (건드리지 않음) -->
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

    <!-- 글쓰기 버튼 (건드리지 않음) -->
    <a href="${root}/recipe/recipe_write" class="btn btn-write">
        <i class="fas fa-pencil-alt"></i> 글쓰기
    </a>
    
    <div style="clear: both;"></div>
</div>

<!-- 게시판 하단 부분 (건드리지 않음) -->
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
