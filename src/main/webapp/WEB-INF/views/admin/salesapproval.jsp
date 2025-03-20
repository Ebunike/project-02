<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>판매자 승인 관리</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        h2 {
            color: #333;
        }
        .button {
            padding: 5px 10px;
            margin: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .approve-button {
            background-color: #4CAF50;
            color: white;
            border: none;
        }
        .reject-button {
            background-color: #f44336;
            color: white;
            border: none;
        }
    </style>
</head>
<body>
    <h1>판매자 승인 관리</h1>

    <!-- 승인 대기 중인 판매자 리스트 -->
    <h2>승인 대기 중인 판매자</h2>
    <table>
        <thead>
            <tr>
                <th>아이디</th>
                <th>상호명</th>
                <th>사업자 등록번호</th>
                <th>상태</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="sellerAwaiter" items="${sellerAwaiterBean}">
                <tr>
                    <td>${sellerAwaiter.id}</td>
                    <td>${sellerAwaiter.company_name}</td>
                    <td>${sellerAwaiter.company_num}</td>
                    <td>승인 대기 중
                        <a href="${root}/admin/salesapproval_pro?result=o&sellerId=${sellerAwaiter.id}">
                            <button class="approve-button">승인</button>
                        </a>
                        <a href="${root}/admin/salesapproval_pro?result=x&sellerId=${sellerAwaiter.id}">
                            <button class="reject-button">거부</button>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- 승인된 판매자 리스트 -->
    <h2>승인된 판매자</h2>
    <table>
        <thead>
            <tr>
                <th>아이디</th>
                <th>상호명</th>
                <th>사업자 등록번호</th>
                <th>상태</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="seller" items="${sellerBean}">
                <tr>
                    <td>${seller.id}</td>
                    <td>${seller.company_name}</td>
                    <td>${seller.company_num}</td>
                    <td>승인됨</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>
