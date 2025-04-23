<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 내역</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .container {
            max-width: 800px;
            padding: 0 15px;
        }
        .main_title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #333;
        }
        .main_title h2 {
            margin: 0;
            font-weight: 700;
            color: #333;
        }
        .go_home .btn {
            background-color: transparent;
            border: 1px solid #333;
            color: #333;
            display: flex;
            align-items: center;
            padding: 8px 15px;
            border-radius: 4px;
            transition: all 0.3s ease;
        }
        .go_home .btn:hover {
            background-color: #333;
            color: white;
        }
        .go_home .btn i {
            margin-right: 8px;
        }
        .order-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            overflow: hidden;
            transition: box-shadow 0.3s ease;
        }
        .order-container:hover {
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        .order-header {
            background-color: #f8f9fa;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .order-date {
            font-weight: 600;
            color: #333;
        }
        .order-number {
            color: #6c757d;
            font-size: 0.9em;
        }
        .order-content {
            padding: 15px;
        }
        .product-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #e9ecef;
        }
        .product-image {
            width: 100px;
            height: 100px;
            margin-right: 20px;
            border-radius: 8px;
            overflow: hidden;
        }
        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .product-details {
            flex-grow: 1;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .product-info {
            flex-grow: 1;
        }
        .product-name {
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }
        .product-price {
            color: #007bff;
            font-weight: 500;
        }
        .product-quantity {
            color: #6c757d;
            font-size: 0.9em;
        }
        .refund-btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .refund-btn:hover:not(:disabled) {
            background-color: #0056b3;
        }
        .refund-btn:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
        }
        .chevron-right {
            color: #6c757d;
            margin-left: 5px;
        }
        .empty-order-message {
            text-align: center;
            padding: 50px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="main_title">
            <h2>주문 내역</h2>
            <div class="go_home">
                <a href="<c:url value='/'/>" class="btn">
                    <i class="fas fa-home"></i> 홈으로
                </a>
            </div>
        </div>
        
        <!-- 주문 목록 -->
        <c:forEach var="order" items="${orderHistory}">
            <div class="order-container">
                <div class="order-header">
                    <div class="order-date">
                        <c:set var="formattedOrderDate" value="${fn:substring(order.orderDate, 0, 10)}" />
                        ${formattedOrderDate}
                        <div class="order-number">주문번호 ${order.orderId} <span class="chevron-right">›</span></div>
                    </div>
                </div>
                
                <div class="order-content">
                    <div class="delivery-date">
                        <c:set var="formattedDeliveryDate" value="${fn:substring(order.orderDate, 5, 16)}" />
                        ${formattedDeliveryDate}
                    </div>
                    
                    <c:forEach var="detail" items="${order.orderDetails}">
                        <div class="product-item">
                            <div class="product-image">
                                <img src="${root}/upload/${detail.itemImage}" alt="${detail.itemName}">
                            </div>
                            <div class="product-details">
                                <div class="product-info">
                                    <div class="product-name">${detail.itemName}</div>
                                    <div class="product-price"><fmt:formatNumber value="${detail.finalPrice}" pattern="#,###" />원</div>
                                    <div class="product-quantity">${detail.count}개</div>
                                </div>
                                <div class="product-action">
                                    <c:choose>
                                        <c:when test="${detail.refundCheck eq 'refund'}">
                                            <button class="refund-btn" disabled>환불완료</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="refund-btn" 
                                                    onclick="location.href='${root }/payment/refund?paymentKey=${order.paymentKey}&itemName=${detail.itemName}&cancelAmount=${detail.finalPrice}&orderDetailIndex=${detail.orderDetailIndex}'">
                                                환불하기
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
        
        <!-- 주문 내역이 없는 경우 -->
        <c:if test="${empty orderHistory}">
            <div class="empty-order-message">
                <p>주문 내역이 없습니다.</p>
            </div>
        </c:if>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- 하단 정보 - include로 불러옴 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>