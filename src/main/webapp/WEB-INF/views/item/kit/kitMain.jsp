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

<!-- Font Awesome 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>
    /* 기본 설정 */
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: white;
        color: #333;
    }

    a {
        text-decoration: none;
        color: inherit;
    }

    /* 키트 상품 컨테이너 */
    .kit-container {
        max-width: 1200px;
        margin: 40px auto;
        padding: 30px;
    }

    /* 헤더 타이틀 */
    .kit-header {
        margin-bottom: 30px;
        text-align: center;
    }

    .kit-title {
        display: inline-block;
        background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
        color: white;
        padding: 12px 30px;
        border-radius: 30px;
        font-size: 22px;
        font-weight: 700;
        box-shadow: 0 10px 20px rgba(37, 117, 252, 0.2);
    }

    /* 상품 그리드 레이아웃 */
    .kit-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 30px;
    }

    /* 개별 상품 카드 */
    .kit-item {
        background-color: white;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 15px 30px rgba(0,0,0,0.08);
        transition: all 0.3s ease;
        display: flex;
        flex-direction: column;
    }

    .kit-item:hover {
        transform: translateY(-10px);
        box-shadow: 0 20px 40px rgba(0,0,0,0.12);
    }

    /* 상품 이미지 */
    .kit-image {
        height: 250px;
        overflow: hidden;
        position: relative;
    }

    .kit-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.4s ease;
    }

    .kit-item:hover .kit-image img {
        transform: scale(1.1);
    }

    /* 상품 정보 */
    .kit-info {
        padding: 20px;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .product-name {
        font-size: 18px;
        font-weight: 700;
        color: #333;
        margin-bottom: 10px;
        display: block;
    }

    .product-price {
        font-size: 20px;
        font-weight: 700;
        color: #2575fc;
        display: block;
    }

    /* 장바구니 버튼 */
    .cart-button {
        width: 100%;
        background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
        color: white;
        border: none;
        padding: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .cart-button:hover {
        opacity: 0.9;
    }

    .cart-button:disabled {
        background: #ccc;
        cursor: not-allowed;
    }

    /* 빈 상태 메시지 */
    .empty-message {
        text-align: center;
        padding: 40px 0;
        color: #999;
        grid-column: 1 / -1;
    }

    .empty-message i {
        font-size: 50px;
        margin-bottom: 15px;
        display: block;
        color: #ddd;
    }

    /* 반응형 */
    @media (max-width: 1024px) {
        .kit-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 768px) {
        .kit-grid {
            grid-template-columns: 1fr;
        }
    }
</style>
</head>
<body>
	
	<!-- 상단 메뉴 -->
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />
	
	<div class="kit-container">
	    <!-- 헤더 타이틀 -->
	    <div class="kit-header">
	        <h4 class="kit-title">키트 상품 리스트</h4>
	    </div>
	
	    <div class="kit-grid">
	        <c:if test="${empty itemList}">
	            <div class="empty-message">
	                <i class="fas fa-box-open"></i>
	                <p>현재 등록된 상품이 없습니다.</p>
	            </div>
	        </c:if>
	
	        <!-- 상품 리스트 반복문 -->
	        <c:forEach var="item" items="${itemList}">
	            <div class="kit-item">
	                <!-- 상품 이미지 -->
	                <div class="kit-image">
	                    <c:if test="${item.item_picture != null}">
	                        <img src="${root}/upload/${item.item_picture}" alt="상품 이미지">
	                    </c:if>
	                    <c:if test="${item.item_picture == null}">
	                        <img src="${root}/resources/images/default-product.jpg" alt="기본 이미지">
	                    </c:if>
	                </div>
	
	                <!-- 상품 이름 & 가격 -->
	                <div class="kit-info">
	                    <a href="${root}/item/kit/kit_detail?item_index=${item.item_index}">
	                        <span class="product-name">${item.item_name}</span>
	                        <span class="product-price">${item.item_price}원</span>
	                    </a>
	
	                    <!-- 장바구니 버튼 -->
	                    <button class="cart-button" onclick="addToCart('${item.item_index}', this)">
	                        <i class="fas fa-shopping-cart"></i>장바구니 추가
	                    </button>
	                </div>
	            </div>
	        </c:forEach>
	    </div>
	</div>

<!-- 하단 정보 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

<script>
function addToCart(item_index, button) {
	   
	   button.disabled = true;
	   // 로딩 상태 표시
	   const originalContent = button.innerHTML;
	   button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 처리 중...';
	    
	   fetch('${root}/cart/addToCart', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json'
	        },
	        body: JSON.stringify({ item_index: item_index }) 
	    })
	    .then(response => {
	        if (response.status == 409) {
	           throw new Error('이미 장바구니에 있는 상품입니다.');
	        }
	       if (!response.ok) {
	            throw new Error(`HTTP 상태 코드: ${response.status}`);
	        }
	        return response.text();
	    })
	    .then(data => { /*
	        console.log('응답 데이터:', data);
	        alert('장바구니에 추가되었습니다.'); */
		    if(confirm("장바구니에 추가되었습니다. 장바구니로 이동하시겠습니까?")){
				location.href = "${root}/cart/my_cart"
			}else{
				location.href = "${root}/item/kit/kitMain"
			}
			
	    })
	    .catch(error => {
	        console.error('에러 발생:', error);
	        alert(error.message);
	        // 오류 발생 시 버튼 원래 상태로 복원
	        button.innerHTML = originalContent;
	        button.disabled = false;
	    })
	    .finally(() => {
	       setTimeout(() => {
	             button.disabled = false;
	           }, 1000);   
	    });
	}
</script>
</body>
</html>