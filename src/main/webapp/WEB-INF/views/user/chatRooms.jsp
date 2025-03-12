<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<html>
<head>
    <title>채팅방 목록</title>
</head>
<body>
    <h2>채팅방 목록</h2>
    <button onclick="createRoom()">➕ 새 채팅방 만들기</button>
    
    <!--  채팅방이 있을 때만 목록 표시 -->
    <c:choose>
        <c:when test="${not empty rooms}">
            <ul>
                <c:forEach var="room" items="${rooms}">
                    <li>
                        ${room.name} 
                        <button onclick="openChatRoom('${room.id}')">입장</button>
                    </li>
                </c:forEach>
            </ul>
        </c:when>
        <c:otherwise>
            <p>❌ 채팅방이 없습니다. 새 채팅방을 만들어 주세요!</p>
        </c:otherwise>
    </c:choose>

    <script>
        function createRoom() {
            let roomName = prompt("채팅방 이름을 입력하세요");
            if (roomName) {
                fetch('${contextPath}/api/chat/create?name=' + encodeURIComponent(roomName), {
                    method: 'POST'
                }).then(() => location.reload());
            }
        }

        function openChatRoom(roomId) {
            let chatWindow = window.open("${contextPath}/chat/room?roomId=" + roomId, 
                                         "chatRoom" + roomId, 
                                         "width=500,height=600");
            chatWindow.focus();
        }
    </script>
</body>
</html>
