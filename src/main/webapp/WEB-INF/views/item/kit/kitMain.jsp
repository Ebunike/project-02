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
        background-color: #f9f9f9;
        color: #333;
    }

    a {
        text-decoration: none;
        color: inherit;
    }

    /* 키트 상품 컨테이너 */
    .kit-container {
        max-width: 1000px;
        margin: 40px auto;
        padding: 30px;
        background-color: white;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        border: none;
    }

    /* 헤더 타이틀 */
    .kit-header {
        margin-bottom: 30px;
        text-align: center;
        position: relative;
    }

    .kit-title {
        display: inline-block;
        background: linear-gradient(135deg, #c2a87d 0%, #a59785 100%);
        color: white;
        padding: 12px 30px;
        border-radius: 30px;
        font-size: 22px;
        font-weight: 700;
        margin: 0;
        box-shadow: 0 4px 15px rgba(194, 168, 125, 0.3);
    }

    /* 개별 상품 카드 */
    .kit-item {
        display: flex;
        align-items: center;
        background-color: white;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 20px;
        border: 1px solid rgba(194, 168, 125, 0.3);
        box-shadow: 0 5px 15px rgba(0,0,0,0.03);
        transition: all 0.3s ease;
    }

    .kit-item:hover {
        box-shadow: 0 8px 25px rgba(0,0,0,0.07);
        border-color: #c2a87d;
    }

    /* 상품 이미지 */
    .kit-image {
        flex-shrink: 0;
        width: 140px;
        height: 140px;
        overflow: hidden;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        border: 2px solid #f0f0f0;
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
        flex-grow: 1;
        padding: 0 25px;
    }

    .kit-info a {
        display: block;
        transition: color 0.3s ease;
    }

    .kit-info a:hover {
        color: #c2a87d;
        text-decoration: none;
    }

    .product-name, .product-price {
        display: block;
        margin-bottom: 10px;
    }

    .product-name {
        font-size: 18px;
        font-weight: 700;
        color: #333;
    }

    .product-price {
        font-size: 20px;
        font-weight: 700;
        color: #c2a87d;
    }

    /* 메타 정보 (좋아요, 평점) */
    .kit-meta {
        width: 130px;
        display: flex;
        flex-direction: column;
        gap: 10px;
        text-align: center;
        padding-right: 20px;
    }

    .meta-item {
        display: flex;
        align-items: center;
        font-size: 15px;
        color: #555;
    }

    .meta-like {
        color: #ff5a5a;
    }

    .meta-rating {
        color: #ffaa00;
    }

    .meta-icon {
        margin-right: 8px;
        font-size: 18px;
    }

    /* 장바구니 버튼 */
    .cart-button {
        background: linear-gradient(135deg, #c4b99c 0%, #a59785 100%);
        color: white;
        border: none;
        padding: 12px 20px;
        border-radius: 8px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        box-shadow: 0 4px 10px rgba(165, 151, 133, 0.2);
    }

    .cart-button:hover {
        background: linear-gradient(135deg, #a59785 0%, #8a7b68 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(165, 151, 133, 0.3);
    }

    .cart-button i {
        margin-right: 8px;
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
    }

    .empty-message i {
        font-size: 50px;
        margin-bottom: 15px;
        display: block;
        color: #ddd;
    }

    /* 반응형 */
    @media (max-width: 768px) {
        .kit-container {
            padding: 20px 15px;
            margin: 20px 15px;
        }

        .kit-item {
            flex-direction: column;
            align-items: stretch;
            padding: 15px;
        }

        .kit-image {
            width: 100%;
            height: 200px;
            margin-bottom: 15px;
        }

        .kit-info {
            padding: 0 0 15px 0;
            text-align: center;
        }

        .kit-meta {
            width: 100%;
            flex-direction: row;
            justify-content: center;
            gap: 20px;
            padding: 15px 0;
            border-top: 1px solid #f0f0f0;
            border-bottom: 1px solid #f0f0f0;
            margin-bottom: 15px;
        }

        .cart-button {
            width: 100%;
            justify-content: center;
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
	            </div>
	
	            <!-- 좋아요 수 & 평점 -->
	            <div class="kit-meta">
	                <div class="meta-item meta-like">
	                    <i class="fas fa-heart meta-icon"></i>
	                    <span>${item.item_like}</span>
	                </div>
	                <div class="meta-item meta-rating">
	                    <i class="fas fa-star meta-icon"></i>
	                    <span>${item.item_avgRating}</span>
	                </div>
	            </div>
	
	            <!-- 장바구니 버튼 -->
	            <button class="cart-button" onclick="addToCart('${item.item_index}', this)">
	                <i class="fas fa-shopping-cart"></i>장바구니 추가
	            </button>
	        </div>
	    </c:forEach>
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