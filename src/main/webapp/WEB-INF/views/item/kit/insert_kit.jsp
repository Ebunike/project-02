<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 등록</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<!-- 네이버 폰트 -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGaRamYeonGgoc.css" rel="stylesheet">

<style type="text/css">
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f5f5f5;
        color: #333;
        margin: 0;
        padding: 0;
    }
    
    .main {
        text-align: center;
        margin-left: 170px; /* 사이드바 너비만큼 여백 */
    }
    
    .side {
        position: fixed;
        left: 0;
        top: 0;
        width: 170px;
        height: 100vh;
        padding: 20px;
        background-color: #fff;
        box-shadow: 2px 0 5px rgba(0,0,0,0.05);
        z-index: 1000;
    }
    
    .title {
        align-items: center;
        padding: 15px 0;
        margin-bottom: 30px;
        border-bottom: 2px solid #e67e22;
        background-color: #fff;
    }
    
    .title h1 {
        font-family: 'NanumGaRamYeonGgoc', cursive;
        font-size: 2.2rem;
        color: #333;
        margin: 0;
        font-weight: 600;
    }
    
    .container_kit {
        max-width: 900px;
        margin: 0 auto;
        padding: 30px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0,0,0,0.05);
    }
    
    /* 기본 항목 스타일 */
    .item-box {
        background: #fff;
        border: 1px solid #eee;
        padding: 20px;
        margin-bottom: 20px;
        border-radius: 8px;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        align-items: center;
        font-size: 16px;
        transition: all 0.3s ease;
        box-shadow: 0 2px 5px rgba(0,0,0,0.03);
    }
    
    .item-box:hover {
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        transform: translateY(-2px);
    }
    
    .item-box label {
        font-weight: 500;
        color: #333;
        margin-bottom: 5px;
        width: 150px;
        text-align: left;
    }
    
    .item-box input[type="text"] {
        flex: 1;
        padding: 10px 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
        transition: border-color 0.3s;
    }
    
    .item-box input[type="text"]:focus {
        border-color: #e67e22;
        outline: none;
        box-shadow: 0 0 0 2px rgba(230, 126, 34, 0.2);
    }
    
    .item-box input[type="file"] {
        flex: 1;
        padding: 10px 0;
    }
    
    .radio-group {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        flex: 1;
    }
    
    .radio-item {
        display: flex;
        align-items: center;
        margin-right: 15px;
    }
    
    .radio-item input[type="radio"] {
        margin-right: 5px;
    }
    
    /* 상세 설명 카드 */
    .description-card {
        background-color: #f8f9fa;
        border-radius: 8px;
        padding: 25px;
        margin-bottom: 30px;
        border: 1px solid #eee;
        box-shadow: 0 3px 10px rgba(0,0,0,0.03);
    }
    
    .description-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 1px solid #eee;
    }
    
    .description-header h3 {
        font-size: 1.4rem;
        font-weight: 600;
        color: #e67e22;
        margin: 0;
    }
    
    /* 상세 설명 단계 스타일 */
    .detail-item {
        margin-bottom: 25px;
        padding: 20px;
        border: 1px solid #eee;
        border-radius: 8px;
        position: relative;
        box-shadow: 0 2px 5px rgba(0,0,0,0.03);
        background-color: #fff;
        transition: all 0.3s ease;
    }
    
    .detail-item:hover {
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        transform: translateY(-2px);
    }
    
    /* 단계 헤더 스타일 */
    .detail-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
        padding-bottom: 10px;
        border-bottom: 1px solid #eee;
    }
    
    .detail-header h5 {
        font-weight: 600;
        color: #e67e22;
        margin: 0;
    }
    
    .detail-number {
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
    .delete-detail-btn {
        padding: 5px 10px;
        font-size: 0.8em;
        border-radius: 4px;
        background-color: #ff6b6b;
        border: none;
        color: white;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .delete-detail-btn:hover {
        background-color: #e74c3c;
        transform: translateY(-2px);
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
    
    /* 등록 및 단계 추가 버튼 */
    .insert_kit {
        background-color: #e67e22;
        color: white;
        border: none;
        padding: 12px 25px;
        border-radius: 5px;
        cursor: pointer;
        font-weight: 500;
        font-size: 16px;
        transition: all 0.3s ease;
        margin-top: 15px;
        display: inline-block;
    }
    
    .insert_kit:hover {
        background-color: #d35400;
        transform: translateY(-2px);
        box-shadow: 0 5px 10px rgba(0,0,0,0.1);
    }
    
    .add-detail-btn {
        background-color: #74b243;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        font-weight: 500;
        font-size: 14px;
        transition: all 0.3s ease;
        display: inline-block;
    }
    
    .add-detail-btn:hover {
        background-color: #639a39;
        transform: translateY(-2px);
        box-shadow: 0 5px 10px rgba(0,0,0,0.1);
    }
    
    /* 텍스트 영역 스타일 */
    .detail-textarea {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
        min-height: 100px;
        resize: vertical;
        margin-bottom: 15px;
        transition: all 0.3s ease;
    }
    
    .detail-textarea:focus {
        border-color: #e67e22;
        outline: none;
        box-shadow: 0 0 0 2px rgba(230, 126, 34, 0.2);
    }
    
    /* 반응형 스타일 */
    @media (max-width: 768px) {
        .main {
            margin-left: 0;
        }
        
        .side {
            position: static;
            width: 100%;
            height: auto;
            box-shadow: none;
            border-bottom: 1px solid #eee;
        }
        
        .container_kit {
            padding: 20px;
        }
        
        .item-box {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .item-box label {
            width: 100%;
            margin-bottom: 10px;
        }
        
        .item-box input[type="text"] {
            width: 100%;
        }
    }
</style>
</head>
<body>
<div class="main">
    <!-- side 고정메뉴  -->
    <div class="side">
        <c:import url="/WEB-INF/views/include/manager_side.jsp" />
    </div>
    <!-- 본문 -->
    <div class="title">
        <h1>상품 등록</h1>
    </div>
    <div class="container_kit">
        <form action="${root}/item/kit/insert_kit_pro" method="post" enctype="multipart/form-data">
            <div class="item-box">
                <label for="kitName"><i class="fas fa-tag"></i> 제품 이름</label>
                <input type="text" name="kitName" id="kitName" required placeholder="제품 이름을 입력하세요"/>
            </div>
            <input type="hidden" name="kit" value="${kit}"/>
            <div class="item-box">
                <label for="kitPrice"><i class="fas fa-won-sign"></i> 제품 가격</label>
                <input type="text" name="kitPrice" id="kitPrice" placeholder="숫자만 입력하세요"/>
            </div>
            <div class="item-box">
                <label for="kitQuantity"><i class="fas fa-boxes"></i> 제품 재고 수량</label>
                <input type="text" name="kitQuantity" id="kitQuantity" placeholder="숫자만 입력하세요"/>
            </div>
            <div class="item-box">
                <label for="kitTheme"><i class="fas fa-list-alt"></i> 제품 테마</label>
                <div class="radio-group">
                    <div class="radio-item">
                        <input type="radio" name="kitTheme" id="food" value="푸드">
                        <label for="food">[푸드]</label>
                    </div>
                    <div class="radio-item">
                        <input type="radio" name="kitTheme" id="beauty" value="뷰티">
                        <label for="beauty">[뷰티]</label>
                    </div>
                    <div class="radio-item">
                        <input type="radio" name="kitTheme" id="fancy" value="팬시">
                        <label for="fancy">[팬시]</label>
                    </div>
                    <div class="radio-item">
                        <input type="radio" name="kitTheme" id="living" value="리빙">
                        <label for="living">[리빙]</label>
                    </div>
                    <div class="radio-item">
                        <input type="radio" name="kitTheme" id="fashion" value="패션">
                        <label for="fashion">[패션]</label>
                    </div>
                </div>
            </div>
            <div class="item-box">
                <label for="kitPicture"><i class="fas fa-image"></i> 대표 이미지</label>
                <input type="file" id="kitPicture" name="kitPicture" accept="image/*" onchange="previewMainImage(this)"/>
                <!-- 메인 이미지 미리보기 영역 -->
                <div class="mt-3 text-center" style="width: 100%;">
                    <img id="mainImagePreview" class="image-preview" src="#" alt="대표 이미지 미리보기" />
                </div>
            </div>
            
            <!-- 기본 제품 설명 -->
            <div class="item-box">
                <label for="kitContent"><i class="fas fa-info-circle"></i> 제품 간단설명</label>
                <input type="text" name="kitContent" id="kitContent" placeholder="제품에 대한 간단한 설명을 입력하세요">
            </div>
            
            <!-- 상세 설명 카드 -->
            <div class="description-card">
                <div class="description-header">
                    <h3><i class="fas fa-clipboard-list"></i> 제품 상세 설명</h3>
                    <button type="button" class="add-detail-btn" onclick="addDetail()">
                        <i class="fas fa-plus-circle"></i> 상세설명 추가
                    </button>
                </div>
                
                <!-- 상세 설명 컨테이너 -->
                <div id="detailsContainer">
                    <!-- 여기에 상세 설명 항목들이 동적으로 추가됩니다 -->
                </div>
            </div>
            
            <!-- 숨겨진 필드들 -->
            <div id="hiddenFields">
                <!-- 여기에 상세 설명 데이터를 위한 숨겨진 필드들이 동적으로 추가됩니다 -->
                <input type="hidden" id="detailCount" name="detailCount" value="0">
            </div>
            
            <button class="insert_kit" type="submit"><i class="fas fa-check"></i> 등록</button>
        </form>
    </div>
</div>

<!-- 게시판 하단 부분 -->    
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

<script>
    // 전역 변수 정의
    let detailCount = 0; // 현재 표시된 상세 설명 수
    
    // 대표 이미지 미리보기 함수
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
    
    // 상세 설명 이미지 미리보기 함수
    function previewDetailImage(input, detailIndex) {
        const preview = document.getElementById('detailImagePreview_' + detailIndex);
        
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
    
    // 상세 설명 추가 함수
    function addDetail() {
        // 상세 설명 항목 최대 개수 제한 (필요시 조정)
        if (detailCount >= 10) {
            alert('최대 10개까지만 추가할 수 있습니다.');
            return;
        }
        
        const detailsContainer = document.getElementById('detailsContainer');
        const detailIndex = detailCount; // 현재 인덱스
        
        // 상세 설명 항목 UI 생성
        const detailItem = document.createElement('div');
        detailItem.className = 'detail-item';
        detailItem.id = 'detail_' + detailIndex;
        
        // 항목 헤더 생성
        const detailHeader = document.createElement('div');
        detailHeader.className = 'detail-header';
        
        // 헤더 제목 추가
        const headerTitle = document.createElement('h5');
        headerTitle.textContent = '상세 설명 ';
        const detailNumber = document.createElement('span');
        detailNumber.className = 'detail-number';
        detailNumber.textContent = detailIndex + 1;
        headerTitle.appendChild(detailNumber);
        detailHeader.appendChild(headerTitle);
        
        // 삭제 버튼 추가
        const deleteBtn = document.createElement('button');
        deleteBtn.type = 'button';
        deleteBtn.className = 'delete-detail-btn';
        deleteBtn.innerHTML = '<i class="fas fa-trash"></i> 삭제';
        deleteBtn.onclick = function() { deleteDetail(detailIndex); };
        detailHeader.appendChild(deleteBtn);
        
        // 상세 설명 본문 컨테이너
        const detailBody = document.createElement('div');
        
        // 설명 텍스트 영역
        const textArea = document.createElement('textarea');
        textArea.className = 'detail-textarea';
        textArea.name = 'detailText_' + detailIndex;
        textArea.placeholder = '상세 설명 내용을 입력하세요';
        textArea.rows = 3;
        detailBody.appendChild(textArea);
        
        // 이미지 업로드 영역
        const imageGroup = document.createElement('div');
        imageGroup.style.marginBottom = '15px';
        
        const imageLabel = document.createElement('label');
        imageLabel.textContent = '관련 이미지:';
        imageLabel.style.display = 'block';
        imageLabel.style.marginBottom = '8px';
        imageLabel.style.fontWeight = '500';
        imageGroup.appendChild(imageLabel);
        
        const imageInput = document.createElement('input');
        imageInput.type = 'file';
        imageInput.name = 'detailImage_' + detailIndex;
        imageInput.className = 'form-control';
        imageInput.accept = 'image/*';
        imageInput.onchange = function() { previewDetailImage(this, detailIndex); };
        imageGroup.appendChild(imageInput);
        
        // 이미지 미리보기 영역
        const previewDiv = document.createElement('div');
        previewDiv.className = 'mt-3 text-center';
        const previewImg = document.createElement('img');
        previewImg.id = 'detailImagePreview_' + detailIndex;
        previewImg.className = 'image-preview';
        previewImg.src = '#';
        previewImg.alt = '상세 설명 이미지 ' + (detailIndex + 1);
        previewDiv.appendChild(previewImg);
        imageGroup.appendChild(previewDiv);
        
        detailBody.appendChild(imageGroup);
        
        // 모든 요소 조합
        detailItem.appendChild(detailHeader);
        detailItem.appendChild(detailBody);
        
        detailsContainer.appendChild(detailItem);
        
        // 숨겨진 필드 업데이트
        document.getElementById('detailCount').value = ++detailCount;
        
        // 새 항목으로 스크롤
        detailItem.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
    
    // 상세 설명 삭제 함수
    function deleteDetail(index) {
        const detailElement = document.getElementById('detail_' + index);
        if (!detailElement) return;
        
        // UI에서 항목 제거
        detailElement.remove();
        
        // 항목 수 감소
        detailCount--;
        document.getElementById('detailCount').value = detailCount;
        
        // 번호 재정렬
        updateDetailNumbers();
    }
    
    // 상세 설명 번호 재정렬 함수
    function updateDetailNumbers() {
        const detailElements = document.querySelectorAll('.detail-item');
        
        detailElements.forEach(function(element, idx) {
            const numberElement = element.querySelector('.detail-number');
            if (numberElement) {
                numberElement.textContent = idx + 1;
            }
        });
    }
    
    // 페이지 로드 시 초기화
    document.addEventListener('DOMContentLoaded', function() {
        // 기본적으로 첫 번째 상세 설명 항목 추가 (선택적)
        addDetail();
    });
</script>

</body>
</html>