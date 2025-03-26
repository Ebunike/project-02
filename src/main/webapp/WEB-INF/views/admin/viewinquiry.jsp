<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>  
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객 문의 상세보기</title>
    
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    
    <!-- Font Awesome 아이콘 라이브러리 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- Google Fonts - 웹폰트 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <style>
        /* 기본 폰트 및 스타일 설정 */
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');
        
        body {
            font-family: 'Noto Sans KR', sans-serif; /* 가독성이 좋은 Noto Sans KR 폰트 적용 */
            background-color: #f8f9fa; /* 연한 회색 배경 */
            color: #333; /* 기본 텍스트 색상 */
            padding-top: 20px; /* 상단 여백 */
        }
        
        /* 전체 컨테이너 스타일 */
        .inquiry_container {
            background-color: #fff; /* 흰색 배경 */
            border-radius: 10px; /* 둥근 모서리 */
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.05); /* 부드러운 그림자 효과 */
            padding: 30px; /* 내부 여백 */
            margin-bottom: 40px; /* 하단 여백 */
            max-width: 900px; /* 최대 너비 제한 */
            margin: auto;
        }
        
        /* 페이지 헤더 스타일 */
        .page-header {
            border-bottom: 1px solid #eee; /* 하단 경계선 */
            padding-bottom: 15px; /* 하단 여백 */
            margin-bottom: 30px; /* 하단 여백 */
            display: flex; /* 플렉스 레이아웃 */
            justify-content: space-between; /* 요소 간 여백 최대화 */
            align-items: center; /* 수직 중앙 정렬 */
        }
        
        .page-header h1 {
            font-size: 28px; /* 글자 크기 */
            font-weight: 600; /* 글자 두께 */
            color: #2c3e50; /* 진한 파란색 계열 */
            margin: 0; /* 여백 제거 */
        }
        
        /* 돌아가기 버튼 스타일 */
        .back-button {
            display: inline-block;
            padding: 8px 16px; /* 버튼 내부 여백 */
            background-color: #007bff; /* 파란색 배경 */
            color: white; /* 흰색 텍스트 */
            border-radius: 5px; /* 둥근 모서리 */
            text-decoration: none; /* 밑줄 제거 */
            font-weight: 500; /* 글자 두께 */
            font-size: 14px; /* 글자 크기 */
            transition: all 0.3s ease; /* 부드러운 전환 효과 */
        }
        
        .back-button:hover {
            background-color: #0069d9; /* 호버 시 어두운 파란색 */
            text-decoration: none; /* 밑줄 제거 유지 */
            color: white; /* 흰색 텍스트 유지 */
        }
        
        .back-button i {
            margin-right: 5px; /* 아이콘 오른쪽 여백 */
        }
        
        /* 카드 스타일 */
        .card {
            border: none; /* 테두리 제거 */
            border-radius: 10px; /* 둥근 모서리 */
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.05); /* 그림자 효과 */
            margin-bottom: 25px; /* 하단 여백 */
            overflow: hidden; /* 내용 넘침 숨김 */
        }
        
        /* 카드 헤더 스타일 */
        .card-header {
            background-color: #f8f9fa; /* 연한 회색 배경 */
            border-bottom: 1px solid #eee; /* 하단 경계선 */
            padding: 15px 20px; /* 내부 여백 */
            font-size: 18px; /* 글자 크기 */
            font-weight: 500; /* 글자 두께 */
            color: #2c3e50; /* 진한 파란색 계열 */
        }
        
        .card-header i {
            margin-right: 10px; /* 아이콘 오른쪽 여백 */
            color: #007bff; /* 파란색 아이콘 */
        }
        
        /* 카드 본문 스타일 */
        .card-body {
            padding: 20px; /* 내부 여백 */
        }
        
        /* 문의 상세 정보 스타일 */
        .inquiry-details {
            margin-bottom: 25px; /* 하단 여백 */
        }
        
        .inquiry-details .info-item {
            margin-bottom: 15px; /* 항목 간 여백 */
            padding-bottom: 15px; /* 하단 여백 */
            border-bottom: 1px solid #eee; /* 하단 경계선 */
        }
        
        .inquiry-details .info-item:last-child {
            border-bottom: none; /* 마지막 항목 경계선 제거 */
            margin-bottom: 0; /* 마지막 항목 여백 제거 */
            padding-bottom: 0; /* 마지막 항목 여백 제거 */
        }
        
        .inquiry-details .label {
            font-weight: 600; /* 라벨 글자 두께 */
            color: #495057; /* 라벨 색상 */
            display: block; /* 블록 요소로 설정 */
            margin-bottom: 5px; /* 하단 여백 */
        }
        
        .inquiry-details .content {
            color: #333; /* 내용 색상 */
            line-height: 1.6; /* 줄 간격 */
        }
        
        /* 문의 내용 영역 스타일 */
        .inquiry-content {
            background-color: #f9f9f9; /* 연한 회색 배경 */
            border-radius: 5px; /* 둥근 모서리 */
            padding: 15px; /* 내부 여백 */
            margin-top: 5px; /* 상단 여백 */
            white-space: pre-wrap; /* 줄바꿈 유지 */
        }
        
        /* 답글 영역 스타일 */
        .reply-section {
            margin-top: 30px; /* 상단 여백 */
        }
        
        .reply-section h3 {
            font-size: 18px; /* 글자 크기 */
            font-weight: 600; /* 글자 두께 */
            margin-bottom: 15px; /* 하단 여백 */
            color: #2c3e50; /* 텍스트 색상 */
            display: flex; /* 플렉스 레이아웃 */
            align-items: center; /* 수직 중앙 정렬 */
        }
        
        .reply-section h3 i {
            margin-right: 8px; /* 아이콘 오른쪽 여백 */
            color: #007bff; /* 파란색 아이콘 */
        }
        
        /* 기존 답글 스타일 */
        .existing-reply {
            background-color: #e6f3ff; /* 연한 파란색 배경 */
            border-left: 4px solid #007bff; /* 왼쪽 테두리 강조 */
            padding: 15px; /* 내부 여백 */
            border-radius: 5px; /* 둥근 모서리 */
            margin-bottom: 15px; /* 하단 여백 */
            white-space: pre-wrap; /* 줄바꿈 유지 */
        }
        
        /* 답글 폼 스타일 */
        .reply-form {
            background-color: #f8f9fa; /* 연한 회색 배경 */
            padding: 20px; /* 내부 여백 */
            border-radius: 5px; /* 둥근 모서리 */
            margin-top: 15px; /* 상단 여백 */
        }
        
        .reply-form textarea {
            width: 100%; /* 가로 너비 100% */
            min-height: 120px; /* 최소 높이 */
            padding: 12px; /* 내부 여백 */
            border: 1px solid #ddd; /* 테두리 */
            border-radius: 5px; /* 둥근 모서리 */
            resize: vertical; /* 세로 방향으로만 크기 조절 가능 */
            margin-bottom: 15px; /* 하단 여백 */
            font-family: 'Noto Sans KR', sans-serif; /* 폰트 */
        }
        
        /* 버튼 스타일 */
        .btn {
            padding: 8px 16px; /* 내부 여백 */
            font-size: 14px; /* 글자 크기 */
            font-weight: 500; /* 글자 두께 */
            border-radius: 5px; /* 둥근 모서리 */
            cursor: pointer; /* 커서 포인터 */
            transition: all 0.3s ease; /* 부드러운 전환 효과 */
        }
        
        .btn-edit {
            background-color: #17a2b8; /* 청록색 배경 */
            color: white; /* 흰색 텍스트 */
            border: none; /* 테두리 없음 */
            margin-right: 10px; /* 오른쪽 여백 */
        }
        
        .btn-edit:hover {
            background-color: #138496; /* 호버 시 더 진한 색상 */
        }
        
        .btn-delete {
            background-color: #dc3545; /* 빨간색 배경 */
            color: white; /* 흰색 텍스트 */
            border: none; /* 테두리 없음 */
        }
        
        .btn-delete:hover {
            background-color: #c82333; /* 호버 시 더 진한 색상 */
        }
        
        .btn-submit {
            background-color: #007bff; /* 파란색 배경 */
            color: white; /* 흰색 텍스트 */
            border: none; /* 테두리 없음 */
        }
        
        .btn-submit:hover {
            background-color: #0069d9; /* 호버 시 더 진한 색상 */
        }
        
        /* 버튼 그룹 스타일 */
        .button-group {
            display: flex; /* 플렉스 레이아웃 */
            margin-top: 15px; /* 상단 여백 */
        }
        
        .button-group button {
            margin-right: 10px; /* 버튼 간 여백 */
        }
        
        /* 반응형 스타일 - 작은 화면에 대응 */
        @media (max-width: 768px) {
            .inquiry_container {
                padding: 20px; /* 작은 화면에서 여백 축소 */
            }
            
            .page-header {
                flex-direction: column; /* 세로 배치로 변경 */
                align-items: flex-start; /* 왼쪽 정렬 */
            }
            
            .back-button {
                margin-top: 15px; /* 상단 여백 추가 */
            }
            
            .button-group {
                flex-direction: column; /* 세로 배치로 변경 */
            }
            
            .button-group button {
                margin-right: 0; /* 오른쪽 여백 제거 */
                margin-bottom: 10px; /* 하단 여백 추가 */
                width: 100%; /* 가로 너비 100% */
            }
        }
    </style>
    
    <!-- JavaScript 추가 -->
    <script>
        function showReplyForm() {
            // 답글 수정 폼을 표시
            document.getElementById('reply-form').style.display = 'block';
            // 기존 답글을 textarea에 미리 채워넣기
            const replyContent = document.getElementById('existing-reply').innerText;
            document.getElementById('reply-content').value = replyContent;
            // 수정 폼 버튼을 숨기기
            document.getElementById('edit-btn').style.display = 'none';
        }
    </script>
</head>
<body>
    <div class="side">
        <c:import url="/WEB-INF/views/include/admin_side.jsp" />
    </div>

    <!-- 메인 컨테이너 - 전체 내용을 감싸는 영역 -->
    <div class="inquiry_container">
        <!-- 페이지 헤더 - 제목과 돌아가기 버튼이 있는 영역 -->
        <div class="page-header">
            <h1>고객 문의 상세보기</h1>
            <a href="${root}/admin/inquiry" class="back-button">
                <i class="fas fa-arrow-left"></i> 문의 목록으로 돌아가기
            </a>
        </div>
        
        <!-- 문의 상세 정보 카드 -->
        <div class="card">
            <div class="card-header">
                <i class="fas fa-info-circle"></i> 문의 정보
            </div>
            <div class="card-body">
                <div class="inquiry-details">
                    <div class="info-item">
                        <span class="label">제목</span>
                        <div class="content">${oneInquiry.inquiry_title}</div>
                    </div>
                    <div class="info-item">
                        <span class="label">작성자</span>
                        <div class="content">${oneInquiry.id}</div>
                    </div>
                    <div class="info-item">
                        <span class="label">문의 내용</span>
                        <div class="inquiry-content">${oneInquiry.inquiry_content}</div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 답변 섹션 -->
        <div class="card">
            <div class="card-header">
                <i class="fas fa-reply"></i> 답변 관리
            </div>
            <div class="card-body">
                <div class="reply-section">
                    <!-- 답글이 없다면 답글 달기 폼을 보여준다 -->
                    <c:if test="${empty oneInquiry.inquiry_reply}">
                        <h3><i class="fas fa-pen"></i> 문의 답변 작성</h3>
                        <form action="${root}/admin/viewinquiry_pro" method="POST" class="reply-form">
                            <input type="hidden" name="idx" value="${oneInquiry.inquiry_idx}" />
                            <textarea name="reply_content" placeholder="고객의 문의에 대한 답변을 작성하세요" required></textarea>
                            <button type="submit" class="btn btn-submit">답변 등록</button>
                        </form>
                    </c:if>
                    
                    <!-- 답글이 있으면 답글 내용과 수정, 삭제 버튼을 보여준다 -->
                    <c:if test="${not empty oneInquiry.inquiry_reply}">
                        <h3><i class="fas fa-comment-dots"></i> 작성된 답변</h3>
                        <div id="existing-reply" class="existing-reply">${oneInquiry.inquiry_reply}</div>
                        
                        <div class="button-group">
                            <!-- 수정 버튼 -->
                            <button id="edit-btn" class="btn btn-edit" onclick="showReplyForm()">
                                <i class="fas fa-edit"></i> 답변 수정
                            </button>
                            
                            <!-- 삭제 버튼 -->
                            <form action="${root}/admin/deleteReply" method="POST" style="display:inline;">
                                <input type="hidden" name="idx" value="${oneInquiry.inquiry_idx}" />
                                <button type="submit" class="btn btn-delete">
                                    <i class="fas fa-trash-alt"></i> 답변 삭제
                                </button>
                            </form>
                        </div>
                        
                        <!-- 답글 수정 폼 (숨겨진 상태) -->
                        <form action="${root}/admin/viewinquiry_pro" method="POST" class="reply-form" id="reply-form" style="display:none;">
                            <input type="hidden" name="idx" value="${oneInquiry.inquiry_idx}" />
                            <textarea name="reply_content" id="reply-content" placeholder="답변을 수정하세요" required></textarea>
                            <button type="submit" class="btn btn-submit">수정 완료</button>
                        </form>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- 게시판 하단 부분 - 공통 푸터 포함 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>