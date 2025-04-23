<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 실패</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <jsp:include page="../include/header.jsp" />

    <div class="container">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="payment-fail-container text-center">
                    <div class="fail-icon">
                        <i class="fas fa-exclamation-circle fa-5x text-danger"></i>
                    </div>
                    <h2 class="mt-4">결제에 실패했습니다</h2>
                    <p class="lead">${message}</p>

                    <div class="mt-5">
                        <p>결제 과정에서 오류가 발생했습니다. 다시 시도하시거나, 문제가 계속되면 고객센터로 문의해주세요.</p>

                        <div class="mt-4 payment-actions">
                            <a href="<c:url value='/oneday/list'/>" class="btn btn-primary mr-2">클래스 목록</a>
                            <a href="javascript:history.back()" class="btn btn-secondary">이전 페이지</a>
                        </div>

                        <div class="mt-4 help-info">
                            <p>도움이 필요하시면 <a href="mailto:support@example.com">support@example.com</a>으로 문의하세요.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

 
</body>
</html>