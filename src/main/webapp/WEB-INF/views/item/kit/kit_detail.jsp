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
<title>제품 상세페이지</title>
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
    /* Base Styles - 기본 스타일 */
    body {
        font-family: 'Noto Sans KR', sans-serif; /* 한글 지원 폰트 */
        background-color: #f8f9fa; /* 연한 회색 배경 */
        color: #343a40; /* 기본 텍스트 색상 */
        line-height: 1.6; /* 줄 간격 */
    }
    
    /* Container Styles - 전체 컨테이너 스타일 */
    .product-container {
        max-width: 1200px; /* 최대 너비 */
        margin: 40px auto; /* 상하 여백 및 중앙 정렬 */
        padding: 0 20px; /* 좌우 여백 */
        background-color: #fff; /* 흰색 배경 */
        border-radius: 12px; /* 둥근 모서리 */
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05); /* 입체감을 주는 그림자 효과 */
        overflow: hidden; /* 내용이 넘치면 숨김 처리 */
    }
    
    /* Product Header Area - 상품 상단 영역 */
    .product-header {
        display: flex; /* 플렉스 레이아웃 */
        flex-wrap: wrap; /* 화면 크기에 따라 줄바꿈 */
        margin: 0;
        padding: 40px; /* 안쪽 여백 */
        background: linear-gradient(to right, #f8f9fa, #fff); /* 왼쪽에서 오른쪽으로 그라데이션 배경 */
        border-bottom: 1px solid #eee; /* 하단 경계선 */
    }
    
    /* Product Image Area - 상품 이미지 영역 */
    .product-image {
        flex: 0 0 42%; /* 너비 42% 고정 */
        padding-right: 40px; /* 오른쪽 여백 */
        position: relative;
    }
    
    .product-image img {
        width: 100%; /* 너비 100% */
        height: 500px; /* 높이 자동 조정 */
        border-radius: 10px; /* 둥근 모서리 */
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
        transition: transform 0.3s ease; /* 호버 시 애니메이션 효과 */
    }
    
    .product-image img:hover {
        transform: scale(1.02); /* 마우스 오버 시 이미지 확대 효과 */
    }
    
    /* Product Info Area - 상품 정보 영역 */
    .product-info {
        flex: 0 0 58%; /* 너비 58% 고정 */
        padding-left: 30px; /* 왼쪽 여백 */
        display: flex;
        flex-direction: column; /* 세로 방향 정렬 */
        justify-content: space-between; /* 콘텐츠 사이 공간 균등 분배 */
    }
    
    .product-title {
        font-size: 32px;
        font-weight: 700;
        margin-bottom: 15px;
        color: #212529;
        letter-spacing: -0.5px;
        line-height: 1.3;
    }
    
    .product-seller {
        margin-bottom: 20px;
        color: #495057;
        font-size: 16px;
        display: flex;
        align-items: center;
    }
    
    .product-seller a {
        color: #3D5AFE;
        transition: color 0.2s;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
    }
    
    .product-seller a:hover {
        color: #304FFE;
        text-decoration: none;
    }
    
    .product-seller a:after {
        content: "\f105";
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
        margin-left: 5px;
        transition: transform 0.2s;
    }
    
    .product-seller a:hover:after {
        transform: translateX(3px);
    }
    
    .product-price {
        font-size: 30px;
        font-weight: 700;
        color: #F44336;
        margin-bottom: 25px;
        display: flex;
        align-items: baseline;
    }
    
    .product-price:after {
        content: "원";
        font-size: 20px;
        margin-left: 5px;
        font-weight: 500;
    }
    
    .product-quantity {
        margin-bottom: 30px;
        color: #495057;
        font-size: 16px;
        padding: 15px;
        background-color: #f1f3f5;
        border-radius: 8px;
        display: inline-block;
    }
    
    .product-quantity:before {
        content: "\f49e";
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
        margin-right: 8px;
        color: #6c757d;
    }
    
    /* Button Group */
    .button-group {
        display: flex;
        margin-top: 20px;
        gap: 15px;
    }
    
    /* Buy Button - 구매하기 버튼 */
    .buy-button {
        background: linear-gradient(135deg, #4CAF50, #2E7D32); /* 녹색 그라데이션 배경 */
        color: white; /* 흰색 텍스트 */
        border: none;
        padding: 14px 28px; /* 안쪽 여백 */
        font-size: 16px; /* 글자 크기 */
        font-weight: 500; /* 글자 두께 */
        border-radius: 8px; /* 둥근 모서리 */
        cursor: pointer; /* 마우스 커서 변경 */
        transition: all 0.3s; /* 애니메이션 효과 */
        display: flex;
        align-items: center; /* 세로 중앙 정렬 */
        justify-content: center; /* 가로 중앙 정렬 */
        box-shadow: 0 4px 12px rgba(46, 125, 50, 0.3); /* 그림자 효과 */
        flex: 1; /* 남은 공간 균등 배분 */
    }
    
    .buy-button:hover {
        background: linear-gradient(135deg, #43A047, #2E7D32);
        box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4);
        transform: translateY(-2px);
    }
    
    .buy-button:active {
        transform: translateY(0);
    }
    
    .buy-button:before {
        content: "\f07a";
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
        margin-right: 10px;
    }
    
    /* Cart Button - 장바구니 버튼 */
    .cart-button {
        background: linear-gradient(135deg, #2196F3, #1565C0); /* 파란색 그라데이션 배경 */
        color: white; /* 흰색 텍스트 */
        border: none;
        padding: 14px 28px; /* 안쪽 여백 */
        font-size: 16px; /* 글자 크기 */
        font-weight: 500; /* 글자 두께 */
        border-radius: 8px; /* 둥근 모서리 */
        cursor: pointer; /* 마우스 커서 변경 */
        transition: all 0.3s; /* 애니메이션 효과 */
        display: flex;
        align-items: center; /* 세로 중앙 정렬 */
        justify-content: center; /* 가로 중앙 정렬 */
        box-shadow: 0 4px 12px rgba(21, 101, 192, 0.3); /* 그림자 효과 */
        flex: 1; /* 남은 공간 균등 배분 */
    }
    
    .cart-button:hover {
        background: linear-gradient(135deg, #1E88E5, #1565C0);
        box-shadow: 0 6px 15px rgba(21, 101, 192, 0.4);
        transform: translateY(-2px);
    }
    
    .cart-button:active {
        transform: translateY(0);
    }
    
    .cart-button:before {
        content: "\f217";
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
        margin-right: 10px;
    }
    
    /* Tab Navigation Styles - 탭 메뉴 스타일 */
    .product-tabs {
        margin-top: 0;
        padding: 0 40px 40px; /* 좌우, 하단 여백 */
    }
    
    .nav-tabs {
        border-bottom: 1px solid #e9ecef; /* 하단 경계선 */
        padding: 0;
        margin-bottom: 30px; /* 아래 여백 */
    }
    
    .nav-tabs .nav-item {
        margin-right: 5px;
    }
    
    .nav-tabs .nav-link {
        color: #6c757d; /* 탭 텍스트 색상 */
        font-weight: 500; /* 글자 두께 */
        padding: 16px 25px; /* 안쪽 여백 */
        font-size: 16px; /* 글자 크기 */
        border: none;
        border-bottom: 3px solid transparent; /* 투명한 하단 테두리 */
        transition: all 0.2s ease; /* 애니메이션 효과 */
        border-radius: 8px 8px 0 0; /* 상단 모서리만 둥글게 */
    }
    
    .nav-tabs .nav-link:hover {
        color: #3D5AFE;
        background-color: rgba(61, 90, 254, 0.05);
        border-bottom: 3px solid rgba(61, 90, 254, 0.3);
    }
    
    .nav-tabs .nav-link.active {
        font-weight: 700;
        color: #3D5AFE;
        background-color: rgba(61, 90, 254, 0.08);
        border-bottom: 3px solid #3D5AFE;
    }
    
    .tab-content {
        padding: 30px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 2px 15px rgba(0, 0, 0, 0.03);
        min-height: 300px;
    }
    
    .tab-pane h3 {
        margin-bottom: 25px;
        font-weight: 700;
        color: #212529;
        padding-bottom: 15px;
        border-bottom: 1px solid #e9ecef;
    }
    
    /* Review Styles - 리뷰 스타일 */
    .review-item {
        border-bottom: 1px solid #e9ecef; /* 하단 경계선 */
        padding: 25px 0; /* 상하 여백 */
        transition: background-color 0.2s; /* 배경색 변화 애니메이션 */
    }
    
    .review-item:hover {
        background-color: #f8f9fa;
    }
    
    .review-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 12px;
        align-items: center;
    }
    
    .review-author {
        font-weight: 600;
        color: #343a40;
        display: flex;
        align-items: center;
    }
    
    .review-author:before {
        content: "\f007";
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
        margin-right: 8px;
        color: #6c757d;
    }
    
    .review-rating {
        color: #FFC107;
        font-size: 18px;
        letter-spacing: 2px;
    }
    
    .review-date {
        color: #adb5bd;
        font-size: 14px;
        margin-top: 5px;
    }
    
    .review-date:before {
        content: "\f073";
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
        margin-right: 8px;
    }
    
    .review-content {
        line-height: 1.7;
        color: #495057;
    }
    
    /* Q&A Styles - 문의 스타일 */
    .qna-item {
        border-bottom: 1px solid #e9ecef; /* 하단 경계선 */
        padding: 25px 0; /* 상하 여백 */
        transition: background-color 0.2s; /* 배경색 변화 애니메이션 */
    }
    
    .qna-item:hover {
        background-color: #f8f9fa;
    }
    
    .question {
        margin-bottom: 20px;
    }
    
    .question-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 12px;
        align-items: center;
    }
    
    .question-author {
        font-weight: 600;
        color: #343a40;
        display: flex;
        align-items: center;
    }
    
    .question-author:before {
        content: "\f059";
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
        margin-right: 8px;
        color: #6c757d;
    }
    
    .question-date {
        color: #adb5bd;
        font-size: 14px;
    }
    
    .question-date:before {
        content: "\f073";
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
        margin-right: 8px;
    }
    
    .question-content {
        line-height: 1.7;
        color: #495057;
    }
    
    .answer {
        background-color: #f1f3f5; /* 답변 배경색 */
        padding: 20px; /* 안쪽 여백 */
        border-radius: 8px; /* 둥근 모서리 */
        margin-left: 25px; /* 왼쪽 들여쓰기 */
        position: relative; /* 상대적 위치 지정 */
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); /* 그림자 효과 */
    }
    
    .answer:before {
        content: "";
        position: absolute;
        top: -10px;
        left: 20px;
        border-left: 10px solid transparent;
        border-right: 10px solid transparent;
        border-bottom: 10px solid #f1f3f5;
    }
    
    .answer-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 12px;
        align-items: center;
    }
    
    .answer-author {
        font-weight: 600;
        color: #3D5AFE;
        display: flex;
        align-items: center;
    }
    
    .answer-author:before {
        content: "\f4ad";
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
        margin-right: 8px;
    }
    
    .answer-date {
        color: #adb5bd;
        font-size: 14px;
    }
    
    .answer-date:before {
        content: "\f073";
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
        margin-right: 8px;
    }
    
    .answer-content {
        line-height: 1.7;
        color: #495057;
    }
    
    /* Action Buttons */
    .btn-primary, .btn-warning {
        padding: 10px 20px;
        font-weight: 500;
        border-radius: 6px;
        transition: all 0.3s;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }
    
    .btn-primary {
        background-color: #3D5AFE;
        border-color: #3D5AFE;
    }
    
    .btn-primary:hover {
        background-color: #304FFE;
        border-color: #304FFE;
        box-shadow: 0 4px 12px rgba(48, 79, 254, 0.3);
        transform: translateY(-2px);
    }
    
    .btn-warning {
        background-color: #FF9800;
        border-color: #FF9800;
    }
    
    .btn-warning:hover {
        background-color: #F57C00;
        border-color: #F57C00;
        box-shadow: 0 4px 12px rgba(245, 124, 0, 0.3);
        transform: translateY(-2px);
    }
    
    /* Modal Styles - 모달 스타일 */
    .modal-content {
        border: none;
        border-radius: 12px; /* 둥근 모서리 */
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
        overflow: hidden; /* 내용이 넘치면 숨김 처리 */
    }
    
    .modal-header {
        background: linear-gradient(135deg, #f8f9fa, #e9ecef);
        padding: 20px 25px;
        border-bottom: 1px solid #e9ecef;
    }
    
    .modal-title {
        font-weight: 700;
        color: #343a40;
    }
    
    .modal-body {
        padding: 25px;
    }
    
    .modal-footer {
        border-top: 1px solid #e9ecef;
        padding: 20px 25px;
    }
    
    .close {
        color: #adb5bd;
        opacity: 1;
        transition: color 0.2s;
    }
    
    .close:hover {
        color: #495057;
    }
    
    /* Form Controls - 폼 컨트롤 스타일 */
    .form-control {
        border-radius: 6px; /* 둥근 모서리 */
        border: 1px solid #ced4da; /* 테두리 */
        padding: 12px; /* 안쪽 여백 */
        transition: all 0.3s; /* 애니메이션 효과 */
    }
    
    .form-control:focus {
        border-color: #3D5AFE;
        box-shadow: 0 0 0 3px rgba(61, 90, 254, 0.15);
    }
    
    .form-group label {
        font-weight: 500;
        color: #495057;
        margin-bottom: 8px;
    }
    
    .form-check-label {
        color: #6c757d;
    }
    
    .form-control-file {
        padding: 8px 0;
    }
    
    /* Responsive Adjustments - 반응형 스타일 조정 */
    @media (max-width: 991px) {
        /* 태블릿 크기 화면에서의 조정 */
        .product-header {
            flex-direction: column; /* 세로 배치로 변경 */
            padding: 30px;
        }
        
        .product-image, .product-info {
            flex: 0 0 100%; /* 너비 100%로 조정 */
            padding: 0;
        }
        
        .product-image {
            margin-bottom: 30px; /* 아래 여백 추가 */
        }
        
        .product-tabs {
            padding: 0 30px 30px;
        }
    }
    
    @media (max-width: 767px) {
        /* 모바일 크기 화면에서의 조정 */
        .button-group {
            flex-direction: column; /* 버튼 세로 배치 */
        }
        
        .buy-button, .cart-button {
            width: 100%; /* 너비 100% */
            margin-bottom: 10px; /* 아래 여백 */
        }
        
        .product-title {
            font-size: 24px; /* 제목 글자 크기 축소 */
        }
        
        .product-price {
            font-size: 24px; /* 가격 글자 크기 축소 */
        }
        
        .nav-tabs .nav-link {
            padding: 12px 15px; /* 탭 패딩 축소 */
        }
        
        .tab-content {
            padding: 20px; /* 탭 콘텐츠 여백 축소 */
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
        
        // 탭 전환 처리
        $('.nav-tabs a').on('click', function (e) {
            e.preventDefault();
            $(this).tab('show');
        });
        
        // 초기 탭 활성화
        $('.nav-tabs a:first').tab('show');
        
        // 리뷰 작성 폼 제출 처리
        $('#reviewForm').on('submit', function (event) {
            event.preventDefault();
            alert('리뷰가 등록되었습니다.');
            $('#reviewModal').modal('hide');
        });
        
        // Q&A 작성 폼 제출 처리
        $('#questionForm').on('submit', function (event) {
            event.preventDefault();
            alert('문의가 등록되었습니다.');
            $('#questionModal').modal('hide');
        });
    });
</script>
</head>
<body>
<!-- 상단 메뉴 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<div class="container product-container">
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
                            <a href="#" data-toggle="modal" data-target="#unifiedModal">${sellerName}</a>
                        </c:when>
                        <c:otherwise>
                            <span>${sellerName}</span>
                        </c:otherwise>
                    </c:choose>
                </p>
                <p class="product-price">${item.item_price}</p>
                <p class="product-quantity">재고 수량: ${item.item_quantity}개</p>
            </div>
            
            <!-- 구매 버튼 영역 -->
            <div class="button-group">
                <button class="buy-button">구매하기</button>
                <!-- 장바구니 버튼 -->
                <button class="cart-button" onclick="addToCart('${item.item_index}', this)">장바구니 추가</button>
            </div>
        </div>
    </div>
    
    <!-- 탭 메뉴 영역 -->
    <div class="product-tabs">
        <ul class="nav nav-tabs" id="productTabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="details-tab" data-toggle="tab" href="#details" role="tab" aria-controls="details" aria-selected="true">상세정보</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review" aria-selected="false">리뷰</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="qna-tab" data-toggle="tab" href="#qna" role="tab" aria-controls="qna" aria-selected="false">Q&A</a>
            </li>
        </ul>
        <div class="tab-content" id="productTabsContent">
            <!-- 상세정보 탭 -->
            <div class="tab-pane fade show active" id="details" role="tabpanel" aria-labelledby="details-tab">
                <h3>상품 상세정보</h3>
                <p>${item.item_info}</p>
                <!-- 추가 상세 정보가 있다면 여기에 표시 -->
            </div>
            
            <!-- 리뷰 탭 -->
            <div class="tab-pane fade" id="review" role="tabpanel" aria-labelledby="review-tab">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3>상품 리뷰</h3>
                    <button class="btn btn-primary" data-toggle="modal" data-target="#reviewModal">리뷰 작성</button>
                </div>
                
                <!-- 샘플 리뷰 아이템 - 실제로는 DB에서 가져온 데이터로 반복 렌더링 필요 -->
                <div class="review-item">
                    <div class="review-header">
                        <span class="review-author">홍길동</span>
                        <span class="review-rating">★★★★★</span>
                    </div>
                    <div class="review-date">2023-05-15</div>
                    <div class="review-content mt-3">
                        상품이 생각보다 너무 좋네요! 배송도 빠르고 품질도 훌륭합니다. 다음에도 구매할 의향이 있습니다.
                    </div>
                </div>
                
                <div class="review-item">
                    <div class="review-header">
                        <span class="review-author">김철수</span>
                        <span class="review-rating">★★★★☆</span>
                    </div>
                    <div class="review-date">2023-05-10</div>
                    <div class="review-content mt-3">
                        전반적으로 만족스럽습니다. 다만 배송이 조금 늦었네요. 상품 자체는 좋습니다.
                    </div>
                </div>
            </div>
            
            <!-- Q&A 탭 -->
            <div class="tab-pane fade" id="qna" role="tabpanel" aria-labelledby="qna-tab">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3>상품 Q&A</h3>
                    <button class="btn btn-warning" data-toggle="modal" data-target="#questionModal">문의하기</button>
                </div>
                
                <!-- 샘플 Q&A 아이템 - 실제로는 DB에서 가져온 데이터로 반복 렌더링 필요 -->
                <div class="qna-item">
                    <div class="question">
                        <div class="question-header">
                            <span class="question-author">이영희</span>
                            <span class="question-date">2023-05-18</span>
                        </div>
                        <div class="question-content mt-3">
                            이 상품은 세탁기에 돌려도 되나요? 세탁 방법이 궁금합니다.
                        </div>
                    </div>
                    <div class="answer">
                        <div class="answer-header">
                            <span class="answer-author">판매자</span>
                            <span class="answer-date">2023-05-19</span>
                        </div>
                        <div class="answer-content mt-3">
                            안녕하세요, 고객님. 해당 상품은 세탁기 사용이 가능합니다. 단, 찬물로 세탁하시고 건조기 사용은 피해주세요.
                        </div>
                    </div>
                </div>
                
                <div class="qna-item">
                    <div class="question">
                        <div class="question-header">
                            <span class="question-author">박민수</span>
                            <span class="question-date">2023-05-16</span>
                        </div>
                        <div class="question-content mt-3">
                            색상이 사진과 실제 제품이 차이가 많이 나나요?
                        </div>
                    </div>
                    <div class="answer">
                        <div class="answer-header">
                            <span class="answer-author">판매자</span>
                            <span class="answer-date">2023-05-17</span>
                        </div>
                        <div class="answer-content mt-3">
                            안녕하세요, 고객님. 모니터 설정에 따라 약간의 색상 차이가 있을 수 있으나, 최대한 실제 색상과 유사하게 촬영하였습니다.
                        </div>
                    </div>
                </div>
            </div>
        </div>
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

<!-- 리뷰 작성 모달 -->
<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reviewModalLabel">리뷰 작성</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="reviewForm">
                    <div class="form-group">
                        <label for="reviewRating">평점</label>
                        <select class="form-control" id="reviewRating" required>
                            <option value="5">★★★★★ (5점)</option>
                            <option value="4">★★★★☆ (4점)</option>
                            <option value="3">★★★☆☆ (3점)</option>
                            <option value="2">★★☆☆☆ (2점)</option>
                            <option value="1">★☆☆☆☆ (1점)</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="reviewContent">내용</label>
                        <textarea class="form-control" id="reviewContent" rows="5" placeholder="리뷰 내용을 입력하세요" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="reviewImage">이미지 첨부 (선택)</label>
                        <input type="file" class="form-control-file" id="reviewImage">
                    </div>
                    <button type="submit" class="btn btn-primary">리뷰 등록</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 문의하기 모달 -->
<div class="modal fade" id="questionModal" tabindex="-1" role="dialog" aria-labelledby="questionModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="questionModalLabel">상품 문의하기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="questionForm">
                    <div class="form-group">
                        <label for="questionTitle">제목</label>
                        <input type="text" class="form-control" id="questionTitle" placeholder="문의 제목을 입력하세요" required>
                    </div>
                    <div class="form-group">
                        <label for="questionContent">내용</label>
                        <textarea class="form-control" id="questionContent" rows="5" placeholder="문의 내용을 입력하세요" required></textarea>
                    </div>
                    <div class="form-check mb-3">
                        <input type="checkbox" class="form-check-input" id="secretQuestion">
                        <label class="form-check-label" for="secretQuestion">비밀글로 작성</label>
                    </div>
                    <button type="submit" class="btn btn-warning">문의 등록</button>
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
