<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>위치 선택</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fb9c39f52da6918d5d47283a1cf98395&libraries=services"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
            line-height: 1.6;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .map-container {
            width: 100%;
            height: 500px;
            border: 1px solid #ddd;
            margin-bottom: 20px;
        }
        
        .search-container {
            margin-bottom: 20px;
        }
        
        .search-input {
            width: 70%;
            padding: 10px;
            border: 1px solid #ddd;
        }
        
        .search-btn {
            padding: 10px 15px;
            background-color: #03c75a;
            color: white;
            border: none;
            cursor: pointer;
        }
        
        .location-info {
            margin-top: 20px;
        }
        
        .location-info p {
            margin: 10px 0;
        }
        
        .btn-container {
            margin-top: 20px;
            text-align: right;
        }
        
        .btn {
            padding: 10px 15px;
            margin-left: 10px;
            cursor: pointer;
        }
        
        .btn-primary {
            background-color: #03c75a;
            color: white;
            border: none;
        }
        
        .btn-secondary {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <%@ include file="../include/header.jsp" %>
    
    <div class="container">
        <h2>위치 선택</h2>
        
        <div class="search-container">
            <input type="text" id="searchInput" class="search-input" placeholder="장소 검색">
            <button id="searchBtn" class="search-btn">검색</button>
        </div>
        
        <div id="map" class="map-container"></div>
        
        <div class="location-info">
            <p><strong>선택한 위치:</strong> <span id="selectedLocation">아직 선택되지 않음</span></p>
            <p><strong>주소:</strong> <span id="selectedAddress">-</span></p>
            <p><strong>좌표:</strong> 위도 <span id="latitude">-</span>, 경도 <span id="longitude">-</span></p>
        </div>
        
        <div class="btn-container">
            <button id="cancelBtn" class="btn btn-secondary">취소</button>
            <button id="selectBtn" class="btn btn-primary">선택 완료</button>
        </div>
    </div>
    
    <script>
        var map;
        var marker;
        var geocoder;
        var selectedPosition;
        
        document.addEventListener('DOMContentLoaded', function() {
            // 카카오맵 초기화
            var container = document.getElementById('map');
            var options = {
                center: new kakao.maps.LatLng(37.566826, 126.9786567), // 서울 시청
                level: 3
            };
            
            map = new kakao.maps.Map(container, options);
            geocoder = new kakao.maps.services.Geocoder();
            
            // 마커 생성
            marker = new kakao.maps.Marker({
                position: map.getCenter(),
                map: map,
                draggable: true
            });
            
            // 맵 클릭 이벤트
            kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
                var latlng = mouseEvent.latLng;
                marker.setPosition(latlng);
                updateLocationInfo(latlng);
            });
            
            // 마커 드래그 이벤트
            kakao.maps.event.addListener(marker, 'dragend', function() {
                var latlng = marker.getPosition();
                updateLocationInfo(latlng);
            });
            
            // 검색 버튼 클릭 이벤트
            document.getElementById('searchBtn').addEventListener('click', function() {
                searchLocation();
            });
            
            // 엔터키 검색
            document.getElementById('searchInput').addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    searchLocation();
                }
            });
            
            // 취소 버튼
            document.getElementById('cancelBtn').addEventListener('click', function() {
                window.history.back();
            });
            
            // 선택 완료 버튼
            document.getElementById('selectBtn').addEventListener('click', function() {
                if (!selectedPosition) {
                    alert('위치를 선택해주세요.');
                    return;
                }
                
                // 선택한 위치 정보를 로컬 스토리지에 저장
                var locationData = {
                    latitude: selectedPosition.getLat(),
                    longitude: selectedPosition.getLng(),
                    address: document.getElementById('selectedAddress').textContent,
                    placeName: document.getElementById('selectedLocation').textContent
                };
                
                localStorage.setItem('selectedLocation', JSON.stringify(locationData));
                
                // 부모 창으로 메시지 전송
                if (window.opener) {
                    window.opener.postMessage({ type: 'LOCATION_SELECTED' }, '*');
                    window.close();
                } else {
                    alert('부모 창이 존재하지 않습니다.');
                }
            });
        });
        
        // 위치 검색 함수
        function searchLocation() {
            var keyword = document.getElementById('searchInput').value;
            if (!keyword.trim()) {
                alert('검색어를 입력해주세요.');
                return;
            }
            
            geocoder.addressSearch(keyword, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    
                    // 결과를 마커로 표시
                    marker.setPosition(coords);
                    map.setCenter(coords);
                    
                    updateLocationInfo(coords);
                } else {
                    // 키워드로 장소 검색
                    var ps = new kakao.maps.services.Places();
                    ps.keywordSearch(keyword, function(data, status) {
                        if (status === kakao.maps.services.Status.OK) {
                            var coords = new kakao.maps.LatLng(data[0].y, data[0].x);
                            
                            // 결과를 마커로 표시
                            marker.setPosition(coords);
                            map.setCenter(coords);
                            
                            updateLocationInfo(coords);
                        } else {
                            alert('검색 결과가 없습니다.');
                        }
                    });
                }
            });
        }
        
        // 위치 정보 업데이트 함수
        function updateLocationInfo(latlng) {
            selectedPosition = latlng;
            
            document.getElementById('latitude').textContent = latlng.getLat();
            document.getElementById('longitude').textContent = latlng.getLng();
            
            // 주소 정보 가져오기
            geocoder.coord2Address(latlng.getLng(), latlng.getLat(), function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var addr = result[0].address;
                    var road_address = result[0].road_address;
                    
                    document.getElementById('selectedAddress').textContent = 
                        road_address ? road_address.address_name : addr.address_name;
                    
                    // 장소명 가져오기
                    var ps = new kakao.maps.services.Places();
                    ps.categorySearch('CS2', function(places, psStatus) {
                        var placeName = '사용자 지정 위치';
                        
                        // 가까운 지역명 찾기 (첫 번째 편의점)
                        if (psStatus === kakao.maps.services.Status.OK && places.length > 0) {
                            placeName = places[0].place_name + ' 주변';
                        }
                        
                        document.getElementById('selectedLocation').textContent = placeName;
                    }, {
                        location: latlng,
                        radius: 500
                    });
                }
            });
        }
    </script>
</body>
</html>