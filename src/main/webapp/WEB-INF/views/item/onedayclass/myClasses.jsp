<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
