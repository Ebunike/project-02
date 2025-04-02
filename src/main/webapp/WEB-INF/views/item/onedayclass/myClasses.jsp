<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 클래스 관리</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <style>
        .class-management .status {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 12px;
        }
        .class-management .status.upcoming {
            background-color: #28a745;
            color: white;
        }
        .class-management .status.ongoing {
            background-color: #007bff;
            color: white;
        }
        .class-management .status.completed {
            background-color: #6c757d;
            color: white;
        }
        .class-management .status.full {
            background-color: #dc3545;
            color: white;
        }
        .class-management .class-actions {
            display: flex;
            gap: 5px;
        }
        .oneday-table {
            width: 100%;
            border-collapse: collapse;
        }
        .oneday-table th, .oneday-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .oneday-table th {
            background-color: #f5f5f5;
        }
        .oneday-table tr:hover {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="class-management">
            <h2>내 클래스 관리</h2>
            
            <div class="button-container">
                <a href="<c:url value='/oneday/register'/>" class="btn btn-primary">새 클래스 등록</a>
                <a href="<c:url value='/oneday/list'/>" class="btn">클래스 목록</a>
            </div>
            
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            
            <c:if test="${empty onedayList}">
                <p class="no-data">등록한 클래스가 없습니다.</p>
            </c:if>
            
            <c:if test="${not empty onedayList}">
                <table class="oneday-table">
                    <thead>
                        <tr>
                            <th>테마</th>
                            <th>클래스명</th>
                            <th>일시</th>
                            <th>장소</th>
                            <th>예약 현황</th>
                            <th>상태</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="oneday" items="${onedayList}">
                            <tr>
                                <td>${oneday.theme_name}</td>
                                <td>
                                    <a href="<c:url value='/oneday/detail/${oneday.oneday_index}'/>">${oneday.oneday_name}</a>
                                </td>
                                <td>
                                    <fmt:formatDate value="${oneday.oneday_date}" pattern="yyyy-MM-dd"/><br>
                                    ${oneday.oneday_start} ~ ${oneday.oneday_end}
                                </td>
                                <td>${oneday.oneday_location}</td>
                                <td>${oneday.current_participants} / ${oneday.oneday_personnel}명</td>
                                <td>
                                    <c:set var="now" value="<%= new java.util.Date() %>" />
                                    <c:choose>
                                        <c:when test="${oneday.oneday_date gt now}">
                                            <c:choose>
                                                <c:when test="${oneday.available}">
                                                    <span class="status upcoming">예약가능</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status full">마감</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${now lt endDateTime}">
                                                    <span class="status ongoing">진행중</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status completed">종료</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="class-actions">
                                        <a href="<c:url value='/oneday/edit/${oneday.oneday_index}'/>" class="btn btn-sm">수정</a>
                                        <a href="<c:url value='/reservation/class/${oneday.oneday_index}'/>" class="btn btn-sm">예약현황</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>
    
    <script>
        // 종료 시간 계산을 위한 함수
        function getEndDateTime(dateStr, endTimeStr) {
            var date = new Date(dateStr);
            var timeParts = endTimeStr.split(':');
            date.setHours(parseInt(timeParts[0]), parseInt(timeParts[1]), 0);
            return date;
        }
        
        // 각 클래스의 종료 시간 계산
        document.addEventListener('DOMContentLoaded', function() {
            var rows = document.querySelectorAll('.oneday-table tbody tr');
            rows.forEach(function(row) {
                var dateCell = row.cells[2];
                var dateText = dateCell.firstChild.textContent.trim();
                var timeText = dateCell.lastChild.textContent.trim();
                var endTime = timeText.split('~')[1].trim();
                
                // 종료 시간 정보를 데이터 속성으로 저장
                var endDateTime = getEndDateTime(dateText, endTime);
                row.setAttribute('data-end-time', endDateTime.getTime());
            });
        });
    </script>
</body>
</html>
 --%>
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 클래스 관리</title>
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
        
        h2 {
            text-align: center;
            font-size: 2.2rem;
            color: var(--primary-color);
            margin-bottom: 30px;
            position: relative;
            padding-bottom: 15px;
        }
        
        h2:after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            border-radius: 1.5px;
        }
        
        .class-management {
            background-color: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 30px;
            box-shadow: var(--shadow);
            margin-bottom: 20px;
            position: relative;
            overflow: hidden;
        }
        
        .button-container {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin: 30px 0;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 25px;
            border-radius: 50px;
            text-decoration: none;
            font-size: 16px;
            transition: var(--transition);
            cursor: pointer;
            border: none;
            text-align: center;
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
        
        .btn:not(.btn-primary):not(.btn-sm) {
            background: white;
            color: var(--text-color);
            border: 2px solid #e9e9e9;
        }
        
        .btn:not(.btn-primary):not(.btn-sm):hover {
            background: #f9f9f9;
            border-color: #ddd;
            transform: translateY(-3px);
        }
        
        .btn-sm {
            padding: 8px 15px;
            font-size: 14px;
            border-radius: 30px;
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: var(--border-radius);
            margin-bottom: 20px;
            font-weight: 500;
        }
        
        .alert-success {
            background-color: rgba(40, 167, 69, 0.15);
            color: #28a745;
            border-left: 4px solid #28a745;
        }
        
        .no-data {
            text-align: center;
            padding: 50px 20px;
            color: var(--text-light);
            font-size: 18px;
            background-color: rgba(0, 0, 0, 0.02);
            border-radius: var(--border-radius);
            margin: 20px 0;
        }
        
        .no-data:before {
            content: "\f119";
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            display: block;
            font-size: 48px;
            margin-bottom: 15px;
            color: var(--primary-color);
            opacity: 0.5;
        }
        
        /* 테이블 스타일 */
        .oneday-table-container {
            overflow-x: auto;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            margin: 20px 0;
        }
        
        .oneday-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background-color: white;
            overflow: hidden;
        }
        
        .oneday-table th {
            background-color: #f8f8f8;
            color: var(--text-color);
            font-weight: 600;
            text-align: left;
            padding: 16px;
            border-bottom: 2px solid #eaeaea;
        }
        
        .oneday-table td {
            padding: 16px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
            transition: background-color 0.2s ease;
        }
        
        .oneday-table tr:hover td {
            background-color: #f9f9f9;
        }
        
        .oneday-table tr:last-child td {
            border-bottom: none;
        }
        
        .oneday-table a {
            color: var(--primary-color);
            text-decoration: none;
            transition: var(--transition);
            font-weight: 500;
        }
        
        .oneday-table a:hover {
            color: var(--accent-color);
            text-decoration: underline;
        }
        
        /* 상태 배지 */
        .status {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 600;
            text-align: center;
            white-space: nowrap;
        }
        
        .status.upcoming {
            background-color: rgba(40, 167, 69, 0.15);
            color: #28a745;
        }
        
        .status.ongoing {
            background-color: rgba(0, 123, 255, 0.15);
            color: #007bff;
        }
        
        .status.completed {
            background-color: rgba(108, 117, 125, 0.15);
            color: #6c757d;
        }
        
        .status.full {
            background-color: rgba(220, 53, 69, 0.15);
            color: #dc3545;
        }
        
        /* 아이콘 추가 */
        .theme-cell::before {
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            margin-right: 8px;
            color: var(--primary-color);
        }
        
        .theme-food::before {
            content: "\f2e7";
        }
        
        .theme-beauty::before {
            content: "\f5fc";
        }
        
        .theme-fancy::before {
            content: "\f53f";
        }
        
        .theme-living::before {
            content: "\f4b8";
        }
        
        .theme-fashion::before {
            content: "\f553";
        }
        
        .class-actions {
            display: flex;
            gap: 8px;
        }
        
        .class-actions .btn-sm {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: var(--text-color);
            background-color: white;
            border: 1px solid #eaeaea;
            transition: all 0.2s ease;
        }
        
        .class-actions .btn-sm:hover {
            background-color: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
        
        .class-actions .btn-sm i {
            margin-right: 6px;
            font-size: 12px;
        }
        
        /* 반응형 테이블 */
        @media (max-width: 992px) {
            .oneday-table {
                min-width: 800px;
            }
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 0 15px;
            }
            
            .class-management {
                padding: 20px;
            }
            
            h2 {
                font-size: 1.8rem;
            }
            
            .button-container {
                flex-direction: column;
                max-width: 300px;
                margin: 30px auto;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="class-management">
            <h2>내 클래스 관리</h2>
            
            <div class="button-container">
                <a href="<c:url value='/oneday/register'/>" class="btn btn-primary">
                    <i class="fas fa-plus-circle"></i> 새 클래스 등록
                </a>
                <a href="<c:url value='/oneday/list'/>" class="btn">
                    <i class="fas fa-list"></i> 클래스 목록
                </a>
            </div>
            
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            
            <c:if test="${empty onedayList}">
                <p class="no-data">등록한 클래스가 없습니다.</p>
            </c:if>
            
            <c:if test="${not empty onedayList}">
                <div class="oneday-table-container">
                    <table class="oneday-table">
                        <thead>
                            <tr>
                                <th>테마</th>
                                <th>클래스명</th>
                                <th>일시</th>
                                <th>장소</th>
                                <th>예약 현황</th>
                                <th>상태</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="oneday" items="${onedayList}">
                                <tr>
                                    <td class="theme-cell theme-${oneday.theme_name.toLowerCase()}">${oneday.theme_name}</td>
                                    <td>
                                        <a href="<c:url value='/oneday/detail/${oneday.oneday_index}'/>">${oneday.oneday_name}</a>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${oneday.oneday_date}" pattern="yyyy-MM-dd"/><br>
                                        ${oneday.oneday_start} ~ ${oneday.oneday_end}
                                    </td>
                                    <td>${oneday.oneday_location}</td>
                                    <td>${oneday.current_participants} / ${oneday.oneday_personnel}명</td>
                                    <td>
                                        <c:set var="now" value="<%= new java.util.Date() %>" />
                                        <c:choose>
                                            <c:when test="${oneday.oneday_date gt now}">
                                                <c:choose>
                                                    <c:when test="${oneday.available}">
                                                        <span class="status upcoming">예약가능</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status full">마감</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${now lt endDateTime}">
                                                        <span class="status ongoing">진행중</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status completed">종료</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="class-actions">
                                            <a href="<c:url value='/oneday/edit/${oneday.oneday_index}'/>" class="btn btn-sm">
                                                <i class="fas fa-edit"></i> 수정
                                            </a>
                                            <a href="<c:url value='/reservation/class/${oneday.oneday_index}'/>" class="btn btn-sm">
                                                <i class="fas fa-users"></i> 예약현황
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
    
    <script>
        // 종료 시간 계산을 위한 함수
        function getEndDateTime(dateStr, endTimeStr) {
            var date = new Date(dateStr);
            var timeParts = endTimeStr.split(':');
            date.setHours(parseInt(timeParts[0]), parseInt(timeParts[1]), 0);
            return date;
        }
        
        // 각 클래스의 종료 시간 계산
        document.addEventListener('DOMContentLoaded', function() {
            var rows = document.querySelectorAll('.oneday-table tbody tr');
            rows.forEach(function(row) {
                var dateCell = row.cells[2];
                var dateText = dateCell.firstChild.textContent.trim();
                var timeText = dateCell.lastChild.textContent.trim();
                var endTime = timeText.split('~')[1].trim();
                
                // 종료 시간 정보를 데이터 속성으로 저장
                var endDateTime = getEndDateTime(dateText, endTime);
                row.setAttribute('data-end-time', endDateTime.getTime());
            });
        });
    </script>
</body>
</html>