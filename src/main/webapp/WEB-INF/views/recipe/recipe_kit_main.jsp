<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<c:set var="theme_index" value="${param.theme_index}" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피키트메인</title>
</head>
<body>

<div class="themebar" id="themeMenu">
	<ul class="themebar-theme">
				<li class="nav-item">
					<a href="${root }/recipe_kit/recipe_kit_main?theme_index=1" 
					class="theme-link">푸드</a>
				</li>
				<li class="nav-item">
					<a href="${root }/recipe_kit/recipe_kit_main?theme_index=2" 
					class="theme-link">뷰티</a>
				</li>
				<li class="nav-item">
					<a href="${root }/recipe_kit/recipe_kit_main?theme_index=3" 
					class="theme-link">문구&팬시</a>
				</li>
				<li class="nav-item">
					<a href="${root }/recipe_kit/recipe_kit_main?theme_index=4" 
					class="theme-link">리빙</a>
				</li>
				<li class="nav-item">
					<a href="${root }/recipe_kit/recipe_kit_main?theme_index=5" 
					class="theme-link">패션</a>
				</li>
	</ul>
</div>

레시피 순위		  

      
<c:choose>
	<c:when test="${theme_index eq '1'}">
		<c:forEach var="obj" items="${openRecipeList }">
		<li class="recipe_list1">
		<a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title }</a>
		</c:forEach>
	</c:when>
			
	<c:when test="${theme_index eq '2'}">
		<c:forEach var="obj" items="${openRecipeList }">
		<li class="recipe_list1">
		<a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title }</a>
		</c:forEach>
	</c:when>
		
	<c:when test="${theme_index eq '3'}">
		<c:forEach var="obj" items="${openRecipeList }">
		<li class="recipe_list1">
		<a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title }</a>
		</c:forEach>
	</c:when>
	
	<c:when test="${theme_index eq '4'}">
		<c:forEach var="obj" items="${openRecipeList }">
		<li class="recipe_list1">
		<a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title }</a>
		</c:forEach>
	</c:when>
	
	<c:when test="${theme_index eq '5'}">
		<c:forEach var="obj" items="${openRecipeList }">
		<li class="recipe_list1">
		<a href="${root}/recipe/recipe_read?openRecipe_index=${obj.openRecipe_index}" class="recipe_read-link">${obj.openRecipe_title }</a>
		</c:forEach>
	</c:when>
					
	<c:otherwise>
		<li class="recipe_list">
		<a href="${root}/recipe/recipe_read" class="recipe_read-link">기본사진1</a>
		</li>
		<li class="recipe_list">
		<a href="${root}/recipe/recipe_read" class="recipe_read-link">기본사진2</a>
		</li>
		<li class="recipe_list">
		<a href="${root}/recipe/recipe_read" class="recipe_read-link">기본사진3</a>
		</li>
		<li class="recipe_list">
		<a href="${root}/recipe/recipe_read" class="recipe_read-link">기본사진4</a>
		</li>
	</c:otherwise>
</c:choose>	
	
			<div class="recipe-write">
				<a href="${root }/recipe/recipe_main?theme_index=1" class="btn btn-primary">더보기</a>
			</div>
		

			<div class="recipe-write">
				<a href="${root }/recipe/recipe_write" class="btn btn-primary">글쓰기</a>
			</div>
			
	
	

</body>
</html>