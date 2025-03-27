<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value='${pageContext.request.contextPath }'/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${readRecipeBean.openRecipe_title} - 레시피</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        color: #333;
        background-color: #f5f5f5;
    }
    .container-recipe {
        background-color: white;
        padding: 0;
        max-width: 960px;
        margin: 20px auto;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        border-radius: 4px;
    }
    .recipe-header {
        padding: 30px 20px;
        border-bottom: 1px solid #ddd;
    }
    .recipe-title {
        font-size: 28px;
        font-weight: 700;
        color: #333;
        margin-bottom: 10px;
    }
    .recipe-user-info {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
        color: #666;
        font-size: 14px;
    }
    .recipe-user-info img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        margin-right: 10px;
    }
    .recipe-intro {
        font-size: 16px;
        line-height: 1.6;
        color: #666;
        margin-bottom: 15px;
    }
    .recipe-stats {
        display: flex;
        color: #74b243;
        font-size: 14px;
        margin-top: 15px;
    }
    .recipe-stats span {
        margin-right: 20px;
        display: flex;
        align-items: center;
    }
    .recipe-stats i {
        margin-right: 5px;
    }
    .recipe-sections {
        padding: 0 20px;
    }
    .recipe-section {
        padding: 30px 0;
        border-bottom: 1px solid #eee;
    }
    .section-title {
        font-size: 20px;
        font-weight: 700;
        color: #333;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
    }
    .section-title::before {
        content: '';
        width: 4px;
        height: 20px;
        background-color: #74b243;
        margin-right: 10px;
        display: inline-block;
    }
    .recipe-ingredients {
        background-color: #f9f9f9;
        padding: 20px;
        border-radius: 4px;
    }
    .ingredient-item {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
        padding-bottom: 10px;
        border-bottom: 1px dashed #ddd;
    }
    .ingredient-item:last-child {
        border-bottom: none;
    }
    .ingredient-name {
        font-weight: 500;
    }
    .ingredient-amount {
        color: #666;
    }
    .recipe-thumbnail {
        width: 100%;
        max-height: 400px;
        object-fit: cover;
        margin-bottom: 30px;
    }
    .cooking-steps {
        counter-reset: step-counter;
    }
    .step-box {
        margin-bottom: 40px;
        padding-bottom: 40px;
        border-bottom: 1px dashed #ddd;
        position: relative;
        display: flex;
        flex-direction: column;
    }
    .step-box:last-child {
        border-bottom: none;
    }
    .step-number {
        position: absolute;
        left: -40px;
        top: 0;
        width: 30px;
        height: 30px;
        background-color: #74b243;
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
    }
    .step-text {
        font-size: 16px;
        line-height: 1.7;
        color: #333;
        margin-bottom: 15px;
    }
    .step-image {
        width: 100%;
        border-radius: 4px;
    }
    .action-buttons {
        padding: 20px;
        display: flex;
        justify-content: space-between;
        border-top: 1px solid #eee;
    }
    .btn-like {
        background-color: #ff6b6b;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 4px;
        font-weight: 500;
        display: flex;
        align-items: center;
    }
    .btn-like.disabled {
        background-color: #ccc;
    }
    .btn-like i {
        margin-right: 8px;
    }
    .btn-action {
        background-color: #f8f9fa;
        color: #333;
        border: 1px solid #ddd;
        padding: 8px 15px;
        margin-left: 10px;
        border-radius: 4px;
        font-size: 14px;
    }
    .btn-primary {
        background-color: #74b243;
        border-color: #74b243;
    }
    .btn-info {
        background-color: #4dabf7;
        border-color: #4dabf7;
        color: white;
    }
    .btn-danger {
        background-color: #ff6b6b;
        border-color: #ff6b6b;
    }
    .buy-button {
        background-color: #ff922b;
        color: white;
        border: none;
        padding: 12px 25px;
        border-radius: 4px;
        font-weight: 700;
        font-size: 16px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-top: 20px;
    }
    .buy-button i {
        margin-right: 10px;
    }
    .recipe-complete-image {
        position: relative;
        margin-bottom: 30px;
    }
    .recipe-complete-image img {
        width: 100%;
        border-radius: 4px;
    }
    .recipe-info-box {
        background-color: #f9f9f9;
        padding: 20px;
        border-radius: 4px;
        margin-top: 20px;
    }
    .recipe-info-title {
        font-weight: 700;
        font-size: 16px;
        margin-bottom: 10px;
        color: #333;
    }
    .recipe-info-content {
        font-size: 14px;
        line-height: 1.6;
        color: #666;
    }
    @media (max-width: 768px) {
        .recipe-title {
            font-size: 22px;
        }
        .recipe-sections {
            padding: 0 15px;
        }
        .step-number {
            position: static;
            margin-bottom: 10px;
        }
    }
</style>
</head>
<body>

<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<!-- 레시피 컨테이너 -->
<div class="container-recipe">
    <!-- 레시피 헤더 -->
    <div class="recipe-header">
        <h1 class="recipe-title">${readRecipeBean.openRecipe_title}</h1>
        
        <div class="recipe-user-info">
             <h4 style="font-weight: 700;"> 작성자 : </h4><span> &nbsp; ${readRecipeBean.id}</span>
        </div>
        
        <p class="recipe-intro">${readRecipeBean.openRecipe_intro}</p>
        
        <div class="recipe-stats">
            <span><i class="far fa-eye"></i> 조회수 ${viewCount}</span>
            <span><i class="far fa-heart"></i> 좋아요 <span id="likeCount">${readRecipeBean.openRecipe_like}</span></span>
        </div>
    </div>
    
    <!-- 레시피 섹션들 -->
    <div class="recipe-sections">
        <!-- 완성 이미지 섹션 -->
        <c:if test="${readRecipeBean.openRecipe_picture != null}">
            <div class="recipe-section">
                <div class="recipe-complete-image">
                    <img src="${root}/upload/${readRecipeBean.openRecipe_picture}" alt="${readRecipeBean.openRecipe_title} 완성 이미지" class="recipe-thumbnail">
                </div>
            </div>
        </c:if>
        
        <!-- 재료 섹션 -->
        <div class="recipe-section">
            <h2 class="section-title">재료</h2>
            <div class="recipe-ingredients">
                <c:forTokens items="${readRecipeBean.openRecipe_prepare}" delims="," var="ingredient">
                    <div class="ingredient-item">
                        <span class="ingredient-name">${ingredient}</span>
                    </div>
                </c:forTokens>
            </div>
        </div>
        
        <!-- 조리 단계 섹션 -->
        <div class="recipe-section">
            <h2 class="section-title">조리 순서</h2>
            <div class="cooking-steps">
                <c:forEach var="step" items="${readRecipeBean.stepBeanList}" varStatus="status">
                    <div class="step-box">
                        <div class="step-number">${status.index + 1}</div>
                        <p class="step-text">${step.stepText}</p>
                        <c:if test="${not empty step.stepImageUrl}">
                            <img src="${root}/upload/${step.stepImageUrl}" alt="Step ${status.index + 1}" class="step-image">
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    
    <!-- 액션 버튼 섹션 -->
    <div class="action-buttons">
        <div>
            <a href="${root}/recipe/recipe_main?theme_index=${readRecipeBean.theme_index}" class="btn-action">목록보기</a>
            
            <c:if test="${loginMember.id == readRecipeBean.id}">
                <a href="${root}/recipe/recipe_modify?openRecipe_index=${readRecipeBean.openRecipe_index}" class="btn-action btn-info">수정하기</a>
                <a href="${root}/recipe/recipe_delete?openRecipe_index=${readRecipeBean.openRecipe_index}" class="btn-action btn-danger">삭제하기</a>
            </c:if>
        </div>
        
        <div>
            <c:choose>
                <c:when test="${empty loginMember.id}">
                    <button class="btn-like disabled">
                        <i class="far fa-heart"></i> 좋아요
                    </button>
                    <small class="text-muted ml-2">로그인 후 좋아요를 누를 수 있습니다.</small>
                </c:when>
                <c:otherwise>
                    <button id="likeBtn" data-recipe-index="${readRecipeBean.openRecipe_index}" class="btn-like">
                        <i class="fas fa-heart"></i> 좋아요
                    </button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>

<!-- 좋아요 버튼 스크립트 - 기존 기능 그대로 유지 -->
<script>
$(document).ready(function() {
    // 좋아요 버튼 클릭 이벤트
    $("#likeBtn").click(function(e) {
        e.preventDefault();
        
        // 로그인 상태 체크 (optional, 서버에서도 체크해야 함)
        <c:if test="${empty loginMember.id}">
            alert("로그인이 필요한 기능입니다.");
            return;
        </c:if>

        var recipeIndex = $(this).data("recipe-index");
        
        $.ajax({
            url: "${root}/recipe/recipe_like",
            type: "POST",
            data: { 
                openRecipe_index: recipeIndex 
            },
            success: function(newLikeCount) {
                // 좋아요 수 업데이트
                $("#likeCount").text(newLikeCount);
                
                // 좋아요 버튼 스타일 토글 (선택사항)
                $("#likeBtn").toggleClass("btn-danger btn-outline-danger");
            },
            error: function(xhr, status, error) {
                console.error("좋아요 처리 중 오류 발생:", error);
                alert("좋아요 처리 중 오류가 발생했습니다.");
            }
        });
    });
});
</script>
</body>
</html>