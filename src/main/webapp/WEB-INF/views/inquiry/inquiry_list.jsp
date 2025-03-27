<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 문의 목록</title>
    
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
            margin: 0 auto; /* 가운데 정렬 */
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
        
        /* 새 문의 작성 버튼 스타일 */
        .new-inquiry-btn {
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
        
        .new-inquiry-btn:hover {
            background-color: #0069d9; /* 호버 시 어두운 파란색 */
            text-decoration: none; /* 밑줄 제거 유지 */
            color: white; /* 흰색 텍스트 유지 */
        }
        
        .new-inquiry-btn i {
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
        
        /* 테이블 스타일 */
        .inquiry-table {
            width: 100%; /* 전체 너비 */
            border-collapse: collapse; /* 테두리 겹침 제거 */
        }
        
        .inquiry-table th, .inquiry-table td {
            padding: 15px; /* 셀 내부 여백 */
            text-align: left; /* 텍스트 왼쪽 정렬 */
            border-bottom: 1px solid #eee; /* 하단 경계선 */
        }
        
        .inquiry-table th {
            background-color: #f8f9fa; /* 연한 회색 배경 */
            font-weight: 600; /* 글자 두께 */
            color: #495057; /* 헤더 텍스트 색상 */
        }
        
        .inquiry-table tr:last-child td {
            border-bottom: none; /* 마지막 행은 경계선 제거 */
        }
        
        .inquiry-table tr:hover {
            background-color: #f8f9fa; /* 호버 시 배경색 변경 */
        }
        
        /* 링크 스타일 */
        .inquiry-table a {
            color: #2c3e50; /* 링크 색상 */
            text-decoration: none; /* 밑줄 제거 */
            font-weight: 500; /* 글자 두께 */
            transition: color 0.3s ease; /* 색상 전환 효과 */
            display: block; /* 블록 요소로 설정 */
        }
        
        .inquiry-table a:hover {
            color: #007bff; /* 호버 시 색상 변경 */
        }
        
        /* 상태 뱃지 스타일 */
        .badge {
            display: inline-block;
            padding: 5px 8px; /* 내부 여백 */
            border-radius: 4px; /* 둥근 모서리 */
            font-size: 12px; /* 글자 크기 */
            font-weight: 500; /* 글자 두께 */
            text-align: center; /* 텍스트 중앙 정렬 */
        }
        
        .badge-waiting {
            background-color: #ffc107; /* 노란색 배경 */
            color: #212529; /* 어두운 텍스트 */
        }
        
        .badge-answered {
            background-color: #28a745; /* 녹색 배경 */
            color: white; /* 흰색 텍스트 */
        }
        
        /* 빈 메시지 스타일 */
        .empty-message {
            text-align: center; /* 텍스트 중앙 정렬 */
            padding: 40px 20px; /* 내부 여백 */
            background-color: #f9f9f9; /* 연한 회색 배경 */
            border-radius: 8px; /* 둥근 모서리 */
            color: #6c757d; /* 회색 텍스트 */
            font-size: 16px; /* 글자 크기 */
            margin: 20px 0; /* 상하 여백 */
        }
        
        .empty-message i {
            display: block; /* 블록 요소로 설정 */
            font-size: 48px; /* 아이콘 크기 */
            margin-bottom: 15px; /* 하단 여백 */
            color: #adb5bd; /* 아이콘 색상 */
        }
        
        /* 반응형 스타일 */
        @media (max-width: 768px) {
            .inquiry_container {
                padding: 20px; /* 작은 화면에서 여백 축소 */
            }
            
            .page-header {
                flex-direction: column; /* 세로 배치로 변경 */
                align-items: flex-start; /* 왼쪽 정렬 */
            }
            
            .new-inquiry-btn {
                margin-top: 15px; /* 상단 여백 추가 */
                width: 100%; /* 전체 너비 */
                text-align: center; /* 텍스트 중앙 정렬 */
            }
            
            .inquiry-table th, .inquiry-table td {
                padding: 10px; /* 셀 내부 여백 축소 */
            }
        }
    </style>
</head>
<body>
    <!-- 상단 메뉴 부분 - include로 불러옴 -->
    <div class="top">
        <c:import url="/WEB-INF/views/include/top_menu.jsp" /> 
    </div>

    <!-- 메인 컨테이너 - 전체 내용을 감싸는 영역 -->
    <div class="inquiry_container">
        <!-- 페이지 헤더 - 제목과 새 문의 작성 버튼이 있는 영역 -->
        <div class="page-header">
            <h1>내 문의 목록</h1>
            <a href="${root}/inquiry/inquiry_main" class="new-inquiry-btn">
                <i class="fas fa-plus"></i> 새 문의 작성
            </a>
        </div>
        
        <!-- 문의 목록 카드 -->
        <div class="card">
            <div class="card-header">
                <i class="fas fa-clipboard-list"></i> 나의 문의 내역
            </div>
            <div class="card-body">
                <!-- 문의 내역이 있는 경우 테이블 표시 -->
                <c:if test="${not empty myinquiry}">
                    <table class="inquiry-table">
                        <thead>
                            <tr>
                                <th style="width: 70%;">문의 제목</th>
                                <th style="width: 30%;">상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="inquiry" items="${myinquiry}">
                                <tr>
                                    <!-- 문의 제목에 링크 추가 -->
                                    <td>
                                        <a href="${root}/inquiry/inquiry_detail?inquiry_idx=${inquiry.inquiry_idx}">
                                            ${inquiry.inquiry_title}
                                        </a>
                                    </td>
                                    <!-- 답변 상태 표시 -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${inquiry.inquiry_read == '답변 대기중'}">
                                                <span class="badge badge-waiting">답변 대기중</span>
                                            </c:when>
                                            <c:when test="${inquiry.inquiry_read == '답변 완료'}">
                                                <span class="badge badge-answered">답변 완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                ${inquiry.inquiry_read}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                
                <!-- 문의 내역이 없는 경우 메시지 표시 -->
                <c:if test="${empty myinquiry}">
                    <div class="empty-message">
                        <i class="fas fa-inbox"></i>
                        현재 등록된 문의가 없습니다.
                        <p class="mt-2">궁금한 점이 있으시면 '새 문의 작성' 버튼을 클릭해주세요.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
<!-- 하단 정보 - include로 불러옴 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>