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
                    window.location.href = `/chat/room/${response.id}`;
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
	
	<div class="product-detail">
        <h1>${item.item_name}</h1>
        <p>판매자: 
		    <a href="#" data-toggle="modal" data-target="#sellerModal">${sellerName}</a>
		</p>
			<!-- 모달 창 -->
			<div class="modal fade" id="sellerModal" tabindex="-1" role="dialog" aria-labelledby="sellerModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="sellerModalLabel">판매자 문의</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- 모달 창 -->
	            <div class="modal fade" id="chatRoomModal" tabindex="-1" role="dialog" aria-labelledby="chatRoomModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="chatRoomModalLabel">채팅방 제목 설정</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body">
	                <form id="chatRoomForm">
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
            
            <div class="modal-body">
                <p>판매자: ${sellerName}</p>
                <!-- 버튼을 눌러 채팅방 제목 모달 열기 -->
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#chatRoomModal">
                    채팅하기
                </button>
            </div>
        </div>
    </div>
</div>

        <p>가격: ${item.item_price}원</p>
        <p>재고 수량: ${item.item_quantity}개</p>
        <p>상세 설명:</p>
        <p>${item.item_info}</p>
        <img src="${root}/upload/${item.item_picture}" />
    </div>
    <a href="#">뒤로가기</a>
	
	
	
<!-- 하단 정보 -->
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />	
</body>
</html>