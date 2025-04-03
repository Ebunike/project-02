<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>주문/결제</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<!-- Daum 우편번호 API 스크립트 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
    /* 기본 스타일 */
    body {
        background-color: #f5f6f7;
        color: #333;
        font-family: 'Noto Sans KR', sans-serif;
        line-height: 1.5;
    }
    
    /* 헤더 영역 */
    .header {
        background-color: white;
        border-bottom: 1px solid #e5e5e5;
        padding: 15px 0;
        margin-bottom: 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }
    
    /* 컨테이너 스타일 */
    .payment-container {
        max-width: 1000px;
        margin: 0 auto;
        padding: 20px 10px;
    }
    
    /* 페이지 제목 */
    .page-title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 30px;
        padding-bottom: 15px;
        border-bottom: 2px solid #333;
        text-align: center;
    }
    
    /* 섹션 스타일 */
    .payment-section {
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        padding: 25px;
        margin-bottom: 25px;
        border: 2px solid transparent;
        transition: all 0.3s ease;
    }
    
    .payment-section:hover {
        box-shadow: 0 6px 15px rgba(0,0,0,0.12);
    }
    
    /* 섹션 제목 */
    .section-title {
        font-size: 18px;
        font-weight: 600;
        color: #333;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        border-bottom: 2px solid #f0f0f0;
        padding-bottom: 10px;
    }
    
    .section-title i {
        margin-right: 12px;
        color: #03c75a;
        font-size: 20px;
    }
    
    /* 폼 라벨 */
    .form-label {
        font-weight: 500;
        color: #555;
        margin-bottom: 8px;
    }
    
    /* 폼 그룹 */
    .form-group {
        margin-bottom: 20px;
    }
    
    /* 입력 필드 */
    .form-control {
        border-radius: 8px;
        border: 1px solid #ddd;
        padding: 12px 15px;
        width: 100%;
        transition: all 0.3s ease;
    }
    
    .form-control:focus {
        border-color: #03c75a;
        box-shadow: 0 0 0 0.2rem rgba(3,199,90,0.25);
    }
    
    .form-control[readonly] {
        background-color: #f8f9fa;
        cursor: not-allowed;
    }
    
    /* 주소 관련 버튼 */
    .address-btn {
        background-color: #03c75a;
        color: white;
        border: none;
        border-radius: 8px;
        padding: 10px 15px;
        font-size: 14px;
        margin-left: 10px;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .address-btn:hover {
        background-color: #02ad4e;
    }
    
    /* 결제 수단 */
    .payment-methods {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        margin-top: 15px;
    }
    
    .payment-method {
        flex: 0 0 calc(50% - 15px);
        border: 2px solid #e0e0e0;
        border-radius: 12px;
        padding: 20px;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s ease;
        background-color: white;
        box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        position: relative;
        overflow: hidden;
    }
    
    .payment-method::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(to bottom, rgba(255,255,255,0.9), rgba(255,255,255,0.7));
        opacity: 0;
        transition: opacity 0.3s ease;
    }
    
    .payment-method:hover::before {
        opacity: 1;
    }
    
    .payment-method i {
        font-size: 36px;
        margin-bottom: 12px;
        color: #666;
        transition: color 0.3s ease, transform 0.3s ease;
    }
    
    .payment-method div {
        font-weight: 600;
        color: #333;
        transition: color 0.3s ease;
    }
    
    /* Kakaopay 특정 스타일링 */
    .payment-method[data-method="kakaopay"]:hover,
    .payment-method[data-method="kakaopay"].active {
        border-color: #FFEB00;
        background-color: #FFF5CC;
    }
    
    .payment-method[data-method="kakaopay"]:hover i,
    .payment-method[data-method="kakaopay"].active i {
        color: #FFEB00;
        transform: scale(1.1);
    }
    
    /* 토스/카드 특정 스타일링 */
    .payment-method[data-method="toss"]:hover,
    .payment-method[data-method="toss"].active {
        border-color: #0064FF;
        background-color: #E6F2FF;
    }
    
    .payment-method[data-method="toss"]:hover i,
    .payment-method[data-method="toss"].active i {
        color: #0064FF;
        transform: scale(1.1);
    }
    
    /* 상품 목록 테이블 */
    .product-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .product-table th {
        background-color: #f8f9fa;
        padding: 15px 10px;
        text-align: center;
        border-bottom: 2px solid #03c75a;
        font-weight: 600;
        color: #333;
    }
    
    .product-table td {
        padding: 15px 10px;
        border-bottom: 1px solid #eee;
        vertical-align: middle;
        text-align: center;
    }
    
    .product-img {
        width: 100px;
        height: 100px;
        object-fit: cover;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    
    .product-name {
        font-weight: 500;
        color: #333;
    }
    
    .product-price {
        font-weight: 600;
        color: #03c75a;
    }
    
    /* 최종 결제 정보 */
    .payment-summary {
        background-color: #f9f9f9;
        border-radius: 12px;
        padding: 25px;
        border: 1px solid #e9e9e9;
    }
    
    .summary-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 15px;
        font-size: 16px;
        color: #555;
    }
    
    .summary-row.total {
        border-top: 1px solid #ddd;
        padding-top: 20px;
        margin-top: 20px;
        font-size: 20px;
        font-weight: 700;
        color: #333;
    }
    
    .summary-price {
        color: #03c75a;
        font-weight: 600;
    }
    
    /* 결제 버튼 */
    .payment-btn {
        background-color: #03c75a;
        color: white;
        font-size: 18px;
        font-weight: 700;
        border: none;
        border-radius: 12px;
        padding: 15px;
        width: 100%;
        margin-top: 20px;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }
    
    .payment-btn:hover {
        background-color: #02ad4e;
        box-shadow: 0 6px 8px rgba(0,0,0,0.15);
        transform: translateY(-2px);
    }
    
    /* 약관 동의 */
    .terms-container {
        margin-top: 25px;
    }
    
    .terms-agree {
        display: flex;
        align-items: center;
        margin-bottom: 12px;
    }
    
    .terms-agree input {
        margin-right: 12px;
        transform: scale(1.2);
    }
    
    .terms-agree label {
        font-size: 15px;
        color: #555;
    }
    
    .terms-details {
        font-size: 13px;
        color: #888;
        margin-left: 30px;
        line-height: 1.6;
    }
    
    /* 모바일 반응형 */
    @media (max-width: 768px) {
        .payment-method {
            flex: 0 0 100%;
        }
        
        .product-table th:nth-child(2),
        .product-table td:nth-child(2) {
            display: none;
        }
    }
    select.form-control:not([size]):not([multiple]) {
    height: calc(2.25rem + 10px);
}
</style>
</head>
<body>
    <!-- 상단 메뉴 부분 -->
    <div class="header">
        <div class="container">
            <h1 class="text-center">
                <a href="${root}/" class="text-dark text-decoration-none">tlqkf쇼핑몰</a>
            </h1>
        </div>
    </div>

    <div class="payment-container">
        <h2 class="page-title">주문/결제</h2>
        
        <!-- 배송지 정보 섹션 -->
        <div class="payment-section">
            <h3 class="section-title">
                <i class="fas fa-map-marker-alt"></i> 배송지 정보
            </h3>
            <div class="row">
                <div class="col-md-6">
                    <!-- 배송지 정보 입력 폼 -->
                    <div class="form-group">
                        <label class="form-label">수신자</label>
                        <input type="text" class="form-control" id="recipient" value="${loginUser.name}" readonly>
                    </div>
                    <div class="form-group">
                        <label class="form-label">연락처</label>
                        <input type="text" class="form-control" id="tel" value="${loginUser.tel}" readonly>
                    </div>
                    <div class="form-group">
                        <label class="form-label">주소</label>
                        <div class="d-flex">
                            <input type="text" class="form-control" id="address" value="${loginUser.address}" readonly>
                            <button class="address-btn" onclick="changeAddress()">주소변경</button>
                            <button class="address-btn" onclick="findAddress()">주소검색</button>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <!-- 배송 요청사항 -->
                    <div class="form-group">
                        <label class="form-label">배송 요청사항</label>
                        <select class="form-control" id="deliveryRequest">
                            <option>배송 요청사항을 선택해주세요</option>
                            <option>직접 받겠습니다</option>
                            <option>문 앞에 놓아주세요</option>
                            <option>부재 시 경비실에 맡겨주세요</option>
                            <option>부재 시 택배함에 넣어주세요</option>
                            <option>직접 입력</option>
                        </select>
                    </div>
                    <div class="form-group" id="customRequestContainer" style="display: none;">
                        <label class="form-label">직접 입력</label>
                        <textarea class="form-control" id="customRequest" rows="3"></textarea>
                    </div>
                </div>
            </div>
        </div>
<!-- 주문 상품 정보 섹션 -->
        <div class="payment-section">
            <h3 class="section-title">
                <i class="fas fa-shopping-basket"></i> 주문상품
            </h3>
            <div class="table-responsive">
                <table class="product-table">
                    <thead>
                        <tr>
                            <th width="20%">이미지</th>
                            <th width="40%">상품정보</th>
                            <th width="20%">수량</th>
                            <th width="20%">주문금액</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 서버에서 가져온 장바구니 상품 목록을 반복문으로 표시 -->
                        <c:forEach items="${cartItems}" var="item">
                            <tr id="row-${item.item_index}">
                                <td>
                                    <img src="${root}/upload/${item.item_picture}" alt="${item.item_name}" class="product-img">
                                </td>
                                <td class="product-name">${item.item_name}</td>
                                <td>${item.cart_quantity}개</td>
                                <td class="product-price">${item.item_price * item.cart_quantity}원</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- 결제 수단 섹션 -->
        <div class="payment-section">
            <h3 class="section-title">
                <i class="fas fa-credit-card"></i> 결제수단
            </h3>
            <div class="payment-methods">
                <!-- 결제 수단 선택 버튼들 -->
                <div class="payment-method" data-method="kakaopay" onclick="selectPayment(this, 'kakaopay')">
                    <i class="fab fa-kaggle"></i>
                    <div>카카오페이</div>
                </div>
                <div class="payment-method" data-method="toss" onclick="selectPayment(this, 'toss')">
                    <i class="fas fa-credit-card"></i>
                    <div>토스/카드결제</div>
                </div>
            </div>
        </div>
        
        <!-- 최종 결제 금액 섹션 -->
        <div class="payment-section">
            <h3 class="section-title">
                <i class="fas fa-calculator"></i> 결제 금액
            </h3>
            <div class="payment-summary">
                <div class="summary-row">
                    <span>총 상품 금액</span>
                    <span class="summary-price" id="total-product-price">
                        <c:set var="totalPrice" value="0" />
                        <c:forEach items="${cartItems}" var="item">
                            <c:set var="totalPrice" value="${totalPrice + (item.item_price * item.cart_quantity)}" />
                        </c:forEach>
                        ${totalPrice}원
                    </span>
                </div>
                <div class="summary-row">
                    <span>배송비</span>
                    <span>무료</span>
                </div>
                <div class="summary-row">
                    <span>할인 금액</span>
                    <span>0원</span>
                </div>
                <div class="summary-row total">
                    <span>최종 결제 금액</span>
                    <span class="summary-price">${totalPrice}원</span>
                </div>
            </div>
            
            <!-- 약관 동의 -->
            <div class="terms-container">
                <div class="terms-agree">
                    <input type="checkbox" id="agreeAll">
                    <label for="agreeAll"><strong>전체 동의</strong></label>
                </div>
                <div class="terms-agree">
                    <input type="checkbox" id="agreeTerms" class="agree-checkbox">
                    <label for="agreeTerms">구매조건 및 결제대행 서비스 약관에 동의 (필수)</label>
                </div>
                <div class="terms-agree">
                    <input type="checkbox" id="agreePrivacy" class="agree-checkbox">
                    <label for="agreePrivacy">개인정보 수집 및 이용 동의 (필수)</label>
                </div>
                <div class="terms-details">
                    주문 내용을 확인하였으며, 정보 제공 등에 동의합니다.
                </div>
            </div>
            
            <!-- 결제하기 버튼 -->
            <button class="payment-btn" onclick="processPayment()">
                <span id="final-payment-amount">${totalPrice}</span>원 결제하기
            </button>
        </div>
    </div>
    
    <script type="text/javascript">
        // 배송 요청사항 직접 입력 처리
        document.getElementById('deliveryRequest').addEventListener('change', function() {
            const customRequestContainer = document.getElementById('customRequestContainer');
            if (this.value === '직접 입력') {
                customRequestContainer.style.display = 'block';
            } else {
                customRequestContainer.style.display = 'none';
            }
        });
        
        // 결제 수단 선택 함수
        function selectPayment(element, method) {
            // 모든 결제 수단에서 active 클래스 제거
            const allMethods = document.querySelectorAll('.payment-method');
            allMethods.forEach(item => {
                item.classList.remove('active');
            });
            
            // 선택한 결제 수단에 active 클래스 추가
            element.classList.add('active');
            
            // 선택된 결제 수단 저장 (실제 결제 처리 시 사용)
            const hiddenInput = document.getElementById('selectedPaymentMethod');
            if (hiddenInput) {
                hiddenInput.value = method;
            }
        }
        
        // 주소 변경 함수
        function changeAddress() {
            // 현재 readonly 속성 제거
            document.getElementById('address').readOnly = false;
            
            // 주소 검색 기능 활성화
            alert('주소를 변경할 수 있습니다. 새로운 주소를 입력하세요.');
            document.getElementById('address').focus();
            
            // 버튼 텍스트 변경
            document.querySelector('.address-btn').textContent = '주소검색';
            document.querySelector('.address-btn').onclick = findAddress;
        }
        
        // 주소 검색 함수 (다음 우편번호 API 사용)
        function findAddress() {
           new daum.Postcode({
              oncomplete: function(data) {
                 var roadAddr = data.roadAddress; // 도로명 주소
                 if (roadAddr) {
                    document.getElementById("address").value = roadAddr; // 도로명 주소 필드
                 }
              }
           }).open();
        }
        
        // 전체 동의 처리
        document.getElementById('agreeAll').addEventListener('change', function() {
            const checkboxes = document.querySelectorAll('.agree-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });
        
        // 개별 체크박스 변경 시 전체 동의 상태 업데이트
        document.querySelectorAll('.agree-checkbox').forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                const allChecked = Array.from(document.querySelectorAll('.agree-checkbox')).every(box => box.checked);
                document.getElementById('agreeAll').checked = allChecked;
            });
        });
        
        // 결제 처리 함수
        function processPayment() {
            // 필수 입력값 검증
            const recipient = document.getElementById('recipient').value;
            const tel = document.getElementById('tel').value;
            const address = document.getElementById('address').value;
            
            if (!recipient || !tel || !address) {
                alert('배송 정보를 모두 확인해주세요.');
                return;
            }
            
            // 결제 수단 선택 확인
            const selectedMethod = document.querySelector('.payment-method.active');
            if (!selectedMethod) {
                alert('결제 수단을 선택해주세요.');
                return;
            }
            
            // 약관 동의 확인
            const termsAgreed = document.getElementById('agreeTerms').checked;
            const privacyAgreed = document.getElementById('agreePrivacy').checked;
            
            if (!termsAgreed || !privacyAgreed) {
                alert('필수 약관에 모두 동의해주세요.');
                return;
            }
            
            // 선택된 결제 방식에 따라 다른 페이지로 이동
            const paymentMethod = document.getElementById('selectedPaymentMethod').value;
            // 이미 my_cart에서 저장된 items 문자열 활용
            const urlParams = new URLSearchParams(window.location.search);
            const items = urlParams.get('items');
            
            if (paymentMethod === 'toss') {
                // 토스 결제 페이지로 이동
                window.location.href = '${root}/payment/forpayment?totalPrice=${totalPrice}&selectedItems=${items}';
            } else if (paymentMethod === 'kakaopay') {
                // 카카오페이 결제 페이지로 이동
                window.location.href = '${root}/payment/kakao/kakaopay?totalPrice=${totalPrice}&selectedItems=${items}';
            } else {
                alert('결제 수단을 선택해주세요.');
                return;
            }
        }
        
        // 페이지 로드 시 실행
        document.addEventListener('DOMContentLoaded', function() {
            // 숨겨진 input 필드 생성 (결제 방식 저장용)
            const hiddenInput = document.createElement('input');
            hiddenInput.type = 'hidden';
            hiddenInput.id = 'selectedPaymentMethod';
            document.body.appendChild(hiddenInput);
        });
    </script>
</body>
</html>