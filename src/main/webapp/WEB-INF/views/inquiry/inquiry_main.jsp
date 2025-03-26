<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>뚝배기 고객센터 문의</title>
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        
        .container {
            padding: 30px;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h3 {
            color: #343a40;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-control {
            padding: 10px;
            font-size: 16px;
        }

        .file-input {
            padding: 5px;
            background-color: #f1f1f1;
        }

        .note {
            font-size: 12px;
            color: #888;
        }

        .footer {
            text-align: center;
            padding: 20px;
            background-color: #343a40;
            color: white;
            position: fixed;
            width: 100%;
            bottom: 0;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="header">
            <h3>뚝배기 고객센터 문의</h3>
            <p>뚝배기를 이용하면서 느끼신 불편사항이나 바라는 점을 알려주세요.</p>
            <p>고객님의 소중한 의견으로 한 뼘 더 자라는 뚝배기가 되겠습니다.</p>
            <p>문의량이 많아 답변은 24시간 이상 소요될 수 있습니다.</p>
        </div>

        <!-- Spring form:form 사용 -->
        <form:form action="inquiry_pro" method="post" modelAttribute="inquiryBean" enctype="multipart/form-data">
            
            <!-- 유형 선택 -->
            <div class="form-group">
                <label for="inquiry_category">유형을 선택해주세요</label>
                <form:select id="inquiry_category" path="inquiry_category" class="form-control">
                    <option value="order">주문 상품 문의</option>
                    <option value="delivery">배송 관련 문의</option>
                    <option value="payment">결제 관련 문의</option>
                    <option value="system">시스템 개선 의견</option>
                    <option value="service">뚝배기 서비스 불편/제안</option>
                </form:select>
            </div>

            <!-- 제목 입력 -->
            <div class="form-group">
                <label for="inquiry_title">제목</label>
                <form:input id="inquiry_title" path="inquiry_title" class="form-control" placeholder="문의 제목을 입력하세요" />
            </div>

            <!-- 내용 입력 -->
            <div class="form-group">
                <label for="inquiry_content">내용</label>
                <form:textarea id="inquiry_content" path="inquiry_content" class="form-control" rows="5" placeholder="여기에 의견을 작성해주세요."></form:textarea>
            </div>

            <!-- 제출 버튼 -->
            <button type="submit" class="btn btn-primary">보내기</button>
        </form:form>

        <!-- 내 문의 확인하기 버튼 (링크로 이동) -->
        <hr>
        <h4>내 문의 확인하기</h4>
        <a href="${root }/inquiry/inquiry_list?id=${loginUser.id}" class="btn btn-info">내 문의 내역 보기</a>

    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 뚝배기 | 모든 권리 보유</p>
    </div>

</body>
</html>
