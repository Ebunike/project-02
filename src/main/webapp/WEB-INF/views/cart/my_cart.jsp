<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html> 
<head> 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>장바구니</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<style>
    body {
        background-color: #f8f9fa;
        color: #343a40;
        font-family: 'Noto Sans KR', sans-serif;
    }
    
    .cart-container {
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
        padding: 30px;
        margin: 40px auto;
    }
    
    .cart-header {
        border-bottom: 1px solid #e9ecef;
        margin-bottom: 20px;
        padding-bottom: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .cart-header h2 {
        font-weight: 600;
        color: #212529;
        font-size: 1.8rem;
        margin-bottom: 0;
    }
    
    .cart-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0 15px;
    }
    
    .cart-table thead th {
        border-bottom: 2px solid #dee2e6;
        padding: 12px 15px;
        font-weight: 600;
        color: #495057;
        background-color: #f8f9fa;
        text-transform: uppercase;
        font-size: 0.85rem;
        letter-spacing: 0.5px;
    }
    
    .cart-table tbody tr {
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
        border-radius: 8px;
        background-color: white;
        transition: transform 0.2s;
    }
    
    .cart-table tbody tr:hover {
        transform: translateY(-2px);
    }
    
    .cart-table tbody td {
        padding: 20px 15px;
        vertical-align: middle;
        border-top: none;
    }
    
    .item-info {
        display: flex;
        align-items: center;
    }
    
    .item-checkbox {
        margin-right: 15px;
        width: 20px;
        height: 20px;
        cursor: pointer;
    }
    
    .item-name {
        font-weight: 500;
        color: #212529;
        font-size: 1.1rem;
    }
    
    .quantity-control {
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .quantity-btn {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        border: 1px solid #ced4da;
        background-color: white;
        color: #495057;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.2s;
    }
    
    .quantity-btn:hover {
        background-color: #f8f9fa;
        border-color: #adb5bd;
    }
    
    .quantity-value {
        margin: 0 12px;
        font-weight: 500;
        width: 30px;
        text-align: center;
    }
    
    .price {
        font-weight: 600;
        color: #495057;
    }
    
    .remove-btn {
        background-color: #fff;
        color: #dc3545;
        border: 1px solid #dc3545;
        border-radius: 4px;
        padding: 6px 12px;
        cursor: pointer;
        transition: all 0.2s;
    }
    
    .remove-btn:hover {
        background-color: #dc3545;
        color: white;
    }
    
    .summary-section {
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
        padding: 25px;
        margin-top: 30px;
    }
    
    .summary-title {
        font-size: 1.3rem;
        font-weight: 600;
        margin-bottom: 20px;
        padding-bottom: 15px;
        border-bottom: 1px solid #e9ecef;
    }
    
    .summary-item {
        display: flex;
        justify-content: space-between;
        margin-bottom: 15px;
    }
    
    .summary-total {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
        padding-top: 20px;
        border-top: 2px solid #e9ecef;
        font-weight: 700;
        font-size: 1.2rem;
    }
    
    .checkout-btn {
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 12px 24px;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        width: 100%;
        margin-top: 15px;
        transition: background-color 0.2s;
    }
    
    .checkout-btn:hover {
        background-color: #45a049;
    }
    
    .checkout-btn:disabled {
        background-color: #cccccc;
        cursor: not-allowed;
    }
    
    .empty-cart-message {
        text-align: center;
        padding: 40px 0;
        color: #6c757d;
    }
    
    .empty-cart-icon {
        font-size: 3rem;
        margin-bottom: 15px;
        color: #adb5bd;
    }
    
    .select-all-container {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
    }
    
    .select-all-checkbox {
        margin-right: 10px;
        width: 18px;
        height: 18px;
    }
    
    @media (max-width: 768px) {
        .cart-container {
            padding: 20px 15px;
        }
        
        .cart-table thead {
            display: none;
        }
        
        .cart-table tbody td {
            display: block;
            text-align: right;
            padding: 12px 15px;
        }
        
        .cart-table tbody td:before {
            content: attr(data-label);
            float: left;
            font-weight: 600;
        }
        
        .cart-table tbody tr {
            margin-bottom: 20px;
            display: block;
        }
        
        .quantity-control {
            justify-content: flex-end;
        }
        
        .item-info {
            flex-direction: column;
            align-items: flex-end;
        }
    }
</style>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<div class="container cart-container">
    <div class="cart-header">
        <h2><i class="fas fa-shopping-cart mr-2"></i> 장바구니</h2>
    </div>
    
    <c:if test="${empty cartItems}">
        <div class="empty-cart-message">
            <div class="empty-cart-icon">
                <i class="fas fa-shopping-cart"></i>
            </div>
            <p>장바구니가 비어있습니다.</p>
            <a href="${root}/item/kit/kitMain" class="btn btn-primary">쇼핑 계속하기</a>
        </div>
    </c:if>
    
    <c:if test="${not empty cartItems}">
        <!-- 전체 선택 체크박스 추가 -->
        <div class="select-all-container">
            <input type="checkbox" id="select-all" class="select-all-checkbox" checked>
            <label for="select-all">전체 선택</label>
        </div>
        
        <div class="table-responsive">
            <table class="cart-table">
                <thead>
                    <tr>
                        <th width="50%">상품정보</th>
                        <th width="15%" class="text-center">수량</th>
                        <th width="15%" class="text-center">가격</th>
                        <th width="20%" class="text-center">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cartItems}" var="item">
                        <tr id="row-${item.item_index}">
                            <td data-label="상품정보">
                                <div class="item-info">
                                    <!-- 개별 상품 체크박스 추가 -->
                                    <input type="checkbox" class="item-checkbox" data-item-index="${item.item_index}" checked>
                                    <span class="item-name">${item.item_name}</span>
                                </div>
                            </td>
                            <td data-label="수량" class="text-center">
                                <div id="price-${item.item_index}" style="display: none">${item.item_price}</div>
                                <div class="quantity-control">
                                    <button type="button" class="quantity-btn" onclick="decreaseQuantity(${item.item_index})">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                    <span id="quantity-${item.item_index}" class="quantity-value">${item.cart_quantity}</span>
                                    <button type="button" class="quantity-btn" onclick="increaseQuantity(${item.item_index})">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                </div>
                            </td>
                            <td data-label="가격" class="text-center price">
                                <span id="total-${item.item_index}">${item.item_price * item.cart_quantity}</span> 원
                            </td>
                            <td data-label="관리" class="text-center">
                                <button class="remove-btn" onclick="removeItem(${item.item_index})">
                                    <i class="fas fa-trash-alt mr-1"></i> 삭제
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="summary-section">
            <div class="summary-title">주문 요약</div>
            <div class="summary-item">
                <span>선택한 상품 금액</span>
                <span id="selected-total">0</span> 원
            </div>
            <div class="summary-total">
                <span>총 결제금액</span>
                <span id="final-total">0</span> 원
            </div>
            <button id="checkout-btn" class="checkout-btn" onclick="checkout()">
                <i class="fas fa-credit-card mr-2"></i> 결제하기
            </button>
        </div>
    </c:if>
</div>

<script type="text/javascript">
    // 선택된 아이템에 대한 합계 계산
    function updateSelectedTotal() {
        const checkboxes = document.querySelectorAll('.item-checkbox');
        let selectedTotal = 0;
        
        checkboxes.forEach((checkbox) => {
            if (checkbox.checked) {
                const itemIndex = checkbox.getAttribute('data-item-index');
                const totalElement = document.getElementById('total-' + itemIndex);
                if (totalElement) {
                    selectedTotal += parseInt(totalElement.innerText);
                }
            }
        });
        
        document.getElementById('selected-total').innerText = selectedTotal;
        document.getElementById('final-total').innerText = selectedTotal;
        
        // 결제 버튼 활성화/비활성화
        const checkoutBtn = document.getElementById('checkout-btn');
        if (selectedTotal === 0) {
            checkoutBtn.disabled = true;
        } else {
            checkoutBtn.disabled = false;
        }
    }
    
    // 체크박스 이벤트 핸들러 등록
    document.addEventListener('DOMContentLoaded', function() {
        const selectAllCheckbox = document.getElementById('select-all');
        const itemCheckboxes = document.querySelectorAll('.item-checkbox');
        
        // 전체 선택 체크박스 이벤트
        selectAllCheckbox.addEventListener('change', function() {
            const isChecked = this.checked;
            
            itemCheckboxes.forEach((checkbox) => {
                checkbox.checked = isChecked;
            });
            
            updateSelectedTotal();
        });
        
        // 개별 체크박스 이벤트
        itemCheckboxes.forEach((checkbox) => {
            checkbox.addEventListener('change', function() {
                updateSelectedTotal();
                
                // 모든 체크박스가 선택되었는지 확인
                const allChecked = Array.from(itemCheckboxes).every(cb => cb.checked);
                selectAllCheckbox.checked = allChecked;
            });
        });
        
        // 초기 합계 계산
        updateSelectedTotal();
    });
    
    // 개별 상품 합계 업데이트
    function updateItemTotal(item_index, cart_quantity) {
        const totalElement = document.getElementById('total-' + item_index);
        const priceElement = document.getElementById('price-' + item_index);
        
        if (totalElement && priceElement) { // 요소 존재 여부 확인
            const price = parseInt(priceElement.innerText);
            totalElement.innerText = price * cart_quantity;

            // 선택된 항목에 대한 합계 업데이트
            updateSelectedTotal();
            
            // 개별 상품 합계를 서버로 전송
            sendAjaxRequest("${root}/cart/updateTotal", { 
                itemIndex: item_index,
                totalAmount: price * cart_quantity 
            }, () => {
                console.log(`아이템 ${item_index}의 합계가 서버에 저장되었습니다.`);
            });
        } else {
            console.error('Item or price element not found for item_index:', item_index);
        }
    }

    // AJAX 요청 함수
    function sendAjaxRequest(url, data, successCallback) {
        const xhr = new XMLHttpRequest();
        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onload = function() {
            if (xhr.status === 200) {
                successCallback();
            } else {
                console.error("Error:", xhr.responseText);
            }
        };
        xhr.send(new URLSearchParams(data).toString());
    }
     
    // 수량 증가
    function increaseQuantity(item_index) {
        let index = item_index;
        
        const quantityElement = document.getElementById('quantity-' + index);
        if (quantityElement) {
            sendAjaxRequest("${root}/cart/increase", { itemIndex: item_index }, () => {
                let currentQuantity = parseInt(quantityElement.innerText);
                currentQuantity++;
                quantityElement.innerText = currentQuantity;
                updateItemTotal(index, currentQuantity);
            });
        }
    }
    
    // 수량 감소
    function decreaseQuantity(item_index) {
        let index = item_index;
        const quantityElement = document.getElementById('quantity-' + index);
        if (quantityElement) {
            let currentQuantity = parseInt(quantityElement.innerText);
            if (currentQuantity > 1) {
                sendAjaxRequest("${root}/cart/decrease", { itemIndex: index }, () => {
                    currentQuantity--;
                    quantityElement.innerText = currentQuantity;
                    updateItemTotal(index, currentQuantity);
                });
            }
        }
    }
    
    // 아이템 삭제
    function removeItem(item_index) {
        let index = item_index;
        const row = document.getElementById('row-' + index);
        if (row) {
            sendAjaxRequest("${root}/cart/remove", { itemIndex: index }, () => {
                row.parentNode.removeChild(row);
                updateSelectedTotal();
                
                // 장바구니가 비었는지 확인
                const remainingItems = document.querySelectorAll('[id^="row-"]');
                if (remainingItems.length === 0) {
                    location.reload(true); // 페이지 새로고침하여 빈 장바구니 메시지 표시
                }
            });
        }
    }
    
    // 결제하기 함수
    function checkout() {
        // 선택된 상품 목록 확인
        const selectedItems = [];
        const checkboxes = document.querySelectorAll('.item-checkbox:checked');
        
        if (checkboxes.length === 0) {
            alert("선택된 상품이 없습니다. 결제할 상품을 선택해주세요.");
            return;
        }
        
        checkboxes.forEach((checkbox) => {
            selectedItems.push(checkbox.getAttribute('data-item-index'));
        });
        
        // 선택된 상품 목록을 쿼리스트링으로 전달
        const selectedItemsParam = selectedItems.join(',');
        location.href = "${root}/cart/my_pay?items=" + selectedItemsParam;
    }
    
    // 페이지 로드 시 초기화
    document.addEventListener('DOMContentLoaded', function() {
        // 선택한 항목에 대한 총합 계산
        updateSelectedTotal();
    });
</script>

<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>