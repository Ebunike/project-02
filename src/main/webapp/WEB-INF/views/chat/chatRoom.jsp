<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<html> 
<head> 
<title>채팅방</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.0.0/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
	<h2>채팅방 - ID: ${roomId}</h2>
	<div id="chat"></div>
	<input type="text" id="sender" value="${sender }" readonly="readonly">
	<input type="text" id="message" placeholder="메시지를 입력하세요">
	<button onclick="sendMessage()">전송</button>

	<script>
		let roomId = "${roomId}";
		let socket = new SockJS('${root}/chat');//서버의 /chat 엔드포인트에 웹소켓 연결
		let stompClient = Stomp.over(socket);//웹소켓을 STOMP 프로토콜과 함께 사용하도록 설정
		//Stomp: 메시지를 전송하기 위한 프로토콜

		stompClient.connect({}, function(frame) {
			console.log("Connected: " + frame);
			stompClient.subscribe('/topic/chat/' + roomId, function(message) {
			//stompClient.subscribe(destination, callbackFunction): 특정 채널(토픽)을 구독
			//topic/chat/{roomId} 경로의 메시지를 구독하면, 해당 방의 메시지를 실시간으로 수신
			//서버가 /topic/chat/{roomId} 경로로 메시지를 보내면, 이 코드가 해당 메시지를 받는 역할	
				let chatMessage = JSON.parse(message.body);//서버에서 전송한 JSON 형식의 메시지
				document.getElementById("chat").innerHTML += "<p><b>"
						+ chatMessage.sender + ":</b> " + chatMessage.content
						+ "</p>";
			});
		});
		//STOMP 클라이언트(stompClient)가 웹소켓 서버에 연결을 시도
		//{} 내부에 추가적인 헤더 정보(예: Authorization 토큰)를 넣을 수도 있지만, 지금은 공백
		//연결 완료 시 함수 수행

		function sendMessage() {
			let sender = document.getElementById("sender").value;
			let content = document.getElementById("message").value;
			let chatMessage = {
				sender : sender,
				content : content,
				roomId : roomId
			};
			stompClient.send("/app/chat/" + roomId, {}, JSON
					.stringify(chatMessage));//웹소켓 서버로 메시지 전송(JSON.stringify(chatMessage) → 메시지를 JSON 형식의 문자열로 변환)
			document.getElementById("message").value = "";
		}//클라이언트에서 웹소켓 서버로 메시지를 전송
	</script>
</body>
</html>
