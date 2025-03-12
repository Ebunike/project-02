<%@ page import="org.apache.commons.lang3.RandomStringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var ="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>미니 프로젝트</title>
<style type="text/css">
	    body, html {
        height: 100%;
        margin: 0;
        background-color: #f5f5dc;
    }
    .container {
        margin-top: 100px;
    }
    .card {
        width: 100%;
        max-width: 500px;
        margin: auto;
    }
    .login-logo img {
        width: 100%;
        max-width: 400px;
        margin: 10px 0;
    }

</style>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<% String state = RandomStringUtils.randomAlphabetic(10); %>

<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
				
				<c:if test="${fail == true }">
					<div class="alert alert-danger">
						<h3>로그인 실패</h3>
						<p>아이디 비밀번호를 확인해주세요</p>
					</div>
				</c:if>
					 <form:form action="${root }/member/login_pro" method='post' modelAttribute="loginUser">
                  <div class="form-group">
                     <form:label path="id">아이디</form:label>
                     <form:input path="id" class='form-control'/>
                     <form:errors path='id' style='color:red'/>
                  </div>
                  <div class="form-group">
                     <form:label path="pw">비밀번호</form:label>
                     <form:password path="pw" class='form-control'/>
                     <form:errors path='pw' style='color:red'/>
                  </div>
                  <div class="login-logo">
	                  <div class="kakao-login">
	                  	<a href="">
	                  		<img src="${root}/logo/kakao_login.png">
	                  	</a>
	                  </div>
                  	  <div class="naver-login">
	                  	<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=_7r1lFqIcHDabyPs6PkX&redirect_uri=http://localhost:9091/Project_hoon/login/naver&state=<%=state%>">
	                  		<img src="${root}/logo/naver_login.png">
	                  	</a>
	                  </div>
                  </div>
                  <div class="form-group text-right">
                     <form:button class='btn btn-primary'>로그인</form:button>
                     <a href="${root }/member/join" class="btn btn-danger">회원가입</a>
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