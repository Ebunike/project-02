<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 작성</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- 썸머노트 에디터 -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
    <style>
        /* 전체 페이지 스타일 */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 1000px;
            margin: 20px auto;
            padding: 0 20px;
        }
        
        .board-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            background-color: #fff;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .board-header h2 {
            margin: 0;
            font-size: 1.8rem;
            color: #333;
        }
        
        /* 폼 스타일 */
        .write-form {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }
        
        .form-control {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        
        .form-control:focus {
            border-color: #4CAF50;
            outline: none;
        }
        
        .error-message {
            color: #F44336;
            font-size: 14px;
            margin-top: 5px;
        }
        
        /* 버튼 스타일 */
        .btn {
            padding: 10px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            font-size: 16px;
        }
        
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        
        .btn-secondary {
            background-color: #f0f0f0;
            color: #333;
        }
        
        .btn:hover {
            opacity: 0.9;
        }
        
        .form-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 20px;
        }
        
        /* 카테고리 선택 */
        .category-select {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .category-option {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .category-option input[type="radio"] {
            display: none;
        }
        
        .category-option label {
            display: flex;
            align-items: center;
            gap: 5px;
            padding: 8px 15px;
            border: 1px solid #ddd;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .category-option input[type="radio"]:checked + label {
            background-color: #4CAF50;
            color: white;
            border-color: #4CAF50;
        }
        
        /* 썸머노트 스타일 수정 */
        .note-editor.note-frame {
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .note-toolbar {
            background-color: #f9f9f9;
            border-bottom: 1px solid #ddd;
        }
        
        /* 지도 연결 섹션 */
        .map-section {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        
        .map-preview {
            width: 100%;
            height: 250px;
            background-color: #f0f0f0;
            border-radius: 4px;
            margin-top: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #666;
        }
        
        .map-info {
            margin-top: 15px;
            padding: 15px;
            background-color: #f5f5f5;
            border-radius: 4px;
            display: none;
        }
        
        .map-info p {
            margin: 5px 0;
        }
        
        .map-info-item {
            margin-bottom: 5px;
        }
        
        .map-info-label {
            font-weight: 600;
            display: inline-block;
            width: 100px;
        }
        
        /* 반응형 */
        @media (max-width: 768px) {
            .category-select {
                flex-direction: column;
                gap: 10px;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .form-actions .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/header.jsp"/>
    
    <div class="container">
        <div class="board-header">
            <h2>게시글 작성</h2>
        </div>
        
        <form:form modelAttribute="postBean" class="write-form" action="${pageContext.request.contextPath}/board/writeProc" method="post">
            <div class="form-group">
                <label for="title">제목</label>
                <form:input path="title" class="form-control" placeholder="제목을 입력해주세요" />
                <form:errors path="title" class="error-message" />
            </div>
            
            <div class="form-group">
                <label>카테고리</label>
                <div class="category-select">
                    <div class="category-option">
                        <input type="radio" id="lifestyle" name="markerType" value="lifestyle" checked />
                        <label for="lifestyle">
                            <i class="fas fa-heart"></i> 라이프스타일
                        </label>
                    </div>
                    
                    <div class="category-option">
                        <input type="radio" id="craft" name="markerType" value="craft" />
                        <label for="craft">
                            <i class="fas fa-cut"></i> 수공예
                        </label>
                    </div>
                    
                    <div class="category-option">
                        <input type="radio" id="food" name="markerType" value="food" />
                        <label for="food">
                            <i class="fas fa-utensils"></i> 푸드
                        </label>
                    </div>
                    
                    <div class="category-option">
                        <input type="radio" id="fashion" name="markerType" value="fashion" />
                        <label for="fashion">
                            <i class="fas fa-tshirt"></i> 패션
                        </label>
                    </div>
                    
                    <div class="category-option">
                        <input type="radio" id="beauty" name="markerType" value="beauty" />
                        <label for="beauty">
                            <i class="fas fa-spa"></i> 뷰티
                        </label>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="maxParticipants">최대 참여 인원</label>
                <form:input path="maxParticipants" type="number" min="1" max="100" class="form-control" style="width: 150px;" />
                <form:errors path="maxParticipants" class="error-message" />
            </div>
            
            <div class="form-group">
                <label for="content">내용</label>
                <form:textarea path="content" id="summernote" />
                <form:errors path="content" class="error-message" />
            </div>
            
            <!-- 지도 위치 연결 섹션 -->
            <div class="map-section">
                <div class="form-group">
                    <label>지도 위치 연결</label>
                    <p style="margin-top: 5px; color: #666;">
                        이 게시글에 표시할 지도 위치를 선택하세요. 위치를 지정하면 지도에 마커가 표시됩니다.
                    </p>
                    
                    <button type="button" id="selectLocation" class="btn btn-secondary" style="margin-top: 10px;">
                        <i class="fas fa-map-marker-alt"></i> 지도에서 위치 선택
                    </button>
                    
                    <div class="map-info" id="locationInfo">
                        <div class="map-info-item">
                            <span class="map-info-label">주소:</span>
                            <span id="placeAddress"></span>
                        </div>
                        <div class="map-info-item">
                            <span class="map-info-label">위도:</span>
                            <span id="placeLatitude"></span>
                        </div>
                        <div class="map-info-item">
                            <span class="map-info-label">경도:</span>
                            <span id="placeLongitude"></span>
                        </div>
                        <button type="button" id="removeLocation" class="btn btn-secondary" style="margin-top: 10px;">
                            <i class="fas fa-times"></i> 위치 삭제
                        </button>
                    </div>
                    
                    <!-- 위치 정보를 저장할 hidden 필드 -->
                    <input type="hidden" id="latitude" name="latitude">
                    <input type="hidden" id="longitude" name="longitude">
                    <input type="hidden" id="address" name="address">
                </div>
            </div>
            
            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/board/main" class="btn btn-secondary">
                    <i class="fas fa-times"></i> 취소
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-check"></i> 등록
                </button>
            </div>
        </form:form>
    </div>
    
    <jsp:include page="/WEB-INF/views/include/footer.jsp"/>
    
    <script>
        $(document).ready(function() {
            // 썸머노트 에디터 초기화
            $('#summernote').summernote({
                placeholder: '내용을 입력해주세요',
                tabsize: 2,
                height: 300,
                toolbar: [
                    ['style', ['style']],
                    ['font', ['bold', 'underline', 'clear']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['table', ['table']],
                    ['insert', ['link', 'picture']],
                    ['view', ['fullscreen', 'codeview', 'help']]
                ],
                callbacks: {
                    onImageUpload: function(files) {
                        // 이미지 업로드 처리 로직 구현
                        for (let i = 0; i < files.length; i++) {
                            uploadSummernoteImage(files[i]);
                        }
                    }
                }
            });
            
            // 썸머노트 이미지 업로드
            function uploadSummernoteImage(file) {
                const formData = new FormData();
                formData.append('file', file);
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/board/uploadImage',
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function(data) {
                        $('#summernote').summernote('insertImage', data.url);
                    },
                    error: function(error) {
                        console.error('이미지 업로드 실패:', error);
                        alert('이미지 업로드에 실패했습니다.');
                    }
                });
            }
            
            // 지도에서 위치 선택 버튼 클릭
            $('#selectLocation').click(function() {
                // 지도 선택 페이지로 이동하는 팝업 띄우기
                const popup = window.open('${pageContext.request.contextPath}/kakaomap/locationPicker', 'locationPicker', 'width=800,height=600');
            });
            
            // 위치 선택기에서 전송한 메시지 수신 처리
            window.addEventListener('message', function(event) {
                if (event.data.type === 'LOCATION_SELECTED') {
                    // 로컬 스토리지에서 위치 정보 가져오기
                    var locationData = JSON.parse(localStorage.getItem('selectedLocation'));
                    
                    // 선택한 위치 정보 표시
                    $('#placeAddress').text(locationData.address);
                    $('#placeLatitude').text(locationData.latitude);
                    $('#placeLongitude').text(locationData.longitude);
                    
                    // 히든 필드에 값 설정
                    $('#latitude').val(locationData.latitude);
                    $('#longitude').val(locationData.longitude);
                    $('#address').val(locationData.address);
                    
                    // 위치 정보 표시 영역 보이기
                    $('#locationInfo').show();
                }
            });
            
            // 위치 삭제 버튼 클릭
            $('#removeLocation').click(function() {
                // 위치 정보 초기화
                $('#placeAddress').text('');
                $('#placeLatitude').text('');
                $('#placeLongitude').text('');
                
                // 히든 필드 값 초기화
                $('#latitude').val('');
                $('#longitude').val('');
                $('#address').val('');
                
                // 위치 정보 표시 영역 숨기기
                $('#locationInfo').hide();
            });
        });
    </script>
</body>
</html>