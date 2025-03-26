<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>  
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객 문의 목록</title>
    
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
            transition: transform 0.3s ease, box-shadow 0.3s ease; /* 애니메이션 효과 */
        }
        
        .card:hover {
            /* transform: translateY(-5px); /* 호버 시 위로 살짝 이동 */ */
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1); /* 호버 시 그림자 강화 */
        }
        
        /* 카드 헤더 스타일 */
        .card-header {
            background-color: #f8f9fa; /* 연한 회색 배경 */
            border-bottom: 1px solid #eee; /* 하단 경계선 */
            padding: 15px 20px; /* 내부 여백 */
            font-size: 18px; /* 글자 크기 */
            font-weight: 500; /* 글자 두께 */
            color: #2c3e50; /* 진한 파란색 계열 */
            border-radius: 10px 10px 0 0 !important; /* 상단 모서리만 둥글게 */
        }
        
        .card-header i {
            margin-right: 10px; /* 아이콘 오른쪽 여백 */
            color: #007bff; /* 파란색 아이콘 */
        }
        
        /* 문의 목록 스타일 */
        .inquiry-list {
            list-style-type: none; /* 목록 기호 제거 */
            padding: 0; /* 패딩 제거 */
            margin: 0; /* 마진 제거 */
        }
        
        .inquiry-list li {
            border-bottom: 1px solid #eee; /* 항목 간 경계선 */
            padding: 12px 15px; /* 내부 여백 */
            transition: background-color 0.3s ease; /* 배경색 전환 효과 */
        }
        
        .inquiry-list li:last-child {
            border-bottom: none; /* 마지막 항목은 경계선 제거 */
        }
        
        .inquiry-list li:hover {
            background-color: #f8f9fa; /* 호버 시 배경색 변경 */
        }
        
        /* 문의 링크 스타일 */
        .inquiry-list a {
            color: #333; /* 기본 텍스트 색상 */
            text-decoration: none; /* 밑줄 제거 */
            display: flex; /* 플렉스 레이아웃 */
            align-items: center; /* 수직 중앙 정렬 */
            padding: 5px 0; /* 상하 여백 */
            transition: color 0.3s ease; /* 색상 전환 효과 */
        }
        
        .inquiry-list a:hover {
            color: #007bff; /* 호버 시 파란색으로 변경 */
        }
        
        .inquiry-list i {
            margin-right: 10px; /* 아이콘 오른쪽 여백 */
            font-size: 16px; /* 아이콘 크기 */
        }
        
        /* 읽지 않은 문의 뱃지 스타일 */
        .badge-unread {
            background-color: #dc3545; /* 빨간색 배경 */
            color: white; /* 흰색 텍스트 */
            margin-left: 10px; /* 왼쪽 여백 */
            font-weight: 400; /* 글자 두께 */
            padding: 5px 8px; /* 내부 여백 */
        }
        
        /* 읽은 문의 뱃지 스타일 */
        .badge-read {
            background-color: #28a745; /* 녹색 배경 */
            color: white; /* 흰색 텍스트 */
            margin-left: 10px; /* 왼쪽 여백 */
            font-weight: 400; /* 글자 두께 */
            padding: 5px 8px; /* 내부 여백 */
        }
        
        /* 빈 메시지 스타일 */
        .empty-message {
            text-align: center; /* 가운데 정렬 */
            padding: 20px; /* 내부 여백 */
            color: #6c757d; /* 회색 텍스트 */
            font-style: italic; /* 이탤릭체 */
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
        }
    </style>
</head>
<body>

	<div class="side">
        <c:import url="/WEB-INF/views/include/admin_side.jsp" />
    </div>
    <!-- 메인 컨테이너 - 전체 내용을 감싸는 영역 -->
    <div class="inquiry_container">
        <!-- 페이지 헤더 - 제목과 돌아가기 버튼이 있는 영역 -->
        <div class="page-header">
            <h1>고객 문의 목록</h1>
            <a href="${root}/admin/adminmain" class="back-button">
                <i class="fas fa-arrow-left"></i> 관리자 페이지로 돌아가기
            </a>
        </div>
        
        <!-- 읽지 않은 고객 문의 섹션 -->
        <div class="card">
            <div class="card-header">
                <i class="fas fa-envelope"></i> 읽지 않은 고객 문의
            </div>
            <div class="card-body">
                <ul class="inquiry-list">
                    <!-- 읽지 않은 문의가 있는지 확인하는 변수 -->
                    <c:set var="hasUnread" value="false" />
                    
                    <!-- 문의 목록을 순회하며 읽지 않은 문의만 표시 -->
                    <c:forEach var="suggestion" items="${inquiry}">
                        <c:if test="${suggestion.inquiry_read == '답변 대기중'}">
                            <c:set var="hasUnread" value="true" />
                            <li>
                                <a href="${root}/admin/viewinquiry?idx=${suggestion.inquiry_idx}">
                                    <i class="fas fa-envelope-open-text"></i> <!-- 문의 아이콘 -->
                                    ${suggestion.inquiry_title} <!-- 문의 제목 -->
                                    <span class="badge badge-unread">안읽음</span> <!-- 읽지 않음 표시 -->
                                </a>
                            </li>
                        </c:if>
                    </c:forEach>
                    
                    <!-- 읽지 않은 문의가 없는 경우 메시지 표시 -->
                    <c:if test="${!hasUnread}">
                        <li class="empty-message">읽지 않은 문의가 없습니다.</li>
                    </c:if>
                </ul>
            </div>
        </div>
        
        <!-- 읽은 고객 문의 섹션 -->
        <div class="card">
            <div class="card-header">
                <i class="fas fa-envelope-open"></i> 읽은 고객 문의
            </div>
            <div class="card-body">
                <ul class="inquiry-list">
                    <!-- 읽은 문의가 있는지 확인하는 변수 -->
                    <c:set var="hasRead" value="false" />
                    
                    <!-- 문의 목록을 순회하며 읽은 문의만 표시 -->
                    <c:forEach var="suggestion" items="${inquiry}">
                        <c:if test="${suggestion.inquiry_read == '답변 완료'}">
                            <c:set var="hasRead" value="true" />
                            <li>
                                <a href="${root}/admin/viewinquiry?idx=${suggestion.inquiry_idx}">
                                    <i class="fas fa-check-circle"></i> <!-- 완료 아이콘 -->
                                    ${suggestion.inquiry_title} <!-- 문의 제목 -->
                                    <span class="badge badge-read">읽음</span> <!-- 읽음 표시 -->
                                </a>
                            </li>
                        </c:if>
                    </c:forEach>
                    
                    <!-- 읽은 문의가 없는 경우 메시지 표시 -->
                    <c:if test="${!hasRead}">
                        <li class="empty-message">읽은 문의가 없습니다.</li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>

    <!-- 게시판 하단 부분 - 공통 푸터 포함 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>