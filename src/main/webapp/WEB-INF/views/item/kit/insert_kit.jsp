<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 등록</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<!-- 네이버 폰트 -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGaRamYeonGgoc.css" rel="stylesheet">

<style type="text/css">
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f5f5f5;
        color: #333;
        margin: 0;
        padding: 0;
    }
    
    .main {
        text-align: center;
        margin-left: 170px; /* 사이드바 너비만큼 여백 */
    }
    
    .side {
        position: fixed;
        left: 0;
        top: 0;
        width: 170px;
        height: 100vh;
        padding: 20px;
        background-color: #fff;
        box-shadow: 2px 0 5px rgba(0,0,0,0.05);
        z-index: 1000;
    }
    
    .title {
        align-items: center;
        padding: 15px 0;
        margin-bottom: 30px;
        border-bottom: 2px solid #e67e22;
        background-color: #fff;
    }
    
    .title h1 {
        font-family: 'NanumGaRamYeonGgoc', cursive;
        font-size: 2.2rem;
        color: #333;
        margin: 0;
        font-weight: 600;
    }
    
    .container_kit {
        max-width: 800px;
        margin: 0 auto;
        padding: 30px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0,0,0,0.05);
    }
    
    .item-box {
        background: #fff;
        border: 1px solid #eee;
        padding: 20px;
        margin-bottom: 20px;
        border-radius: 8px;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        align-items: center;
        font-size: 16px;
        transition: all 0.3s ease;
        box-shadow: 0 2px 5px rgba(0,0,0,0.03);
    }
    
    .item-box:hover {
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        transform: translateY(-2px);
    }
    
    .item-box label {
        font-weight: 500;
        color: #333;
        margin-bottom: 5px;
        width: 150px;
        text-align: left;
    }
    
    .item-box input[type="text"] {
        flex: 1;
        padding: 10px 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
        transition: border-color 0.3s;
    }
    
    .item-box input[type="text"]:focus {
        border-color: #e67e22;
        outline: none;
        box-shadow: 0 0 0 2px rgba(230, 126, 34, 0.2);
    }
    
    .item-box input[type="file"] {
        flex: 1;
        padding: 10px 0;
    }
    
    .radio-group {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        flex: 1;
    }
    
    .radio-item {
        display: flex;
        align-items: center;
        margin-right: 15px;
    }
    
    .radio-item input[type="radio"] {
        margin-right: 5px;
    }
    
    .insert_kit {
        background-color: #e67e22;
        color: white;
        border: none;
        padding: 12px 25px;
        border-radius: 5px;
        cursor: pointer;
        font-weight: 500;
        font-size: 16px;
        transition: all 0.3s ease;
        margin-top: 10px;
        display: inline-block;
    }
    
    .insert_kit:hover {
        background-color: #d35400;
        transform: translateY(-2px);
        box-shadow: 0 5px 10px rgba(0,0,0,0.1);
    }
    
    /* 반응형 스타일 */
    @media (max-width: 768px) {
        .main {
            margin-left: 0;
        }
        
        .side {
            position: static;
            width: 100%;
            height: auto;
            box-shadow: none;
            border-bottom: 1px solid #eee;
        }
        
        .container_kit {
            padding: 20px;
        }
        
        .item-box {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .item-box label {
            width: 100%;
            margin-bottom: 10px;
        }
        
        .item-box input[type="text"] {
            width: 100%;
        }
    }
</style>
</head>
<body>
<div class="main">
    <!-- side 고정메뉴  -->
    <div class="side">
        <c:import url="/WEB-INF/views/include/manager_side.jsp" />
    </div>
    <!-- 본문 -->
    <div class="title">
        <h1>상품 등록</h1>
    </div>
    <div class="container_kit">
        <form action="${root}/item/kit/insert_kit_pro" method="post" enctype="multipart/form-data">
            <div class="item-box">
                <label for="kitName"><i class="fas fa-tag"></i> 제품 이름</label>
                <input type="text" name="kitName" id="kitName" required placeholder="제품 이름을 입력하세요"/>
            </div>
            <input type="hidden" name="kit" value="${kit}"/>
            <div class="item-box">
                <label for="kitPrice"><i class="fas fa-won-sign"></i> 제품 가격</label>
                <input type="text" name="kitPrice" id="kitPrice" placeholder="숫자만 입력하세요"/>
            </div>
            <div class="item-box">
                <label for="kitQuantity"><i class="fas fa-boxes"></i> 제품 재고 수량</label>
                <input type="text" name="kitQuantity" id="kitQuantity" placeholder="숫자만 입력하세요"/>
            </div>
            <div class="item-box">
                <label for="kitTheme"><i class="fas fa-list-alt"></i> 제품 테마</label>
                <div class="radio-group">
                    <div class="radio-item">
                        <input type="radio" name="kitTheme" id="food" value="푸드">
                        <label for="food">[푸드]</label>
                    </div>
                    <div class="radio-item">
                        <input type="radio" name="kitTheme" id="beauty" value="뷰티">
                        <label for="beauty">[뷰티]</label>
                    </div>
                    <div class="radio-item">
                        <input type="radio" name="kitTheme" id="fancy" value="팬시">
                        <label for="fancy">[팬시]</label>
                    </div>
                    <div class="radio-item">
                        <input type="radio" name="kitTheme" id="living" value="리빙">
                        <label for="living">[리빙]</label>
                    </div>
                    <div class="radio-item">
                        <input type="radio" name="kitTheme" id="fashion" value="패션">
                        <label for="fashion">[패션]</label>
                    </div>
                </div>
            </div>
            <div class="item-box">
                <label for="kitPicture"><i class="fas fa-image"></i> 첨부 이미지</label>
                <input type="file" id="kitPicture" name="kitPicture" accept="image/*"/>
            </div>
            <div class="item-box">
                <label for="kitContent"><i class="fas fa-info-circle"></i> 제품 상세설명</label>
                <input type="text" name="kitContent" id="kitContent" placeholder="제품에 대한 상세 설명을 입력하세요">
            </div>
            <button class="insert_kit" type="submit"><i class="fas fa-check"></i> 등록</button>
        </form>
    </div>
</div>

<!-- 게시판 하단 부분 -->    
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>