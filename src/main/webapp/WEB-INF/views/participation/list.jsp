<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>참여자 목록</title>
    <style>
        body {
            font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
            line-height: 1.6;
            color: #333;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }
        
        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        
        h1 {
            margin-top: 0;
            color: #03c75a;
            border-bottom: 2px solid #03c75a;
            padding-bottom: 10px;
        }
        
        .section {
            margin-bottom: 30px;
        }
        
        .section-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .participant-count {
            font-size: 1rem;
            color: #666;
        }
        
        .participant-list {
            list-style-type: none;
            padding: 0;
        }
        
        .participant-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
            transition: background-color 0.3s;
        }
        
        .participant-item:hover {
            background-color: #f9f9f9;
        }
        
        .participant-info {
            display: flex;
            align-items: center;
        }
        
        .participant-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #e0e0e0;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-right: 15px;
            font-weight: bold;
            color: white;
            background-color: #03c75a;
        }
        
        .participant-name {
            font-weight: bold;
        }
        
        .participant-contact {
            font-size: 0.9rem;
            color: #666;
            margin-top: 3px;
        }
        
        .participant-date {
            font-size: 0.85rem;
            color: #888;
        }
        
        .no-participants {
            padding: 20px;
            text-align: center;
            color: #888;
            font-style: italic;
            background-color: #f9f9f9;
            border-radius: 4px;
        }
        
        .notice {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            border-left: 4px solid #03c75a;
        }
        
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 8px 16px;
            background-color: #03c75a;
            color: white;
            border-radius: 4px;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        
        .back-btn:hover {
            background-color: #02ad4e;
            text-decoration: none;
        }
        
        .tab-container {
            display: flex;
            margin-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }
        
        .tab {
            padding: 10px 20px;
            cursor: pointer;
            border: 1px solid transparent;
            border-bottom: none;
            border-radius: 4px 4px 0 0;
            margin-right: 5px;
        }
        
        .tab.active {
            background-color: white;
            border-color: #ddd;
            color: #03c75a;
            font-weight: bold;
        }
        
        .tab-content {
            display: none;
        }
        
        .tab-content.active {
            display: block;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/header.jsp"/>
    
    <div class="container">
        <h1>참여자 목록</h1>
        
        <div class="notice">
            이 페이지에서는 해당 게시글에 참여한 사용자와 대기자 목록을 확인할 수 있습니다.
        </div>
        
        <div class="tab-container">
            <div class="tab active" data-tab="participants">참여자 (${participants.size()})</div>
            <div class="tab" data-tab="waiting">대기자 (${waitingList.size()})</div>
        </div>
        
        <!-- 참여자 목록 탭 -->
        <div id="participants" class="tab-content active">
            <div class="section">
                <div class="section-title">
                    참여자 목록
                    <span class="participant-count">${participants.size()}/${maxParticipants}</span>
                </div>
                
                <c:if test="${empty participants}">
                    <div class="no-participants">
                        아직 참여자가 없습니다.
                    </div>
                </c:if>
                
                <c:if test="${not empty participants}">
                    <ul class="participant-list">
                        <c:forEach var="participant" items="${participants}">
                            <li class="participant-item">
                                <div class="participant-info">
                                    <div class="participant-avatar">
                                        ${fn:substring(participant.memberName, 0, 1)}
                                    </div>
                                    <div>
                                        <div class="participant-name">${participant.memberName}</div>
                                        <div class="participant-contact">${participant.memberEmail}</div>
                                    </div>
                                </div>
                                <div class="participant-date">
                                    참여일: <fmt:formatDate value="${participant.participationDate}" 
                                                     pattern="yyyy-MM-dd HH:mm"/>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
            </div>
        </div>
        
        <!-- 대기자 목록 탭 -->
        <div id="waiting" class="tab-content">
            <div class="section">
                <div class="section-title">
                    대기자 목록
                    <span class="participant-count">${waitingList.size()}</span>
                </div>
                
                <c:if test="${empty waitingList}">
                    <div class="no-participants">
                        현재 대기자가 없습니다.
                    </div>
                </c:if>
                
                <c:if test="${not empty waitingList}">
                    <ul class="participant-list">
                        <c:forEach var="waiting" items="${waitingList}" varStatus="status">
                            <li class="participant-item">
                                <div class="participant-info">
                                    <div class="participant-avatar" style="background-color: #ff9800;">
                                        ${fn:substring(waiting.memberName, 0, 1)}
                                    </div>
                                    <div>
                                        <div class="participant-name">${waiting.memberName} <small>(대기 ${status.index + 1}번)</small></div>
                                        <div class="participant-contact">${waiting.memberEmail}</div>
                                    </div>
                                </div>
                                <div class="participant-date">
                                    등록일: <fmt:formatDate value="${waiting.registrationDate}" 
                                                     pattern="yyyy-MM-dd HH:mm"/>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
            </div>
        </div>
        
        <a href="${pageContext.request.contextPath}/board/read?id=${postId}" class="back-btn">게시글로 돌아가기</a>
    </div>
    
    <jsp:include page="/WEB-INF/views/include/footer.jsp"/>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 탭 전환 기능
            const tabs = document.querySelectorAll('.tab');
            
            tabs.forEach(tab => {
                tab.addEventListener('click', function() {
                    // 모든 탭 비활성화
                    tabs.forEach(t => t.classList.remove('active'));
                    
                    // 모든 탭 컨텐츠 숨기기
                    document.querySelectorAll('.tab-content').forEach(content => {
                        content.classList.remove('active');
                    });
                    
                    // 클릭한 탭 활성화
                    this.classList.add('active');
                    
                    // 해당 탭 컨텐츠 표시
                    const tabName = this.getAttribute('data-tab');
                    document.getElementById(tabName).classList.add('active');
                });
            });
        });
    </script>
</body>
</html>