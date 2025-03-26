<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value='${pageContext.request.contextPath}'/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 메인페이지</title>

<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<a href="${root}/recipe/recipe_main?theme_index=1">푸드</a>
<a href="${root}/recipe/recipe_main?theme_index=2">뷰티</a>
<a href="${root}/recipe/recipe_main?theme_index=3">문구</a>
<a href="${root}/recipe/recipe_main?theme_index=4">리빙</a>
<a href="${root}/recipe/recipe_main?theme_index=5">패션</a>


<c:choose>
	<c:when test="${theme_index eq '1'}">
		<h2>푸드 카테고리</h2>
		<c:forEach var="obj" items="${openRecipeList}">
		<li class="recipe_list1">
		<a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">
		 <img src="${root}/upload/${obj.openRecipe_picture}" alt="${obj.openRecipe_title}" class="img-thumbnail" style="width: 100px; height: 100px; object-fit: cover;" />
		</a>
		<a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title}</a>
		
		<!-- 조회수 출력 -->
        <span class="badge badge-secondary">
            조회수: ${recipeViewCounts[obj.openRecipe_index] != null ? recipeViewCounts[obj.openRecipe_index] : 0}
        </span>
		</li>
		</c:forEach>
	</c:when>
			
	<c:when test="${theme_index eq '2'}">
		<h2>뷰티 카테고리</h2>
		<c:forEach var="obj" items="${openRecipeList }">
		<li class="recipe_list1">
		<a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title }</a>
		</c:forEach>
	</c:when>
		
	<c:when test="${theme_index eq '3'}">
		<h2>문구 카테고리</h2>
		<c:forEach var="obj" items="${openRecipeList }">
		<li class="recipe_list1">
		<a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title }</a>
		</c:forEach>
	</c:when>
	
	<c:when test="${theme_index eq '4'}">
		<h2>리빙 카테고리</h2>
		<c:forEach var="obj" items="${openRecipeList }">
		<li class="recipe_list1">
		<a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title }</a>
		</c:forEach>
	</c:when>
	
	<c:when test="${theme_index eq '5'}">
		<h2>패션 카테고리</h2>
		<c:forEach var="obj" items="${openRecipeList }">
		<li class="recipe_list1">
		<a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title }</a>
		</c:forEach>
	</c:when>
					
	<c:otherwise>
		<h2>모든 항목 최고 좋아요 카테고리</h2>
		<c:forEach var="obj" items="${allRecipeList }">
		<li class="recipe_list1">
		<a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title }</a>
		</c:forEach>
	</c:otherwise>
</c:choose>	
	
	
			<div class="d-none d-md-block">
				<ul class="pagination justify-content-center">
					<c:choose>
						<c:when test="${pageBean.prevPage <= 0 }">
							<li class="page-item">
								<a href="#" class="page-link">이전</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
								<a href="${root }/recipe/recipe_main?theme_index=${theme_index}&page=${pageBean.prevPage}" 
								class="page-link">이전</a>
							</li>
						</c:otherwise>
					</c:choose>
					
					<c:forEach var="idx" begin="${pageBean.min }" end="${pageBean.max }">
						<li class="page-item">
							<a href="${root }/recipe/recipe_main?theme_index=${theme_index}&page=${idx}" 
							class="page-link">${idx }</a>
						</li>
					</c:forEach>
					
					<c:choose>
						<c:when test="${pageBean.max >= pageBean.pageCnt }">
							<li class="page-item">
								<a href="#" class="page-link">다음</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
								<a href="${root }/recipe/recipe_main?theme_index=${theme_index}&page=${pageBean.nextPage}" 
								class="page-link">다음</a>
							</li>
						</c:otherwise>
					</c:choose>
					
				</ul>
			</div>
			
			<div class="d-block d-md-none">
				<ul class="pagination justify-content-center">
					<li class="page-item">
						<a href="#" class="page-link">이전</a>
					</li>
					<li class="page-item">
						<a href="#" class="page-link">다음</a>
					</li>
				</ul>
			</div>
	
	
	
        <a href="${root}/recipe/recipe_write" class="btn btn-primary">글쓰기</a>
	
	
<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>