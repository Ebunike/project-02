<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>write OpenRecipe</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<form:form action="${root }/recipe/recipe_write_pro" method="post" modelAttribute="writeRecipe" 
           enctype="multipart/form-data">
					
					<form:label path="theme_index">카테고리 선택</form:label>
					<form:select path="theme_index" id="theme_index">
						<form:option value="0">-- 카테고리 선택 --</form:option>
					    <form:option value="1">푸드</form:option>
					    <form:option value="2">뷰티</form:option>
					    <form:option value="3">문구/팬시</form:option>
					    <form:option value="4">패션</form:option>
					</form:select>
					
					<div class="form-group">
					    <form:label path="id">아이디</form:label>
					<form:input type="text" id="id" class="form-control" path="id" readonly="true" />
					</div>
					
					<div class="form-group">
						<form:label path="openRecipe_title">제목</form:label>
						<form:input type="text" id="openRecipe_title" path="openRecipe_title" class="form-control"/>
					</div>
					<div class="form-group">
						<form:label path="openRecipe_content">내용</form:label>
						<form:textarea id="openRecipe_content" path="openRecipe_content" class="form-control" rows="10" style="resize:none"></form:textarea>
					</div>
<%-- 				<div class="form-group">
						<form:label path="openRecipe_picture">첨부 이미지</form:label>
						<form:input type="file" id="openRecipe_picture" path="openRecipe_picture" class="form-control" accept="image/*" />
					</div> 
--%>
					<div class="form-group">
						<form:label path="openRecipe_picture">첨부 이미지</form:label>
						<form:input type="file" id="openRecipe_picture" path="upload_picture" class="form-control" accept="image/*" />
					</div>
					<div class="form-group">
						<div class="text-right">
							<button type="submit" class="btn btn-primary">작성하기</button>
						</div>
					</div>
					
					</form:form>
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>

</body>
</html>