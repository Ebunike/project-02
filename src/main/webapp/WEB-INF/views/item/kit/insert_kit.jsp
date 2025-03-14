<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <c:set var="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<style type="text/css">
	body {
	        font-family: 'Arial', sans-serif; /* 기본 글꼴 */
	        background-color: #f5f5dc; /* 페이지 전체 배경색 (베이지) */
	    }
	.container_kit {
	        max-width: 700px; /* 최대 가로 크기 제한 */
	        margin: 0 auto; /* 가운데 정렬 */
	        padding: 30px; /* 내부 여백 */
	        border-radius: 15px; /* 둥근 모서리 */
	        box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
    }
    .item-box {
        background: #f9f9f3; /* 연한 배경색 */
        border: 2px solid #c2a87d; /* 테두리 색상 */
        padding: 12px 15px; /* 안쪽 여백 */
        margin-bottom: 15px; /* 아래쪽 여백 */
        border-radius: 10px; /* 둥근 모서리 */
        display: flex; /* 가로 정렬 */
        justify-content: space-between; /* 라벨과 값 사이 간격 */
        align-items: center; /* 세로 중앙 정렬 */
        font-size: 16px; /* 글씨 크기 조정 */
        font-weight: 500; /* 글씨 조금 두껍게 */
    }
    .item-box label {
        font-weight: bold; /* 글씨 굵게 */
        color: #5a4635; /* 어두운 갈색 (배경과 조화) */
        margin-right: 10px; /* 오른쪽 여백 추가 */
        min-width: 90px; /* 최소 너비 설정 (정렬 통일) */
    }
    /* 키트등록 버튼 */
    .insert_kit {
	    background-color: #c4b99c;
	    color: white;
	    border: none;
	    padding: 8px 15px;
	    border-radius: 5px;
	    cursor: pointer;
	    margin-left: auto; /* 오른쪽으로 정렬 */
	}
	.insert_kit:hover {
	    background-color: #a59785;
	}
</style>	
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

	<div class="container_kit">
		<form action="${root }/item/kit/insert_kit_pro" method="post" enctype="multipart/form-data">
			<div class="item-box">
				<label for="kitName" >제품 이름</label>
				<input type="text" name="kitName" id="kitName" required/>
				
			</div>
			<input type="hidden" name="kit" value="${kit}"/>
			<div class="item-box">
				<label for="kitPrice">제품 가격</label>
				<input type="text" name="kitPrice" id="kitPrice"/>
			</div>
			<div class="item-box">
				<label for="kitQuantity">제품 재고 수량</label>
				<input type="text" name="kitQuantity" id="kitQuantity"/>
			</div>
			<div class="item-box">
				<label for="kitTheme">제품 테마 명</label>
				<input type="radio" name="kitTheme" value="푸드"> [푸드]
				<input type="radio" name="kitTheme" value="뷰티"> [뷰티]
				<input type="radio" name="kitTheme" value="팬시"> [팬시] <br>
				<input type="radio" name="kitTheme" value="리빙"> [리빙]
				<input type="radio" name="kitTheme" value="패션"> [패션]
			</div>
			<div class="item-box">
				<label for="kitPicture">첨부 이미지</label>
				<input type="file" id="kitPicture" name="kitPicture" accept="image/*"/>
			</div>
			<div class="item-box">
				<label for="kitContent">제품 상세설명</label>
				<input type="text" name="kitContent" id="kitContent"/>
			</div>
			<button class="insert_kit" type="submit">등록</button>
		</form>
	</div>
	
	<!-- 게시판 하단 부분 -->
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>