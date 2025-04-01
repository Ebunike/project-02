<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${item.item_name} - 상품 상세</title>
<!-- Bootstrap & jQuery -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
    /* 기본 스타일 */
    body {
        font-family: 'Noto Sans KR', sans-serif;
        color: #333;
        background-color: #f8f9fa;
        line-height: 1.6;
    }
    
    /* 메인 컨테이너 */
    .product-container {
        background-color: white;
        padding: 0;
        max-width: 960px;
        margin: 30px auto;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        border-radius: 12px;
        overflow: hidden;
    }
    
    /* 상품 헤더 */
    .product-header {
        padding: 40px 30px;
        border-bottom: 1px solid #eee;
        position: relative;
        display: flex;
        flex-wrap: wrap;
        background: linear-gradient(to right, rgba(255,255,255,0.95), rgba(255,255,255,0.8));
    }
    
    /* 상품 이미지 영역 */
    .product-image {
        flex: 0 0 42%;
        padding-right: 40px;
        position: relative;
    }
    
    .product-image img {
        width: 100%;
        max-height: 500px;
        object-fit: cover;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        transition: transform 0.3s ease;
    }
    
    .product-image img:hover {
        transform: scale(1.02);
    }
    
    /* 상품 정보 영역 */
    .product-info {
        flex: 0 0 58%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }
    
    .product-title {
        font-size: 32px;
        font-weight: 700;
        color: #222;
        margin-bottom: 20px;
        line-height: 1.3;
    }
    
    .product-seller {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
        color: #555;
        font-size: 16px;
    }
    
    .product-seller a {
        color: #3D5AFE;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        transition: all 0.3s ease;
    }
    
    .product-seller a:hover {
        color: #304FFE;
        text-decoration: none;
    }
    
    .product-price {
        font-size: 30px;
        font-weight: 700;
        color: #F44336;
        margin-bottom: 25px;
    }
    
    .product-quantity {
        margin-bottom: 25px;
        color: #555;
        font-size: 16px;
        display: inline-block;
        padding: 10px 15px;
        background-color: #f9f9fa;
        border-radius: 8px;
    }
    
    .product-quantity i {
        margin-right: 8px;
        color: #74b243;
    }
    
    /* 버튼 그룹 */
    .button-group {
        display: flex;
        gap: 15px;
        margin-top: 20px;
    }
    
    /* 구매하기 버튼 */
    .buy-button {
        background: linear-gradient(to right, #74b243, #5a9625);
        color: white;
        border: none;
        padding: 14px 28px;
        border-radius: 25px;
        font-weight: 500;
        font-size: 16px;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 10px rgba(116, 178, 67, 0.2);
        flex: 1;
    }
    
    .buy-button:hover {
        background: linear-gradient(to right, #6ba23a, #4e8420);
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(116, 178, 67, 0.3);
    }
    
    .buy-button i {
        margin-right: 8px;
    }
    
    /* 장바구니 버튼 */
    .cart-button {
        background: linear-gradient(to right, #4dabf7, #339af0);
        color: white;
        border: none;
        padding: 14px 28px;
        border-radius: 25px;
        font-weight: 500;
        font-size: 16px;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 10px rgba(77, 171, 247, 0.2);
        flex: 1;
    }
    
    .cart-button:hover {
        background: linear-gradient(to right, #3d96e0, #278bdc);
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(77, 171, 247, 0.3);
    }
    
    .cart-button i {
        margin-right: 8px;
    }
    
    /* 상품 상세 정보 영역 */
    .product-detail {
        padding: 30px;
    }
    
    .detail-title {
        font-size: 24px;
        font-weight: 700;
        color: #222;
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 1px solid #e9ecef;
        position: relative;
    }
    
    .detail-title:before {
        content: '';
        position: absolute;
        left: 0;
        bottom: -1px;
        width: 80px;
        height: 3px;
        background: linear-gradient(to right, #74b243, #5a9625);
        border-radius: 3px;
    }
    
    /* 기본 설명 스타일 */
    .basic-info {
        margin-bottom: 30px;
        padding: 20px;
        background-color: #f9f9fa;
        border-radius: 10px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.03);
        line-height: 1.7;
    }
    
    /* 상세 설명 단계 스타일 */
    .detail-steps {
        counter-reset: step-counter;
        position: relative;
        padding-left: 25px;
    }
    
    .detail-step {
        margin-bottom: 40px;
        padding-bottom: 40px;
        border-bottom: 1px dashed #ddd;
        position: relative;
        display: flex;
        flex-direction: column;
        padding-left: 10px;
    }
    
    .detail-step:last-child {
        border-bottom: none;
        margin-bottom: 0;
        padding-bottom: 0;
    }
    
    .step-number {
        position: absolute;
        left: -15px;
        top: 0;
        width: 35px;
        height: 35px;
        background: linear-gradient(to bottom right, #74b243, #5a9625);
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        box-shadow: 0 3px 6px rgba(0,0,0,0.1);
        z-index: 5;
    }
    
    .step-text {
        font-size: 17px;
        line-height: 1.8;
        color: #444;
        margin-bottom: 20px;
        padding-left: 15px;
    }
    
    .step-image {
        width: 100%;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    }
    
    /* 모달 스타일 */
    .modal-content {
        border: none;
        border-radius: 12px;
        overflow: hidden;
    }
    
    .modal-header {
        background: linear-gradient(to right, #f8f9fa, #e9ecef);
        padding: 20px 25px;
        border-bottom: 1px solid #e9ecef;
    }
    
    .modal-title {
        font-weight: 700;
        color: #333;
    }
    
    .modal-body {
        padding: 25px;
    }
    
    .form-control {
        border-radius: 8px;
        padding: 12px 15px;
        transition: all 0.3s ease;
    }
    
    .form-control:focus {
        border-color: #74b243;
        box-shadow: 0 0 0 3px rgba(116, 178, 67, 0.15);
    }
    
    /* 반응형 스타일 */
    @media (max-width: 991px) {
        .product-header {
            flex-direction: column;
            padding: 30px;
        }
        
        .product-image, .product-info {
            flex: 0 0 100%;
            padding: 0;
        }
        
        .product-image {
            margin-bottom: 30px;
        }
        
        .product-detail {
            padding: 20px;
        }
    }
    
    @media (max-width: 767px) {
        .button-group {
            flex-direction: column;
        }
        
        .buy-button, .cart-button {
            width: 100%;
            margin-bottom: 10px;
        }
        
        .product-title {
            font-size: 24px;
        }
        
        .product-price {
            font-size: 24px;
        }
        
        .detail-steps {
            padding-left: 15px;
        }
        
        .step-number {
            left: -10px;
            width: 30px;
            height: 30px;
        }
    }
</style>
<script>
    $(document).ready(function () {
       let root = "${root}";
        // 모달 내부의 폼 제출 시 채팅방 생성
        $('#chatRoomForm').on('submit', function (event) {
            event.preventDefault(); // 기본 폼 제출 동작 방지

            // 채팅방 제목 입력값 가져오기
            const chatRoomTitle = $('#chatRoomTitle').val().trim();
            if (!chatRoomTitle) {
                alert('채팅방 제목을 입력해주세요!');
                return;
            }

            // 사용자 정보 (JSP에서 데이터 렌더링됨)
         const buyerName = encodeURIComponent(`${loginUser.name}`);
         const sellerName = encodeURIComponent(`${sellerName}`);
         
         console.log(buyerName);

            // AJAX 요청
            $.ajax({
                type: "POST",
                url: root + "/chating/createRoom",
                data: {
                    buyer: buyerName,
                    seller: sellerName,
                    title: chatRoomTitle
                },
                success: function (response) {
                    // 요청 성공 시 생성된 채팅방으로 리다이렉션
                    window.location.href = root+'/chating/main';
                },
                error: function (xhr, status, error) {
                    // 에러 발생 시 처리
                    console.error("Error:", error);
                    alert("채팅방 생성에 실패했습니다. 다시 시도해주세요.");
                }
            });
        });
    });
</script>
</head>
<body>
<!-- 상단 메뉴 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<div class="product-container">
    <!-- 상품 기본 정보 영역 -->
    <div class="product-header">
        <!-- 상품 이미지 -->
        <div class="product-image">
            <img src="${root}/upload/${item.item_picture}" alt="${item.item_name}" />
        </div>
        
        <!-- 상품 기본 정보 -->
        <div class="product-info">
            <div>
                <h1 class="product-title">${item.item_name}</h1>
                <p class="product-seller">
                    <c:choose>
                        <c:when test="${loginUser.login.equals('buyer')}">
                            <a href="#" data-toggle="modal" data-target="#unifiedModal">
                                <i class="fas fa-store mr-1"></i> ${sellerName}
                            </a>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-store mr-1"></i> <span>${sellerName}</span>
                        </c:otherwise>
                    </c:choose>
                </p>
                <p class="product-price">${item.item_price}원</p>
                <p class="product-quantity"><i class="fas fa-box-open"></i> 재고 수량: ${item.item_quantity}개</p>
            </div>
            
            <!-- 구매 버튼 영역 -->
            <div class="button-group">
                <button class="buy-button">
                    <i class="fas fa-shopping-bag"></i> 구매하기
                </button>
                <!-- 장바구니 버튼 -->
                <button class="cart-button" onclick="addToCart('${item.item_index}', this)">
                    <i class="fas fa-cart-plus"></i> 장바구니 추가
                </button>
            </div>
        </div>
    </div>
    
    <!-- 상품 상세 정보 영역 -->
    <div class="product-detail">
        <h3 class="detail-title">상품 상세정보</h3>
        
        <!-- 기본 설명 -->
        <div class="basic-info">
            <p>${item.item_info}</p>
        </div>
        
        <!-- 상세 설명 단계 (insert_kit에서 등록한 상세 정보를 표시하는 영역) -->
        <%-- <div class="detail-steps">
            <!-- 예시 단계 - 실제로는 데이터베이스에서 가져온 상세 설명 단계로 대체됩니다 -->
            <!-- 상세 설명 단계 1 -->
            <div class="detail-step">
                <div class="step-number">1</div>
                <p class="step-text">상품을 세척한 후 사용하시면 더욱 위생적입니다. 흐르는 물에 가볍게 세척 후 사용하세요.</p>
                <img src="${root}/images/detail/step1.jpg" alt="세척 방법" class="step-image">
            </div>
            
            <!-- 상세 설명 단계 2 -->
            <div class="detail-step">
                <div class="step-number">2</div>
                <p class="step-text">제품의 특성에 맞게 사용 전 반드시 사용 설명서를 읽어보세요. 잘못된 사용은 제품 손상을 일으킬 수 있습니다.</p>
                <img src="${root}/images/detail/step2.jpg" alt="사용 방법" class="step-image">
            </div>
            
            <!-- 상세 설명 단계 3 -->
            <div class="detail-step">
                <div class="step-number">3</div>
                <p class="step-text">사용 후에는 직사광선을 피해 서늘한 곳에 보관하세요. 습기가 많은 곳에 보관할 경우 제품 변형이 일어날 수 있습니다.</p>
                <img src="${root}/images/detail/step3.jpg" alt="보관 방법" class="step-image">
            </div>
        </div> --%>
    </div>
</div>

<!-- 채팅방 생성 모달 -->
<div class="modal fade" id="unifiedModal" tabindex="-1" role="dialog" aria-labelledby="unifiedModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="unifiedModalLabel">판매자 정보 및 채팅</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h6 class="mb-3">판매자: ${sellerName}</h6>
                <p>판매자에게 문의하시려면 아래 버튼을 눌러주세요.</p>
                <!-- 채팅방 제목 설정 -->
                <form id="chatRoomForm" method="post">
                    <div class="form-group">
                        <label for="chatRoomTitle">채팅방 제목</label>
                        <input type="text" class="form-control" id="chatRoomTitle" placeholder="채팅방 제목을 입력하세요" required>
                    </div>
                    <button type="submit" class="btn btn-primary">확인</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
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
<!-- 하단 정보 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>