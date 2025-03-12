<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>키트 상품 리스트</title>

<!-- Bootstrap & jQuery -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<style>
		/* 상품 리스트 전체 컨테이너 */
	.kit-container {
	    border: 2px solid #c2a87d; /* 테두리 색상 */
	    display: flex;
	    flex-direction: column;
	    align-items: flex-start;  /* 왼쪽 정렬 */
	    width: 80%;
	    margin: 20px auto;
	    padding: 20px;
	    position: relative; /* 상대 위치 지정 */
	}
	
	/* "키트 상품 등록" 버튼 (오른쪽 정렬) */
	.kit-header {
	    width: 100%;
	    display: flex;
	    justify-content: flex-end; /* 오른쪽 정렬 */
	    margin-bottom: 10px;
	}
	
	/* 개별 상품 카드 */
	.kit-item {
	    display: flex;
	    align-items: center;
	    justify-content: space-between;
	    width: 100%;
	    max-width: 800px;
	    background-color: #f9f9f9;
	    padding: 15px;
	    border: 2px solid #c2a87d; /* 테두리 색상 */
	    border-radius: 10px;
	    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
	    margin-bottom: 15px;
	}
	
	/* 상품 이미지 */
	.kit-image img {
	    width: 120px;
	    height: 120px;
	    object-fit: cover;
	    border-radius: 8px;
	}
	
	/* 상품 정보 (이름 & 가격) */
	.kit-info {
	    flex: 1;
	    padding-left: 15px;
	}
	
	.kit-info span {
	    display: block;
	    font-size: 16px;
	    font-weight: bold;
	    color: #333;
	}
	
	/* 좋아요 & 평점 - 너비 조정 및 간격 확보 */
	.kit-meta {
	    width: 150px; /* 기존보다 넓게 설정하여 간격 확보 */
	    text-align: center;
	    padding-right: 30px; /* 버튼과의 거리 확보 */
	}
	
	.kit-meta span {
	    display: block;
	    font-size: 14px;
	    color: #666;
	}
	/* 장바구니 버튼 */
	.cart-button {
	    background-color: #c4b99c;
	    color: white;
	    border: none;
	    padding: 8px 15px;
	    border-radius: 5px;
	    cursor: pointer;
	    margin-left: auto; /* 오른쪽으로 정렬 */
	}
	.cart-button:hover {
	    background-color: #a59785;
	}
</style>
</head>
<body>
	
	<!-- 상단 메뉴 -->
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />
	
	<div class="kit-container">
	    <!-- "키트 상품 등록" 버튼을 오른쪽에 배치 -->
	    <div class="kit-header">
	        <a href="${root }/item/kit/insert_kit?kit=1" class="btn btn-primary">키트 상품 등록</a>
	    </div>
	
	    <h4>키트 상품 리스트</h4>
	
	    <!-- 상품 리스트 반복문 -->
	    <c:forEach var="item" items="${itemList}">
	        <div class="kit-item">
	            <!-- 상품 이미지 -->
	            <div class="kit-image">
	                <c:if test="${item.item_picture != null}">
	                    <img src="${root}/upload/${item.item_picture}" alt="상품 이미지">
	                </c:if>
	            </div>
	
	            <!-- 상품 이름 & 가격 -->
	            <div class="kit-info">
	                <a href="">
	                    <span>상품명: ${item.item_name}</span>
	                    <span>가격: ${item.item_price} 원</span>
	                </a>
	            </div>
	
	            <!-- 좋아요 수 & 평점 -->
	            <div class="kit-meta">
	                <span>❤️ 좋아요: ${item.item_like}</span>
	                <span>⭐ 평점: ${item.item_avgRating}</span>
	            </div>
	
	            <!-- 장바구니 버튼 -->
	            <button class="cart-button" onclick="addToCart('${item.item_index}')">장바구니 추가</button>
	        </div>
	    </c:forEach>
	</div>

<!-- 하단 정보 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

<script>
function addToCart(item_index) {
    fetch('${root}/cart/addToCart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ item_index: item_index }) 
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`HTTP 상태 코드: ${response.status}`);
        }
        return response.text();
    })
    .then(data => {
        console.log('응답 데이터:', data);
        alert('장바구니에 추가되었습니다.');
    })
    .catch(error => {
        console.error('에러 발생:', error);
    });
}
</script>

</body>
</html>