<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>클래스 예약 현황</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <style>
        .reservation-list {
            width: 900px;
            margin: 0 auto;
        }
        .class-info {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .reservation-table {
            width: 100%;
            border-collapse: collapse;
        }
        .reservation-table th, .reservation-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .reservation-table th {
            background-color: #f5f5f5;
        }
        .status-badges {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }
        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 3px;
            font-size: 12px;
            margin-right: 5px;
        }
        .status-badge.confirmed {
            background-color: #28a745;
            color: white;
        }
        .status-badge.cancelled {
            background-color: #dc3545;
            color: white;
        }
        .status-badge.attended {
            background-color: #007bff;
            color: white;
        }
        .status-badge.no-show {
            background-color: #6c757d;
            color: white;
        }
        .status-select {
            padding: 5px;
            border-radius: 3px;
        } 
    </style>
</head>
<body>
    <div class="container">
        <div class="reservation-list">
            <h2>클래스 예약 현황</h2>
            
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>
            
            <div class="class-info">
                <h3>${oneday.oneday_name}</h3>
                <p>
                    <fmt:formatDate value="${oneday.oneday_date}" pattern="yyyy년 MM월 dd일"/>
                    ${oneday.oneday_start} ~ ${oneday.oneday_end} | ${oneday.oneday_location}
                </p>
                <p>
                    <strong>예약 현황:</strong> ${oneday.current_participants} / ${oneday.oneday_personnel}명
                    <c:if test="${oneday.available}">
                        <span class="status-badge confirmed">예약가능</span>
                    </c:if>
                    <c:if test="${!oneday.available}">
                        <span class="status-badge cancelled">마감</span>
                    </c:if>
                </p>
                
                <div class="status-badges">
                    <div>
                        <span class="status-badge confirmed">확정</span>: 
                        <span id="confirmedCount">0</span>명
                    </div>
                    <div>
                        <span class="status-badge attended">참석</span>: 
                        <span id="attendedCount">0</span>명
                    </div>
                    <div>
                        <span class="status-badge no-show">노쇼</span>: 
                        <span id="noShowCount">0</span>명
                    </div>
                    <div>
                        <span class="status-badge cancelled">취소</span>: 
                        <span id="cancelledCount">0</span>명
                    </div>
                </div>
            </div>
            
            <c:if test="${empty reservationList}">
                <p class="no-data">예약 내역이 없습니다.</p>
            </c:if>
            
            <c:if test="${not empty reservationList}">
                <table class="reservation-table">
                    <thead>
                        <tr>
                            <th>예약번호</th>
                            <th>예약자</th>
                            <th>연락처</th>
                            <th>인원</th>
                            <th>예약일시</th>
                            <th>상태</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="reservation" items="${reservationList}">
                            <tr data-status="${reservation.reservation_status}">
                                <td>${reservation.reservation_index}</td>
                                <td>${reservation.member_name}</td>
                                <td>${reservation.member_tel}</td>
                                <td>${reservation.participant_count}명</td>
                                <td>
                                    <fmt:formatDate value="${reservation.reservation_date}" pattern="yyyy-MM-dd HH:mm"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${reservation.reservation_status eq 'CONFIRMED'}">
                                            <span class="status-badge confirmed">확정</span>
                                        </c:when>
                                        <c:when test="${reservation.reservation_status eq 'ATTENDED'}">
                                            <span class="status-badge attended">참석</span>
                                        </c:when>
                                        <c:when test="${reservation.reservation_status eq 'NO_SHOW'}">
                                            <span class="status-badge no-show">노쇼</span>
                                        </c:when>
                                        <c:when test="${reservation.reservation_status eq 'CANCELLED'}">
                                            <span class="status-badge cancelled">취소</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${reservation.reservation_status ne 'CANCELLED'}">
                                        <form action="<c:url value='/reservation/class/update-status'/>" method="post" style="display: inline;">
                                            <input type="hidden" name="reservation_index" value="${reservation.reservation_index}">
                                            <input type="hidden" name="oneday_index" value="${oneday.oneday_index}">
                                            <select name="status" class="status-select" onchange="this.form.submit()">
                                                <option value="">상태 변경</option>
                                                <option value="CONFIRMED" <c:if test="${reservation.reservation_status eq 'CONFIRMED'}">disabled</c:if>>확정</option>
                                                <option value="ATTENDED" <c:if test="${reservation.reservation_status eq 'ATTENDED'}">disabled</c:if>>참석</option>
                                                <option value="NO_SHOW" <c:if test="${reservation.reservation_status eq 'NO_SHOW'}">disabled</c:if>>노쇼</option>
                                                <option value="CANCELLED" <c:if test="${reservation.reservation_status eq 'CANCELLED'}">disabled</c:if>>취소</option>
                                            </select>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            
            <div class="button-container" style="margin-top: 20px;">
                <a href="<c:url value='/oneday/my-classes'/>" class="btn">내 클래스 목록</a>
                <a href="<c:url value='/oneday/detail/${oneday.oneday_index}'/>" class="btn">클래스 상세</a>
            </div>
        </div>
    </div>
    
    <script>
        // 예약 상태별 카운트 업데이트
        document.addEventListener('DOMContentLoaded', function() {
            var confirmedCount = 0;
            var attendedCount = 0;
            var noShowCount = 0;
            var cancelledCount = 0;
            
            var rows = document.querySelectorAll('tr[data-status]');
            rows.forEach(function(row) {
                var status = row.getAttribute('data-status');
                var participantCount = parseInt(row.cells[3].textContent);
                
                if (status === 'CONFIRMED') {
                    confirmedCount += participantCount;
                } else if (status === 'ATTENDED') {
                    attendedCount += participantCount;
                } else if (status === 'NO_SHOW') {
                    noShowCount += participantCount;
                } else if (status === 'CANCELLED') {
                    cancelledCount += participantCount;
                }
            });
            
            document.getElementById('confirmedCount').textContent = confirmedCount;
            document.getElementById('attendedCount').textContent = attendedCount;
            document.getElementById('noShowCount').textContent = noShowCount;
            document.getElementById('cancelledCount').textContent = cancelledCount;
        });
    </script>
</body>
</html>