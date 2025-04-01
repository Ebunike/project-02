<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<c:set var="root" value="${pageContext.request.contextPath}" />
<html>
<head>
    <title>고객 문의 상세보기</title>
 
</head>
<body>
    <div class="container">
        <h1>고객 문의 상세보기</h1>

        <!-- 제목, 내용, 글쓴이 출력 -->
        <div class="report-details">
            <p><strong>제목:</strong> ${oneInquiry.inquiry_title}</p>
            <p><strong>내용:</strong> ${oneInquiry.inquiry_content}</p>
            <p><strong>글쓴이:</strong> ${oneInquiry.id}</p>
        </div>

        <!-- 답글 출력 -->
			<div class="report-reply">
			    <p><strong>답글:</strong></p>
			
			    <c:if test="${not empty oneInquiry.inquiry_reply}">
			        <div class="existing-reply">${oneInquiry.inquiry_reply}</div>
			    </c:if>
			
			    <c:if test="${empty oneInquiry.inquiry_reply}">
			        <div class="existing-reply text-muted">등록된 답글이 없습니다.</div>
			    </c:if>
			
			    <a href="${root}/manager/manager_ask">뒤로가기</a>
			</div>
        </div>
</body>
</html>