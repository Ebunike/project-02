<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>원데이 클래스 수정</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGaRamYeonGgoc.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --primary-color: #FF9F29;
            --secondary-color: #1A5D1A;
            --accent-color: #FFC83D;
            --bg-color: #FFFAF2;
            --card-bg: #FFFFFF;
            --text-color: #333333;
            --text-light: #666666;
            --border-radius: 12px;
            --input-radius: 8px;
            --shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'NanumGaRamYeonGgoc', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            line-height: 1.6;
        }
        
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .edit-form {
            background-color: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 40px;
            box-shadow: var(--shadow);
            margin: 0 auto;
            position: relative;
            overflow: hidden;
            max-width: 900px;
        }
        
        .edit-form::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: linear-gradient(to bottom, var(--primary-color), var(--accent-color));
        }
        
        h2 {
            text-align: center;
            font-size: 2.2rem;
            color: var(--primary-color);
            margin-bottom: 30px;
            position: relative;
            padding-bottom: 15px;
        }
        
        h2:after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            border-radius: 1.5px;
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: var(--border-radius);
            margin-bottom: 25px;
            font-weight: 500;
            font-size: 15px;
        }
        
        .alert-danger {
            background-color: rgba(220, 53, 69, 0.15);
            color: #dc3545;
            border-left: 4px solid #dc3545;
        }
        
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            font-size: 16px;
            color: var(--text-color);
        }
        
        .required:after {
            content: " *";
            color: #dc3545;
            font-weight: bold;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: var(--input-radius);
            font-family: 'NanumGaRamYeonGgoc', sans-serif;
            font-size: 16px;
            color: var(--text-color);
            background-color: #fff;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(255, 159, 41, 0.2);
        }
        
        select.form-control {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%23333' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 16px;
            padding-right: 40px;
        }
        
        .time-group {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .time-group input {
            flex: 0 0 120px;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: var(--input-radius);
            font-family: 'NanumGaRamYeonGgoc', sans-serif;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .time-group input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(255, 159, 41, 0.2);
        }
        
        .time-group span {
            color: var(--text-light);
            font-weight: 500;
        }
        
        .textarea-container {
            position: relative;
        }
        
        .textarea-counter {
            position: absolute;
            bottom: 12px;
            right: 12px;
            font-size: 13px;
            color: var(--text-light);
            background-color: rgba(255, 255, 255, 0.8);
            padding: 3px 8px;
            border-radius: 15px;
            pointer-events: none;
        }
        
        .preview-container {
            margin-top: 15px;
            width: 250px;
            height: 250px;
            border: 2px dashed #e0e0e0;
            border-radius: var(--input-radius);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .preview-container:hover {
            border-color: var(--primary-color);
        }
        
        .preview-container img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
            transition: all 0.3s ease;
        }
        
        .help-text {
            margin-top: 8px;
            font-size: 14px;
            color: var(--text-light);
            line-height: 1.4;
        }
        
        .text-center {
            text-align: center;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 30px;
            border-radius: 50px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 600;
            transition: var(--transition);
            cursor: pointer;
            border: none;
            font-family: 'NanumGaRamYeonGgoc', sans-serif;
        }
        
        .btn-primary {
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            color: white;
            box-shadow: 0 4px 15px rgba(255, 159, 41, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 20px rgba(255, 159, 41, 0.4);
        }
        
        .btn:not(.btn-primary) {
            background: white;
            color: var(--text-color);
            border: 2px solid #e9e9e9;
            margin-left: 10px;
        }
        
        .btn:not(.btn-primary):hover {
            background: #f9f9f9;
            border-color: #ddd;
            transform: translateY(-3px);
        }
        
        /* 파일 입력 사용자 정의 스타일 */
        input[type="file"] {
            width: 0.1px;
            height: 0.1px;
            opacity: 0;
            overflow: hidden;
            position: absolute;
            z-index: -1;
        }
        
        .file-input-label {
            display: inline-block;
            padding: 12px 20px;
            background-color: #f8f9fa;
            color: var(--text-color);
            border: 2px solid #e0e0e0;
            border-radius: var(--input-radius);
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 15px;
            text-align: center;
            margin-bottom: 15px;
        }
        
        .file-input-label:hover {
            background-color: #e9ecef;
            border-color: #ced4da;
        }
        
        .file-input-label i {
            margin-right: 8px;
            color: var(--primary-color);
        }
        
        /* 필드 그룹 스타일 */
        .form-row {
            display: flex;
            flex-wrap: wrap;
            margin: 0 -10px;
        }
        
        .form-col {
            flex: 1 0 300px;
            padding: 0 10px;
            margin-bottom: 20px;
        }
        
        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .edit-form {
                padding: 25px;
            }
            
            h2 {
                font-size: 1.8rem;
            }
            
            .form-row {
                flex-direction: column;
            }
            
            .time-group {
                flex-wrap: wrap;
            }
            
            .btn {
                width: 100%;
                margin: 5px 0;
            }
            
            .form-group .btn:not(.btn-primary) {
                margin-left: 0;
                margin-top: 10px;
            }
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
                
                <div class="form-row">
                    <div class="form-col">
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
                    </div>
                    
                    <div class="form-col">
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
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="onedayInfo" class="required">클래스 설명</label>
                    <div class="textarea-container">
                        <textarea name="oneday_info" id="onedayInfo" class="form-control" 
                                  required rows="10" maxlength="2000">${oneday.oneday_info}</textarea>
                        <span class="textarea-counter">0/2000</span>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="onedayLocation" class="required">수업 장소</label>
                            <input type="text" name="oneday_location" id="onedayLocation" class="form-control" 
                                   value="${oneday.oneday_location}" required maxlength="200">
                        </div>
                    </div>
                    
                    <div class="form-col">
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
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="imageFile">클래스 이미지</label>
                    <label for="imageFile" class="file-input-label">
                        <i class="fas fa-image"></i> 이미지 파일 선택
                    </label>
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