<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${oneday.oneday_name} - 원데이 클래스</title>
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
        
        .oneday-detail {
            background-color: var(--card-bg);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            margin-bottom: 30px;
        }
        
        .oneday-header {
            background: linear-gradient(120deg, var(--primary-color), var(--accent-color));
            color: white;
            padding: 30px 40px;
            position: relative;
        }
        
        .oneday-header h2 {
            font-size: 2.2rem;
            margin-bottom: 10px;
            font-weight: 700;
        }
        
        .oneday-theme {
            display: inline-block;
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 6px 15px;
            border-radius: 30px;
            font-size: 0.9rem;
            font-weight: 600;
        }
        
        .oneday-content {
            display: flex;
            flex-wrap: wrap;
            padding: 30px;
        }
        
        .oneday-image {
            flex: 1;
            min-width: 300px;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            margin-right: 30px;
            height: 400px;
        }
        
        .oneday-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.8s ease;
        }
        
        .oneday-image:hover img {
            transform: scale(1.03);
        }
        
        .oneday-info-box {
            flex: 1;
            min-width: 300px;
            padding: 20px;
        }
        
        .oneday-info-box dl {
            margin-bottom: 30px;
        }
        
        .oneday-info-box dt {
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--primary-color);
            font-size: 1.05rem;
            display: flex;
            align-items: center;
        }
        
        .oneday-info-box dt::before {
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            margin-right: 10px;
            font-size: 1.1rem;
            width: 20px;
            text-align: center;
        }
        
        .oneday-info-box dt:nth-of-type(1)::before {
            content: "\f073"; /* Calendar icon */
        }
        
        .oneday-info-box dt:nth-of-type(2)::before {
            content: "\f3c5"; /* Location icon */
        }
        
        .oneday-info-box dt:nth-of-type(3)::before {
            content: "\f007"; /* User icon */
        }
        
        .oneday-info-box dt:nth-of-type(4)::before {
            content: "\f53a"; /* Money check icon */
        }
        
        .oneday-info-box dt:nth-of-type(5)::before {
            content: "\f500"; /* User group icon */
        }
        
        .oneday-info-box dd {
            margin-left: 30px;
            margin-bottom: 20px;
            font-size: 1.1rem;
            color: var(--text-color);
        }
        
        .status {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-left: 10px;
        }
        
        .available {
            background-color: rgba(26, 93, 26, 0.15);
            color: var(--secondary-color);
        }
        
        .full {
            background-color: rgba(231, 76, 60, 0.15);
            color: #e74c3c;
        }
        
        .oneday-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 25px;
            border-radius: 50px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 600;
            transition: var(--transition);
            cursor: pointer;
            text-align: center;
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
        
        .btn:not(.btn-primary):not(.btn-disabled) {
            background: white;
            color: var(--text-color);
            border: 2px solid #e9e9e9;
        }
        
        .btn:not(.btn-primary):not(.btn-disabled):hover {
            background: #f9f9f9;
            border-color: #ddd;
            transform: translateY(-3px);
        }
        
        .btn-disabled {
            background: #e0e0e0;
            color: #888;
            cursor: not-allowed;
        }
        
        .oneday-description {
            padding: 30px;
            border-top: 1px solid #eaeaea;
        }
        
        .oneday-description h3 {
            font-size: 1.5rem;
            margin-bottom: 20px;
            color: var(--primary-color);
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .oneday-info-content {
            background-color: #f9f9f9;
            padding: 25px;
            border-radius: var(--border-radius);
            margin-bottom: 20px;
            white-space: pre-wrap;
            line-height: 1.8;
        }
        
        .oneday-management {
            padding: 30px;
            background-color: #f9f9f9;
            border-top: 1px solid #eaeaea;
        }
        
        .oneday-management h3 {
            font-size: 1.5rem;
            margin-bottom: 20px;
            color: var(--primary-color);
        }
        
        .management-buttons {
            display: flex;
            gap: 15px;
        }
        
        /* 반응형 디자인 */
        @media (max-width: 992px) {
            .oneday-content {
                flex-direction: column;
            }
            
            .oneday-image {
                margin-right: 0;
                margin-bottom: 30px;
                max-height: 350px;
            }
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 0 15px;
                margin: 20px auto;
            }
            
            .oneday-header {
                padding: 25px;
            }
            
            .oneday-header h2 {
                font-size: 1.8rem;
            }
            
            .oneday-content, 
            .oneday-description, 
            .oneday-management {
                padding: 20px;
            }
            
            .oneday-buttons {
                flex-direction: column;
                max-width: 300px;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="oneday-detail">
            <div class="oneday-header">
                <h2>${oneday.oneday_name}</h2>
                <p class="oneday-theme">${oneday.theme_name}</p>
            </div>
            
            <div class="oneday-content">
                <div class="oneday-image">
                    <img src="<c:url value='/resources/images/oneday/${oneday.oneday_imageUrl}'/>" 
                         alt="${oneday.oneday_name}" onerror="this.src='<c:url value='/resources/images/default.jpg'/>'">
                </div>
                
                <div class="oneday-info-box">
                    <dl>
                        <dt>일시</dt>
                        <dd>
                            <fmt:formatDate value="${oneday.oneday_date}" pattern="yyyy년 MM월 dd일"/>
                            ${oneday.oneday_start} ~ ${oneday.oneday_end}
                        </dd>
                        
                        <dt>장소</dt>
                        <dd>${oneday.oneday_location}</dd>
                        
                        <dt>강사</dt>
                        <dd>${oneday.seller_name}</dd>
                        
                        <dt>수강료</dt>
                        <dd><fmt:formatNumber value="${oneday.oneday_price}" pattern="#,###"/>원</dd>
                        
                        <dt>정원</dt>
                        <dd>
                            ${oneday.current_participants} / ${oneday.oneday_personnel}명
                            <c:if test="${oneday.available}">
                                <span class="status available">예약가능</span>
                            </c:if>
                            <c:if test="${!oneday.available}">
                                <span class="status full">마감</span>
                            </c:if>
                        </dd>
                    </dl>
                    
                    <div class="oneday-buttons">
                        <c:if test="${not empty loginMember}">
                            <c:if test="${oneday.available}">
                                <c:choose>
                                    <c:when test="${isNaverCalendarConnected}">
                                        <a href="<c:url value='/reservation/form/${oneday.oneday_index}'/>" class="btn btn-primary">
                                            <i class="fas fa-calendar-check"></i> 예약하기
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="<c:url value='/naver-calendar/auth'/>" class="btn btn-primary" 
                                           onclick="sessionStorage.setItem('calendarRedirectUrl', '/reservation/form/${oneday.oneday_index}')">
                                            <i class="fas fa-calendar-plus"></i> 네이버 캘린더 연동 후 예약하기
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <c:if test="${!oneday.available}">
                                <button class="btn btn-disabled" disabled><i class="fas fa-ban"></i> 예약마감</button>
                            </c:if>
                        </c:if>
                        <c:if test="${empty loginMember}">
                            <a href="<c:url value='/member/login'/>" class="btn btn-primary">
                                <i class="fas fa-sign-in-alt"></i> 로그인 후 예약하기
                            </a>
                        </c:if>
                        
                        <a href="<c:url value='/oneday/list'/>" class="btn">
                            <i class="fas fa-list"></i> 목록으로
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="oneday-description">
                <h3><i class="fas fa-info-circle"></i> 클래스 소개</h3>
                <div class="oneday-info-content">
                    <pre>${oneday.oneday_info}</pre>
                </div>
            </div>
            
            <c:if test="${oneday.seller_index eq seller_index}">
                <div class="oneday-management">
                    <h3><i class="fas fa-cog"></i> 클래스 관리</h3>
                    <div class="management-buttons">
                        <a href="<c:url value='/oneday/edit/${oneday.oneday_index}'/>" class="btn">
                            <i class="fas fa-edit"></i> 클래스 수정
                        </a>
                        <a href="<c:url value='/reservation/class/${oneday.oneday_index}'/>" class="btn">
                            <i class="fas fa-users"></i> 예약 현황
                        </a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
    
    <script>
        // 네이버 캘린더 리다이렉트 URL 저장
        if (sessionStorage.getItem('calendarRedirectUrl')) {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', '<c:url value="/api/set-calendar-redirect"/>'
                + '?url=' + sessionStorage.getItem('calendarRedirectUrl'), true);
            xhr.send();
            sessionStorage.removeItem('calendarRedirectUrl');
        }
    </script>
</body>
</html>