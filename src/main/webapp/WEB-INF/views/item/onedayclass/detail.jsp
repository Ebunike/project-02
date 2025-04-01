<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${oneday.oneday_name} - 원데이 클래스</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
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
                                        <a href="<c:url value='/reservation/form/${oneday.oneday_index}'/>" class="btn btn-primary">예약하기</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="<c:url value='/naver-calendar/auth'/>" class="btn btn-primary" 
                                           onclick="sessionStorage.setItem('calendarRedirectUrl', '/reservation/form/${oneday.oneday_index}')">
                                            네이버 캘린더 연동 후 예약하기
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <c:if test="${!oneday.available}">
                                <button class="btn btn-disabled" disabled>예약마감</button>
                            </c:if>
                        </c:if>
                        <c:if test="${empty loginMember}">
                            <a href="<c:url value='/member/login'/>" class="btn btn-primary">로그인 후 예약하기</a>
                        </c:if>
                        
                        <a href="<c:url value='/oneday/list'/>" class="btn">목록으로</a>
                    </div>
                </div>
            </div>
            
            <div class="oneday-description">
                <h3>클래스 소개</h3>
                <div class="oneday-info-content">
                    <pre>${oneday.oneday_info}</pre>
                </div>
            </div>
            
            <c:if test="${oneday.seller_index eq seller_index}">
                <div class="oneday-management">
                    <h3>클래스 관리</h3>
                    <div class="management-buttons">
                        <a href="<c:url value='/oneday/edit/${oneday.oneday_index}'/>" class="btn">클래스 수정</a>
                        <a href="<c:url value='/reservation/class/${oneday.oneday_index}'/>" class="btn">예약 현황</a>
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
                        