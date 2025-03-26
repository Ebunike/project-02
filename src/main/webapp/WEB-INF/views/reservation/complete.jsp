<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>예약 완료</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <style>
        .reservation-complete {
            width: 600px;
            margin: 50px auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .reservation-icon {
            font-size: 50px;
            color: #28a745;
            margin-bottom: 20px;
        }
        .reservation-info {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
            text-align: left;
        }
        .reservation-info dl {
            display: grid;
            grid-template-columns: 120px 1fr;
            gap: 10px;
        }
        .reservation-info dt {
            font-weight: bold;
        }
        .reservation-buttons {
            margin-top: 30px;
        }
        .reservation-notice {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            text-align: left;
        }
        .reservation-notice h4 {
            margin-top: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="reservation-complete">
            <div class="reservation-icon">✓</div>
            <h2>예약이 완료되었습니다</h2>
            <p>원데이 클래스 예약이 성공적으로 완료되었습니다.<br>네이버 캘린더에도 일정이 등록되었습니다.</p>
            
            <div class="reservation-info">
                <h3>${reservation.oneday_name}</h3>
                <dl>
                    <dt>예약 번호</dt>
                    <dd>${reservation.reservation_index}</dd>
                    
                    <dt>수업일</dt>
                    <dd><fmt:formatDate value="${reservation.oneday_date}" pattern="yyyy년 MM월 dd일"/></dd>
                    
                    <dt>수업 시간</dt>
                    <dd>${reservation.oneday_start} ~ ${reservation.oneday_end}</dd>
                    
                    <dt>수업 장소</dt>
                    <dd>${reservation.oneday_location}</dd>
                    
                    <dt>예약 인원</dt>
                    <dd>${reservation.participant_count}명</dd>
                    
                    <dt>총 결제 금액</dt>
                    <dd>
                        <fmt:formatNumber value="${reservation.participant_count * reservation.oneday_price}" pattern="#,###"/>원
                    </dd>
                    
                    <dt>예약일시</dt>
                    <dd><fmt:formatDate value="${reservation.reservation_date}" pattern="yyyy-MM-dd HH:mm:ss"/></dd>
                </dl>
            </div>
            
            <div class="reservation-notice">
                <h4>예약 안내</h4>
                <ul>
                    <li>예약하신 내용은 네이버 캘린더에 자동으로 등록되었습니다.</li>
                    <li>예약 취소는 수업일 기준 3일 전까지 100% 환불, 2일 전 취소 시 50% 환불, 1일 전 취소 시 환불이 불가합니다.</li>
                    <li>수업 당일에는 10분 전까지 입실해주세요.</li>
                    <li>문의사항은 마이페이지 > 예약 내역에서 확인하실 수 있습니다.</li>
                </ul>
            </div>
            
            <div class="reservation-buttons">
                <a href="<c:url value='/reservation/list'/>" class="btn btn-primary">예약 내역 확인</a>
                <a href="<c:url value='/oneday/list'/>" class="btn">클래스 목록</a>
            </div>
        </div>
    </div>
</body>
</html>
