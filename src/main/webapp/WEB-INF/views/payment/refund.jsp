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
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .container {
            max-width: 500px;
            padding-top: 50px;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: all 0.3s ease;
        }
        .card:hover {
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            transform: translateY(-5px);
        }
        .card-body {
            padding: 30px;
        }
        .card-title {
            color: #333;
            font-weight: 700;
            margin-bottom: 25px;
            position: relative;
            padding-bottom: 10px;
        }
        .card-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 50px;
            height: 3px;
            background-color: #007bff;
            transform: translateX(-50%);
        }
        .form-group label {
            font-weight: 500;
            color: #555;
            margin-bottom: 8px;
        }
        .form-control {
            border-radius: 6px;
            border-color: #e1e5eb;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }
        .form-control[readonly] {
            background-color: #f9f9f9;
            opacity: 1;
        }
        textarea.form-control {
            resize: vertical;
            min-height: 120px;
        }
        .btn-danger {
            background-color: #dc3545;
            border: none;
            padding: 12px 25px;
            border-radius: 6px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        .btn-danger:hover {
            background-color: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        .btn-danger:focus {
            box-shadow: 0 0 0 0.2rem rgba(225, 83, 97, 0.25);
        }
    </style>
</head>
<body>
    <div class="container">
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
                        <input type="text" class="form-control" value="${cancelAmount}원" readonly>
                    </div>
                    <!-- 환불 사유 입력 -->
                    <div class="form-group">
                        <label for="cancelReason">환불 사유</label>
                        <textarea class="form-control" id="cancelReason" name="cancelReason" rows="4" placeholder="환불 사유를 상세히 작성해 주세요." required></textarea>
                    </div>
                    <!-- 제출 버튼 -->
                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-danger">환불 요청</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>