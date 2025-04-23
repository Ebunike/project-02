<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>원데이 클래스</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
 

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="oneday-header mb-4">
                    <h2>
                        <c:choose>
                            <c:when test="${not empty theme}">
                                ${theme.theme_name} 원데이 클래스
                            </c:when>
                            <c:when test="${not empty keyword}">
                                "${keyword}" 검색 결과
                            </c:when>
                            <c:otherwise>
                                원데이 클래스
                            </c:otherwise>
                        </c:choose>
                    </h2>

                    <div class="oneday-filters">
                        <form action="<c:url value='/oneday/search'/>" method="get" class="search-form">
                            <div class="search-box">
                                <input type="text" name="keyword" placeholder="클래스 검색..." value="${keyword}" required>
                                <button type="submit"><i class="fas fa-search"></i></button>
                            </div>
                        </form>

                        <div class="theme-select">
                            <select id="themeFilter" class="form-control">
                                <option value="">전체 테마</option>
                                <c:forEach var="themeItem" items="${themeList}">
                                    <option value="${themeItem.theme_index}" ${themeItem.theme_index eq theme.theme_index ? 'selected' : ''}>${themeItem.theme_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">${errorMessage}</div>
                </c:if>

                <c:if test="${empty onedayList}">
                    <div class="no-classes text-center">
                        <p>현재 등록된 원데이 클래스가 없습니다.</p>
                    </div>
                </c:if>
<%-- 
				<c:if test="${sellerIndex > 0}">
                            <a href="<c:url value='/oneday/register'/>" class="btn btn-primary mt-3">클래스 등록하기</a>
                        </c:if> --%>
                        
                <c:if test="${not empty onedayList}">
                    <div class="oneday-grid">
                        <div class="row">
                            <c:forEach var="oneday" items="${onedayList}">
                                <div class="col-md-4 col-sm-6">
                                    <div class="oneday-card">
                                        <div class="oneday-image">
                                            <a href="<c:url value='/oneday/detail/${oneday.oneday_index}'/>">
                                                <img src="<c:url value='/upload/${oneday.oneday_imageUrl}'/>" alt="${oneday.oneday_name}">
                                            </a>
                                        </div>
                                        <div class="oneday-info">
                                            <c:choose>
                                                <c:when test="${oneday.current_participants >= oneday.oneday_max_participants}">
                                                    <span class="status-tag status-full">마감</span>
                                                </c:when>
                                                <c:when test="${oneday.oneday_date < now}">
                                                    <span class="status-tag status-closed">종료</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-tag status-open">예약가능</span>
                                                </c:otherwise>
                                            </c:choose>

                                            <h3 class="oneday-title">
                                                <a href="<c:url value='/oneday/detail/${oneday.oneday_index}'/>">${oneday.oneday_name}</a>
                                            </h3>

                                            <div class="oneday-date">
                                                <i class="far fa-calendar-alt"></i>
                                            <fmt:formatDate value="${oneday.oneday_date}" pattern="yyyy-MM-dd HH:mm"/>
                                            </div>

                                            <div class="oneday-location">
                                                <i class="fas fa-map-marker-alt"></i> ${oneday.oneday_location}
                                            </div>

                                            <div class="oneday-price">
                                                <fmt:formatNumber value="${oneday.oneday_price}" pattern="#,###"/>원
                                            </div>

                                            <div class="oneday-participants">
                                                <span>${oneday.current_participants}명</span> / ${oneday.oneday_max_participants}명
                                            </div>

                                            <div class="oneday-tags">
                                                <span class="oneday-tag">${oneday.theme_name}</span>
                                              
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- 페이지네이션 -->
                    <div class="pagination-container">
                        <ul class="pagination">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="<c:url value='/oneday/list?page=${currentPage - 1}'/>">&laquo; 이전</a>
                                </li>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="page">
                                <li class="page-item ${page == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="<c:url value='/oneday/list?page=${page}'/>">${page}</a>
                                </li>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="<c:url value='/oneday/list?page=${currentPage + 1}'/>">다음 &raquo;</a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </c:if>

                <div class="actions text-center mt-4">
                    <c:if test="${sellerIndex > 0}">
                        <a href="<c:url value='/oneday/register'/>" class="btn btn-primary">클래스 등록하기</a>
                        <a href="<c:url value='/oneday/my-classes'/>" class="btn btn-secondary ml-2">예약 관리</a>
                        <a href="<c:url value='/kakaomap/main'/>" class="btn btn-secondary ml-2">커뮤니티 이동</a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>



    <script>
    document.getElementById('themeFilter').addEventListener('change', function() {
        const themeId = this.value;
        if (themeId) {
            window.location.href = '<c:url value="/oneday/theme/"/>' + themeId;
        } else {
            window.location.href = '<c:url value="/oneday/list"/>';
        }
    });
    </script>
</body>
</html>