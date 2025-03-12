<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />


<head>
	<script type="text/javascript">
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
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }
        .container {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .form-group input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }
        .form-group input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>회원가입</h2>

    <!-- form:form 태그로 Spring MVC 폼 바인딩 -->
    <form:form action="${root}/member/join_pro" modelAttribute="sellerBean" method="POST">

        <!-- 이름 (사용자가 수정할 수 없게 readonly 설정) -->
        <div class="form-group">
            <label for="name">이름</label>
            <form:input id="name" path="name" readonly="true" required="true" />
        </div>

        <!-- 이메일 (사용자가 수정할 수 없게 readonly 설정) -->
        <div class="form-group">
            <label for="email">이메일</label>
            <form:input id="email" path="email" readonly="true" required="true" />
        </div>

        <!-- 전화번호 (사용자가 수정할 수 없게 readonly 설정) -->
        <div class="form-group">
            <label for="tel">전화번호</label>
            <form:input id="tel" path="tel" readonly="true" required="true" />
        </div>

        <!-- 성별 (사용자가 수정할 수 없게 disabled 설정) -->
        <div class="form-group">
            <label for="gender">성별</label>
            <form:input id="gender" path="gender" type="text" required="true" readonly="true"/>
        </div>
		<div class="form-group">
            <label for="id">아이디</label>
            <form:input id="id" path="id" type="text" required="true" />
        </div>
        <!-- 비밀번호 -->
        <div class="form-group">
            <label for="pw">비밀번호</label>
            <form:input id="pw" path="pw" type="password" required="true" />
        </div>

        <!-- 주소 -->
        <div class="form-group">
            <label for="address">주소</label>
            <form:input id="address" path="address" required="true" />
        </div>

        <!-- 나이 -->
        <div class="form-group">
            <label for="age">나이</label>
            <form:input id="age" path="age" required="true" />
        </div>

        <!-- 관심 키워드 선택 (체크박스) -->
        <p>관심 키워드를 선택하세요:</p>
        <form:checkbox path="keyword" value="programming" label="프로그래밍" /><br>
        <form:checkbox path="keyword" value="design" label="디자인" /><br>
        <form:checkbox path="keyword" value="marketing" label="마케팅" /><br>
        <form:checkbox path="keyword" value="craft" label="공예" /><br>
        <form:checkbox path="keyword" value="cooking" label="요리" /><br>
		
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
        <!-- 제출 버튼 -->
        <div class="form-group">
            <form:button type="submit">회원가입</form:button>
        </div>
        

    </form:form>
</div>

</body>
</html>
