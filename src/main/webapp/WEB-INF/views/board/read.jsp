<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${post.title} - 게시글 상세</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        /* 전체 페이지 스타일 */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 1000px;
            margin: 20px auto;
            padding: 0 20px;
        }
        
        /* 게시글 헤더 */
        .post-header {
            background-color: #fff;
            border-radius: 8px 8px 0 0;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .post-title {
            font-size: 1.8rem;
            margin: 0 0 10px;
            color: #333;
        }
        
        .post-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        
        .post-meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .category-badge {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 12px;
            margin-right: 8px;
            background-color: #e0f2e0;
            color: #4CAF50;
        }
        
        .category-lifestyle {
            background-color: #e0f2e0;
            color: #4CAF50;
        }
        
        .category-craft {
            background-color: #e0f2f2;
            color: #00BCD4;
        }
        
        .category-food {
            background-color: #fff0e0;
            color: #FF9800;
        }
        
        .category-fashion {
            background-color: #f2e0f2;
            color: #9C27B0;
        }
        
        .category-beauty {
            background-color: #ffe0e0;
            color: #F44336;
        }
        
        /* 게시글 내용 */
        .post-content {
            background-color: #fff;
            padding: 20px;
            border-top: 1px solid #eee;
            min-height: 300px;
        }
        
        /* 게시글 푸터 */
        .post-footer {
            background-color: #fff;
            padding: 20px;
            border-top: 1px solid #eee;
            border-radius: 0 0 8px 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        /* 위치 정보 */
        .location-info {
            margin-top: 15px;
            padding: 15px;
            background-color: #f5f5f5;
            border-radius: 4px;
        }
        
        .location-info h3 {
            margin: 0 0 10px;
            font-size: 1.2rem;
            color: #333;
        }
        
        .map-preview {
            width: 100%;
            height: 250px;
            background-color: #f0f0f0;
            border-radius: 4px;
            margin-top: 10px;
        }
        
        .location-meta {
            margin-top: 10px;
            font-size: 14px;
            color: #666;
        }
        
        .location-meta p {
            margin: 5px 0;
        }
        
        /* 참여 버튼 */
        .participation-section {
            margin-top: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 4px;
        }
        
        .participation-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .participation-header h3 {
            margin: 0;
            font-size: 1.2rem;
            color: #333;
        }
        
        .participation-status {
            display: flex;
            align-items: center;
            gap: 5px;
            font-weight: 600;
        }
        
        .participation-status.full {
            color: #F44336;
        }
        
        .participation-status.available {
            color: #4CAF50;
        }
        
        .participation-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 15px;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        
        .btn-secondary {
            background-color: #f0f0f0;
            color: #333;
        }
        
        .btn-danger {
            background-color: #F44336;
            color: white;
        }
        
        .btn-warning {
            background-color: #FF9800;
            color: white;
        }
        
        .btn:hover {
            opacity: 0.9;
        }
        
        .btn:disabled {
            background-color: #ccc;
            cursor: not-allowed;
            opacity: 0.7;
        }
        
        .participation-notice {
            margin-top: 10px;
            font-size: 14px;
            color: #666;
        }
        
        /* 참여자 목록 */
        .participants-list {
            margin-top: 15px;
        }
        
        .participants-list h4 {
            margin: 0 0 10px;
            font-size: 1rem;
            color: #333;
        }
        
        .participants-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }
        
        .participant-tag {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 5px 10px;
            background-color: #e0f2e0;
            border-radius: 30px;
            font-size: 14px;
            color: #4CAF50;
        }
        
        .participant-tag.me {
            background-color: #4CAF50;
            color: white;
        }
        
        /* 게시글 수정/삭제 버튼 */
        .post-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        
        /* 댓글 섹션 */
        .comments-section {
            margin-top: 30px;
        }
        
        .comments-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
.comments-header h3 {
            margin: 0;
            font-size: 1.2rem;
            color: #333;
        }
        
        .comments-count {
            color: #4CAF50;
            font-weight: 600;
        }
        
        /* 댓글 목록 */
        .comment-item {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .comment-item:last-child {
            border-bottom: none;
        }
        
        .comment-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }
        
        .comment-user {
            font-weight: 600;
            color: #333;
        }
        
        .comment-time {
            font-size: 12px;
            color: #888;
        }
        
        .comment-body {
            margin-bottom: 10px;
            word-break: break-word;
        }
        
        .comment-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }
        
        .comment-action {
            font-size: 13px;
            color: #666;
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
        }
        
        .comment-action:hover {
            color: #4CAF50;
        }
        
        /* 댓글 작성 폼 */
        .comment-form {
            margin-top: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 4px;
        }
        
        .comment-form textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: vertical;
            min-height: 80px;
            box-sizing: border-box;
        }
        
        .comment-form-actions {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
        }
        
        /* 반응형 */
        @media (max-width: 768px) {
            .post-meta {
                flex-direction: column;
                gap: 5px;
            }
            
            .participation-actions {
                flex-direction: column;
            }
            
            .participation-actions .btn {
                width: 100%;
            }
            
            .post-actions {
                flex-direction: column;
            }
            
            .post-actions .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/header.jsp"/>
    
    <div class="container">
        <!-- 게시글 헤더 -->
        <div class="post-header">
            <h1 class="post-title">${post.title}</h1>
            
            <div class="post-meta">
                <c:if test="${post.markerType != null}">
                    <span class="category-badge category-${post.markerType}">
                        <c:choose>
                            <c:when test="${post.markerType == 'lifestyle'}">라이프스타일</c:when>
                            <c:when test="${post.markerType == 'craft'}">수공예</c:when>
                            <c:when test="${post.markerType == 'food'}">푸드</c:when>
                            <c:when test="${post.markerType == 'fashion'}">패션</c:when>
                            <c:when test="${post.markerType == 'beauty'}">뷰티</c:when>
                            <c:otherwise>기타</c:otherwise>
                        </c:choose>
                    </span>
                </c:if>
                
                <div class="post-meta-item">
                    <i class="fas fa-user"></i>
                    <span>${post.writerName}</span>
                </div>
                
                <div class="post-meta-item">
                    <i class="fas fa-calendar"></i>
                    <span><fmt:formatDate value="${post.regdate}" pattern="yyyy-MM-dd HH:mm"/></span>
                </div>
                
                <div class="post-meta-item">
                    <i class="fas fa-users"></i>
                    <span>${post.currentParticipants} / ${post.maxParticipants} 참여</span>
                </div>
            </div>
        </div>
        
        <!-- 게시글 내용 -->
        <div class="post-content">
            ${post.content}
        </div>
        
        <!-- 게시글 푸터 -->
        <div class="post-footer">
            <!-- 위치 정보가 있는 경우 -->
            <c:if test="${post.latitude != null && post.longitude != null}">
                <div class="location-info">
                    <h3>
                        <i class="fas fa-map-marker-alt"></i> 위치 정보
                    </h3>
                    
                    <div id="map" class="map-preview"></div>
                    
                    <div class="location-meta">
                        <p><strong>주소:</strong> ${post.address}</p>
                        <p><strong>좌표:</strong> ${post.latitude}, ${post.longitude}</p>
                    </div>
                </div>
            </c:if>
            
            <!-- 참여 섹션 -->
            <div class="participation-section">
                <div class="participation-header">
                    <h3>참여 정보</h3>
                    
                    <div class="participation-status ${post.currentParticipants >= post.maxParticipants ? 'full' : 'available'}">
                        <i class="fas ${post.currentParticipants >= post.maxParticipants ? 'fa-user-times' : 'fa-user-check'}"></i>
                        <span>${post.currentParticipants}/${post.maxParticipants} 명 참여 중</span>
                    </div>
                </div>
                
                <div class="participation-actions">
                    <c:choose>
                        <%-- 내가 작성한 글인 경우 --%>
                        <c:when test="${post.writerId eq sessionScope.loginMember.id}">
                            <button class="btn btn-secondary" disabled>
                                <i class="fas fa-pen"></i> 내가 작성한 글입니다
                            </button>
                            <a href="${pageContext.request.contextPath}/participation/list?postId=${post.id}" class="btn btn-primary">
                                <i class="fas fa-users"></i> 참여자 관리
                            </a>
                        </c:when>
                        
                        <%-- 이미 참여한 경우 --%>
                        <c:when test="${isParticipating}">
                            <button id="cancelBtn" class="btn btn-danger">
                                <i class="fas fa-user-minus"></i> 참여 취소하기
                            </button>
                            <a href="${pageContext.request.contextPath}/participation/list?postId=${post.id}" class="btn btn-secondary">
                                <i class="fas fa-users"></i> 참여자 목록
                            </a>
                        </c:when>
                        
                        <%-- 대기자 목록에 있는 경우 --%>
                        <c:when test="${isWaiting}">
                            <button id="cancelWaitingBtn" class="btn btn-warning">
                                <i class="fas fa-user-clock"></i> 대기 취소하기
                            </button>
                            <a href="${pageContext.request.contextPath}/participation/list?postId=${post.id}" class="btn btn-secondary">
                                <i class="fas fa-users"></i> 참여자 목록
                            </a>
                        </c:when>
                        
                        <%-- 참여 가능한 경우 --%>
                        <c:when test="${post.currentParticipants < post.maxParticipants}">
                            <button id="participateBtn" class="btn btn-primary">
                                <i class="fas fa-user-plus"></i> 참여하기
                            </button>
                            <a href="${pageContext.request.contextPath}/participation/list?postId=${post.id}" class="btn btn-secondary">
                                <i class="fas fa-users"></i> 참여자 목록
                            </a>
                        </c:when>
                        
                        <%-- 정원이 다 찬 경우 --%>
                        <c:otherwise>
                            <button id="waitingBtn" class="btn btn-warning">
                                <i class="fas fa-user-clock"></i> 대기자 등록하기
                            </button>
                            <a href="${pageContext.request.contextPath}/participation/list?postId=${post.id}" class="btn btn-secondary">
                                <i class="fas fa-users"></i> 참여자 목록
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- 참여자 목록 미리보기 -->
                <div class="participants-list">
                    <h4>현재 참여자 (${post.currentParticipants}명)</h4>
                    
                    <div class="participants-tags">
                        <c:forEach var="participant" items="${participants}" varStatus="status">
                            <c:if test="${status.index < 5}">
                                <div class="participant-tag ${participant.memberId eq sessionScope.loginMember.id ? 'me' : ''}">
                                    <i class="fas fa-user"></i>
                                    <span>${participant.member.name}</span>
                                </div>
                            </c:if>
                        </c:forEach>
                        
                        <c:if test="${participants.size() > 5}">
                            <div class="participant-tag" style="background-color: #f0f0f0; color: #666;">
                                <span>+ ${participants.size() - 5}명 더...</span>
                            </div>
                        </c:if>
                    </div>
                </div>
                
                <c:if test="${post.currentParticipants >= post.maxParticipants}">
                    <p class="participation-notice">
                        <i class="fas fa-info-circle"></i> 
                        현재 모집이 마감되었습니다. 대기자로 등록하시면 자리가 나는 대로 참여 기회가 주어집니다.
                    </p>
                </c:if>
            </div>
            
            <!-- 글 작성자인 경우 수정/삭제 버튼 -->
            <c:if test="${post.writerId eq sessionScope.loginMember.id}">
                <div class="post-actions">
                    <a href="${pageContext.request.contextPath}/board/modify?id=${post.id}" class="btn btn-secondary">
                        <i class="fas fa-edit"></i> 수정하기
                    </a>
                    <button id="deleteBtn" class="btn btn-danger">
                        <i class="fas fa-trash"></i> 삭제하기
                    </button>
                </div>
            </c:if>
        </div>
        
        <!-- 댓글 섹션 -->
        <div class="comments-section">
            <div class="comments-header">
                <h3>댓글 <span class="comments-count">${comments.size()}</span></h3>
            </div>
            
            <!-- 댓글 목록 -->
            <div class="comments-list">
                <c:if test="${empty comments}">
                    <div style="text-align: center; padding: 30px 0; color: #888;">
                        <i class="far fa-comment-dots" style="font-size: 24px; margin-bottom: 10px;"></i>
                        <p style="margin: 0;">첫 댓글을 남겨보세요!</p>
                    </div>
                </c:if>
                
                <c:forEach var="comment" items="${comments}">
                    <div class="comment-item" id="comment-${comment.id}">
                        <div class="comment-header">
                            <div class="comment-user">
                                ${comment.writerName}
                                <c:if test="${comment.writerId eq post.writerId}">
                                    <span style="color: #4CAF50; font-size: 12px; margin-left: 5px;">작성자</span>
                                </c:if>
                            </div>
                            <div class="comment-time">
						    <c:if test="${not empty comment.comment_Date}">
						        <fmt:parseDate value="${comment.comment_Date}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" />
						        <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/>
						    </c:if>
						</div>
                        </div>
                        
                        <div class="comment-body">
                            ${comment.content}
                        </div>
                        
                        <c:if test="${comment.writerId eq sessionScope.loginMember.id}">
                            <div class="comment-actions">
                                <button class="comment-action edit-comment" data-id="${comment.id}">
                                    <i class="fas fa-edit"></i> 수정
                                </button>
                                <button class="comment-action delete-comment" data-id="${comment.id}">
                                    <i class="fas fa-trash"></i> 삭제
                                </button>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
            
            <!-- 댓글 작성 폼 -->
            <div class="comment-form">
                <form id="commentForm">
                    <input type="hidden" name="postId" value="${post.id}">
                    <textarea name="content" placeholder="댓글을 작성해주세요" required></textarea>
                    <div class="comment-form-actions">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane"></i> 댓글 작성
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/include/footer.jsp"/>
    
    <!-- 카카오맵 API -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fb9c39f52da6918d5d47283a1cf98395&libraries=services"></script>
    
    <script>
        $(document).ready(function() {
            // 카카오맵 초기화 (위치 정보가 있는 경우)
            <c:if test="${post.latitude != null && post.longitude != null}">
            var mapContainer = document.getElementById('map');
            var mapOption = {
                center: new kakao.maps.LatLng(${post.latitude}, ${post.longitude}),
                level: 3
            };
            
            var map = new kakao.maps.Map(mapContainer, mapOption);
            
            // 마커 생성
            var marker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(${post.latitude}, ${post.longitude}),
                map: map
            });
            
            // 인포윈도우 생성
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="padding:5px;font-size:12px;">${post.address}</div>'
            });
            
            infowindow.open(map, marker);
            </c:if>
            
            // 참여하기 버튼 클릭
            $("#participateBtn").click(function() {
                if (confirm("이 모임에 참여하시겠습니까?")) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/participation/join",
                        type: "POST",
                        data: { postId: ${post.id} },
                        success: function(response) {
                            alert("모임 참여가 완료되었습니다.");
                            location.reload();
                        },
                        error: function(xhr) {
                            alert("오류가 발생했습니다: " + xhr.responseText);
                        }
                    });
                }
            });
            
            // 참여 취소 버튼 클릭
            $("#cancelBtn").click(function() {
                if (confirm("참여를 취소하시겠습니까?")) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/participation/cancel",
                        type: "POST",
                        data: { postId: ${post.id} },
                        success: function(response) {
                            alert("참여가 취소되었습니다.");
                            location.reload();
                        },
                        error: function(xhr) {
                            alert("오류가 발생했습니다: " + xhr.responseText);
                        }
                    });
                }
            });
            
            // 대기자 등록 버튼 클릭
            $("#waitingBtn").click(function() {
                if (confirm("대기자로 등록하시겠습니까?")) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/participation/waiting",
                        type: "POST",
                        data: { postId: ${post.id} },
                        success: function(response) {
                            alert("대기자로 등록되었습니다.");
                            location.reload();
                        },
                        error: function(xhr) {
                            alert("오류가 발생했습니다: " + xhr.responseText);
                        }
                    });
                }
            });
            
            // 대기 취소 버튼 클릭
            $("#cancelWaitingBtn").click(function() {
                if (confirm("대기자 등록을 취소하시겠습니까?")) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/participation/cancelWaiting",
                        type: "POST",
                        data: { postId: ${post.id} },
                        success: function(response) {
                            alert("대기자 등록이 취소되었습니다.");
                            location.reload();
                        },
                        error: function(xhr) {
                            alert("오류가 발생했습니다: " + xhr.responseText);
                        }
                    });
                }
            });
            
            // 게시글 삭제 버튼 클릭
            $("#deleteBtn").click(function() {
                if (confirm("정말 게시글을 삭제하시겠습니까?")) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/board/delete",
                        type: "POST",
                        data: { id: ${post.id} },
                        success: function(response) {
                            alert("게시글이 삭제되었습니다.");
                            window.location.href = "${pageContext.request.contextPath}/board/main";
                        },
                        error: function(xhr) {
                            alert("오류가 발생했습니다: " + xhr.responseText);
                        }
                    });
                }
            });
            
            // 댓글 작성 폼 제출
            $("#commentForm").submit(function(e) {
			    e.preventDefault();
			    
			    $.ajax({
			        url: "${pageContext.request.contextPath}/comment/write",
			        type: "POST",
			        data: $(this).serialize(),
			        success: function(response) {
			            // 폼 초기화
			            $("#commentForm textarea").val("");
			            
			            // 댓글 작성 성공 시에만 getHtml 호출
			            if (response.success && response.commentId) {
			                // 새 댓글 추가
			                $.get("${pageContext.request.contextPath}/comment/getHtml?id=" + response.commentId, function(commentHtml) {
			                    if (commentHtml) {
			                        $(".comments-list").append(commentHtml);
			                        $(".comments-count").text($(".comment-item").length);
			                        
			                        // 댓글이 없다는 메시지 제거
			                        if ($(".comments-list > div").length > 1) {
			                            $(".comments-list > div:first-child").remove();
			                        }
			                    }
			                });
			            } else {
			                // 실패 메시지 표시
			                alert(response.message || "댓글 작성에 실패했습니다.");
			            }
			        },
			        error: function(xhr) {
			            alert("댓글 작성 중 오류가 발생했습니다.");
			        }
			    });
			});
            
            // 댓글 삭제
            $(document).on("click", ".delete-comment", function() {
                const commentId = $(this).data("id");
                
                if (confirm("댓글을 삭제하시겠습니까?")) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/comment/delete",
                        type: "POST",
                        data: { id: commentId },
                        success: function(response) {
                            $("#comment-" + commentId).fadeOut(300, function() {
                                $(this).remove();
                                $(".comments-count").text($(".comment-item").length);
                                
                                // 댓글이 없는 경우 메시지 표시
                                if ($(".comment-item").length === 0) {
                                    $(".comments-list").html(`
                                        <div style="text-align: center; padding: 30px 0; color: #888;">
                                            <i class="far fa-comment-dots" style="font-size: 24px; margin-bottom: 10px;"></i>
                                            <p style="margin: 0;">첫 댓글을 남겨보세요!</p>
                                        </div>
                                    `);
                                }
                            });
                        },
                        error: function(xhr) {
                            alert("오류가 발생했습니다: " + xhr.responseText);
                        }
                    });
                }
            });
            
            // 댓글 수정
            $(document).on("click", ".edit-comment", function() {
                const commentId = $(this).data("id");
                const commentItem = $("#comment-" + commentId);
                const commentContent = commentItem.find(".comment-body").text().trim();
                
                // 이미 수정 모드인 경우 리턴
                if (commentItem.hasClass("editing")) return;
                
                // 수정 폼으로 변경
                commentItem.addClass("editing");
                commentItem.find(".comment-body").html(`
                    <textarea class="form-control" style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; resize: vertical; min-height: 60px;">${commentContent}</textarea>
                    <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 10px;">
                        <button class="btn btn-secondary comment-edit-cancel" style="padding: 4px 8px; font-size: 14px;">취소</button>
                        <button class="btn btn-primary comment-edit-save" data-id="${commentId}" style="padding: 4px 8px; font-size: 14px;">저장</button>
                    </div>
                `);
                
                // 수정 취소
                commentItem.find(".comment-edit-cancel").click(function() {
                    commentItem.removeClass("editing");
                    commentItem.find(".comment-body").html(commentContent);
                });
                
                // 수정 저장
                commentItem.find(".comment-edit-save").click(function() {
                    const newContent = commentItem.find("textarea").val();
                    
                    $.ajax({
                        url: "${pageContext.request.contextPath}/comment/update",
                        type: "POST",
                        data: { 
                            id: commentId,
                            content: newContent 
                        },
                        success: function(response) {
                            commentItem.removeClass("editing");
                            commentItem.find(".comment-body").html(newContent);
                        },
                        error: function(xhr) {
                            alert("오류가 발생했습니다: " + xhr.responseText);
                        }
                    });
                });
            });
        });
    </script>
</body>
</html>