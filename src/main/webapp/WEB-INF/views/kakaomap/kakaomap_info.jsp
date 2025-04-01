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
        
        /* 마커 카테고리 스타일 */
        #mapwrap {
            position: relative;
            overflow: hidden;
        }
        
        .category, .category * {
            margin: 0;
            padding: 0;
            color: #000;
        }
        
        .category {
		    position: absolute;
		    overflow: hidden;
		    top: 10px;
		    left: 10px;
		    width: 255px; /* 약간 여유 공간 추가 */
		    height: 50px;
		    z-index: 10;
		    border: 1px solid black;
		    font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
		    font-size: 12px;
		    text-align: center;
		    background-color: #fff;
		    border-radius: 5px; /* 모서리 둥글게 처리 (선택사항) */
		}
        
        .category .menu_selected {
            background: #FF5F4A;
            color: #fff;
            border-left: 1px solid #915B2F;
            border-right: 1px solid #915B2F;
            margin: 0 -1px;
        }
        
        .category li {
		    list-style: none;
		    float: left;
		    width: 50px;
		    height: 45px;
		    padding-top: 5px;
		    cursor: pointer;
		    position: relative; /* 아이콘 위치 조정을 위해 */
		    vertical-align: middle; /* 텍스트 수직 정렬 */
		}
		
		
		.category .ico_comm {
		    display: block;
		    margin: 0 auto 3px; /* 아이콘과 텍스트 사이 간격 약간 조정 */
		    width: 22px;
		    height: 22px;
		    background: url('${pageContext.request.contextPath}/resources/pic/category.png') no-repeat;
		    background-size: 32px 160px;
		} 
        
        .category .ico_lifestyle {
   		 	background-position: 5px 0; /* 조금 더 오른쪽으로 조정 */
		}
		
		.category .ico_craft {
		    background-position: 5px -32px;
		}
		
		.category .ico_food {
		    background-position: 5px -64px;
		}
		        
		.category .ico_fashion {
		    background-position: 5px -96px;
		}
		        
		.category .ico_beauty {
		    background-position: 5px -128px;
		}
        
        
        /* API 오류 알림창 스타일 */
        .api-error {
            color: #721c24;
            background-color: #f8d7da;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #f5c6cb;
            border-radius: 4px;
            display: none;
        }
    </style>
</head>
<body>
    <h2>멤버 위치 정보</h2>
    
    <div id="mapwrap">
        <!-- 지도를 표시할 div -->
        <div id="map"></div>
        
        <!-- 지도 위에 표시될 마커 카테고리 -->
        <div class="category">
            <ul>
                <li id="lifestyleMenu" onclick="changeMarker('lifestyle')">
                    <span class="ico_comm ico_lifestyle"></span>
                    라이프
                </li>
                <li id="craftMenu" onclick="changeMarker('craft')">
                    <span class="ico_comm ico_craft"></span>
                    수공예
                </li>
                <li id="foodMenu" onclick="changeMarker('food')">
                    <span class="ico_comm ico_food"></span>
                    푸드
                </li>
                <li id="fashionMenu" onclick="changeMarker('fashion')">
                    <span class="ico_comm ico_fashion"></span>
                    패션
                </li>
                <li id="beautyMenu" onclick="changeMarker('beauty')">
                    <span class="ico_comm ico_beauty"></span>
                    뷰티
                </li>
            </ul>
        </div>
    </div>
    
    <!-- API 오류 알림창 -->
    <div id="apiError" class="api-error">
        API 요청 제한에 도달했습니다. 잠시 후 다시 시도해 주세요.
    </div>
    
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
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fb9c39f52da6918d5d47283a1cf98395&libraries=services"></script>
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
        
        // API 호출을 위한 디바운스 타이머
        var geocodeTimer = null;
        
        // API 오류 카운트 및 재시도 관리
        var apiErrorCount = 0;
        var maxRetryAttempts = 3;
        var retryDelay = 2000; // 2초 후 재시도
        
        // API 오류 표시 함수
        function showApiError(show) {
            var errorDiv = document.getElementById('apiError');
            if (show) {
                errorDiv.style.display = 'block';
            } else {
                errorDiv.style.display = 'none';
            }
        }
        
        // 모든 인포윈도우 닫기 함수
        function closeAllInfowindows() {
            for(var i=0; i<infowindows.length; i++) {
                infowindows[i].close();
            }
        }
        
        // 멤버 주소로 좌표를 검색하여 지도 중심 설정 - 오류 처리 추가
        function setInitialMapCenter() {
            if (memberInfo.address && memberInfo.address.trim() !== "") {
                geocoder.addressSearch(memberInfo.address, function(result, status) {
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
                        showApiError(false);
                    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                        alert("주소를 찾을 수 없습니다. 기본 위치를 표시합니다.");
                    } else if (status === kakao.maps.services.Status.ERROR) {
                        handleApiError("초기 지도 설정", function() {
                            setInitialMapCenter();
                        });
                    }
                });
            } else {
                alert("주소 정보가 없습니다. 기본 위치를 표시합니다.");
            }
        }
        
        // API 오류 처리 및 재시도 함수
        function handleApiError(operationName, retryFunction) {
            apiErrorCount++;
            console.error(operationName + " 중 API 오류 발생. 재시도 " + apiErrorCount + "/" + maxRetryAttempts);
            showApiError(true);
            
            if (apiErrorCount <= maxRetryAttempts) {
                setTimeout(function() {
                    showApiError(false);
                    retryFunction();
                }, retryDelay * apiErrorCount); // 재시도 간격을 점점 늘림
            } else {
                alert("API 요청이 너무 많습니다. 잠시 후 다시 시도해주세요.");
            }
        }
        
        // 페이지 로드 시 초기 설정
        setInitialMapCenter();
        
        // 저장된 장소 로드
        loadSavedPlaces();
        
        // 페이지 로드 시 기본으로 라이프스타일 카테고리 선택
        window.onload = function() {
            changeMarker('lifestyle');
        };
        
        // 지도 클릭 이벤트 처리 - 디바운싱 적용
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
            // 이전 타이머 취소하여 API 호출 줄이기
            if (geocodeTimer) {
                clearTimeout(geocodeTimer);
            }
            
            // 0.5초 후에 실행하도록 설정
            geocodeTimer = setTimeout(function() {
                processMapClick(mouseEvent);
            }, 500);
        });
        
        // 지도 클릭 처리 함수
        function processMapClick(mouseEvent) {
            // 클릭한 위도, 경도 정보를 가져옵니다
            var latlng = mouseEvent.latLng;
            
            // 역지오코딩 - 좌표를 주소로 변환
            geocoder.coord2Address(latlng.getLng(), latlng.getLat(), function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var detailAddr = !!result[0].road_address ? 
                        result[0].road_address.address_name : 
                        result[0].address.address_name;
                    
                    // 현재 선택된 카테고리에 따른 마커 이미지 가져오기
                    var markerImage = getMarkerImageByType(currentMarkerType);
                    
                    // 새 마커 생성 (선택된 카테고리의 이미지 적용)
                    var marker;
                    if (markerImage) {
                        marker = new kakao.maps.Marker({
                            position: latlng,
                            map: map,
                            image: markerImage,
                            zIndex: 10 // 마커가 지도 위에 표시되도록 z-index 설정
                        });
                    } else {
                        // 기본 마커 생성
                        marker = new kakao.maps.Marker({
                            position: latlng,
                            map: map,
                            zIndex: 10
                        });
                    }
                    
                    markers.push(marker);
                    
                    // 랜덤 ID 생성 (실제로는 백엔드에서 생성될 ID)
                    var randomId = 'place_' + Math.floor(Math.random() * 100000);
                    
                    // 클릭한 위치 정보를 포함한 인포윈도우 내용 생성
                    var iwContent = '<div class="info-window">' +
                                    '<div class="info-title">선택한 위치</div>' +
                                    '<div class="info-address">주소: ' + detailAddr + '</div>' +
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
                    resultDiv.innerHTML = '클릭한 위치: ' + detailAddr;
                    
                    // API 오류 표시 숨기기
                    showApiError(false);
                    // API 오류 카운트 초기화 (성공했으므로)
                    apiErrorCount = 0;
                } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                    alert("주소 정보가 없습니다.");
                } else if (status === kakao.maps.services.Status.ERROR) {
                    // API 오류 처리 및 재시도
                    handleApiError("지도 클릭 처리", function() {
                        processMapClick(mouseEvent);
                    });
                }
            });
        }
        
        // 장소 정보 저장 함수 - 마커 타입 정보를 추가하여 수정
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
            
            // 서버로 전송할 데이터 - 마커 타입 정보 추가
            var data = JSON.stringify({
                member_id: memberInfo.id,
                address_name: addressName,
                id: placeId,
                place_name: placeName,
                x: lng,
                y: lat,
                marker_type: currentMarkerType // 현재 선택된 마커 타입 저장
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
        
        // 저장된 장소로 이동 함수 - 마커 타입에 따라 다른 마커 이미지 사용하도록 수정
        function moveToPlace(place) {
            var position = new kakao.maps.LatLng(place.y, place.x);
            map.setCenter(position);
            
            // 저장된 마커 타입에 따른 마커 이미지 가져오기
            var markerType = place.marker_type || 'default';
            var markerImage = getMarkerImageByType(markerType);
            
            // 마커 생성 (저장된 마커 타입 이미지 적용)
            var marker;
            if (markerImage) {
                marker = new kakao.maps.Marker({
                    position: position,
                    map: map,
                    image: markerImage,
                    zIndex: 10
                });
            } else {
                // 기본 마커 생성
                marker = new kakao.maps.Marker({
                    position: position,
                    map: map,
                    zIndex: 10
                });
            }
            
            markers.push(marker);
            
            // 인포윈도우 내용
            var iwContent = '<div class="info-window">' +
                            '<div class="info-title">' + place.place_name + '</div>' +
                            '<div class="info-address">주소: ' + place.address_name + '</div>' +
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
        
        // ===== 마커 카테고리 관련 기능 =====
        
        // 마커 이미지 관련 변수
        var markerImageSrc = '${pageContext.request.contextPath}/resources/pic/category.png';  // 마커이미지의 주소
        var currentMarkerType = 'default'; // 현재 선택된 마커 타입 (기본값)
        
        // 마커이미지의 주소와, 크기, 옵션으로 마커 이미지를 생성하여 리턴하는 함수
        function createMarkerImage(src, size, options) {
            var markerImage = new kakao.maps.MarkerImage(src, size, options);
            return markerImage;            
        }

        // 좌표와 마커이미지를 받아 마커를 생성하여 리턴하는 함수
        function createMarker(position, image) {
            var marker = new kakao.maps.Marker({
                position: position,
                image: image,
                zIndex: 10
            });
            
            return marker;  
        }   
        
        // 카테고리에 따른 마커 이미지 생성 함수
        function getMarkerImageByType(type) {
    // 실제 이미지 크기를 더 작게 조정 (예: 32x32, 필요에 따라 조정)
		    var imageSize = new kakao.maps.Size(32, 32);
		    var imageOptions;
		    
		    if (type === 'lifestyle') {
		        imageOptions = {  
		            spriteOrigin: new kakao.maps.Point(0, 0),    
		            spriteSize: new kakao.maps.Size(32, 160)  
		        };
		    } else if (type === 'craft') {
		        imageOptions = {  
		            spriteOrigin: new kakao.maps.Point(0, 32),    
		            spriteSize: new kakao.maps.Size(32, 160)  
		        };
		    } else if (type === 'food') {
		        imageOptions = {  
		            spriteOrigin: new kakao.maps.Point(0, 64),    
		            spriteSize: new kakao.maps.Size(32, 160)  
		        };
		    } else if (type === 'fashion') {
		        imageOptions = {  
		            spriteOrigin: new kakao.maps.Point(0, 96),    
		            spriteSize: new kakao.maps.Size(32, 160)  
		        };
		    } else if (type === 'beauty') {
		        imageOptions = {  
		            spriteOrigin: new kakao.maps.Point(0, 128),    
		            spriteSize: new kakao.maps.Size(32, 160)  
		        };
		    } else {
		        return null;
		    }
		    
		    return createMarkerImage(markerImageSrc, imageSize, imageOptions);
		}

        // 카테고리를 클릭했을 때 type에 따라 카테고리의 스타일 변경 및 현재 마커 타입 설정
        function changeMarker(type) {
            var lifestyleMenu = document.getElementById('lifestyleMenu');
            var craftMenu = document.getElementById('craftMenu');
            var foodMenu = document.getElementById('foodMenu');
            var fashionMenu = document.getElementById('fashionMenu');
            var beautyMenu = document.getElementById('beautyMenu');
            
            // 현재 선택된 마커 타입 저장
            currentMarkerType = type;
            
            // 카테고리 메뉴 스타일 변경
            if (type === 'lifestyle') {
                lifestyleMenu.className = 'menu_selected';
                craftMenu.className = '';
                foodMenu.className = '';
                fashionMenu.className = '';
                beautyMenu.className = '';
            } else if (type === 'craft') {
                lifestyleMenu.className = '';
                craftMenu.className = 'menu_selected';
                foodMenu.className = '';
                fashionMenu.className = '';
                beautyMenu.className = '';
            } else if (type === 'food') {
                lifestyleMenu.className = '';
                craftMenu.className = '';
                foodMenu.className = 'menu_selected';
                fashionMenu.className = '';
                beautyMenu.className = '';
            } else if (type === 'fashion') {
                lifestyleMenu.className = '';
                craftMenu.className = '';
                foodMenu.className = '';
                fashionMenu.className = 'menu_selected';
                beautyMenu.className = '';
            } else if (type === 'beauty') {
                lifestyleMenu.className = '';
                craftMenu.className = '';
                foodMenu.className = '';
                fashionMenu.className = '';
                beautyMenu.className = 'menu_selected';
            }
        }
            </script>
      </body>
</html>