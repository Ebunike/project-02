<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>레시피 수정</title>
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <!-- 부트스트랩 아이콘 추가 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <!-- 스타일 추가 -->
    <style>
        /* 스텝 컨테이너 스타일 */
        .step-item {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            position: relative;
        }
        
        /* 스텝 헤더 스타일 */
        .step-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            padding-bottom: 5px;
            border-bottom: 1px solid #eee;
        }
        
        /* 삭제 버튼 스타일 */
        .delete-step-btn {
            padding: 3px 8px;
            font-size: 0.8em;
        }
        
        /* 이미지 미리보기 스타일 */
        .image-preview {
            max-width: 100%;
            max-height: 200px;
            margin-top: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        
        /* 숨겨진 스텝 */
        .hidden-step {
            display: none;
        }
    </style>
</head>
<body>
    <c:import url="/WEB-INF/views/include/top_menu.jsp"/>

    <div class="container" style="margin-top:100px">
        <div class="row">
            <div class="col-sm-2"></div>
            <div class="col-sm-8">
                <div class="card shadow">
                    <div class="card-header">
                        <h4>레시피 수정</h4>
                    </div>
                    <div class="card-body">
                        <form:form id="recipeForm" action="${root}/recipe/recipe_modify_pro" method="post" modelAttribute="modifyRecipe" enctype="multipart/form-data">
                            <!-- 기존 글 정보 (hidden) -->
                            <form:hidden path="openRecipe_index"/>
                            <form:hidden path="theme_index"/>
                            
                            <!-- 작성자 정보 -->
                            <div class="form-group">
                                <form:label path="id">작성자</form:label>
                                <form:input path="id" class='form-control' readonly="true"/>
                            </div>
                            
                            <!-- 제목 필드 -->
                            <div class="form-group">
                                <form:label path="openRecipe_title">제목</form:label>
                                <form:input path="openRecipe_title" class='form-control'/>
                                <form:errors path="openRecipe_title" style='color:red'/>
                            </div>
                            
                            <!-- 한줄 소개 필드 -->
                            <div class="form-group">
                                <form:label path="openRecipe_intro">한줄소개</form:label>
                                <form:input path="openRecipe_intro" class='form-control'/>
                                <form:errors path="openRecipe_intro" style='color:red'/>
                            </div>
                            
                            <!-- 재료 필드 -->
                            <div class="form-group">
                                <form:label path="openRecipe_prepare">재료</form:label>
                                <form:input path="openRecipe_prepare" class='form-control'/>
                                <form:errors path="openRecipe_prepare" style='color:red'/>
                            </div>
                            
                            <!-- 완성 이미지 -->
                            <div class="form-group">
                                <label for="openRecipe_picture">완성 이미지</label>
                                <c:if test="${modifyRecipe.openRecipe_picture != null }">
                                    <div class="mb-3">
                                        <img id="mainImagePreview" src="${root}/upload/${modifyRecipe.openRecipe_picture}" width="100%" class="image-preview"/>
                                        <form:hidden path="openRecipe_picture"/>
                                    </div>
                                </c:if>
                                <input type="file" id="upload_picture" name="upload_picture" class="form-control" accept="image/*" onchange="previewMainImage(this)"/>
                            </div>
                            
                            <!-- 레시피 단계 컨테이너 -->
                            <div class="card mt-4 mb-4">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5>요리 단계</h5>
                                    <div>
                                        <button type="button" class="btn btn-sm btn-success" onclick="addStep()">
                                            <i class="bi bi-plus-circle"></i> 순서추가
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body" id="stepsContainer">
                                    <!-- 여기에 기존 스텝들을 표시 -->
                                    <!-- 별도 스크립트에서 처리됨 -->
                                </div>
                            </div>
                            
                            <!-- 컨트롤 버튼 -->
                            <div class="text-center">
                                <form:button class='btn btn-primary'>
                                    <i class="bi bi-check-circle"></i> 수정완료
                                </form:button>
                                <a href="${root}/recipe/read?openRecipe_index=${modifyRecipe.openRecipe_index}" class="btn btn-info">취소</a>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
            <div class="col-sm-2"></div>
        </div>
    </div>

    <c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
    
    <script>
    // 전역 변수 정의
    let stepCount = 0;       // 현재 표시된 스텝 수
    let visibleSteps = [];   // 현재 보이는 스텝의 실제 인덱스들
    
    // 페이지 로드 시 초기화
    document.addEventListener('DOMContentLoaded', function() {
        // 기존 스텝 데이터 로드
        loadExistingSteps();
    });
    
    // 기존 스텝 데이터 로드 함수
    function loadExistingSteps() {
        const stepsContainer = document.getElementById('stepsContainer');
        
        // 서버에서 전달받은 StepBeanList 배열을 순회하며 스텝을 표시
        <c:forEach var="step" items="${modifyRecipe.stepBeanList}" varStatus="status">
            <c:if test="${not empty step.stepText}">
                createStepItem(${status.index}, '${step.stepText}', '${step.stepImageUrl}', ${step.stepNumber});
                visibleSteps.push(${status.index});
                stepCount++;
            </c:if>
        </c:forEach>
        
        // 스텝이 하나도 없으면 빈 스텝 하나 추가
        if (stepCount === 0) {
            addStep();
        }
    }
    
    // 스텝 항목 생성 함수
    function createStepItem(index, stepText, stepImageUrl, stepNumber) {
        const stepsContainer = document.getElementById('stepsContainer');
        
        // 스텝 UI 생성
        const stepItem = document.createElement('div');
        stepItem.className = 'step-item';
        stepItem.id = 'step_' + index;
        
        // 스텝 헤더 생성
        const stepHeader = document.createElement('div');
        stepHeader.className = 'step-header';
        
        // 헤더 제목 추가
        const headerTitle = document.createElement('h5');
        headerTitle.innerHTML = 'Step <span class="step-number">' + stepNumber + '</span>';
        stepHeader.appendChild(headerTitle);
        
        // 삭제 버튼 추가
        const deleteBtn = document.createElement('button');
        deleteBtn.type = 'button';
        deleteBtn.className = 'btn btn-sm btn-danger delete-step-btn';
        deleteBtn.innerHTML = '<i class="bi bi-trash"></i> 삭제';
        deleteBtn.onclick = function() { deleteStep(index); };
        stepHeader.appendChild(deleteBtn);
        
        // 스텝 번호 히든 필드
        const hiddenStepNumber = document.createElement('input');
        hiddenStepNumber.type = 'hidden';
        hiddenStepNumber.name = 'stepBeanList[' + index + '].stepNumber';
        hiddenStepNumber.value = stepNumber;
        
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
        textarea.name = 'stepBeanList[' + index + '].stepText';
        textarea.value = stepText || '';
        textGroup.appendChild(textarea);
        
        // 이미지 업로드 영역
        const imageGroup = document.createElement('div');
        imageGroup.className = 'form-group';
        
        const imageLabel = document.createElement('label');
        imageLabel.textContent = '단계 이미지:';
        imageGroup.appendChild(imageLabel);
        
        // 이미지 컨테이너 생성 (기존 이미지와 새 이미지 미리보기 모두 표시)
        const imageContainer = document.createElement('div');
        imageContainer.id = 'imageContainer_' + index;
        imageGroup.appendChild(imageContainer);
        
        // 기존 이미지가 있으면 표시
        if (stepImageUrl && stepImageUrl !== '') {
            const existingImageDiv = document.createElement('div');
            existingImageDiv.className = 'mb-2';
            existingImageDiv.id = 'existingImage_' + index;
            
            const existingImage = document.createElement('img');
            existingImage.src = "${root}/upload/" + stepImageUrl;
            existingImage.className = 'image-preview';
            existingImage.style.display = 'block';
            existingImage.width = 200;
            existingImage.className = 'img-thumbnail';
            existingImageDiv.appendChild(existingImage);
            
            // 이미지 URL 히든 필드
            const hiddenImage = document.createElement('input');
            hiddenImage.type = 'hidden';
            hiddenImage.name = 'stepBeanList[' + index + '].stepImageUrl';
            hiddenImage.value = stepImageUrl;
            hiddenImage.id = 'stepImageUrl_' + index;
            existingImageDiv.appendChild(hiddenImage);
            
            imageContainer.appendChild(existingImageDiv);
        }
        
        // 파일 입력 필드
        const imageInputDiv = document.createElement('div');
        const imageInput = document.createElement('input');
        imageInput.type = 'file';
        imageInput.name = 'stepBeanList[' + index + '].stepImage';
        imageInput.className = 'form-control step-image';
        imageInput.accept = 'image/*';
        imageInput.onchange = function() { previewStepImage(this, index); };
        imageInputDiv.appendChild(imageInput);
        imageGroup.appendChild(imageInputDiv);
        
        // 새 이미지 미리보기 영역
        const previewDiv = document.createElement('div');
        previewDiv.className = 'mt-2';
        previewDiv.id = 'previewDiv_' + index;
        previewDiv.style.display = 'none'; // 처음에는 숨김
        
        const previewImg = document.createElement('img');
        previewImg.id = 'stepImagePreview_' + index;
        previewImg.className = 'image-preview';
        previewImg.src = '#';
        previewImg.alt = 'Step ' + stepNumber + ' 이미지 미리보기';
        previewDiv.appendChild(previewImg);
        imageGroup.appendChild(previewDiv);
        
        // 모든 요소 조합
        stepItem.appendChild(stepHeader);
        stepItem.appendChild(hiddenStepNumber);
        stepBody.appendChild(textGroup);
        stepBody.appendChild(imageGroup);
        stepItem.appendChild(stepBody);
        
        stepsContainer.appendChild(stepItem);
    }
    
    // 새 스텝 추가 함수
    function addStep() {
        if (stepCount >= 20) {
            alert('최대 20개까지만 추가할 수 있습니다.');
            return;
        }
        
        // 비어있는 인덱스 찾기
        let newIndex = 0;
        while (visibleSteps.includes(newIndex) && newIndex < 20) {
            newIndex++;
        }
        
        // 화면에 표시될 스텝 번호 (1부터 시작)
        const stepDisplayNumber = stepCount + 1;
        
        // 스텝 추적 배열에 추가
        visibleSteps.push(newIndex);
        
        // 새 스텝 생성
        createStepItem(newIndex, '', '', stepDisplayNumber);
        
        // 스텝 카운트 증가
        stepCount++;
        
        // 새 스텝으로 스크롤
        const newStep = document.getElementById('step_' + newIndex);
        if (newStep) {
            newStep.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    }
    
    // 스텝 삭제 함수
    function deleteStep(index) {
        // 최소 하나의 스텝은 남겨야 함
        if (stepCount <= 1) {
            alert('최소 하나의 요리 단계는 있어야 합니다.');
            return;
        }
        
        // 삭제하려는 스텝 요소
        const stepElement = document.getElementById('step_' + index);
        if (!stepElement) return;
        
        // visibleSteps 배열에서 해당 인덱스 위치 찾기
        const positionInArray = visibleSteps.indexOf(index);
        if (positionInArray === -1) return;
        
        // UI에서 스텝 요소 제거
        stepElement.remove();
        
        // 추적 배열에서 제거
        visibleSteps.splice(positionInArray, 1);
        
        // 총 스텝 수 감소
        stepCount--;
        
        // 스텝 번호 재정렬
        updateStepNumbers();
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
            const stepNumberField = element.querySelector('input[name="stepBeanList[' + stepIndex + '].stepNumber"]');
            if (stepNumberField) {
                stepNumberField.value = displayNumber;
            }
        });
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
        }
    }
    
    // 스텝 이미지 미리보기 함수
    function previewStepImage(input, index) {
        if (input.files && input.files[0]) {
            // 기존 이미지 숨기기
            const existingImageDiv = document.getElementById('existingImage_' + index);
            if (existingImageDiv) {
                existingImageDiv.style.display = 'none';
            }
            
            // 새 이미지 미리보기 표시
            const previewDiv = document.getElementById('previewDiv_' + index);
            const preview = document.getElementById('stepImagePreview_' + index);
            
            const reader = new FileReader();
            
            reader.onload = function(e) {
                preview.src = e.target.result;
                previewDiv.style.display = 'block';
            };
            
            reader.readAsDataURL(input.files[0]);
            
            // 기존 이미지 URL 필드 비우기 (새 이미지로 대체)
            const urlField = document.getElementById('stepImageUrl_' + index);
            if (urlField) {
                urlField.value = '';
            }
        } else {
            // 파일 선택 취소 시 기존 이미지 다시 표시
            const existingImageDiv = document.getElementById('existingImage_' + index);
            if (existingImageDiv) {
                existingImageDiv.style.display = 'block';
            }
            
            // 미리보기 숨기기
            const previewDiv = document.getElementById('previewDiv_' + index);
            if (previewDiv) {
                previewDiv.style.display = 'none';
            }
        }
    }
    
    // 폼 제출 전 유효성 검사
    document.getElementById('recipeForm').addEventListener('submit', function(e) {
        // 기본 검사: 제목 필수
        const title = document.getElementById('openRecipe_title').value;
        
        if (!title.trim()) {
            e.preventDefault();
            alert('제목을 입력해주세요.');
            return;
        }
        
        // 최소 하나의 스텝 필요
        if (visibleSteps.length === 0) {
            e.preventDefault();
            alert('최소 하나의 요리 단계를 입력해주세요.');
            return;
        }
    });
    </script>
</body>
</html>