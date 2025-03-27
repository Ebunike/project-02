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
    <style>
        .order-container {
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            margin-bottom: 20px;
            padding: 15px;
            background-color: #fff;
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #e0e0e0;
            padding-bottom: 10px;
            margin-bottom: 15px;
        }
        .order-date {
            font-weight: bold;
        }
        .order-number {
            color: #777;
        }
        .product-item {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #f0f0f0;
        }
        .product-image {
            width: 80px;
            height: 80px;
            margin-right: 15px;
        }
        .product-image img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
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
            font-weight: bold;
            margin-bottom: 5px;
        }
        .product-price {
            color: #333;
        }
        .product-quantity {
            color: #555;
            font-size: 0.9em;
        }
        .product-action {
            min-width: 100px;
            text-align: right;
        }
        .refund-btn {
            background-color: #33b5e5;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
        }
        .refund-btn:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
        .period-tabs {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .period-tab {
            flex: 1;
            text-align: center;
            padding: 10px;
            background-color: #f5f5f5;
            cursor: pointer;
            border-radius: 5px;
            margin: 0 5px;
        }
        .period-tab.active {
            background-color: #222;
            color: white;
        }
        .chevron-right {
            float: right;
            margin-top: 2px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2>주문 내역</h2>
        
        <!-- 기간 선택 탭 -->
        <div class="period-tabs">
            <div class="period-tab" data-period="3m">3개월</div>
            <div class="period-tab" data-period="6m">6개월</div>
            <div class="period-tab" data-period="1y">1년</div>
            <div class="period-tab active" data-period="all">3년</div>
        </div>
        
        <!-- 주문 목록 -->
        <c:forEach var="order" items="${orderHistory}">
            <div class="order-container">
                <div class="order-header">
                    <div class="order-date">
                        <!-- String으로 된 날짜 포맷팅 -->
                        <c:set var="formattedOrderDate" value="${fn:substring(order.orderDate, 0, 10)}" />
                        ${formattedOrderDate}
                        <div class="order-number">주문번호 ${order.orderId} <span class="chevron-right">›</span></div>
                    </div>
                </div>
                
                <div class="order-content">
                    <div class="delivery-date">
                        <!-- 주문 일시가 문자열일 경우 직접 포맷팅 처리 -->
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
            <div class="text-center py-5">
                <p>주문 내역이 없습니다.</p>
            </div>
        </c:if>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        // 기간 탭 선택
        $('.period-tab').on('click', function() {
            $('.period-tab').removeClass('active');
            $(this).addClass('active');
            
            const period = $(this).data('period');
            // 여기에 선택된 기간에 따라 주문 내역을 필터링하는 로직 추가
            // 예: location.href = '/orders/history?period=' + period;
        });
    </script>
</body>
</html>
