<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<html>
<head>
<title>채팅방 목록</title>
</head>
<body>
	<h2>채팅방 목록</h2>
	<button onclick="createChatRoom()">새 채팅방 만들기</button>

	<!-- 채팅방이 있을 때만 목록 표시 -->
	<c:choose>
		<c:when test="${not empty rooms}">
			<ul>
				<c:forEach var="room" items="${rooms}">
					<li>${room.name}
						<button onclick="openChatRoom('${room.id}')">입장</button>
					</li>
				</c:forEach>
			</ul>
		</c:when>
		<c:otherwise>
			<p>채팅방이 없습니다. 새 채팅방을 만들어 주세요!</p>
		</c:otherwise>
	</c:choose>

	<script>
		function createChatRoom() {
			let roomName = prompt("채팅방 이름을 입력하세요");//입력창
			let root = "${root}";
			if (roomName) {
				$.ajax({
					url : root + "/chating/create",
					type : "POST",
					data : {
						name : roomName
					},
					success : function(response) {
						alert("채팅방이 생성되었습니다");
						location.reload();
					},
					error : function(xhr, status, error) {
						alert("오류 발생: " + error);
					}
				});
			}
		}

		function openChatRoom(roomId) {
			let chatWindow = window.open("${root}/chating/room?roomId="
					+ roomId, "chatRoom" + roomId, "width=500,height=600");
			chatWindow.focus();
		}
	</script>
</body>
</html>
