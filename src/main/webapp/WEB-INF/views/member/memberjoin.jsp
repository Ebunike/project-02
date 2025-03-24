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

<!-- Daum 우편번호 API 스크립트 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
var api = "${api}";

window.onload = function() {
    var nameField = document.getElementById('name');
    var emailField = document.getElementById('email');
    
    if (api && api.trim() !== "") {
        nameField.setAttribute('readonly', 'true');
        emailField.setAttribute('readonly', 'true');
    }
}

   // 아이디 중복 확인
   function checkUserId() {
      let id = $("#id").val();
      if (id.length == 0) {
         alert("아이디를 입력해주세요");
         return;
      }
      $.ajax({
         url: '${root}/member/checkId/' + id,
         type: "get",
         dataType: 'text',
         success: function(result) {
            if (result == "true") {
               alert("사용할 수 있는 아이디입니다");
               $("#idExist").val("true");
               $("#registerBtn").prop("disabled", false); // 아이디 중복 확인 후 회원가입 버튼 활성화
            } else {
               alert("사용할 수 없는 아이디입니다");
               $("#idExist").val("false");
               $("#registerBtn").prop("disabled", true); // 중복 아이디일 경우 회원가입 버튼 비활성화
            }
         }
      });
   }

   // Daum 우편번호 검색 함수
   function sample4_execDaumPostcode() {
      new daum.Postcode({
         oncomplete: function(data) {
            var roadAddr = data.roadAddress; // 도로명 주소
            if (roadAddr) {
               document.getElementById("address").value = roadAddr; // 도로명 주소 필드
            }
         }
      }).open();
   }
</script>
	<style type="text/css">
	  .card shadow {
	    display: flex;
	    width: 100%;
	    height: 100%;
	    margin: 0;
	  }
	  .form-control {
	    border: 3px solid black;
	}
	</style>
</head>
<body>

<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<div class="container" style="margin-top:100px">
   <div class="row">
      <div class="col-sm-3"></div>
      <div class="col-sm-6">
         <div class="card shadow">
            <div class="card-body" style="border: 2px solid; border-radius: 20px">
               <form:form action="${root}/member/memberjoin_pro" method="post" modelAttribute="memberBean">
                  <div class="form-group">
                     <form:label path="name">이름</form:label>
                     <form:input type="text" id="name" path="name" class="form-control"/>
                     <form:errors path="name" cssStyle="color:red"/>
                  </div>

                  <div class="form-group">
                     <form:label path="id">아이디</form:label>
                     <div class="input-group">
                        <form:input type="text" id="id" path="id" class="form-control" />
                        <div class="input-group-append">
                           <button type="button" class="btn btn-primary" onclick="checkUserId()">중복확인</button>
                        </div>
                     </div>
                     <form:errors path="id" cssStyle="color:red"/>
                  </div>
                  <div class="form-group">
                     <form:label path="pw">비밀번호</form:label>
                     <form:input type="password" id="pw" path="pw" class="form-control"/>
                     <form:errors path="pw" cssStyle="color:red"/>
                  </div>
                  <div class="form-group">
                     <form:label path="address">주소</form:label>
                     <form:input type="text" id="address" path="address" class="form-control" readonly="true"/>
                     <button type="button" class="btn" onclick="sample4_execDaumPostcode()">주소 검색</button>
                  </div>
                   <form:errors path="address" cssStyle="color:red"/>
                  <div class="form-group">
                     <form:label path="email">이메일</form:label>
                     <form:input type="text" id="email" path="email" class="form-control"/>
                     <form:errors path="email" cssStyle="color:red"/>
                  </div>
                  <div class="form-group">
                     <form:label path="tel">전화번호</form:label>
                     <form:input type="text" id="tel" path="tel" class="form-control"/>
                     <form:errors path="tel" cssStyle="color:red"/>
                  </div>
                  <div class="form-group">
                     <form:label path="age">나이</form:label>
                     <form:input type="text" id="age" path="age" class="form-control"/>
                     <form:errors path="age" cssStyle="color:red"/>
                  </div>
                  <div class="form-group">
                     <form:label path="gender">성별</form:label><br>
                     <form:radiobutton path="gender" value="male"/> 남성
                     <form:radiobutton path="gender" value="female"/> 여성
                     <form:errors path="gender" cssStyle="color:red"/>
                  </div>
                  <div class="form-group">
                     <form:label path="keyword">관심 키워드를 선택하세요</form:label><br>
                     <form:checkbox path="keyword" value="프로그래밍"/> 프로그래밍 <br>
                     <form:checkbox path="keyword" value="디자인"/> 디자인 <br>
                     <form:checkbox path="keyword" value="마케팅"/> 마케팅 <br>
                     <form:checkbox path="keyword" value="공예"/> 공예 <br>
                     <form:checkbox path="keyword" value="요리"/> 요리 <br>
                     <form:errors path="keyword" cssStyle="color:red"/>
                  </div>
                  
                  <div class="form-group">
                     <div class="text-right">
                       
                        <button type="submit" class="btn btn-primary" id="registerBtn" disabled>회원가입</button>
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
