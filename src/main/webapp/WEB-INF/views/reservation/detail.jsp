<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>예약 상세 정보</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <style>
        .reservation-detail {
            width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .class-info {
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        .info-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .info-table th, .info-table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .info-table th {
            width: 140px;
            color: #666;
        }
        .status-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 12px;
            margin-left: 10px;
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
        .cancel-policy {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
            font-size: 14px;
            margin-top: 20px;
        }
        .naver-calendar-link {
            display: block;
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #1EC800;
            color: white;
            text-decoration: none;
            text-align: center;
            border-radius: 5px;
        }
        .naver-calendar-link:hover {
            background-color: #17a300;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="reservation-detail">
            <h2>예약 상세 정보</h2>
            
            <div class="class-info">
                <h3>${reservation.oneday_name}</h3>
                <p class="class-theme">${reservation.theme_name}</p>
            </div>
            
            <table class="info-table">
                <tr>
                    <th>예약 번호</th>
                    <td>${reservation.reservation_index}</td>
                </tr>
                <tr>
                    <th>예약 상태</th>
                    <td>
                        <c:choose>
                            <c:when test="${reservation.reservation_status eq 'CONFIRMED'}">
                                확정<span class="status-badge confirmed">확정</span>
                            </c:when>
                            <c:when test="${reservation.reservation_status eq 'ATTENDED'}">
                                참석<span class="status-badge attended">참석</span>
                            </c:when>
                            <c:when test="${reservation.reservation_status eq 'NO_SHOW'}">
                                노쇼<span class="status-badge no-show">노쇼</span>
                            </c:when>
                            <c:when test="${reservation.reservation_status eq 'CANCELLED'}">
                                취소<span class="status-badge cancelled">취소</span>
                            </c:when>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>예약자</th>
                    <td>${reservation.member_name}</td>
                </tr>
                <tr>
                    <th>연락처</th>
                    <td>${reservation.member_tel}</td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td>${reservation.member_email}</td>
                </tr>
                <tr>
                    <th>수업일</th>
                    <td><fmt:formatDate value="${reservation.oneday_date}" pattern="yyyy년 MM월 dd일"/></td>
                </tr>
                <tr>
                    <th>수업 시간</th>
                    <td>${reservation.oneday_start} ~ ${reservation.oneday_end}</td>
                </tr>
                <tr>
                    <th>수업 장소</th>
                    <td>${reservation.oneday_location}</td>
                </tr>
                <tr>
                    <th>예약 인원</th>
                    <td>${reservation.participant_count}명</td>
                </tr>
                <tr>
                    <th>총 결제 금액</th>
                    <td><fmt:formatNumber value="${reservation.participant_count * reservation.oneday_price}" pattern="#,###"/>원</td>
                </tr>
                <tr>
                    <th>예약 일시</th>
                    <td><fmt:formatDate value="${reservation.reservation_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr>
                    <th>요청사항</th>
                    <td>${not empty reservation.special_requests ? reservation.special_requests : '없음'}</td>
                </tr>
            </table>
            
            <c:set var="now" value="<%= new java.util.Date() %>" />
            <c:if test="${reservation.reservation_status eq 'CONFIRMED' && reservation.oneday_date gt now}">
                <div class="cancel-policy">
                    <h4>취소 정책</h4>
                    <ul>
                        <li>수업일 기준 3일 전까지 취소 시 100% 환불</li>
                        <li>수업일 기준 2일 전 취소 시 50% 환불</li>
                        <li>수업일 기준 1일 전 취소 시 환불 불가</li>
                    </ul>
                    
                    <form action="<c:url value='/reservation/cancel/${reservation.reservation_index}'/>" method="post" 
                          onsubmit="return confirm('예약을 취소하시겠습니까?\n취소 정책에 따라 환불 금액이 달라질 수 있습니다.');">
                        <button type="submit" class="btn btn-danger">예약 취소</button>
                    </form>
                </div>
            </c:if>
            
            <c:if test="${not empty reservation.calendar_event_id}">
                <a href="https://calendar.naver.com" target="_blank" class="naver-calendar-link">
                    네이버 캘린더에서 일정 보기
                </a>
            </c:if>
            
            <div class="button-container" style="margin-top: 20px; text-align: center;">
                <a href="<c:url value='/reservation/list'/>" class="btn">목록으로</a>
                <a href="<c:url value='/oneday/detail/${reservation.oneday_index}'/>" class="btn">클래스 상세</a>
            </div>
        </div>
    </div>
</body>
</html>