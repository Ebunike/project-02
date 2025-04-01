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
        background-color: #f8f9fa;
        line-height: 1.6;
    }
    
    /* 메인 컨테이너 */
    .container-recipe {
        background-color: white;
        padding: 0;
        max-width: 960px;
        margin: 30px auto;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        border-radius: 12px;
        overflow: hidden;
    }
    
    /* 레시피 헤더 */
    .recipe-header {
        padding: 40px 30px;
        border-bottom: 1px solid #eee;
        position: relative;
        background: linear-gradient(to right, rgba(255,255,255,0.95), rgba(255,255,255,0.8)), url('${root}/upload/${readRecipeBean.openRecipe_picture}');
        background-size: cover;
        background-position: center;
    }
    
    .recipe-title {
        font-size: 32px;
        font-weight: 700;
        color: #222;
        margin-bottom: 20px;
        line-height: 1.3;
    }
    
    .recipe-user-info {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
        color: #555;
        font-size: 16px;
    }
    
    .recipe-user-info h4 {
        margin: 0;
        font-size: 16px;
    }
    
    .recipe-intro {
        font-size: 18px;
        line-height: 1.7;
        color: #555;
        margin-bottom: 25px;
        padding-left: 12px;
        border-left: 3px solid #74b243;
    }
    
    .recipe-stats {
        display: flex;
        color: #74b243;
        font-size: 16px;
        margin-top: 15px;
    }
    
    .recipe-stats span {
        margin-right: 25px;
        display: flex;
        align-items: center;
        font-weight: 500;
    }
    
    .recipe-stats i {
        margin-right: 8px;
        font-size: 18px;
    }
    
    /* 레시피 섹션 */
    .recipe-sections {
        padding: 30px;
    }
    
    .recipe-section {
        padding: 30px 0;
        border-bottom: 1px solid #eee;
    }
    
    .recipe-section:last-child {
        border-bottom: none;
    }
    
    .section-title {
        font-size: 24px;
        font-weight: 700;
        color: #222;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        position: relative;
        padding-left: 15px;
    }
    
    .section-title::before {
        content: '';
        position: absolute;
        left: 0;
        top: 8px;
        width: 5px;
        height: 25px;
        background: linear-gradient(to bottom, #74b243, #5a9625);
        border-radius: 3px;
    }
    
    /* 재료 섹션 */
    .recipe-ingredients {
        background-color: #f9f9fa;
        padding: 25px;
        border-radius: 10px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.03);
    }
    
    .ingredient-item {
        display: flex;
        justify-content: space-between;
        margin-bottom: 15px;
        padding-bottom: 15px;
        border-bottom: 1px dashed #ddd;
    }
    
    .ingredient-item:last-child {
        border-bottom: none;
        margin-bottom: 0;
        padding-bottom: 0;
    }
    
    .ingredient-name {
        font-weight: 500;
        font-size: 16px;
        color: #444;
    }
    
    /* 완성 이미지 */
    .recipe-thumbnail {
        width: 100%;
        max-height: 450px;
        object-fit: cover;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        transition: transform 0.3s ease;
    }
    
    .recipe-thumbnail:hover {
        transform: scale(1.01);
    }
    
    /* 조리 단계 */
    .cooking-steps {
        counter-reset: step-counter;
        position: relative;
        padding-left: 25px; /* 왼쪽 여백 추가 */
    }
    
    .step-box {
        margin-bottom: 40px;
        padding-bottom: 40px;
        border-bottom: 1px dashed #ddd;
        position: relative;
        display: flex;
        flex-direction: column;
        padding-left: 10px; /* 왼쪽 패딩 추가 */
    }
    
    .step-box:last-child {
        border-bottom: none;
        margin-bottom: 0;
        padding-bottom: 0;
    }
    
    .step-number {
        position: absolute;
        left: -15px; /* -40px에서 -15px로 변경하여 오른쪽으로 이동 */
        top: 0;
        width: 35px;
        height: 35px;
        background: linear-gradient(to bottom right, #74b243, #5a9625);
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        box-shadow: 0 3px 6px rgba(0,0,0,0.1);
        z-index: 5; /* 다른 요소 위에 표시되도록 z-index 추가 */
    }
    
    .step-text {
        font-size: 17px;
        line-height: 1.8;
        color: #444;
        margin-bottom: 20px;
        padding-left: 15px;
    }
    
    .step-image {
        width: 100%;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    }
    
    /* 공유 버튼 섹션 */
    .share-buttons {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 15px;
        padding: 20px 0;
        margin-top: 20px;
        border-top: 1px solid #eee;
    }
    
    /* 액션 버튼 섹션 */
    .action-buttons {
        padding: 25px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-top: 1px solid #eee;
        background-color: #f9f9fa;
    }
    
    /* 버튼 스타일링 */
    .btn-like {
        background: linear-gradient(to right, #ff6b6b, #ff8787);
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 25px;
        font-weight: 500;
        display: flex;
        align-items: center;
        box-shadow: 0 4px 10px rgba(255, 107, 107, 0.2);
        transition: all 0.3s ease;
    }
    
    .btn-like:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(255, 107, 107, 0.25);
    }
    
    .btn-like.disabled {
        background: linear-gradient(to right, #adb5bd, #ced4da);
        cursor: not-allowed;
    }
    
    .btn-like i {
        margin-right: 8px;
    }
    
    .btn-action {
        background-color: white;
        color: #555;
        border: 1px solid #ddd;
        padding: 8px 15px;
        margin-left: 10px;
        border-radius: 25px;
        font-size: 14px;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
    }
    
    .btn-action:hover {
        background-color: #f0f0f0;
        color: #333;
        text-decoration: none;
    }
    
    .btn-primary {
        background: linear-gradient(to right, #74b243, #5a9625);
        border: none;
        color: white;
        box-shadow: 0 4px 10px rgba(116, 178, 67, 0.2);
    }
    
    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(116, 178, 67, 0.25);
        color: white;
    }
    
    .btn-info {
        background: linear-gradient(to right, #4dabf7, #339af0);
        border: none;
        color: white;
        box-shadow: 0 4px 10px rgba(77, 171, 247, 0.2);
    }
    
    .btn-info:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(77, 171, 247, 0.25);
        color: white;
    }
    
    .btn-danger {
        background: linear-gradient(to right, #ff6b6b, #ff8787);
        border: none;
        color: white;
        box-shadow: 0 4px 10px rgba(255, 107, 107, 0.2);
    }
    
    .btn-danger:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(255, 107, 107, 0.25);
        color: white;
    }
    
    /* 공유 버튼 스타일 */
    .share-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background: linear-gradient(to right, #74b9ff, #6c5ce7);
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 25px;
        font-weight: 500;
        transition: all 0.3s ease;
        box-shadow: 0 4px 10px rgba(108, 92, 231, 0.2);
        text-decoration: none;
        font-size: 16px;
    }
    
    .share-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(108, 92, 231, 0.25);
        color: white;
        text-decoration: none;
    }
    
    .share-btn i {
        margin-right: 8px;
    }
    
    .kakao-btn {
        display: inline-flex;
        align-items: center;
        background: none;
        border: none;
        padding: 0;
        transition: all 0.3s ease;
    }
    
    .kakao-btn:hover {
        transform: translateY(-2px);
    }
    
    .kakao-btn img {
        height: 40px;
        border-radius: 8px;
    }
    
    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .recipe-header {
            padding: 25px 20px;
        }
        
        .recipe-title {
            font-size: 24px;
        }
        
        .recipe-sections {
            padding: 20px;
        }
        
        .section-title {
            font-size: 20px;
        }
        
        .cooking-steps {
            position: relative;
            padding-left: 25px; /* 모바일에서는 왼쪽 여백 추가 */
        }
        
        .step-number {
            position: absolute;
            left: -15px;
            top: 0;
        }
        
        .step-text {
            padding-left: 25px; /* 모바일에서도 텍스트 들여쓰기 */
        }
        
        .action-buttons {
            flex-direction: column;
            gap: 15px;
        }
        
        .action-buttons > div {
            width: 100%;
            display: flex;
            justify-content: center;
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
        
        <!-- 공유 버튼 섹션 - 새로 추가 -->
        <div class="share-buttons">
            <button id="copyLinkBtn" class="share-btn">
                <i class="fas fa-link"></i> 공유하기
            </button>
            <a id="kakaotalk-sharing-btn" href="javascript:shareMessage()" class="kakao-btn">
                <img src="https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_medium.png"
                    alt="카카오톡 공유 보내기 버튼" />
            </a>
        </div>
    </div>
    
    <!-- 액션 버튼 섹션 -->
    <div class="action-buttons">
        <div>
            <a href="${root}/recipe/recipe_main?theme_index=${readRecipeBean.theme_index}" class="btn-action">
                <i class="fas fa-list mr-1"></i> 목록보기
            </a>
            
            <c:if test="${loginMember.id == readRecipeBean.id}">
                <a href="${root}/recipe/recipe_modify?openRecipe_index=${readRecipeBean.openRecipe_index}" class="btn-action btn-info">
                    <i class="fas fa-edit mr-1"></i> 수정하기
                </a>
                <a href="${root}/recipe/recipe_delete?openRecipe_index=${readRecipeBean.openRecipe_index}" class="btn-action btn-danger">
                    <i class="fas fa-trash-alt mr-1"></i> 삭제하기
                </a>
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

<!-- 공유하기 버튼 스크립트 -->
<script>
document.addEventListener("DOMContentLoaded", function () {
    // 버튼 요소 가져오기
    const copyLinkBtn = document.getElementById("copyLinkBtn");

    copyLinkBtn.addEventListener("click", function () {
        // 현재 페이지의 URL 가져오기
        const pageUrl = window.location.href;

        // 클립보드에 복사
        navigator.clipboard.writeText(pageUrl)
            .then(() => {
                alert("링크가 복사되었습니다! ✅");
            })
            .catch(err => {
                console.error("클립보드 복사 실패:", err);
                alert("클립보드 복사에 실패했습니다. 😢");
            });
    });
});
</script>

<!-- 카카오톡 공유하기 메시지 시작 -->	
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.1.0/kakao.min.js"
  integrity="sha384-dpu02ieKC6NUeKFoGMOKz6102CLEWi9+5RQjWSV0ikYSFFd8M3Wp2reIcquJOemx" crossorigin="anonymous"></script>

<script>
  Kakao.init('fb9c39f52da6918d5d47283a1cf98395'); // 사용하려는 앱의 JavaScript 키 입력
</script>

<script>
var titlemessage = `${readRecipeBean.openRecipe_title }`
var intro = `${readRecipeBean.openRecipe_intro }`
var finImage = `${root }/upload/${readRecipeBean.openRecipe_picture}`
var urlLink = `${root}/recipe/recipe_read?openRecipe_index=${readRecipeBean.openRecipe_index}`

  function shareMessage() {
    Kakao.Share.sendCustom({
      templateId: 118871,
      templateArgs: {
    	THUMB: finImage, // 썸네일 주소 ${THUMB}
    	TITLE: titlemessage, // 제목 텍스트 ${TITLE}
    	DESC: intro, // 설명 텍스트 ${DESC}
    	forpath: urlLink,
      },
    });
  }
</script>
</body>
</html>