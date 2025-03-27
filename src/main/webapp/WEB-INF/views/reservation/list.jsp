<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 예약 내역</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <style>
        .reservation-history {
            width: 900px;
            margin: 0 auto;
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
        .reservation-table tr:hover {
            background-color: #f9f9f9;
        }
        .status-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 12px;
        }
        .status-badge.confirmed {
            background-color: #28a745;
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
        .status-badge.cancelled {
            background-color: #dc3545;
            color: white;
        }
        .reservation-tabs {
            display: flex;
            margin-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }
        .reservation-tabs a {
            padding: 10px 20px;
            text-decoration: none;
            color: #333;
        }
        .reservation-tabs a.active {
            border-bottom: 2px solid #007bff;
            font-weight: bold;
            color: #007bff;
        }
        .class-title {
            font-weight: bold;
            display: block;
        }
        .class-date {
            font-size: 12px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="reservation-history">
            <h2>내 예약 내역</h2>
            
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            
            <div class="reservation-tabs">
                <a href="#" class="active" data-status="all">전체</a>
                <a href="#" data-status="upcoming">예정된 클래스</a>
                <a href="#" data-status="past">지난 클래스</a>
                <a href="#" data-status="cancelled">취소된 예약</a>
            </div>
            
            <c:if test="${empty reservationList}">
                <p class="no-data">예약 내역이 없습니다.</p>
            </c:if>
            
            <c:if test="${not empty reservationList}">
                <table class="reservation-table">
                    <thead>
                        <tr>
                            <th>클래스 정보</th>
                            <th>예약 번호</th>
                            <th>예약 일시</th>
                            <th>인원</th>
                            <th>상태</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="now" value="<%= new java.util.Date() %>" />
                        <c:forEach var="reservation" items="${reservationList}">
                            <tr class="reservation-row" 
                                data-status="${reservation.reservation_status}" 
                                data-date="${reservation.oneday_date.time}">
                                <td>
                                    <span class="class-title">${reservation.oneday_name}</span>
                                    <span class="class-date">
                                        <fmt:formatDate value="${reservation.oneday_date}" pattern="yyyy-MM-dd"/> 
                                        ${reservation.oneday_start} ~ ${reservation.oneday_end}
                                    </span>
                                    <div>${reservation.oneday_location}</div>
                                </td>
                                <td>${reservation.reservation_index}</td>
                                <td>
                                    <fmt:formatDate value="${reservation.reservation_date}" pattern="yyyy-MM-dd HH:mm"/>
                                </td>
                                <td>${reservation.participant_count}명</td>
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
                                    <a href="<c:url value='/reservation/detail/${reservation.reservation_index}'/>" class="btn btn-sm">상세</a>
                                    
                                    <c:if test="${reservation.reservation_status eq 'CONFIRMED' && reservation.oneday_date gt now}">
                                        <button class="btn btn-sm btn-danger" 
                                                onclick="confirmCancel(${reservation.reservation_index})">취소</button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            
            <div class="button-container" style="margin-top: 20px;">
                <a href="<c:url value='/oneday/list'/>" class="btn">클래스 목록</a>
                <a href="<c:url value='/mypage'/>" class="btn">마이페이지</a>
            </div>
        </div>
    </div>
    
    <script>
        // 예약 취소 확인
        function confirmCancel(reservationIndex) {
            if (confirm('예약을 취소하시겠습니까?\n취소 정책에 따라 환불 금액이 달라질 수 있습니다.')) {
                // 취소 폼 생성 및 제출
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<c:url value="/reservation/cancel/"/>' + reservationIndex;
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // 탭 필터링
        document.addEventListener('DOMContentLoaded', function() {
            const tabs = document.querySelectorAll('.reservation-tabs a');
            const rows = document.querySelectorAll('.reservation-row');
            const now = new Date().getTime();
            
            tabs.forEach(tab => {
                tab.addEventListener('click', function(e) {
                    e.preventDefault();
                    
                    // 탭 활성화
                    tabs.forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                    
                    const status = this.getAttribute('data-status');
                    
                    // 필터링
                    rows.forEach(row => {
                        const rowStatus = row.getAttribute('data-status');
                        const rowDate = parseInt(row.getAttribute('data-date'));
                        
                        if (status === 'all') {
                            row.style.display = '';
                        } else if (status === 'upcoming') {
                            if (rowStatus !== 'CANCELLED' && rowDate > now) {
                                row.style.display = '';
                            } else {
                                row.style.display = 'none';
                            }
                        } else if (status === 'past') {
                            if (rowStatus !== 'CANCELLED' && rowDate <= now) {
                                row.style.display = '';
                            } else {
                                row.style.display = 'none';
                            }
                        } else if (status === 'cancelled') {
                            if (rowStatus === 'CANCELLED') {
                                row.style.display = '';
                            } else {
                                row.style.display = 'none';
                            }
                        }
                    });
                });
            });
        });
    </script>
</body>
</html>
