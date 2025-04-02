<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마커-게시글 연결</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/header.jsp"/>
    <main>
        <div class="container">
            <h2>마커와 게시글 연결하기</h2>
            <div class="form-container">
                <form id="linkForm" method="post" action="${pageContext.request.contextPath}/postmap/linkFromKakaoMap">
                    <input type="hidden" id="postId" name="postId" value="${postId}">
                    <input type="hidden" id="mapId" name="mapId">
                    <input type="hidden" id="latitude" name="latitude">
                    <input type="hidden" id="longitude" name="longitude">
                    <input type="hidden" id="address" name="address">
                    <input type="hidden" id="markerType" name="markerType" value="default">
                    
                    <div class="form-group">
                        <label for="searchKeyword">장소 검색:</label>
                        <div class="search-container">
                            <input type="text" id="searchKeyword" placeholder="장소명 입력">
                            <button type="button" id="searchBtn">검색</button>
                        </div>
                    </div>
                    
                    <div id="map" style="width:100%;height:400px;"></div>
                    
                    <div class="form-group">
                        <label>마커 카테고리:</label>
                        <div class="category-select">
                            <label><input type="radio" name="markerTypeSelect" value="lifestyle" checked> 라이프스타일</label>
                            <label><input type="radio" name="markerTypeSelect" value="craft"> 수공예</label>
                            <label><input type="radio" name="markerTypeSelect" value="food"> 푸드</label>
                            <label><input type="radio" name="markerTypeSelect" value="fashion"> 패션</label>
                            <label><input type="radio" name="markerTypeSelect" value="beauty"> 뷰티</label>
                        </div>
                    </div>
                    
                    <div class="selected-place-info" style="display:none;">
                        <h3>선택된 장소</h3>
                        <div id="selectedPlaceInfo"></div>
                    </div>
                    
                    <div class="button-group">
                        <button type="submit" class="submit-btn" disabled>연결하기</button>
                        <a href="${pageContext.request.contextPath}/board/read?id=${postId}" class="cancel-btn">취소</a>
                    </div>
                </form>
            </div>
        </div>
    </main>
<%--     <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>
    
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fb9c39f52da6918d5d47283a1cf98395&libraries=services"></script>
    <script>
        // 카카오맵 및 마커-게시글 연결 관련 자바스크립트 코드
        // (여기에 지도 초기화 및 검색, 마커 선택, 카테고리 선택 코드가 들어갑니다)
    </script>
</body>
</html>