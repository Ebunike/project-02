<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<html> 
<head> 
    <title>채팅방</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.0.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            height: 100vh;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }
        
        .chat-header {
            background-color: #3498db;
            color: white;
            padding: 15px 20px;
            display: flex;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .chat-header h2 {
            font-size: 1.2rem;
            font-weight: 500;
            margin-left: 10px;
        }
        
        .chat-container {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            background-color: #f5f7fa;
        }
        
        #chat {
            display: flex;
            flex-direction: column;
            gap: 12px;
            padding-bottom: 15px;
        }
        
        .message {
            max-width: 80%;
            padding: 10px 15px;
            border-radius: 18px;
            position: relative;
            line-height: 1.5;
            font-size: 0.95rem;
            word-break: break-word;
        }
        
        .sender-name {
            font-size: 0.8rem;
            margin-bottom: 4px;
            font-weight: 500;
        }
        
        .my-message {
            background-color: #3498db;
            color: white;
            align-self: flex-end;
            border-bottom-right-radius: 4px;
        }
        
        .other-message {
            background-color: white;
            color: #333;
            align-self: flex-start;
            border-bottom-left-radius: 4px;
            box-shadow: 0 1px 2px rgba(0,0,0,0.1);
        }
        
        .input-area {
            display: flex;
            padding: 15px;
            background-color: white;
            box-shadow: 0 -2px 5px rgba(0,0,0,0.05);
        }
        
        .input-area input[type="text"] {
            flex: 1;
            padding: 12px 15px;
            border: 1px solid #e1e8ed;
            border-radius: 20px;
            margin-right: 10px;
            font-size: 0.95rem;
            outline: none;
            transition: border-color 0.2s;
        }
        
        .input-area input[type="text"]:focus {
            border-color: #3498db;
        }
        
        .input-area input[type="text"]#sender {
            flex: none;
            width: auto;
            max-width: 80px;
            background-color: #edf2f7;
            color: #4a5568;
            font-weight: 500;
            margin-right: 10px;
        }
        
        .input-area button {
            background-color: #3498db;
            color: white;
            border: none;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            cursor: pointer;
            transition: background-color 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .input-area button:hover {
            background-color: #2980b9;
        }
        
        .input-area button i {
            font-size: 1.2rem;
        }
        
        /* Hide scrollbar for Chrome, Safari and Opera */
        .chat-container::-webkit-scrollbar {
            display: none;
        }
        
        /* Hide scrollbar for IE, Edge and Firefox */
        .chat-container {
            -ms-overflow-style: none;  /* IE and Edge */
            scrollbar-width: none;  /* Firefox */
        }
        
        .time-stamp {
            font-size: 0.7rem;
            color: #a0aec0;
            margin-top: 4px;
            text-align: right;
        }
        
    </style>
</head>
<body>
    <div class="chat-header">
        <i class="fas fa-comments"></i>
        <h2>채팅방 - ID: ${roomId}</h2>
    </div>
    
    <div class="chat-container">
        <div id="chat"></div>
    </div>
    
    <div class="input-area">
        <input type="text" id="sender" value="${sender}" readonly="readonly">
        <input type="text" id="message" placeholder="메시지를 입력하세요">
        <button onclick="sendMessage()">
            <i class="fas fa-paper-plane"></i>
        </button>
    </div>
    
    <script>
        let roomId = "${roomId}";
        let socket = new SockJS('${root}/chat');//서버의 /chat 엔드포인트에 웹소켓 연결
        let stompClient = Stomp.over(socket);//웹소켓을 STOMP 프로토콜과 함께 사용하도록 설정
        let currentSender = document.getElementById("sender").value;
        
        // Enter 키로 메시지 전송
        document.getElementById("message").addEventListener("keypress", function(event) {
            if (event.key === "Enter") {
                event.preventDefault();
                sendMessage();
            }
        });
        
        stompClient.connect({}, function(frame) {
            console.log("Connected: " + frame);
            stompClient.subscribe('/topic/chat/' + roomId, function(message) {
                let chatMessage = JSON.parse(message.body);
                let isMine = chatMessage.sender === currentSender;
                
                // 현재 시간 가져오기
                let now = new Date();
                let hours = now.getHours().toString().padStart(2, '0');
                let minutes = now.getMinutes().toString().padStart(2, '0');
                let timeString = hours + ':' + minutes;
                
                // 메시지 요소 생성
                let messageElement = document.createElement('div');
                messageElement.className = isMine ? 'message my-message' : 'message other-message';
                
                let messageContent = '';
                
                // 내 메시지가 아닌 경우에만 발신자 이름 표시
                if (!isMine) {
                    messageContent += '<div class="sender-name">' + chatMessage.sender + '</div>';
                }
                
                messageContent += chatMessage.content;
                messageContent += '<div class="time-stamp">' + timeString + '</div>';
                
                messageElement.innerHTML = messageContent;
                document.getElementById("chat").appendChild(messageElement);
                
                // 새 메시지가 추가될 때 스크롤을 아래로 이동
                let chatContainer = document.querySelector('.chat-container');
                chatContainer.scrollTop = chatContainer.scrollHeight;
            });
            
            // 페이지 로드 시 스크롤을 아래로 이동
            let chatContainer = document.querySelector('.chat-container');
            chatContainer.scrollTop = chatContainer.scrollHeight;
        });
        
        function sendMessage() {
            let sender = document.getElementById("sender").value;
            let content = document.getElementById("message").value.trim();
            
            if (content === '') return;
            
            let chatMessage = {
                sender: sender,
                content: content,
                roomId: roomId
            };
            
            stompClient.send("/app/chat/" + roomId, {}, JSON.stringify(chatMessage));
            document.getElementById("message").value = "";
        }
    </script>
</body>
</html>