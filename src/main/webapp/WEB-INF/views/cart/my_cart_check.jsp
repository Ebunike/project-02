<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html> 
<html>
<head> 
<meta charset="UTF-8">
<title>My_cart</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<style>
        .cart-container { max-width: 800px; margin: 50px auto; }
        .cart-item { border-bottom: 1px solid #ddd; padding: 15px 0; display: flex; align-items: center; justify-content: space-between; }
        .cart-item img { width: 80px; height: 80px; object-fit: cover; }
        .quantity { width: 50px; text-align: center; }
    </style>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />
<%-- 내 배송 ${ 장바구니에 넣은 게시물 수 } --%>
<div class="container cart-container">
    <h2 class="text-center">장바구니</h2>
    
    <c:choose>
        <c:when test="${empty sessionScope.cart}">
            <p class="text-center">장바구니가 비어 있습니다.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="item" items="${sessionScope.cart}">
                <div class="cart-item">
                    <img src="${item.image}" alt="상품 이미지">
                    <span>${item.name}</span>
                    <span>${item.price}원</span>
                    <input type="number" class="quantity" value="${item.quantity}" min="1" data-id="${item.id}">
                    <button class="btn btn-danger btn-sm remove-item" data-id="${item.id}">삭제</button>
                </div>
            </c:forEach>
            <div class="text-right mt-3">
                <h4>총 가격: <span id="total-price">0</span>원</h4>
                <button class="btn btn-warning" id="clear-cart">장바구니 비우기</button>
            </div>
        </c:otherwise>
    </c:choose>
</div>
	<script>
	$(document).ready(function () {
	    function updateTotal() {
	        let total = 0;
	        $('.cart-item').each(function () {
	            let price = parseInt($(this).find('span:nth-child(3)').text().replace('원', ''));
	            let quantity = parseInt($(this).find('.quantity').val());
	            total += price * quantity;
	        });
	        $('#total-price').text(total);
	    }
	    
	    updateTotal();
	    
	    $('.quantity').on('change', function () {
	        let itemId = $(this).data('id');
	        let newQuantity = $(this).val();
	        $.post('${root}/updateCart', { id: itemId, quantity: newQuantity }, function () {
	            updateTotal();
	        });
	    });
	    
	    $('.remove-item').on('click', function () {
	        let itemId = $(this).data('id');
	        $(this).closest('.cart-item').remove();
	        $.post('${root}/removeFromCart', { id: itemId }, function () {
	            updateTotal();
	        });
	    });
	    
	    $('#clear-cart').on('click', function () {
	        $('.cart-item').remove();
	        $.post('${root}/clearCart', function () {
	            updateTotal();
	        });
	    });
	});
	</script>

<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>