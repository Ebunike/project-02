<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<head>
    <meta charset="UTF-8">
    <title>카테고리 선택</title>
    <style>
    	.category-list{
    		list-style-type: none;
    		padding: 0
    	}
    	.category-list li{
    		margin: 10px 0;
    	}
    	.category-list input[type="radio"] {
			display: none;
		}
		.custom-radio{
			display: inline-block;
			width: 20px;
			height: 20px;
			background-color: #eee;
			border-radius: 50%;
			position: relative;
			cursor: pointer;
		}
		.category-list input[type="radio"]:checked + .custom-radio{
			background-color: #077bff;
		}
		.customradio:after {
			content: "";
			display: block;
			width: 14px;
			height: 14px;
			background-color: white;
			border-radius: 50%;
			position: absolute;
			top: 3px;
			left: 3px;
		}
		.category-list input[type="radio"]:checked + .custom-radio::after{
			background-color: #077bff;
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

    <div class="container">
        <h2>카테고리 선택</h2>
        <form:form modelAttribute="categoryBean" id="categoryForm" method="POST" action="category">
            <ul class="category-list">
                <li>
                    <form:radiobutton id="index1" path="theme_index" value="1" onclick="submitForm()" /> 
                    <label for="index1" class="custom-radio"></label> 푸드
                </li>
                <li>
                    <form:radiobutton id="index2" path="theme_index" value="2" onclick="submitForm()"/> 
                    <label for="index2" class="custom-radio"></label> 뷰티
                </li>
                <li>
                    <form:radiobutton id="index3" path="theme_index" value="3" onclick="submitForm()"/> 
                    <label for="index3" class="custom-radio"></label> 팬시
                </li>
                <li>
                    <form:radiobutton id="index4" path="theme_index" value="4" onclick="submitForm()"/> 
                    <label for="index4" class="custom-radio"></label> 리빙
                </li>
                <li>
                    <form:radiobutton id="index5" path="theme_index" value="5" onclick="submitForm()"/> 
                    <label for="index5" class="custom-radio"></label> 패션
                </li>
            </ul>
        </form:form>
    </div>
    
    <script>
    	function submitForm() {
			document.getElementById("categoryForm").submit();
		}
    </script>
    
    	<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>