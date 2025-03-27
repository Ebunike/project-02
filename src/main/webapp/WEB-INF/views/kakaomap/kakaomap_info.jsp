<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>멤버 주소 지도</title>
    <style>
        /* 맵 컨테이너의 스타일 */
        #map {
            width: 100%;
            height: 500px;
            margin-bottom: 20px;
        }
        
        /* 결과 표시 영역 스타일 */
        #clickLatlng {
            margin-top: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            background-color: #f8f9fa;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        
        /* 인포윈도우 스타일 */
        .info-window {
            padding: 15px;
            width: 250px;
            text-align: left;
        }
        
        .info-title {
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 8px;
            color: #03c75a;
        }
        
        .info-address {
            margin-bottom: 5px;
        }
        
        .info-contact {
            color: #555;
            margin-bottom: 10px;
        }
        
        /* 메모 입력 영역 스타일 */
        .memo-input {
            width: 100%;
            margin-top: 10px;
        }
        
        .memo-input textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: vertical;
            min-height: 60px;
        }
        
        .memo-input button {
            margin-top: 5px;
            padding: 6px 12px;
            background-color: #03c75a;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .memo-input button:hover {
            background-color: #02ad4e;
        }
        
        /* 저장된 장소 목록 스타일 */
        .saved-places {
            margin-top: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 15px;
            background-color: white;
        }
        
        .saved-places h3 {
            margin-top: 0;
            color: #03c75a;
            margin-bottom: 15px;
        }
        
        .place-item {
            padding: 10px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
        }
        
        .place-item:last-child {
            border-bottom: none;
        }
        
        .place-item:hover {
            background-color: #f5f5f5;
        }
        
        .place-name {
            font-weight: bold;
        }
        
        .place-address {
            font-size: 0.9em;
            color: #666;
        }
    </style>
</head>
<body>
    <h2>멤버 위치 정보</h2>
    
    <!-- 지도를 표시할 div -->
    <div id="map"></div>
    
    <!-- 클릭한 위치 정보를 표시할 div -->
    <div id="clickLatlng"></div>
    
    <!-- 저장된 장소 목록 -->
    <div class="saved-places">
        <h3>저장된 장소 목록</h3>
        <div id="placesList">
            <!-- 여기에 저장된 장소들이 표시됩니다 -->
        </div>
    </div>
    
    <!-- 카카오 맵 API 불러오기 - 주소 검색 기능을 위해 libraries=services 추가 -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3271852fb207f3646c1632162efc1284&libraries=services"></script>
    <script>
        // 멤버 정보 (서버에서 가져온 값)
        var memberInfo = {
            name: "${loginMember.name}", // JSP 표현식으로 멤버 이름 가져오기
            id: "${loginMember.id}", // JSP 표현식으로 멤버 ID 가져오기
            address: "${loginMember.address}", // JSP 표현식으로 멤버 주소 가져오기
            tel: "${loginMember.tel}", // JSP 표현식으로 멤버 전화번호 가져오기
            email: "${loginMember.email}" // JSP 표현식으로 멤버 이메일 가져오기
        };
        console.log("memberInfo.id:", memberInfo.id);
        // 지도를 표시할 div와 지도 옵션
        var mapContainer = document.getElementById('map');
        var mapOption = { 
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 기본 중심좌표 (나중에 변경됨)
            level: 3 // 지도의 확대 레벨
        };
        
        // 지도 생성
        var map = new kakao.maps.Map(mapContainer, mapOption);
        
        // 주소-좌표 변환 객체를 생성
        var geocoder = new kakao.maps.services.Geocoder();
        
        // 마커와 인포윈도우 관리를 위한 배열
        var markers = [];
        var infowindows = [];
        
        // 모든 인포윈도우 닫기 함수
        function closeAllInfowindows() {
            for(var i=0; i<infowindows.length; i++) {
                infowindows[i].close();
            }
        }
        
        // 멤버 주소로 좌표를 검색하여 지도 중심 설정
        if (memberInfo.address && memberInfo.address.trim() !== "") {
            geocoder.addressSearch(memberInfo.address, function(result, status) {
                // 정상적으로 검색이 완료됐으면 
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    
                    // 지도 중심을 이동
                    map.setCenter(coords);
                    
                    // 마커 생성
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords,
                        clickable: true // 마커 클릭 가능
                    });
                    
                    markers.push(marker);
                    
                    // 인포윈도우에 표출될 멤버 정보 HTML
                    var iwContent = '<div class="info-window">' +
                                    '<div class="info-title">' + memberInfo.name + '님의 위치</div>' +
                                    '<div class="info-address">주소: ' + memberInfo.address + '</div>' +
                                    '<div class="info-contact">연락처: ' + memberInfo.tel + '</div>' +
                                    '</div>';
                    
                    // 인포윈도우 생성
                    var infowindow = new kakao.maps.InfoWindow({
                        content: iwContent,
                        removable: true // 닫기 버튼 표시
                    });
                    
                    infowindows.push(infowindow);
                    
                    // 마커 클릭 시 인포윈도우 표시
                    kakao.maps.event.addListener(marker, 'click', function() {
                        closeAllInfowindows(); // 다른 인포윈도우 닫기
                        infowindow.open(map, marker);
                    });
                    
                    // 맨 처음에 인포윈도우 표시
                    infowindow.open(map, marker);
                } else {
                    alert("주소를 찾을 수 없습니다. 기본 위치를 표시합니다.");
                }
            });
        } else {
            alert("주소 정보가 없습니다. 기본 위치를 표시합니다.");
        }
        
        // 저장된 장소 로드
        loadSavedPlaces();
        
        // 지도 클릭 이벤트 처리 - 원하는 정보 표시
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
            // 클릭한 위도, 경도 정보를 가져옵니다
            var latlng = mouseEvent.latLng;
            
            // 역지오코딩 - 좌표를 주소로 변환
            geocoder.coord2Address(latlng.getLng(), latlng.getLat(), function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var detailAddr = !!result[0].road_address ? 
                        result[0].road_address.address_name : 
                        result[0].address.address_name;
                    
                    // 새 마커 생성
                    var marker = new kakao.maps.Marker({
                        position: latlng,
                        map: map
                    });
                    
                    markers.push(marker);
                    
                    // 랜덤 ID 생성 (실제로는 백엔드에서 생성될 ID)
                    var randomId = 'place_' + Math.floor(Math.random() * 100000);
                    
                    // 클릭한 위치 정보를 포함한 인포윈도우 내용 생성
                    var iwContent = '<div class="info-window">' +
                                    '<div class="info-title">선택한 위치</div>' +
                                    '<div class="info-address">주소: ' + detailAddr + '</div>' +
                                    '<div class="info-contact">위도: ' + latlng.getLat() + '</div>' +
                                    '<div class="info-contact">경도: ' + latlng.getLng() + '</div>' +
                                    '<div class="memo-input">' +
                                    '<textarea id="memo_' + randomId + '" placeholder="이 장소에 대한 메모를 입력하세요"></textarea>' +
                                    '<button onclick="savePlaceWithMemo(\'' + randomId + '\', \'' + 
                                        detailAddr + '\', \'' + latlng.getLat() + '\', \'' + 
                                        latlng.getLng() + '\')">저장하기</button>' +
                                    '</div>' +
                                    '</div>';
                    
                    // 인포윈도우 생성
                    var infowindow = new kakao.maps.InfoWindow({
                        content: iwContent,
                        removable: true
                    });
                    
                    infowindows.push(infowindow);
                    
                    // 마커에 클릭 이벤트 등록
                    kakao.maps.event.addListener(marker, 'click', function() {
                        closeAllInfowindows(); // 다른 인포윈도우 닫기
                        infowindow.open(map, marker);
                    });
                    
                    // 인포윈도우 표시
                    closeAllInfowindows(); // 다른 인포윈도우 닫기
                    infowindow.open(map, marker);
                    
                    // 클릭 정보 표시
                    var resultDiv = document.getElementById('clickLatlng');
                    resultDiv.innerHTML = '클릭한 위치: ' + detailAddr + 
                                         '<br>위도: ' + latlng.getLat() + 
                                         '<br>경도: ' + latlng.getLng();
                }
            });
        });
        
        // 장소 정보 저장 함수
        function savePlaceWithMemo(placeId, addressName, lat, lng) {
            var placeName = document.getElementById('memo_' + placeId).value || "저장된 장소";
            
            // AJAX로 서버에 저장
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "${pageContext.request.contextPath}/kakaomap/savePlace", true);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        alert("장소가 저장되었습니다.");
                        // 저장된 장소 목록 갱신
                        loadSavedPlaces();
                    } else {
                        alert("장소 저장에 실패했습니다.");
                        console.error(xhr.responseText);
                    }
                }
            };
            
            // 서버로 전송할 데이터
            var data = JSON.stringify({
            	member_id: memberInfo.id,
            	address_name: addressName,
                id: placeId,
                place_name: placeName,
                x: lng,
                y: lat
            });
            
            xhr.send(data);
        }
        
        // 저장된 장소 목록 로드 함수
        function loadSavedPlaces() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "${pageContext.request.contextPath}/kakaomap/getSavedPlaces?memberId=" + memberInfo.id, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        var places = JSON.parse(xhr.responseText);
                        displaySavedPlaces(places);
                    } else {
                        console.error("저장된 장소 로드 실패:", xhr.responseText);
                    }
                }
            };
            xhr.send();
        }
        
        // 저장된 장소 목록 표시 함수
        function displaySavedPlaces(places) {
            var listEl = document.getElementById('placesList');
            listEl.innerHTML = '';
            
            if (places.length === 0) {
                listEl.innerHTML = '<div style="padding: 10px; text-align: center; color: #888;">저장된 장소가 없습니다.</div>';
                return;
            }
            
            for (var i = 0; i < places.length; i++) {
                var place = places[i];
                var itemEl = document.createElement('div');
                itemEl.className = 'place-item';
                itemEl.onclick = (function(p) {
                    return function() {
                        moveToPlace(p);
                    };
                })(place);
                
                var nameEl = document.createElement('div');
                nameEl.className = 'place-name';
                nameEl.textContent = place.place_name;
                
                var addrEl = document.createElement('div');
                addrEl.className = 'place-address';
                addrEl.textContent = place.address_name;
                
                itemEl.appendChild(nameEl);
                itemEl.appendChild(addrEl);
                listEl.appendChild(itemEl);
            }
        }
        
        // 저장된 장소로 이동 함수
        function moveToPlace(place) {
            var position = new kakao.maps.LatLng(place.y, place.x);
            map.setCenter(position);
            
            // 마커 생성
            var marker = new kakao.maps.Marker({
                position: position,
                map: map
            });
            
            markers.push(marker);
            
            // 인포윈도우 내용
            var iwContent = '<div class="info-window">' +
                            '<div class="info-title">' + place.place_name + '</div>' +
                            '<div class="info-address">주소: ' + place.address_name + '</div>' +
                            '<div class="info-contact">위도: ' + place.y + '</div>' +
                            '<div class="info-contact">경도: ' + place.x + '</div>' +
                            '</div>';
            
            // 인포윈도우 생성
            var infowindow = new kakao.maps.InfoWindow({
                content: iwContent,
                removable: true
            });
            
            infowindows.push(infowindow);
            
            // 마커 클릭 이벤트
            kakao.maps.event.addListener(marker, 'click', function() {
                closeAllInfowindows();
                infowindow.open(map, marker);
            });
            
            // 인포윈도우 표시
            closeAllInfowindows();
            infowindow.open(map, marker);
        }
    </script>
</body>
</html>