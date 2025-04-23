<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알림 목록</title>
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
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }
        
        .notification-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            background-color: #fff;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .notification-header h2 {
            margin: 0;
            font-size: 1.8rem;
            color: #333;
        }
        
        .notification-actions {
            display: flex;
            gap: 10px;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        
        .btn-secondary {
            background-color: #f0f0f0;
            color: #333;
        }
        
        .btn:hover {
            opacity: 0.9;
        }
        
        /* 알림 목록 스타일 */
        .notification-list {
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .notification-item {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            transition: background-color 0.3s;
        }
        
        .notification-item:last-child {
            border-bottom: none;
        }
        
        .notification-item:hover {
            background-color: #f9f9f9;
        }
        
        .notification-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #e5f7e5;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            flex-shrink: 0;
        }
        
        .notification-icon.unread {
            background-color: #c8e6c9;
        }
        
        .notification-icon i {
            color: #4CAF50;
            font-size: 18px;
        }
        
        .notification-content {
            flex-grow: 1;
        }
        
        .notification-content p {
            margin: 0 0 5px;
            font-size: 16px;
            color: #333;
        }
        
        .notification-time {
            color: #888;
            font-size: 13px;
        }
        
        .notification-actions-item {
            margin-left: 15px;
        }
        
        .notification-actions-item button {
            background: none;
            border: none;
            color: #666;
            cursor: pointer;
            font-size: 14px;
            transition: color 0.3s;
        }
        
        .notification-actions-item button:hover {
            color: #4CAF50;
        }
        
        .notification-item.unread {
            border-left: 4px solid #4CAF50;
            background-color: #f0f7f0;
        }
        
        .empty-notification {
            padding: 60px 20px;
            text-align: center;
            color: #888;
        }
        
        .empty-notification i {
            font-size: 48px;
            margin-bottom: 15px;
            color: #ccc;
        }
        
        .empty-notification p {
            font-size: 16px;
            margin: 0;
        }
        
        /* 페이지네이션 스타일 */
        .pagination {
            display: flex;
            justify-content: center;
            list-style: none;
            padding: 0;
            margin: 30px 0 0;
        }
        
        .pagination li {
            margin: 0 5px;
        }
        
        .pagination a {
            display: block;
            padding: 8px 12px;
            background-color: #fff;
            border: 1px solid #ddd;
            color: #333;
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.3s;
        }
        
        .pagination a:hover {
            background-color: #f5f5f5;
        }
        
        .pagination .active a {
            background-color: #4CAF50;
            color: white;
            border-color: #4CAF50;
        }
        
        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .notification-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .notification-actions {
                width: 100%;
                justify-content: flex-start;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/header.jsp"/>
    
    <div class="container">
        <div class="notification-header">
            <h2>알림 목록</h2>
            <div class="notification-actions">
                <button id="markAllRead" class="btn btn-secondary">모두 읽음 표시</button>
                <button id="deleteAllRead" class="btn btn-secondary">읽은 알림 삭제</button>
            </div>
        </div>
        
        <div class="notification-list">
            <c:if test="${empty notifications}">
                <div class="empty-notification">
                    <i class="fas fa-bell-slash"></i>
                    <p>새로운 알림이 없습니다.</p>
                </div>
            </c:if>
            
            <c:forEach var="notification" items="${notifications}">
                <div class="notification-item ${notification.read ? '' : 'unread'}" data-id="${notification.id}">
                    <div class="notification-icon ${notification.read ? '' : 'unread'}">
                        <c:choose>
                            <c:when test="${notification.notificationType == 'POST_LINKED'}">
                                <i class="fas fa-map-marker-alt"></i>
                            </c:when>
                            <c:when test="${notification.notificationType == 'PARTICIPATION'}">
                                <i class="fas fa-user-plus"></i>
                            </c:when>
                            <c:when test="${notification.notificationType == 'PARTICIPATION_CANCEL'}">
                                <i class="fas fa-user-minus"></i>
                            </c:when>
                            <c:when test="${notification.notificationType == 'WAITING_LIST'}">
                                <i class="fas fa-user-clock"></i>
                            </c:when>
                            <c:when test="${notification.notificationType == 'SPOT_AVAILABLE'}">
                                <i class="fas fa-check-circle"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-bell"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="notification-content">
                        <p>${notification.content}</p>
                        <span class="notification-time">
                            <fmt:formatDate value="${notification.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                        </span>
                    </div>
                    
                    <div class="notification-actions-item">
                        <c:if test="${notification.postId > 0}">
                            <button class="view-post" data-post-id="${notification.postId}">
                                <i class="fas fa-external-link-alt"></i> 게시글 보기
                            </button>
                        </c:if>
                        <button class="delete-notification" data-id="${notification.id}">
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <!-- 페이지네이션 -->
        <c:if test="${not empty notifications}">
            <ul class="pagination">
                <c:if test="${currentPage > 1}">
                    <li><a href="?page=${currentPage - 1}"><i class="fas fa-chevron-left"></i></a></li>
                </c:if>
                
                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                    <li class="${pageNum == currentPage ? 'active' : ''}">
                        <a href="?page=${pageNum}">${pageNum}</a>
                    </li>
                </c:forEach>
                
                <c:if test="${currentPage < totalPages}">
                    <li><a href="?page=${currentPage + 1}"><i class="fas fa-chevron-right"></i></a></li>
                </c:if>
            </ul>
        </c:if>
    </div>
    
    <jsp:include page="/WEB-INF/views/include/footer.jsp"/>
    
    <script>
        $(document).ready(function() {
            // 알림 읽음 표시
            $('.notification-item.unread').click(function() {
                const notificationId = $(this).data('id');
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/notification/markAsRead',
                    type: 'POST',
                    data: { id: notificationId },
                    success: function() {
                        // 읽음 표시 UI 업데이트
                        $(`[data-id=${notificationId}]`).removeClass('unread');
                        $(`[data-id=${notificationId}] .notification-icon`).removeClass('unread');
                    }
                });
            });
            
            // 게시글 보기 버튼
            $('.view-post').click(function(e) {
                e.stopPropagation();
                const postId = $(this).data('post-id');
                window.location.href = '${pageContext.request.contextPath}/board/read?id=' + postId;
            });
            
            // 알림 삭제 버튼
            $('.delete-notification').click(function(e) {
                e.stopPropagation();
                const notificationId = $(this).data('id');
                const $notificationItem = $(this).closest('.notification-item');
                
                if (confirm('이 알림을 삭제하시겠습니까?')) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/notification/delete',
                        type: 'POST',
                        data: { id: notificationId },
                        success: function() {
                            $notificationItem.fadeOut(300, function() {
                                $(this).remove();
                                
                                if ($('.notification-item').length === 0) {
                                    $('.notification-list').html(`
                                        <div class="empty-notification">
                                            <i class="fas fa-bell-slash"></i>
                                            <p>새로운 알림이 없습니다.</p>
                                        </div>
                                    `);
                                }
                            });
                        }
                    });
                }
            });
            
            // 모두 읽음 표시 버튼
            $('#markAllRead').click(function() {
                if ($('.notification-item.unread').length === 0) {
                    alert('읽지 않은 알림이 없습니다.');
                    return;
                }
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/notification/markAllAsRead',
                    type: 'POST',
                    success: function() {
                        $('.notification-item.unread').removeClass('unread');
                        $('.notification-icon.unread').removeClass('unread');
                    }
                });
            });
            
            // 읽은 알림 삭제 버튼
            $('#deleteAllRead').click(function() {
                if ($('.notification-item:not(.unread)').length === 0) {
                    alert('삭제할 읽은 알림이 없습니다.');
                    return;
                }
                
                if (confirm('읽은 알림을 모두 삭제하시겠습니까?')) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/notification/deleteAllRead',
                        type: 'POST',
                        success: function() {
                            $('.notification-item:not(.unread)').fadeOut(300, function() {
                                $(this).remove();
                                
                                if ($('.notification-item').length === 0) {
                                    $('.notification-list').html(`
                                        <div class="empty-notification">
                                            <i class="fas fa-bell-slash"></i>
                                            <p>새로운 알림이 없습니다.</p>
                                        </div>
                                    `);
                                }
                            });
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>