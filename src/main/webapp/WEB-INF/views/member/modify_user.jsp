<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
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

<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<form:form action="${root }/member/modify_user_pro" method="post"
					modelAttribute="modifyMember">
					<div class="form-group">
						<form:label path="name">이름</form:label>
						<form:input type="text" id="name" path="name" class="form-control" readonly="true"/>
					</div>
					<div class="form-group">
						<form:label path="id">아이디</form:label>
						<form:input type="text" id="id" path="id" class="form-control" readonly="true"/>
					</div>
					<div class="form-group">
						<form:label path="address">주소</form:label>
						<form:input type="text" id="address" path="address" class="form-control" />
						<form:errors path="address"/>
					</div>
					<div class="form-group">
	                  <form:label path="tel">전화번호</form:label>
	                  <form:input type="text" id="tel" path="tel" class="form-control" />
	                  <form:errors path="tel"/>
	               </div>
					
					<div class="form-group">
						<form:label path="pw">비밀번호</form:label>
						<form:input type="password" id="pw" path="pw" class="form-control" />
						<form:errors path="pw"/>
					</div>
					<%-- <div class="form-group">
						<form:label path="pw2">비밀번호 확인</form:label>
						<form:input type="password" id="pw2" path="pw2" class="form-control" />
						<form:errors path="upw2"/>
					</div> --%>
					<div class="form-group">
						<div class="text-right">
							<button type="submit" class="btn btn-primary">정보수정</button>
						</div>
					</div>
					
					</form:form>
					
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>

	<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>
    