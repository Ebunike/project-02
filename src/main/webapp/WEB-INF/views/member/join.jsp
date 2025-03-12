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
<style type="text/css">
 
 	body{
 		background-color: #f5f5dc;
 	}
 	.card shadow{
 		display: flex;
 		width: 100%;
 		height: 100%;
 		margin: 0;
 	}
 	
</style>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<body>

<script type="text/javascript">

   function checkUserId(){
      let id = $("#id").val()
      console.log(id)
      //변수선언: 사용자가 입력한 ID값 가져오기
      if(id.length == 0){
         //lengtj==0 길이가0일때.(아무것도 적지 않았을때)
         alert("아이디를 입력해주세요")
         return
      }
      $.ajax({
         url : '${root}/member/checkId/' + id ,//서버에 요청하기
         type : "get",
         dataType : 'text',
         success : function(result){
            //응답결과
            if(result == "true"){
               // 응답 데이터가 true
               alert("사용할 수 있는 아이디입니다")
               $("#idExist").val("true")
            }else{
               // 응답 데이터가 false
               alert("사용할 수 없는 아이디입니다")
               $("#idExist").val("false")
            }
         }
      })
      function resetUserId(){
         $("#idExist").val("false")
      }
   }
   /*=====================================================================  */
      function toggleSellerFields() {
           var isSeller = document.getElementById("sellerRadio").checked;
           var sellerFields = document.getElementById("sellerFields");
           if (isSeller) {
               sellerFields.style.display = "block"; // 판매자 필드를 보이게
           } else {
               sellerFields.style.display = "none"; // 판매자 필드를 숨기게
           }
       }

   
</script>

<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<form:form action="${root }/member/join_pro" method="post" modelAttribute="sellerBean" >
						<%-- <form:hidden path="idExist" /> --%>
						<div class="form-group">
							<form:label path="name">이름</form:label>
							<form:input type="text" id="name" path="name" class="form-control"/>
							<form:errors path="name" cssStyle="color:red"/>
						</div>
						<div class="form-group">
							<form:label path="id">아이디</form:label>
							<div class="input-group">
								<form:input type="text" id="id" path="id" class="form-control"
								oninput="resetUserId()" />
								<form:errors path="id" cssStyle="color:red"/>
								<div class="input-group-append">
									<button type="button" class="btn btn-primary" onclick="checkUserId()">중복확인</button>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<form:label path="pw">비밀번호</form:label>
							<form:input type="password" id="pw" path="pw" class="form-control"/>
							<form:errors path="pw" cssStyle="color:red"/>
						</div>
						
						<%-- <div class="form-group">
							<!-- pw2로 변경할것  -->
							<form:label path="pw2">비밀번호 확인</form:label>
							<form:input type="password" id="pw2" path="pw2" class="form-control"/>
						</div> --%>
						
						<div class="form-group">
							<form:label path="address">주소</form:label>
							<form:input type="text" id="address" path="address" class="form-control"/>
						</div>
						
						<div class="form-group">
							<form:label path="email">이메일</form:label>
							<form:input type="text" id="email" path="email" class="form-control"/>
						</div>
						
						<div class="form-group">
							<form:label path="tel">전화번호</form:label>
							<form:input type="text" id="tel" path="tel" class="form-control"/>
						</div>
						
						<div class="form-group">
							<form:label path="age">나이</form:label>
							<form:input type="text" id="age" path="age" class="form-control"/>
						</div>
						
						<div class="form-group">
		                    <form:label path="gender">성별</form:label><br>
		                    <form:radiobutton path="gender" value="male"/> 남성
		                    <form:radiobutton path="gender" value="female"/> 여성
	                	</div>
	                		
			            <div class="form-group">
			                 <form:label path="keyword">관심 키워드를 선택하세요</form:label><br>
			                 <form:checkbox path="keyword" value="program"/> 프로그래밍 <br>
			                 <form:checkbox path="keyword" value="design"/> 디자인 <br>
			                 <form:checkbox path="keyword" value="marketing"/> 마케팅 <br>
			                 <form:checkbox path="keyword" value="crafts"/> 공예 <br>
			                 <form:checkbox path="keyword" value="cook"/> 요리 <br>
			            </div>
			            
			            <!-- 판매자 여부 선택 라디오 버튼 -->
                       <p>판매자 회원으로 가입하시겠습니까?</p>
		                    <input type="radio" id="buyerRadio" name="userType" value="buyer" checked="checked" onclick="toggleSellerFields()"> 일반회원
		                    <input type="radio" id="sellerRadio" name="userType" value="seller" onclick="toggleSellerFields()"> 판매자회원<br><br>
        
        				<!-- 판매자 추가 필드 (기본적으로 숨김) -->
	                    <div id="sellerFields" style="display:none;">
	                        <form:label path="company_name">상호명:</form:label>
	                     	<form:input path="company_name"/><br><br>
	            
	                     	<form:label path="company_num">사업자 등록번호:</form:label>
	                     	<form:input path="company_num"/><br><br>
	                    </div>
						
						<div class="form-group">
							<div class="text-right">
								<button type="submit" class="btn btn-primary">회원가입</button>
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