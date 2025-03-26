<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>원데이 클래스 목록</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
</head>
<body>
    <div class="container">
        <h2>원데이 클래스</h2>
        
        <div class="search-box">
            <form action="<c:url value='/oneday/search'/>" method="get">
                <input type="text" name="keyword" placeholder="검색어를 입력하세요" value="${keyword}">
                <button type="submit">검색</button>
            </form>
        </div>
        
        <div class="oneday-list">
            <c:if test="${empty onedayList}">
                <p class="no-data">등록된 원데이 클래스가 없습니다.</p>
            </c:if>
            
            <c:forEach var="oneday" items="${onedayList}">
                <div class="oneday-card">
                    <div class="oneday-image">
                        <img src="<c:url value='/resources/images/oneday/${oneday.oneday_imageUrl}'/>" 
                             alt="${oneday.oneday_name}" onerror="this.src='<c:url value='/resources/images/default.jpg'/>'">
                    </div>
                    <div class="oneday-info">
                        <h3><a href="<c:url value='/oneday/detail/${oneday.oneday_index}'/>">${oneday.oneday_name}</a></h3>
                        <p class="oneday-theme">${oneday.theme_name}</p>
                        <p class="oneday-date">
                            <fmt:formatDate value="${oneday.oneday_date}" pattern="yyyy년 MM월 dd일"/>
                            ${oneday.oneday_start} ~ ${oneday.oneday_end}
                        </p>
                        <p class="oneday-location">${oneday.oneday_location}</p>
                        <div class="oneday-meta">
                            <span class="oneday-price"><fmt:formatNumber value="${oneday.oneday_price}" pattern="#,###"/>원</span>
                            <span class="oneday-personnel">
                                ${oneday.current_participants} / ${oneday.oneday_personnel}명
                                <c:if test="${oneday.available}">
                                    <span class="status available">예약가능</span>
                                </c:if>
                                <c:if test="${!oneday.available}">
                                    <span class="status full">마감</span>
                                </c:if>
                            </span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <c:if test="${not empty loginMember}">
            <c:if test="${not empty sellerIndex}">
                <div class="button-container">
                    <a href="<c:url value='/oneday/register'/>" class="btn btn-primary">원데이 클래스 등록</a>
                    <a href="<c:url value='/oneday/my-classes'/>" class="btn">내 클래스 관리</a>
                </div>
            </c:if>
        </c:if>
    </div>
</body>
</html>
