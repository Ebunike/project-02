<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의 상세</title>
    <!-- 스타일링 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .inquiry-detail-container {
            max-width: 900px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
        }

        .inquiry-detail-container h2 {
            font-size: 1.8rem;
            margin-bottom: 20px;
        }

        .badge {
            font-size: 0.9rem;
            padding: 5px 10px;
            margin-bottom: 10px;
        }

        .badge-category {
            background-color: #ffb84d;
            color: white;
        }

        .badge-read {
            background-color: #28a745;
            color: white;
        }

        .badge-unread {
            background-color: #dc3545;
            color: white;
        }

        .content-box {
            background-color: white;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .content-box h5 {
            font-size: 1.2rem;
            margin-bottom: 10px;
        }

        .content-box p {
            font-size: 1rem;
            line-height: 1.6;
        }

        .content-box .reply p {
            background-color: #f1f1f1;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ddd;
        }

        .content-box .date {
            font-size: 0.9rem;
            color: #777;
        }
    </style>
</head>
<body>

<div class="inquiry-detail-container">
    <!-- 문의 제목 -->
    <h2>${oneinquiry.inquiry_title}</h2>

    <!-- 문의 카테고리 -->
    <span class="badge badge-category">${oneinquiry.inquiry_category}</span>

    <!-- 문의 상태 (읽음/안읽음) -->
    <span class="badge ${oneinquiry.inquiry_read == '답변X' ? 'badge-unread' : 'badge-read'}">
        ${oneinquiry.inquiry_read == '답변X' ? '안읽음' : '읽음'}
    </span>

    <!-- 문의 제목 -->
    <div class="content-box">
        <h5>문의 제목:</h5>
        <p>${oneinquiry.inquiry_title}</p>
    </div>
    
    <!-- 문의 내용 -->
    <div class="content-box">
        <h5>문의 내용:</h5>
        <p>${oneinquiry.inquiry_content}</p>
    </div>

    <!-- 답변 내용 -->
    <c:if test="${not empty oneinquiry.inquiry_reply}">
        <div class="content-box reply">
            <h5>답변:</h5>
            <p>${oneinquiry.inquiry_reply}</p>
        </div>
    </c:if>

    <!-- 답변자 -->
    <c:if test="${not empty oneinquiry.inquiry_replyer}">
        <div class="content-box">
            <h5>답변자:</h5>
            <p>${oneinquiry.inquiry_replyer}</p>
        </div>
    </c:if>

    <!-- 문의 날짜 -->
    <div class="content-box">
        <h5>문의 날짜:</h5>
        <p>${oneinquiry.inquiry_date}</p>
    </div>
</div>

<!-- 버튼: 목록으로 돌아가기 -->
<div class="text-center">
    <a href="${pageContext.request.contextPath}/inquiry/inquiry_list?id=${oneinquiry.id}" class="btn btn-primary">
        목록으로 돌아가기
    </a>
</div>

</body>
</html>
