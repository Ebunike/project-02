<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<html>
<head>
    <title>개인 문의</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }
        
        body {
            background-color: #f8f9fa;
            color: #333;
            line-height: 1.6;
            padding: 20px;
            max-width: 800px;
            margin: 0 auto;
        }
        
        h3 {
            color: #2c3e50;
            margin: 25px 0 15px 0;
            font-size: 1.5rem;
            font-weight: 600;
            border-bottom: 2px solid #3498db;
            padding-bottom: 8px;
            display: inline-block;
        }
        
        ul {
            list-style: none;
            padding: 0;
        }
        
        li {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 12px;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        li:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        
        button {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.2s;
            display: flex;
            align-items: center;
        }
        
        button:hover {
            background-color: #2980b9;
        }
        
        button i {
            margin-left: 6px;
        }
        
        p {
            color: #7f8c8d;
            text-align: center;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            font-size: 1.1rem;
        }
        
        .room-name {
            font-weight: 500;
            color: #34495e;
            font-size: 1.1rem;
        }
        
        .no-inquiries {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px 20px;
        }
        
        .no-inquiries i {
            font-size: 3rem;
            color: #bdc3c7;
            margin-bottom: 15px;
        }
        .go_home .btn {
            background-color: transparent;
            border: 1px solid #333;
            color: #333;
            display: flex;
            align-items: center;
            padding: 8px 15px;
            border-radius: 4px;
            transition: all 0.3s ease;
            width: 150px;
        }
        .go_home .btn:hover {
            background-color: #333;
            color: white;
        }
        .go_home .btn i {
            margin-right: 8px;
        }
    </style>
</head>  
<body>
			<div class="go_home">
                <a href="<c:url value='/'/>" class="btn">
                    <i class="fas fa-home"></i> 홈으로
                </a>
            </div>
    <c:choose>
        <c:when test="${not empty rooms}">
            <c:choose>
                <c:when test="${loginUser.login.equals('buyer')}">
                <h3>상품 문의</h3>
                    <ul>
                        <c:forEach var="privateChat" items="${rooms }">
                            <c:if test="${privateChat.buyer == loginUser.name }">
                            <li>
                                <span class="room-name">${privateChat.name}</span>
                                <button onclick="openChatRoom('${privateChat.id}')">
                                    입장 <i class="fas fa-arrow-right"></i>
                                </button>
                            </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${loginUser.login.equals('seller')}">
                <h3>상품 문의</h3>
                    <ul>
                        <c:forEach var="privateChat" items="${rooms }">
                            <c:if test="${privateChat.seller == loginUser.name }">
                                <li>
                                    <span class="room-name">${privateChat.name}</span>
                                    <button onclick="openChatRoom('${privateChat.id}')">
                                        입장 <i class="fas fa-arrow-right"></i>
                                    </button>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </c:when>
            </c:choose>
        </c:when>
        <c:otherwise>
            <div class="no-inquiries">
                <i class="far fa-comment-dots"></i>
                <p>문의사항이 없습니다.</p>
            </div>
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
            let chatWindow = window.open("${root}/chat/room?roomId="
                    + roomId, "chatRoom" + roomId, "width=500,height=600");
            chatWindow.focus();
        }
    </script>
</body>
</html>