<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko"> 
<head> 
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멤버 관리</title>
    
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
            margin-bottom: 50px;
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
        .table th, td {
        	text-align: center;
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
        
        /* 회원 아이디 링크 스타일 */
        .member-link {
            color: #007bff; /* 파란색 링크 */
            text-decoration: none; /* 밑줄 제거 */
            font-weight: 500; /* 글자 두께 */
            transition: color 0.3s ease; /* 색상 전환 효과 */
        }
        
        .member-link:hover {
            color: #0056b3; /* 호버 시 어두운 파란색 */
            text-decoration: underline; /* 밑줄 추가 */
        }
        
        /* 검색 폼 스타일 */
        .search-form {
            margin-bottom: 20px; /* 하단 여백 */
            display: flex; /* 플렉스 레이아웃 */
            justify-content: flex-end; /* 오른쪽 정렬 */
        }
        
        .search-form .form-control {
            width: 250px; /* 입력란 너비 */
            border-radius: 5px 0 0 5px; /* 왼쪽 모서리만 둥글게 */
            border-right: none; /* 오른쪽 테두리 제거 */
        }
        
        .search-form .btn {
            border-radius: 0 5px 5px 0; /* 오른쪽 모서리만 둥글게 */
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
            
            .search-form {
                justify-content: flex-start; /* 왼쪽 정렬 */
                margin-top: 15px; /* 상단 여백 추가 */
            }
            
            .search-form .form-control {
                width: 100%; /* 전체 너비 */
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
            <h1>회원 목록</h1>
            <a href="${root}/admin/adminmain" class="back-button">
                <i class="fas fa-arrow-left"></i> 관리자 페이지로 돌아가기
            </a>
        </div>
        
        <!-- 회원 목록 카드 -->
        <div class="card">
            <div class="card-header">
                <i class="fas fa-users"></i> 등록된 회원 목록
            </div>
            <div class="card-body p-0">
                <!-- 검색 폼 (기능이 필요하면 추가) -->
                <!--
                <div class="search-form p-3">
                    <form class="form-inline ml-auto">
                        <input type="text" class="form-control" placeholder="회원 검색...">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
                    </form>
                </div>
                -->
                
                <!-- 회원 목록 테이블 -->
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>이름</th>
                            <th>아이디</th>
                            <th>주소</th>
                            <th>연락처</th>
                            <th>성별</th>
                            <th>이메일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 회원 정보가 있는지 확인하는 변수 -->
                        <!-- 회원 목록을 순회하며 표시 -->
<c:set var="hasMembers" value="false" />
<c:forEach var="member" items="${allMember}">
    <!-- 'admin' 아이디를 가진 회원은 제외 -->
    <c:if test="${member.id != 'admin'}">
        <c:set var="hasMembers" value="true" />
        <tr>
            <td>${member.name}</td>
            <td>
                <a href="${root}/admin/memberinfo?id=${member.id}" class="member-link">
                    ${member.id}
                </a>
            </td>
            <td>${member.address}</td>
            <td>${member.tel}</td>
            <td>${member.gender}</td>
            <td>${member.email}</td>
        </tr>
    </c:if>
</c:forEach>
                        
                        <!-- 회원 정보가 없는 경우 메시지 표시 -->
                        <c:if test="${!hasMembers}">
                            <tr>
                                <td colspan="3" class="empty-message">등록된 회원이 없습니다.</td>
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