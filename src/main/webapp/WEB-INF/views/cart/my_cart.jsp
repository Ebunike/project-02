<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
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
        <h1>장바구니</h1>
        <table>
            <thead>
                <tr>
                    <th>상품명</th>
                    <!-- <th>가격</th> -->
                    <th>수량</th>
                    <th>가격</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${cartItems}" var="item">
                    <tr id="row-${item.item_index}">
					    <td>${item.item_name}</td>
					    <td  id="price-${item.item_index}" style="display: none">${item.item_price}</td>
					    <td class="quantity-control">
					        <button type="button" onclick="decreaseQuantity(${item.item_index})">-</button>
					        <span id="quantity-${item.item_index}">${item.cart_quantity}</span>
					        <button type="button" onclick="increaseQuantity(${item.item_index})">+</button>
					    </td>
					    <td id="total-${item.item_index}">${item.item_price * item.cart_quantity}</td>
					    <td class="actions">
					        <button onclick="removeItem(${item.item_index})">삭제</button>
					    </td>
					</tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 최종 합계 표시 -->
        <div class="total-price">
            총 합계: <span id="grand-total">0</span> 원
        </div>

        <div class="actions">
            <button onclick="checkout()">결제하기</button> <!-- 아직 뭐가 없음 -->
        </div>
    </div>

    <script type="text/javascript">
        // 장바구니 합계 업데이트 함수
        function updateGrandTotal() {
            const totalElements = document.querySelectorAll('[id^="total-"]');
            let grandTotal = 0;
            totalElements.forEach((totalElement) => {
                grandTotal += parseInt(totalElement.innerText);
            });
            document.getElementById(`grand-total`).innerText = grandTotal;
            
         // 합계를 서버로 전송
            sendAjaxRequest("${root}/cart/updateTotal", { totalAmount: grandTotal }, () => {
                console.log("합계금액이 DB에 저장되었습니다.");
            });
        }
     // 개별 상품 합계 업데이트
        function updateItemTotal(item_index, cart_quantity) {
    	 let index = item_index;
    	 let quantity = cart_quantity;
            const totalElement = document.getElementById('total-'+index);
            const price = parseInt(document.getElementById('price-'+index).innerText); // 가격을 가져오는 방식 수정
            if (totalElement) {
                totalElement.innerText = price * quantity;
                updateGrandTotal(); // 전체 합계 업데이트
            } else {
                console.error('Element with id "total-${item_index}" not found');
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
        	
            /* const quantityElement = document.getElementById(`quantity-${item_index}`); */
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
            /* const quantityElement = document.getElementById(`quantity-${item_index}`); */
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
                    updateGrandTotal();
                });
            }
        }
        // 결제하기
        function checkout() {
            alert("결제 페이지로 이동합니다.");
        }
        // 페이지 로드 시 초기 총합 계산
        updateGrandTotal();
    </script>
<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>