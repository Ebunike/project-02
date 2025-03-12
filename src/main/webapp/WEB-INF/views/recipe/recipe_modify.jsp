<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>미니 프로젝트</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<body>

<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<form:form action='${root }/recipe/recipe_modify_pro' method='post' modelAttribute="modifyRecipe" enctype="multipart/form-data">
					
						<form:hidden path="openRecipe_index"/>
				
						<form:hidden path="theme_index"/>
						<%-- <input type='hidden' name='page' value='${page }'/> --%>
						<div class="form-group">
							<form:label path="id">작성자</form:label>
							<form:input path="id" class='form-control' readonly="true"/>
						</div>
						<div class="form-group">
							<form:label path="openRecipe_title">제목</form:label>
							<form:input path="openRecipe_title" class='form-control'/>
							<form:errors path="openRecipe_title" style='color:red'/>
						</div>
						<div class="form-group">
							<form:label path="openRecipe_content">내용</form:label>
							<form:textarea path="openRecipe_content" class="form-control" rows="10" style="resize:none"/>
							<form:errors path="openRecipe_content" style='color:red'/>
						</div>
						<div class="form-group">
							<label for="openRecipe_picture">첨부 이미지</label>
							<c:if test="${modifyContentBean.content_file != null }">
							<img src="${root }/upload/${modifyContentBean.content_file}" width="100%"/>	
							<!-- 첨부파일 주입 수정시 이미지 파일 변경없이 유지-->	
							<form:hidden path="content_file"/>
							</c:if>
							<form:input path="upload_picture" type='file' class="form-control" accept="image/*"/>
						</div>
						<div class="form-group">
							<div class="text-right">
								<form:button class='btn btn-primary'>수정완료</form:button>
								<a href="${root }/recipe/read?openRecipe_index=${openRecipe_index}" class="btn btn-info">취소</a>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>

<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>

</body>
</html>
    