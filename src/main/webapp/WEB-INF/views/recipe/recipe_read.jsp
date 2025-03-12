<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value='${pageContext.request.contextPath }'/>
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피상세페이지</title>
</head>
<body>

<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<div class="form-group">
						<label for="id">작성자</label>
						<input type="text" id="id" name="id" class="form-control" value="${readRecipeBean.id }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="id">글번호</label>
						<input type="text" id="openRecipe_index" name="openRecipe_index" class="form-control" value="${readRecipeBean.openRecipe_index }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="openRecipe_title">제목</label>
						<input type="text" id="openRecipe_title" name="openRecipe_title" class="form-control" value="${readRecipeBean.openRecipe_title }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="openRecipe_content">내용</label>
						<textarea id="openRecipe_content" name="openRecipe_content" class="form-control" rows="10" style="resize:none" disabled="disabled">${readRecipeBean.openRecipe_content }</textarea>
					</div>
					<c:if test="${readRecipeBean.openRecipe_picture != null }">
					<div class="form-group">
						<label for="openRecipe_picture">첨부 이미지</label>
						<img src="${root }/upload/${readRecipeBean.openRecipe_picture}" width="100%"/>	
					</div>
					</c:if>
					<div class="form-group">
						<div class="text-right">
						

							<a href="${root }/recipe_kit/recipe_kit_main?theme_index=${readRecipeBean.theme_index}" class="btn btn-primary">목록보기</a>
							<c:if test="${loginMember.id == readRecipeBean.id }">
							<a href="${root }/recipe/recipe_modify?openRecipe_index=${readRecipeBean.openRecipe_index}" class="btn btn-info">수정하기</a>
							<a href="${root }/recipe/recipe_delete?openRecipe_index=${readRecipeBean.openRecipe_index}" class="btn btn-danger">삭제하기</a>
							<a href="${root }/payment/payment?openRecipe_index=${readRecipeBean.openRecipe_index}" class="btn btn-danger">구매하기</a>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>

<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>

</body>
</html>