<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 상세 정보</title>
    
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
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            padding-top: 20px;
        }
        
        /* 전체 컨테이너 스타일 */
        .info_container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
            padding: 30px;
            margin-bottom: 40px;
            max-width: 800px;
            margin: 0 auto 40px;
            border: 2px solid black;
        }
        
        /* 페이지 헤더 스타일 */
        .page-header {
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .page-header h1 {
            font-size: 28px;
            font-weight: 600;
            color: #2c3e50;
            margin: 0;
        }
        
        /* 버튼 스타일 */
        .btn-custom {
            display: inline-block;
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.3s ease;
            margin-right: 10px;
        }
        
        .btn-custom:hover {
            background-color: #0069d9;
            text-decoration: none;
            color: white;
        }
        
        .btn-danger {
            background-color: #dc3545;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
        }
        
        .btn-custom i {
            margin-right: 5px;
        }
        
        /* 카드 스타일 */
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
        }
        
        /* 카드 헤더 스타일 */
        .card-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #eee;
            padding: 15px 20px;
            font-size: 18px;
            font-weight: 500;
            color: #2c3e50;
            border-radius: 10px 10px 0 0 !important;
        }
        
        .card-header i {
            margin-right: 10px;
            color: #007bff;
        }
        
        /* 테이블 스타일 */
        .table {
            margin-bottom: 0;
        }
        
        .table th {
            background-color: #f0f7ff;
            color: #2c3e50;
            font-weight: 500;
            border-top: none;
            padding: 12px 15px;
            width: 30%;
        }
        
        .table td {
            padding: 12px 15px;
            vertical-align: middle;
            border-color: #eee;
        }
        
        /* 버튼 그룹 스타일 */
        .button-group {
            text-align: center;
            margin-top: 20px;
        }
        
        /* 키워드 스타일 */
        .keyword-item {
            display: inline-block;
            background-color: #e9ecef;
            color: #495057;
            padding: 5px 10px;
            border-radius: 15px;
            margin: 3px;
            font-size: 14px;
        }
        
        /* 반응형 스타일 */
        @media (max-width: 768px) {
            .info_container {
                padding: 20px;
            }
            
            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .button-group {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }
            
            .btn-custom {
                margin: 5px 0;
                width: 100%;
                text-align: center;
            }
            
            .table th, .table td {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
	<div class="side">
        <c:import url="/WEB-INF/views/include/admin_side.jsp" />
    </div>
    <!-- 메인 컨테이너 - 전체 내용을 감싸는 영역 -->
    <div class="info_container">
        <!-- 페이지 헤더 - 제목을 표시하는 영역 -->
        <div class="page-header">
            <h1>회원 상세 정보</h1>
        </div>
        
        <!-- 회원 정보 카드 -->
        <div class="card">
            <div class="card-header">
                <i class="fas fa-user"></i> ${memberInfo.name}님의 정보
            </div>
            <div class="card-body p-0">
                <table class="table">
                    <tbody>
                        <tr>
                            <th>아이디</th>
                            <td>${memberInfo.id}</td>
                        </tr>
                        <tr>
                            <th>이름</th>
                            <td>${memberInfo.name}</td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td>${memberInfo.email}</td>
                        </tr>
                        <tr>
                            <th>전화번호</th>
                            <td>${memberInfo.tel}</td>
                        </tr>
                        <tr>
                            <th>나이</th>
                            <td>${memberInfo.age}</td>
                        </tr>
                        <tr>
                            <th>성별</th>
                            <td>${memberInfo.gender}</td>
                        </tr>
                        <tr>
                            <th>주소</th>
                            <td>${memberInfo.address}</td>
                        </tr>
                        <tr>
                            <th>관심 키워드</th>
                            <td>
                                <c:forEach var="keyword" items="${memberInfo.keyword}">
                                    <span class="keyword-item">${keyword}</span>
                                </c:forEach>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- 버튼 그룹 -->
        <div class="button-group">
            <a href="${root}/admin/delete?id=${memberInfo.id}" class="btn-custom btn-danger">
                <i class="fas fa-user-times"></i> 회원 제명하기
            </a>
            <a href="${root}/admin/management" class="btn-custom">
                <i class="fas fa-arrow-left"></i> 회원 목록으로 돌아가기
            </a>
        </div>
    </div>

    <!-- 게시판 하단 부분 -->	
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>