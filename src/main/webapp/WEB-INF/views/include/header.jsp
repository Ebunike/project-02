<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 전체 리셋 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f8f9fa;
        }
        
        /* 헤더 스타일 */
        header {
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        header .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 70px;
        }
        
        .logo a {
            font-size: 24px;
            font-weight: bold;
            color: #03c75a;
            text-decoration: none;
        }
        
        nav ul {
            display: flex;
            list-style: none;
        }
        
        nav ul li {
            margin-left: 20px;
            position: relative;
        }
        
        nav ul li a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            transition: color 0.3s;
        }
        
        nav ul li a:hover {
            color: #03c75a;
        }
        
        /* 반응형 - 모바일 메뉴 */
        .menu-toggle {
            display: none;
            cursor: pointer;
            font-size: 24px;
        }
        
        /* 알림 아이콘 스타일 */
        .notification-icon-container {
            position: relative;
            margin-left: 20px;
            cursor: pointer;
        }
        
        .notification-icon {
            font-size: 1.2rem;
            color: #333;
        }
        
        .notification-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background-color: #ff4757;
            color: white;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 0.7rem;
            line-height: 1;
            min-width: 15px;
            text-align: center;
        }
        
        /* 알림 드롭다운 스타일 */
        .notification-dropdown {
            position: absolute;
            top: 100%;
            right: 0;
            width: 300px;
            max-height: 400px;
            overflow-y: auto;
            background-color: white;
            border-radius: 4px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            display: none;
        }
        
        .notification-dropdown.show {
            display: block;
        }
        
        .notification-header {
            padding: 10px 15px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .notification-title {
            font-weight: bold;
            margin: 0;
            font-size: 16px;
        }
        
        .view-all {
            color: #03c75a;
            text-decoration: none;
            font-size: 0.9em;
        }
        
        .notification-list {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }
        
        .notification-item {
            padding: 10px 15px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        
        .notification-item:hover {
            background-color: #f9f9f9;
        }
        
        .notification-item.unread {
            background-color: #f0f7ff;
        }
        
        .notification-item.unread:hover {
            background-color: #e6f2ff;
        }
        
        .notification-content {
            margin-bottom: 5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .notification-time {
            font-size: 0.8em;
            color: #888;
        }
        
        .no-notifications {
            padding: 15px;
            text-align: center;
            color: #888;
            font-style: italic;
        }
        
        /* 반응형 */
        @media (max-width: 768px) {
            .menu-toggle {
                display: block;
            }
            
            nav ul {
                position: absolute;
                top: 70px;
                left: 0;
                right: 0;
                background-color: white;
                flex-direction: column;
                padding: 0;
                box-shadow: 0 5px 5px rgba(0, 0, 0, 0.1);
                height: 0;
                overflow: hidden;
                transition: height 0.3s;
            }
            
            nav.active ul {
                height: auto;
                padding: 10px 0;
            }
            
            nav ul li {
                margin: 0;
                padding: 12px 20px;
                border-bottom: 1px solid #eee;
            }
            
            nav ul li:last-child {
                border-bottom: none;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/main">멤버 위치 웹</a>
            </div>
            <div class="menu-toggle">
                <i class="fas fa-bars"></i>
            </div>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/board/main">게시판</a></li>
                    <li><a href="${pageContext.request.contextPath}/kakaomap/main">지도</a></li>
                    
                    <c:choose>
                        <c:when test="${not empty loginMemberBean.id}">
                            <li><a href="${pageContext.request.contextPath}/member/modify">정보수정</a></li>
                            <li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
                            
                            <!-- 알림 아이콘 -->
                            <li class="notification-icon-container" id="notificationContainer">
                                <div class="notification-icon">
                                    <i class="fas fa-bell"></i>
                                    <span class="notification-badge" id="notificationBadge"></span>
                                </div>
                                <div class="notification-dropdown" id="notificationDropdown">
                                    <div class="notification-header">
                                        <h4 class="notification-title">알림</h4>
                                        <a href="${pageContext.request.contextPath}/notification/list" class="view-all">모두 보기</a>
                                    </div>
                                    <div id="notificationContent">
                                        <div class="no-notifications">알림이 없습니다.</div>
                                    </div>
                                </div>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${pageContext.request.contextPath}/member/login">로그인</a></li>
                            <li><a href="${pageContext.request.contextPath}/member/join">회원가입</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </nav>
        </div>
    </header>
    
    <!-- 알림 관련 JavaScript -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 모바일 메뉴 토글
            const menuToggle = document.querySelector('.menu-toggle');
            const nav = document.querySelector('nav');
            
            if (menuToggle) {
                menuToggle.addEventListener('click', function() {
                    nav.classList.toggle('active');
                });
            }
            
            // 알림 기능은 로그인한 경우에만 실행
            if (document.getElementById('notificationContainer')) {
                const notificationContainer = document.getElementById('notificationContainer');
                const notificationDropdown = document.getElementById('notificationDropdown');
                const notificationBadge = document.getElementById('notificationBadge');
                const notificationContent = document.getElementById('notificationContent');
                
                // 알림 아이콘 클릭 이벤트
                notificationContainer.addEventListener('click', function(e) {
                    e.stopPropagation();
                    notificationDropdown.classList.toggle('show');
                    
                 // 알림 드롭다운이 열릴 때마다 최신 알림 로드
                    if (notificationDropdown.classList.contains('show')) {
                        loadNotifications();
                    }
                });
                
                // 페이지 외부 클릭 시 알림 드롭다운 닫기
                document.addEventListener('click', function(e) {
                    if (!notificationContainer.contains(e.target)) {
                        notificationDropdown.classList.remove('show');
                    }
                });
                
                // 알림 로드 함수
                function loadNotifications() {
                    fetch('${pageContext.request.contextPath}/notification/recent')
                        .then(response => response.json())
                        .then(notifications => {
                            if (notifications.length === 0) {
                                notificationContent.innerHTML = '<div class="no-notifications">알림이 없습니다.</div>';
                                notificationBadge.style.display = 'none';
                            } else {
                                // 알림 배지 업데이트
                                notificationBadge.textContent = notifications.length;
                                notificationBadge.style.display = 'block';
                                
                                // 알림 목록 생성
                                const notificationList = document.createElement('ul');
                                notificationList.className = 'notification-list';
                                
                                notifications.forEach(notification => {
                                    const notificationItem = document.createElement('li');
                                    notificationItem.className = `notification-item ${notification.read ? '' : 'unread'}`;
                                    
                                    // 알림 아이콘 선택
                                    let iconClass = 'fas fa-bell';
                                    switch(notification.type) {
                                        case 'PARTICIPATION':
                                            iconClass = 'fas fa-user-plus';
                                            break;
                                        case 'POST_LINKED':
                                            iconClass = 'fas fa-map-marker-alt';
                                            break;
                                        case 'WAITING_LIST':
                                            iconClass = 'fas fa-user-clock';
                                            break;
                                    }
                                    
                                    notificationItem.innerHTML = `
                                        <div class="notification-content">
                                            <i class="${iconClass}"></i> 
                                            ${notification.content}
                                        </div>
                                        <div class="notification-time">
                                            \${formatTime(notification.createdAt)}
                                        </div>
                                    `;
                                    
                                    // 알림 클릭 시 해당 게시글로 이동
                                    notificationItem.addEventListener('click', function() {
                                        if (notification.postId) {
                                            window.location.href = '${pageContext.request.contextPath}/board/read?id=' + notification.postId;
                                        }
                                        
                                        // 알림 읽음 처리
                                        markNotificationAsRead(notification.id);
                                    });
                                    
                                    notificationList.appendChild(notificationItem);
                                });
                                
                                notificationContent.innerHTML = '';
                                notificationContent.appendChild(notificationList);
                            }
                        })
                        .catch(error => {
                            console.error('알림 로드 중 오류:', error);
                            notificationContent.innerHTML = '<div class="no-notifications">알림을 불러오는 중 오류가 발생했습니다.</div>';
                        });
                }
                
                // 알림 시간 포맷팅 함수
                function formatTime(timestamp) {
                    const now = new Date();
                    const notificationTime = new Date(timestamp);
                    const diffMinutes = Math.round((now - notificationTime) / (1000 * 60));
                    
                    if (diffMinutes < 1) return '방금 전';
                    if (diffMinutes < 60) return `${diffMinutes}분 전`;
                    
                    const diffHours = Math.round(diffMinutes / 60);
                    if (diffHours < 24) return `${diffHours}시간 전`;
                    
                    const diffDays = Math.round(diffHours / 24);
                    if (diffDays < 7) return `${diffDays}일 전`;
                    
                    return new Date(timestamp).toLocaleDateString();
                }
                
                // 알림 읽음 처리 함수
                function markNotificationAsRead(notificationId) {
                    fetch('${pageContext.request.contextPath}/notification/markAsRead', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ id: notificationId })
                    });
                }
                
                // 주기적으로 알림 확인 (30초마다)
                setInterval(function() {
                    // 드롭다운이 열려있지 않을 때만 알림 확인
                    if (!notificationDropdown.classList.contains('show')) {
                        loadNotifications();
                    }
                }, 30000);
                
                // 초기 알림 로드
                loadNotifications();
            }
        });
    </script>
</body>
</html>