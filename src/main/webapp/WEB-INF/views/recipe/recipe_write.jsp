<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>레시피 작성</title>
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <!-- 부트스트랩 아이콘 추가 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <!-- 스타일 추가 -->
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }
        
        .container {
            max-width: 1000px;
        }
        
        .card {
            border: none;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            border-radius: 10px;
            overflow: hidden;
        }
        
        .card-header {
            background-color: #e67e22;
            color: white;
            padding: 15px 20px;
            border-bottom: none;
        }
        
        .card-header h4 {
            margin: 0;
            font-weight: 600;
        }
        
        .card-body {
            padding: 30px;
        }
        
        .form-group label {
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
        }
        
        .form-control {
            border-radius: 5px;
            border: 1px solid #ddd;
            padding: 10px 15px;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #e67e22;
            box-shadow: 0 0 0 0.2rem rgba(230, 126, 34, 0.25);
        }
        
        select.form-control {
            height: 45px;
        }
        
        /* 스텝 컨테이너 스타일 */
        .step-item {
            margin-bottom: 25px;
            padding: 20px;
            border: 1px solid #eee;
            border-radius: 8px;
            position: relative;
            box-shadow: 0 2px 5px rgba(0,0,0,0.03);
            background-color: #fff;
            transition: all 0.3s ease;
        }
        
        .step-item:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transform: translateY(-2px);
        }
        
        /* 스텝 헤더 스타일 */
        .step-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .step-header h5 {
            font-weight: 600;
            color: #e67e22;
            margin: 0;
        }
        
        .step-number {
            display: inline-block;
            background-color: #e67e22;
            color: white;
            width: 28px;
            height: 28px;
            line-height: 28px;
            text-align: center;
            border-radius: 50%;
            margin-left: 8px;
            font-weight: normal;
        }
        
        /* 삭제 버튼 스타일 */
        .delete-step-btn {
            padding: 5px 10px;
            font-size: 0.8em;
            border-radius: 4px;
            background-color: #ff6b6b;
            border: none;
        }
        
        .delete-step-btn:hover {
            background-color: #e74c3c;
        }
        
        /* 이미지 미리보기 스타일 */
        .image-preview {
            max-width: 100%;
            max-height: 200px;
            margin-top: 10px;
            display: none;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        /* 버튼 스타일 */
        .btn-primary {
            background-color: #e67e22;
            border-color: #e67e22;
            padding: 10px 25px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .btn-primary:hover {
            background-color: #d35400;
            border-color: #d35400;
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(0,0,0,0.1);
        }
        
        .btn-success {
            background-color: #74b243;
            border-color: #74b243;
            transition: all 0.3s;
        }
        
        .btn-success:hover {
            background-color: #639a39;
            border-color: #639a39;
            transform: translateY(-2px);
        }
        
        /* 메인 카드 내부 카드 스타일 */
        .card .card {
            box-shadow: none;
            border: 1px solid #eee;
        }
        
        .card .card-header {
            background-color: #f8f9fa;
            color: #333;
            border-bottom: 1px solid #eee;
            padding: 15px 20px;
        }
        
        .card .card-header h5 {
            font-weight: 600;
            margin: 0;
        }
        
        /* 파일 업로드 스타일 */
        input[type="file"] {
            padding: 8px;
            background-color: #f9f9f9;
        }
        
        /* 텍스트 에어리어 스타일 */
        textarea.form-control {
            resize: none;
            min-height: 100px;
        }
        
        /* 페이지 타이틀 */
        .page-title {
            text-align: center;
            margin: 30px 0;
            color: #333;
            font-weight: 700;
        }
    </style>
</head>
<body>
    <!-- JSP 변수를 JavaScript에 전달하기 위한 hidden 필드 추가 -->
    <input type="hidden" id="rootPath" value="${root}">

    <c:import url="/WEB-INF/views/include/top_menu.jsp"/>

    <h1 class="page-title">나만의 레시피 작성</h1>

    <div class="container" style="margin-top:30px; margin-bottom:50px;">
        <div class="row">
            <div class="col-lg-10 offset-lg-1">
                <div class="card shadow">
                    <div class="card-header">
                        <h4><i class="fas fa-edit"></i> 레시피 작성</h4>
                    </div>
                    <div class="card-body">
                        <form:form id="recipeForm" action="${root}/recipe/recipe_write_pro" method="post" modelAttribute="writeRecipe" enctype="multipart/form-data">
                            <!-- 카테고리 선택 -->
                            <div class="form-group">
                                <form:label path="theme_index">카테고리 선택</form:label>
                                <form:select path="theme_index" id="theme_index" class="form-control">
                                    <form:option value="0">-- 카테고리 선택 --</form:option>
                                    <form:option value="1">푸드</form:option>
                                    <form:option value="2">뷰티</form:option>
                                    <form:option value="3">문구/팬시</form:option>
                                    <form:option value="4">패션</form:option>
                                    <form:option value="5">리빙</form:option>
                                </form:select>
                            </div>

                            <!-- 아이디 필드 -->
                            <div class="form-group">
                                <form:label path="id">아이디</form:label>
                                <form:input type="text" id="id" class="form-control" path="id" readonly="true" />
                            </div>

                            <!-- 제목 필드 -->
                            <div class="form-group">
                                <form:label path="openRecipe_title">제목</form:label>
                                <form:input type="text" id="openRecipe_title" path="openRecipe_title" class="form-control" placeholder="레시피 제목을 입력해주세요"/>
                            </div>

                            <!-- 한줄 소개 필드 -->
                            <div class="form-group">
                                <form:label path="openRecipe_intro">한줄 소개</form:label>
                                <form:input type="text" id="openRecipe_intro" path="openRecipe_intro" class="form-control" placeholder="레시피에 대한 간단한 소개를 입력해주세요"/>
                            </div>

                            <!-- 재료 필드 -->
                            <div class="form-group">
                                <form:label path="openRecipe_prepare">재료</form:label>
                                <form:input type="text" id="openRecipe_prepare" path="openRecipe_prepare" class="form-control" placeholder="필요한 재료를 쉼표(,)로 구분하여 입력해주세요"/>
                                <small class="form-text text-muted">예: 당근 100g, 양파 1개, 소고기 300g</small>
                            </div>

                            <!-- 작품 완성 사진 -->
                            <div class="form-group">
                                <form:label path="upload_picture">작품 완성 사진</form:label>
                                <div class="custom-file">
                                    <input type="file" id="upload_picture" name="upload_picture" class="form-control" accept="image/*" onchange="previewMainImage(this)" />
                                </div>
                                <!-- 메인 이미지 미리보기 영역 추가 -->
                                <div class="mt-3 text-center">
                                    <img id="mainImagePreview" class="image-preview" src="#" alt="메인 이미지 미리보기" />
                                </div>
                            </div>

                            <!-- 레시피 단계 컨테이너 -->
                            <div class="card mt-4 mb-4">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5><i class="fas fa-list-ol"></i> 요리 단계</h5>
                                    <div>
                                        <button type="button" class="btn btn-sm btn-success" onclick="addStep()">
                                            <i class="bi bi-plus-circle"></i> 순서추가
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body" id="stepsContainer">
                                    <!-- 여기에 스텝들이 추가됩니다 -->
                                </div>
                            </div>


                            <!-- 컨트롤러에 필요한 숨겨진 필드들 -->
                            <div id="hiddenFields">
                                <!-- 여기에 스텝 데이터를 위한 숨겨진 필드들이 동적으로 추가됩니다 -->
                                <c:forEach var="i" begin="0" end="19">
                                    <form:hidden path="stepBeanList[${i}].stepNumber" id="stepNumber_${i}" />
                                    <form:hidden path="stepBeanList[${i}].stepText" id="stepText_${i}" />
                                </c:forEach>
                            </div>

                            <!-- 컨트롤 버튼 -->
                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="bi bi-check-circle"></i> 저장하기
                                </button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
    
    <script>
    // 전역 변수 정의
    let stepCount = 0;       // 현재 표시된 스텝 수
    let visibleSteps = [];   // 현재 보이는 스텝의 실제 인덱스들
    
   // 페이지 로드 시 초기화
    document.addEventListener('DOMContentLoaded', function() {
        // 첫 번째 스텝 자동 추가
        addStep();
    }); 
    
    // 스텝 추가 함수
    function addStep() {
        if (stepCount >= 20) {
            alert('최대 20개까지만 추가할 수 있습니다.');
            return;
        }
        
        const stepsContainer = document.getElementById('stepsContainer');
        
        // 새 스텝의 실제 인덱스 결정 (컨트롤러에 보낼 때 사용할 인덱스)
        let stepIndex = 0;
        while (visibleSteps.includes(stepIndex) && stepIndex < 20) {
            stepIndex++;
        }
        
        // 화면에 표시될 스텝 번호 (1부터 시작)
        const stepDisplayNumber = stepCount + 1;
        
        // 스텝 추적 배열에 추가
        visibleSteps.push(stepIndex);
        
        // 스텝 UI 생성
        const stepItem = document.createElement('div');
        stepItem.className = 'step-item';
        stepItem.id = 'step_' + stepIndex;
        
        // 스텝 헤더 생성
        const stepHeader = document.createElement('div');
        stepHeader.className = 'step-header';
        
        // 헤더 제목 추가
        const headerTitle = document.createElement('h5');
        headerTitle.textContent = 'Step ';
        const stepNumber = document.createElement('span');
        stepNumber.className = 'step-number';
        stepNumber.textContent = stepDisplayNumber;
        headerTitle.appendChild(stepNumber);
        stepHeader.appendChild(headerTitle);
        
        // 삭제 버튼 추가
        const deleteBtn = document.createElement('button');
        deleteBtn.type = 'button';
        deleteBtn.className = 'btn btn-sm btn-danger delete-step-btn';
        deleteBtn.innerHTML = '<i class="bi bi-trash"></i> 삭제';
        deleteBtn.onclick = function() { deleteStep(stepIndex); };
        stepHeader.appendChild(deleteBtn);
        
        // 스텝 본문 컨테이너
        const stepBody = document.createElement('div');
        
        // 설명 텍스트 영역
        const textGroup = document.createElement('div');
        textGroup.className = 'form-group';
        
        const textLabel = document.createElement('label');
        textLabel.textContent = '단계 설명:';
        textGroup.appendChild(textLabel);
        
        const textarea = document.createElement('textarea');
        textarea.className = 'form-control step-textarea';
        textarea.rows = 3;
        textarea.placeholder = '예시) 소고기를 썰어주세요';
        textarea.onchange = function() { updateStepText(stepIndex, this.value); };
        textGroup.appendChild(textarea);
        
        // 이미지 업로드 영역
        const imageGroup = document.createElement('div');
        imageGroup.className = 'form-group';
        
        const imageLabel = document.createElement('label');
        imageLabel.textContent = '단계 이미지:';
        imageGroup.appendChild(imageLabel);
        
        const imageInputDiv = document.createElement('div');
        const imageInput = document.createElement('input');
        imageInput.type = 'file';
        imageInput.name = 'stepBeanList[' + stepIndex + '].stepImage';
        imageInput.className = 'form-control step-image';
        imageInput.accept = 'image/*';
        imageInput.onchange = function() { previewStepImage(this, stepIndex); };
        imageInputDiv.appendChild(imageInput);
        imageGroup.appendChild(imageInputDiv);
        
        // 이미지 미리보기 영역
        const previewDiv = document.createElement('div');
        previewDiv.className = 'mt-3 text-center';
        const previewImg = document.createElement('img');
        previewImg.id = 'stepImagePreview_' + stepIndex;
        previewImg.className = 'image-preview';
        previewImg.src = '#';
        previewImg.alt = 'Step ' + stepDisplayNumber + ' 이미지 미리보기';
        previewDiv.appendChild(previewImg);
        imageGroup.appendChild(previewDiv);
        
        // 모든 요소 조합
        stepItem.appendChild(stepHeader);
        stepBody.appendChild(textGroup);
        stepBody.appendChild(imageGroup);
        stepItem.appendChild(stepBody);
        
        stepsContainer.appendChild(stepItem);
        
        // 숨겨진 필드 업데이트
        document.getElementById('stepNumber_' + stepIndex).value = stepDisplayNumber;
        
        // 스텝 카운트 증가
        stepCount++;
        
        // 새 스텝으로 스크롤
        stepItem.scrollIntoView({ behavior: 'smooth', block: 'center' });
        
        console.log('스텝 추가됨: 인덱스 ' + stepIndex + ', 표시 번호 ' + stepDisplayNumber);
        console.log('현재 보이는 스텝들:', visibleSteps);
    }
    
    // 스텝 삭제 함수
    function deleteStep(index) {
        // 삭제하려는 스텝 요소
        const stepElement = document.getElementById('step_' + index);
        if (!stepElement) return;
        
        console.log('스텝 삭제 시도: 인덱스 ' + index);
        
        // visibleSteps 배열에서 해당 인덱스 위치 찾기
        const positionInArray = visibleSteps.indexOf(index);
        if (positionInArray === -1) return;
        
        // UI에서 스텝 요소 제거
        stepElement.remove();
        
        // 추적 배열에서 제거
        visibleSteps.splice(positionInArray, 1);
        
        // 숨겨진 입력 필드 초기화
        document.getElementById('stepNumber_' + index).value = '';
        document.getElementById('stepText_' + index).value = '';
        
        // 총 스텝 수 감소
        stepCount--;
        
        // 스텝 번호 재정렬
        updateStepNumbers();
        
        console.log('스텝 삭제 완료');
        console.log('남은 스텝들:', visibleSteps);
    }
    
    // 스텝 번호 재정렬 함수
    function updateStepNumbers() {
        // 현재 보이는 모든 스텝 요소
        const stepElements = document.querySelectorAll('.step-item');
        
        // 각 스텝의 표시 번호 업데이트
        stepElements.forEach(function(element, idx) {
            const displayNumber = idx + 1;
            const numberElement = element.querySelector('.step-number');
            if (numberElement) {
                numberElement.textContent = displayNumber;
            }
            
            // 스텝 인덱스 추출
            const stepId = element.id;
            const stepIndex = parseInt(stepId.split('_')[1]);
            
            // 숨겨진 스텝 번호 필드 업데이트
            document.getElementById('stepNumber_' + stepIndex).value = displayNumber;
            
            console.log('스텝 번호 업데이트: 인덱스 ' + stepIndex + ' -> 표시 번호 ' + displayNumber);
        });
    }
    
    // 스텝 텍스트 업데이트 함수
    function updateStepText(index, text) {
        document.getElementById('stepText_' + index).value = text;
    }
    
    // 메인 이미지 미리보기 함수
    function previewMainImage(input) {
        const preview = document.getElementById('mainImagePreview');
        
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            
            reader.onload = function(e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
            };
            
            reader.readAsDataURL(input.files[0]);
        } else {
            preview.style.display = 'none';
        }
    }
    
    // 스텝 이미지 미리보기 함수
    function previewStepImage(input, index) {
        const preview = document.getElementById('stepImagePreview_' + index);
        
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            
            reader.onload = function(e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
            };
            
            reader.readAsDataURL(input.files[0]);
        } else {
            preview.style.display = 'none';
        }
    }
    
    // 폼 제출 전 유효성 검사
    document.getElementById('recipeForm').addEventListener('submit', function(e) {
        // 기본 검사: 카테고리와 제목 필수
        const themeIndex = document.getElementById('theme_index').value;
        const title = document.getElementById('openRecipe_title').value;
        
        if (themeIndex === '0') {
            e.preventDefault();
            alert('카테고리를 선택해주세요.');
            return;
        }
        
        if (!title.trim()) {
            e.preventDefault();
            alert('제목을 입력해주세요.');
            return;
        }

        if (document.getElementById('upload_picture').files.length === 0) {
            e.preventDefault();
            alert('완성 사진을 넣어주세요.');
            return;
        }
        
        // 최소 하나의 스텝 필요
        if (visibleSteps.length === 0) {
            e.preventDefault();
            alert('최소 하나의 요리 단계를 입력해주세요.');
            return;
        }
        
        // 모든 스텝 텍스트 확인
        let hasContent = false;
        for (let i = 0; i < visibleSteps.length; i++) {
            const index = visibleSteps[i];
            const stepTextValue = document.getElementById('stepText_' + index).value;
            if (stepTextValue && stepTextValue.trim() !== '') {
                hasContent = true;
                break;
            }
        }
        
        if (!hasContent) {
            e.preventDefault();
            alert('최소 하나의 요리 단계에 내용을 입력해주세요.');
            return;
        }
    });
    </script>
</body>
</html>