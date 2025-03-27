<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>원데이 클래스 수정</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <style>
        .edit-form {
            width: 800px;
            margin: 0 auto;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .required:after {
            content: " *";
            color: red;
        }
        .time-group {
            display: flex;
            gap: 10px;
        }
        .time-group input {
            width: 100px;
        }
        .textarea-container {
            position: relative;
        }
        .textarea-counter {
            position: absolute;
            bottom: 5px;
            right: 5px;
            font-size: 12px;
            color: #666;
        }
        .preview-container {
            margin-top: 10px;
            width: 200px;
            height: 200px;
            border: 1px dashed #ccc;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .preview-container img {
            max-width: 100%;
            max-height: 100%;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="edit-form">
            <h2>원데이 클래스 수정</h2>
            
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>
            
            <form action="<c:url value='/oneday/edit'/>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="oneday_index" value="${oneday.oneday_index}">
                <input type="hidden" name="seller_index" value="${oneday.seller_index}">
                
                <div class="form-group">
                    <label for="themeIndex" class="required">테마</label>
                    <select name="theme_index" id="themeIndex" class="form-control" required>
                        <option value="">테마를 선택하세요</option>
                        <c:forEach var="theme" items="${themeList}">
                            <option value="${theme.theme_index}" <c:if test="${theme.theme_index eq oneday.theme_index}">selected</c:if>>${theme.theme_name}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="onedayName" class="required">클래스명</label>
                    <input type="text" name="oneday_name" id="onedayName" class="form-control" 
                           value="${oneday.oneday_name}" required maxlength="100">
                </div>
                
                <div class="form-group">
                    <label for="onedayInfo" class="required">클래스 설명</label>
                    <div class="textarea-container">
                        <textarea name="oneday_info" id="onedayInfo" class="form-control" 
                                  required rows="10" maxlength="2000">${oneday.oneday_info}</textarea>
                        <span class="textarea-counter">0/2000</span>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="onedayDate" class="required">수업일</label>
                    <fmt:formatDate value="${oneday.oneday_date}" pattern="yyyy-MM-dd" var="formattedDate" />
                    <input type="date" name="oneday_date" id="onedayDate" class="form-control" 
                           value="${formattedDate}" required min="${today}">
                </div>
                
                <div class="form-group">
                    <label class="required">수업 시간</label>
                    <div class="time-group">
                        <input type="time" name="oneday_start" id="onedayStart" value="${oneday.oneday_start}" required>
                        <span>부터</span>
                        <input type="time" name="oneday_end" id="onedayEnd" value="${oneday.oneday_end}" required>
                        <span>까지</span>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="onedayLocation" class="required">수업 장소</label>
                    <input type="text" name="oneday_location" id="onedayLocation" class="form-control" 
                           value="${oneday.oneday_location}" required maxlength="200">
                </div>
                
                <div class="form-group">
                    <label for="onedayPrice" class="required">수강료</label>
                    <input type="number" name="oneday_price" id="onedayPrice" class="form-control" 
                           value="${oneday.oneday_price}" required min="0" max="1000000">
                </div>
                
                <div class="form-group">
                    <label for="onedayPersonnel" class="required">정원</label>
                    <input type="number" name="oneday_personnel" id="onedayPersonnel" class="form-control" 
                           value="${oneday.oneday_personnel}" required min="${oneday.current_participants}" max="100">
                    <p class="help-text">* 현재 예약 인원: ${oneday.current_participants}명 (정원은 현재 예약 인원보다 적게 설정할 수 없습니다)</p>
                </div>
                
                <div class="form-group">
                    <label for="imageFile">클래스 이미지</label>
                    <input type="file" name="imageFile" id="imageFile" accept="image/*" 
                           onchange="previewImage(this)">
                    <div class="preview-container">
                        <img id="preview" src="<c:url value='/resources/images/oneday/${oneday.oneday_imageUrl}'/>" 
                             alt="미리보기" onerror="this.src='<c:url value='/resources/images/default.jpg'/>'">
                    </div>
                    <p class="help-text">* 이미지를 변경하지 않으면 기존 이미지가 유지됩니다</p>
                    <p class="help-text">* 권장 크기: 800 x 600 픽셀, 최대 5MB</p>
                </div>
                
                <div class="form-group text-center">
                    <button type="submit" class="btn btn-primary">클래스 수정</button>
                    <a href="<c:url value='/oneday/my-classes'/>" class="btn">취소</a>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // 이미지 미리보기
        function previewImage(input) {
            var preview = document.getElementById('preview');
            
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                
                reader.onload = function(e) {
                    preview.src = e.target.result;
                };
                
                reader.readAsDataURL(input.files[0]);
            }
        }
        
        // 텍스트 영역 글자 수 카운터 초기화 및 이벤트
        document.addEventListener('DOMContentLoaded', function() {
            var textarea = document.getElementById('onedayInfo');
            var counter = document.querySelector('.textarea-counter');
            counter.textContent = textarea.value.length + '/2000';
            
            textarea.addEventListener('input', function() {
                counter.textContent = this.value.length + '/2000';
            });
        });
        
        // 폼 유효성 검사
        document.querySelector('form').addEventListener('submit', function(e) {
            var startTime = document.getElementById('onedayStart').value;
            var endTime = document.getElementById('onedayEnd').value;
            
            if (startTime >= endTime) {
                alert('종료 시간은 시작 시간보다 뒤여야 합니다.');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>