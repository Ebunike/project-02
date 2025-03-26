<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>원데이 클래스 등록</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <style>
        .register-form {
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
        <div class="register-form">
            <h2>원데이 클래스 등록</h2>
            
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>
            
            <form action="<c:url value='/oneday/register'/>" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="theme_index" class="required">테마</label>
                    <select name="theme_index" id="theme_index" class="form-control" required>
                        <option value="">테마를 선택하세요</option>
                        <c:forEach var="theme" items="${themeList}">
                            <option value="${theme.theme_index}">${theme.theme_name}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="oneday_name" class="required">클래스명</label>
                    <input type="text" name="oneday_name" id="oneday_name" class="form-control" 
                           placeholder="클래스명을 입력하세요" required maxlength="100">
                </div>
                
                <div class="form-group">
                    <label for="oneday_info" class="required">클래스 설명</label>
                    <div class="textarea-container">
                        <textarea name="oneday_info" id="oneday_info" class="form-control" 
                                  placeholder="클래스 설명을 입력하세요" required rows="10" maxlength="2000"></textarea>
                        <span class="textarea-counter">0/2000</span>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="oneday_date" class="required">수업일</label>
                    <input type="date" name="oneday_date" id="oneday_date" class="form-control" required min="${today}">
                </div>
                
                <div class="form-group">
                    <label class="required">수업 시간</label>
                    <div class="time-group">
                        <input type="time" name="oneday_start" id="oneday_start" required>
                        <span>부터</span>
                        <input type="time" name="oneday_end" id="oneday_end" required>
                        <span>까지</span>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="oneday_location" class="required">수업 장소</label>
                    <input type="text" name="oneday_location" id="oneday_location" class="form-control" 
                           placeholder="수업 장소를 입력하세요" required maxlength="200">
                </div>
                
                <div class="form-group">
                    <label for="oneday_price" class="required">수강료</label>
                    <input type="number" name="oneday_price" id="oneday_price" class="form-control" 
                           placeholder="수강료를 입력하세요" required min="0" max="1000000">
                </div>
                
                <div class="form-group">
                    <label for="oneday_personnel" class="required">정원</label>
                    <input type="number" name="oneday_personnel" id="oneday_personnel" class="form-control" 
                           placeholder="최대 수강 인원을 입력하세요" required min="1" max="100">
                </div>
                
                <div class="form-group">
                    <label for="imageFile" class="required">클래스 이미지</label>
                    <input type="file" name="imageFile" id="imageFile" accept="image/*" required 
                           onchange="previewImage(this)">
                    <div class="preview-container">
                        <img id="preview" src="#" alt="미리보기" style="display: none;">
                        <span id="preview-text">이미지를 선택하세요</span>
                    </div>
                    <p class="help-text">* 권장 크기: 800 x 600 픽셀, 최대 5MB</p>
                </div>
                
                <div class="form-group text-center">
                    <button type="submit" class="btn btn-primary">클래스 등록</button>
                    <a href="<c:url value='/oneday/list'/>" class="btn">취소</a>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // 이미지 미리보기
        function previewImage(input) {
            var preview = document.getElementById('preview');
            var previewText = document.getElementById('preview-text');
            
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    previewText.style.display = 'none';
                };
                
                reader.readAsDataURL(input.files[0]);
            } else {
                preview.src = '#';
                preview.style.display = 'none';
                previewText.style.display = 'block';
            }
        }
        
        // 텍스트 영역 글자 수 카운터
        document.getElementById('oneday_info').addEventListener('input', function() {
            var counter = document.querySelector('.textarea-counter');
            counter.textContent = this.value.length + '/2000';
        });
        
        // 폼 유효성 검사
        document.querySelector('form').addEventListener('submit', function(e) {
            var startTime = document.getElementById('oneday_start').value;
            var endTime = document.getElementById('oneday_end').value;
            
            if (startTime >= endTime) {
                alert('종료 시간은 시작 시간보다 뒤여야 합니다.');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>
