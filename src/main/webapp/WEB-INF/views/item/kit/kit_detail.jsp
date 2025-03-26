<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 상세페이지</title>
<!-- Bootstrap & jQuery -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<style>
    /* 전체 컨테이너 스타일 */
    .product-container {
        max-width: 1200px;
        margin: 30px auto;
        padding: 0 20px;
    }
    
    /* 상품 정보 상단 영역 */
    .product-header {
        display: flex;
        flex-wrap: wrap;
        margin-bottom: 40px;
    }
    
    /* 상품 이미지 영역 */
    .product-image {
        flex: 0 0 40%;
        padding-right: 30px;
    }
    
    .product-image img {
        width: 100%;
        height: auto;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    
    /* 상품 기본 정보 영역 */
    .product-info {
        flex: 0 0 60%;
        padding-left: 20px;
    }
    
    .product-title {
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 15px;
        color: #333;
    }
    
    .product-seller {
        margin-bottom: 15px;
        color: #666;
    }
    
    .product-price {
        font-size: 24px;
        font-weight: 600;
        color: #e53935;
        margin-bottom: 20px;
    }
    
    .product-quantity {
        margin-bottom: 20px;
        color: #555;
    }
    
    /* 구매 버튼 */
    .buy-button {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 12px 24px;
        font-size: 16px;
        border-radius: 4px;
        cursor: pointer;
        margin-right: 10px;
        transition: background-color 0.3s;
    }
    
    .buy-button:hover {
        background-color: #388E3C;
    }
    
    /* 장바구니 버튼 */
    .cart-button {
        background-color: #2196F3;
        color: white;
        border: none;
        padding: 12px 24px;
        font-size: 16px;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    
    .cart-button:hover {
        background-color: #1976D2;
    }
    
    /* 탭 메뉴 스타일 */
    .product-tabs {
        margin-top: 50px;
    }
    
    .nav-tabs .nav-link {
        color: #555;
        font-weight: 500;
        padding: 12px 20px;
        font-size: 16px;
    }
    
    .nav-tabs .nav-link.active {
        font-weight: 700;
        color: #2196F3;
        border-bottom: 3px solid #2196F3;
    }
    
    .tab-content {
        padding: 30px;
        background-color: #fff;
        border: 1px solid #ddd;
        border-top: none;
        min-height: 300px;
    }
    
    /* 리뷰 스타일 */
    .review-item {
        border-bottom: 1px solid #eee;
        padding: 20px 0;
    }
    
    .review-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }
    
    .review-author {
        font-weight: 600;
    }
    
    .review-rating {
        color: #FFB900;
    }
    
    .review-date {
        color: #999;
        font-size: 14px;
    }
    
    /* Q&A 스타일 */
    .qna-item {
        border-bottom: 1px solid #eee;
        padding: 20px 0;
    }
    
    .question {
        margin-bottom: 15px;
    }
    
    .question-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }
    
    .question-author {
        font-weight: 600;
    }
    
    .question-date {
        color: #999;
        font-size: 14px;
    }
    
    .answer {
        background-color: #f9f9f9;
        padding: 15px;
        border-radius: 4px;
        margin-left: 20px;
    }
    
    .answer-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }
    
    .answer-author {
        font-weight: 600;
        color: #2196F3;
    }
    
    .answer-date {
        color: #999;
        font-size: 14px;
    }
    
    /* 문의 작성 버튼 */
    .write-question-btn {
        background-color: #FF9800;
        color: white;
        border: none;
        padding: 8px 16px;
        font-size: 14px;
        border-radius: 4px;
        cursor: pointer;
        margin-top: 20px;
        transition: background-color 0.3s;
    }
    
    .write-question-btn:hover {
        background-color: #F57C00;
    }
    
    /* 모달 스타일 */
    .modal-header {
        background-color: #f8f9fa;
        border-bottom: 1px solid #eee;
    }
    
    .modal-title {
        font-weight: 600;
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
            <h1 class="product-title">${item.item_name}</h1>
            <p class="product-seller">판매자: 
                <c:choose>
                    <c:when test="${loginUser.login.equals('buyer')}">
                        <a href="#" data-toggle="modal" data-target="#unifiedModal">${sellerName}</a>
                    </c:when>
                    <c:otherwise>
                        <span>${sellerName}</span>
                    </c:otherwise>
                </c:choose>
            </p>
            <p class="product-price">${item.item_price}원</p>
            <p class="product-quantity">재고 수량: ${item.item_quantity}개</p>
            
            <!-- 구매 버튼 영역 -->
            <div class="button-group">
                <button class="buy-button">구매하기</button>
                 <!-- 장바구니 버튼 -->
	            <button class="cart-button" onclick="addToCart('${item.item_index}', this)">
	                <i class="fas fa-shopping-cart"></i>장바구니 추가
	            </button>
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
                <a class="nav-link" id="qna-tab" data-toggle="tab" href="#qna" role="tab" aria-controls="qna" aria-selected="false"> Q&A </a>
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
                    <div class="review-content mt-2">
                        상품이 생각보다 너무 좋네요! 배송도 빠르고 품질도 훌륭합니다. 다음에도 구매할 의향이 있습니다.
                    </div>
                </div>
                
                <div class="review-item">
                    <div class="review-header">
                        <span class="review-author">김철수</span>
                        <span class="review-rating">★★★★☆</span>
                    </div>
                    <div class="review-date">2023-05-10</div>
                    <div class="review-content mt-2">
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
                        <div class="question-content mt-2">
                            이 상품은 세탁기에 돌려도 되나요? 세탁 방법이 궁금합니다.
                        </div>
                    </div>
                    <div class="answer">
                        <div class="answer-header">
                            <span class="answer-author">판매자</span>
                            <span class="answer-date">2023-05-19</span>
                        </div>
                        <div class="answer-content mt-2">
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
                        <div class="question-content mt-2">
                            색상이 사진과 실제 제품이 차이가 많이 나나요?
                        </div>
                    </div>
                    <div class="answer">
                        <div class="answer-header">
                            <span class="answer-author">판매자</span>
                            <span class="answer-date">2023-05-17</span>
                        </div>
                        <div class="answer-content mt-2">
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
                <h6>판매자: ${sellerName}</h6>
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