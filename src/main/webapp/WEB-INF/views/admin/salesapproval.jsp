<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매자 승인 관리</title>
    
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- Google Fonts -->
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
        .management_container {
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
        
        /* 테이블 스타일 */
        .table {
            margin-bottom: 0; /* 하단 여백 제거 */
        }
        
        .table th, .table td {
            text-align: center; /* 텍스트 가운데 정렬 */
        }
        
        .table th {
            background-color: #f0f7ff; /* 연한 파란색 배경 */
            color: #2c3e50; /* 진한 텍스트 색상 */
            font-weight: 700; /* 글자 두께 */
            border-top: none; /* 상단 테두리 제거 */
            padding: 12px 15px; /* 내부 여백 */
        }
        
        .table td {
            padding: 12px 15px; /* 내부 여백 */
            vertical-align: middle; /* 수직 중앙 정렬 */
            border-color: #eee; /* 경계선 색상 */
        }
        
        .table-hover tbody tr:hover {
            background-color: #f8f9fa; /* 호버 시 배경색 */
        }
        
        /* 버튼 스타일 */
        .btn {
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 4px;
            margin-right: 5px;
            transition: all 0.3s ease;
        }
        
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        
        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        
        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }
        
        /* 승인 상태 뱃지 */
        .badge {
            padding: 5px 10px;
            font-size: 12px;
            font-weight: 500;
            border-radius: 30px;
        }
        
        .badge-warning {
            background-color: #ffc107;
            color: #212529;
        }
        
        .badge-success {
            background-color: #28a745;
            color: white;
        }
        
        /* 빈 메시지 스타일 */
        .empty-message {
            text-align: center; /* 가운데 정렬 */
            padding: 30px; /* 내부 여백 */
            color: #6c757d; /* 회색 텍스트 */
            font-style: italic; /* 이탤릭체 */
        }
        
        /* 반응형 스타일 - 작은 화면에 대응 */
        @media (max-width: 768px) {
            .management_container {
                padding: 20px; /* 작은 화면에서 여백 축소 */
            }
            
            .page-header {
                flex-direction: column; /* 세로 배치로 변경 */
                align-items: flex-start; /* 왼쪽 정렬 */
            }
            
            .back-button {
                margin-top: 15px; /* 상단 여백 추가 */
            }
            
            .btn {
                padding: 4px 8px; /* 더 작은 패딩 */
                font-size: 12px; /* 더 작은 글자 크기 */
            }
        }
    </style>
</head>
<body>
    <div class="side">
        <c:import url="/WEB-INF/views/include/admin_side.jsp" />
    </div>
    
    <!-- 메인 컨테이너 - 전체 내용을 감싸는 영역 -->
    <div class="management_container">
        <!-- 페이지 헤더 - 제목과 돌아가기 버튼이 있는 영역 -->
        <div class="page-header">
            <h1>판매자 승인 관리</h1>
            <a href="${root}/admin/adminmain" class="back-button">
                <i class="fas fa-arrow-left"></i> 관리자 페이지로 돌아가기
            </a>
        </div>
        
        <!-- 승인 대기 중인 판매자 목록 카드 -->
        <div class="card">
            <div class="card-header">
                <i class="fas fa-clock"></i> 승인 대기 중인 판매자
            </div>
            <div class="card-body p-0">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>아이디</th>
                            <th>상호명</th>
                            <th>사업자 등록번호</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="sellerAwaiter" items="${sellerAwaiterBean}">
                            <tr>
                                <td>${sellerAwaiter.id}</td>
                                <td>${sellerAwaiter.company_name}</td>
                                <td>${sellerAwaiter.company_num}</td>
                                <td>
                                    <span class="badge badge-warning">승인 대기 중</span>
                                    <a href="${root}/admin/salesapproval_pro?result=o&sellerId=${sellerAwaiter.id}" class="btn btn-success btn-sm">
                                        <i class="fas fa-check"></i> 승인
                                    </a>
                                    <a href="${root}/admin/salesapproval_pro?result=x&sellerId=${sellerAwaiter.id}" class="btn btn-danger btn-sm">
                                        <i class="fas fa-times"></i> 거부
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <!-- 승인 대기 중인 판매자가 없는 경우 메시지 표시 -->
                        <c:if test="${empty sellerAwaiterBean}">
                            <tr>
                                <td colspan="4" class="empty-message">승인 대기 중인 판매자가 없습니다.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- 승인된 판매자 목록 카드 -->
        <div class="card">
            <div class="card-header">
                <i class="fas fa-check-circle"></i> 승인된 판매자
            </div>
            <div class="card-body p-0">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>아이디</th>
                            <th>상호명</th>
                            <th>사업자 등록번호</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="seller" items="${sellerBean}">
                            <tr>
                                <td>${seller.id}</td>
                                <td>${seller.company_name}</td>
                                <td>${seller.company_num}</td>
                                <td><span class="badge badge-success">승인됨</span></td>
                            </tr>
                        </c:forEach>
                        <!-- 승인된 판매자가 없는 경우 메시지 표시 -->
                        <c:if test="${empty sellerBean}">
                            <tr>
                                <td colspan="4" class="empty-message">승인된 판매자가 없습니다.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- 게시판 하단 부분 - 공통 푸터 포함 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>