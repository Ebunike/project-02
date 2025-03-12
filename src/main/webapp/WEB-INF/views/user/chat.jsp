<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<html>
<head>
    <title>Spring WebSocket Chat</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.0.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
    <h2>스프링 웹소켓 채팅</h2>
    <div id="chat"></div>
    <input type="text" id="sender" placeholder="이름 입력">
    <input type="text" id="message" placeholder="메시지를 입력하세요">
    <button onclick="sendMessage()">전송</button>

    <script>
        let socket = new SockJS('${contextPath}/chat'); // 🔥 컨텍스트 루트를 동적으로 설정!
        let stompClient = Stomp.over(socket);

        stompClient.connect({}, function (frame) {
            console.log("Connected: " + frame);
            stompClient.subscribe('/topic/messages', function (message) {
                var chatMessage = JSON.parse(message.body);
                document.getElementById("chat").innerHTML += "<p><b>" + chatMessage.sender + ":</b> " + chatMessage.content + "</p>";
            });
        });

        function sendMessage() {
        	let sender = document.getElementById("sender").value;
        	let content = document.getElementById("message").value;
        	let chatMessage = {
                sender: sender,
                content: content
            };
            stompClient.send("/app/sendMessage", {}, JSON.stringify(chatMessage));
            document.getElementById("message").value = "";
        }
    </script>
</body>
</html>
