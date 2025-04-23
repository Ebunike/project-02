<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${place.place_name} - 장소 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <style>
        .place-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }
        
        .place-title {
            margin-top: 0;
            color: #333;
            border-bottom: 2px solid #03c75a;
            padding-bottom: 10px;
        }
        
        .place-info {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 4px;
        }
        
        .place-address {
            margin-bottom: 10px;
        }
        
        .place-map {
            width: 100%;
            height: 300px;
            margin-bottom: 20px;
            border-radius: 4px;
            overflow: hidden;
        }
        
        .related-posts-title {
            margin-top: 30px;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        
        .related-posts-list {
            list-style-type: none;
            padding: 0;
        }
        
        .related-post-item {
            padding: 15px;
            margin-bottom: 10px;
            border: 1px solid #eee;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        
        .related-post-item:hover {
            background-color: #f9f9f9;
        }
        
        .post-title a {
            color: #333;
            font-weight: bold;
            text-decoration: none;
        }
        
        .post-title a:hover {
            color: #03c75a;
        }
        
        .post-meta {
            margin-top: 5px;
            font-size: 0.9em;
            color: #666;
            display: flex;
            justify-content: space-between;
        }
        
        .no-posts {
            padding: 20px;
            text-align: center;
            color: #888;
            background-color: #f9f9f9;
            border-radius: 4px;
        }
        
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 8px 16px;
            background-color: #03c75a;
            color: white;
            border-radius: 4px;
            text-decoration: none;
        }
        
        .back-btn:hover {
            background-color: #02ad4e;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/header.jsp"/>
    <main>
        <div class="container">
            <div class="place-header">
                <h2 class="place-title">${place.place_name}</h2>
                <div>
                    <c:if test="${loginMember.id == place.member_id}">
                        <a href="${pageContext.request.contextPath}/kakaomap/deletePlace?identifier=${place.identifier}" 
                           onclick="return confirm('이 장소를 삭제하시겠습니까?');" class="delete-btn">장소 삭제</a>
                    </c:if>
                </div>
            </div>
            
            <div class="place-info">
                <div class="place-address">주소: ${place.address_name}</div>
                <div>카테고리: 
                    <c:choose>
                        <c:when test="${place.marker_type eq 'lifestyle'}">라이프스타일</c:when>
                        <c:when test="${place.marker_type eq 'craft'}">수공예</c:when>
                        <c:when test="${place.marker_type eq 'food'}">푸드</c:when>
                        <c:when test="${place.marker_type eq 'fashion'}">패션</c:when>
                        <c:when test="${place.marker_type eq 'beauty'}">뷰티</c:when>
                        <c:otherwise>${place.marker_type}</c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <div class="place-map" id="map"></div>
            
            <h3 class="related-posts-title">관련 게시글</h3>
            
            <c:if test="${empty relatedPosts}">
                <div class="no-posts">
                    이 장소와 연결된 게시글이 없습니다.
                </div>
            </c:if>
            
            <c:if test="${not empty relatedPosts}">
                <ul class="related-posts-list">
                    <c:forEach var="post" items="${relatedPosts}">
                        <li class="related-post-item">
                            <div class="post-title">
                                <a href="${pageContext.request.contextPath}/board/read?id=${post.id}">${post.title}</a>
                            </div>
                            <div class="post-meta">
                                <span>작성자: ${post.writer_id}</span>
                                <span>등록일: <fmt:formatDate value="${post.regdate}" pattern="yyyy-MM-dd"/></span>
                            </div>
                            <div class="post-participation">
                                참여자: ${post.currentParticipants}/${post.maxParticipants}
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
            
            <a href="${pageContext.request.contextPath}/kakaomap/main" class="back-btn">지도로 돌아가기</a>
        </div>
    </main>
<%--     <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>
    
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fb9c39f52da6918d5d47283a1cf98395&libraries=services"></script>
    <script>
        // 지도 초기화 및 마커 표시 코드
        var mapContainer = document.getElementById('map');
        var mapOption = { 
            center: new kakao.maps.LatLng(${place.y}, ${place.x}),
            level: 3
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);
        
        // 마커 추가
        var marker = new kakao.maps.Marker({
            position: new kakao.maps.LatLng(${place.y}, ${place.x}),
            map: map
        });
    </script>
</body>
</html>