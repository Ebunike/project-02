<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>환불 요청</title>
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-body">
                <h4 class="card-title text-center">환불 요청</h4>
                <form action="${root}/payment/cancel" method="post">
                    <!-- Hidden 필드: 사용자에게 보이지 않음 -->
                    <input type="hidden" name="paymentKey" value="${paymentKey}">
                    <input type="hidden" name="cancelAmount" value="${cancelAmount}">
                    <input type="hidden" name="order_detail_index" value="${order_detail_index}">
                    
                    <!-- 상품명 (읽기 전용) -->
                    <div class="form-group">
                        <label>상품명</label>
                        <input type="text" class="form-control" value="${itemName}" readonly>
                    </div>

                    <!-- 환불 금액 (읽기 전용) -->
                    <div class="form-group">
                        <label>환불 금액</label>
                        <input type="text" class="form-control" value="${cancelAmount}" readonly>
                    </div>

                    <!-- 환불 사유 입력 -->
                    <div class="form-group">
                        <label for="cancelReason">환불 사유</label>
                        <textarea class="form-control" id="cancelReason" name="cancelReason" rows="4" required></textarea>
                    </div>

                    <!-- 제출 버튼 -->
                    <div class="text-center">
                        <button type="submit" class="btn btn-danger">환불 요청</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>