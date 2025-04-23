<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 취소</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <jsp:include page="../include/header.jsp" />

    <div class="container">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="payment-cancel-container text-center">
                    <div class="cancel-icon">
                        <i class="fas fa-times-circle fa-5x text-warning"></i>
                    </div>
                    <h2 class="mt-4">결제가 취소되었습니다</h2>
                    <p class="lead">${message}</p>

                    <div class="mt-5">
                        <p>결제를 취소하셨습니다. 다시 시도하시려면 아래 버튼을 클릭해주세요.</p>

                        <div class="mt-4">
                            <a href="<c:url value='/oneday/list'/>" class="btn btn-primary mr-2">클래스 목록</a>
                            <a href="javascript:history.back()" class="btn btn-secondary">이전 페이지</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</body>
</html>