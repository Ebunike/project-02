<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>원데이 클래스 목록</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGaRamYeonGgoc.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --primary-color: #FF9F29;
            --secondary-color: #1A5D1A;
            --accent-color: #FFC83D;
            --text-color: #333333;
            --text-light: #666666;
            --background-color: #FFFAF2;
            --card-bg: #FFFFFF;
            --border-radius: 12px;
            --shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'NanumGaRamYeonGgoc', sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
        }
        
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        h2 {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 30px;
            color: var(--primary-color);
            position: relative;
            padding-bottom: 15px;
        }
        
        h2:after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            border-radius: 2px;
        }
        
        /* 검색 박스 스타일 */
        .search-box {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 20px;
            margin-bottom: 40px;
            display: flex;
            justify-content: center;
            transition: var(--transition);
        }
        
        .search-box form {
            display: flex;
            width: 100%;
            max-width: 600px;
        }
        
        .search-box input {
            flex: 1;
            padding: 15px 20px;
            border: 2px solid #EAEAEA;
            border-radius: var(--border-radius) 0 0 var(--border-radius);
            font-family: 'NanumGaRamYeonGgoc', sans-serif;
            font-size: 16px;
            color: var(--text-color);
            transition: var(--transition);
        }
        
        .search-box input:focus {
            outline: none;
            border-color: var(--primary-color);
        }
        
        .search-box button {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 0 25px;
            border-radius: 0 var(--border-radius) var(--border-radius) 0;
            cursor: pointer;
            font-family: 'NanumGaRamYeonGgoc', sans-serif;
            font-size: 16px;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .search-box button:hover {
            background: #E67E22;
        }
        
        .search-box button::before {
            content: "\f002";
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            margin-right: 8px;
        }
        
        /* 클래스 그리드 레이아웃 */
        .oneday-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 30px;
        }
        
        /* 빈 데이터 스타일 */
        .no-data {
            grid-column: 1 / -1;
            text-align: center;
            padding: 40px;
            background: var(--card-bg);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            color: var(--text-light);
            font-size: 18px;
        }
        
        .no-data::before {
            content: "\f119";
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            display: block;
            font-size: 48px;
            margin-bottom: 15px;
            color: var(--primary-color);
        }
        
        /* 클래스 카드 스타일 */
        .oneday-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: var(--transition);
            position: relative;
            height: 100%;
            display: flex;
            flex-direction: column;
            border: 1px solid rgba(0,0,0,0.05);
        }
        
        .oneday-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
        }
        
        .oneday-image {
            height: 200px;
            overflow: hidden;
            position: relative;
        }
        
        .oneday-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.8s ease;
        }
        
        .oneday-card:hover .oneday-image img {
            transform: scale(1.05);
        }
        
        .oneday-info {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        
        .oneday-info h3 {
            font-size: 1.4rem;
            margin-bottom: 12px;
            line-height: 1.3;
        }
        
        .oneday-info h3 a {
            color: var(--text-color);
            text-decoration: none;
            transition: var(--transition);
        }
        
        .oneday-info h3 a:hover {
            color: var(--primary-color);
        }
        
        .oneday-theme {
            background-color: var(--secondary-color);
            color: white;
            display: inline-block;
            padding: 5px 12px;
            font-size: 0.85rem;
            border-radius: 20px;
            margin-bottom: 15px;
        }
        
        .oneday-date, .oneday-location {
            color: var(--text-light);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }
        
        .oneday-date:before {
            content: "\f073";
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            margin-right: 8px;
            color: var(--primary-color);
        }
        
        .oneday-location:before {
            content: "\f3c5";
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            margin-right: 8px;
            color: var(--primary-color);
        }
        
        .oneday-meta {
            margin-top: auto;
            padding-top: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px dashed #EAEAEA;
        }
        
        .oneday-price {
            font-size: 1.2rem;
            font-weight: bold;
            color: var(--primary-color);
        }
        
        .oneday-personnel {
            color: var(--text-light);
            display: flex;
            align-items: center;
        }
        
        .oneday-personnel:before {
            content: "\f500";
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            margin-right: 8px;
            color: var(--primary-color);
        }
        
        .status {
            display: inline-block;
            padding: 3px 10px;
            font-size: 0.8rem;
            border-radius: 15px;
            margin-left: 8px;
            font-weight: bold;
        }
        
        .available {
            background-color: rgba(26, 93, 26, 0.15);
            color: var(--secondary-color);
        }
        
        .full {
            background-color: rgba(231, 76, 60, 0.15);
            color: #e74c3c;
        }
        
        /* 버튼 스타일 */
        .button-container {
            margin-top: 40px;
            text-align: center;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 25px;
            border-radius: 30px;
            text-decoration: none;
            font-family: 'NanumGaRamYeonGgoc', sans-serif;
            font-size: 16px;
            font-weight: bold;
            margin: 0 10px;
            transition: var(--transition);
        }
        
        .btn-primary {
            background: var(--primary-color);
            color: white;
            box-shadow: 0 4px 15px rgba(255, 159, 41, 0.3);
        }
        
        .btn-primary:hover {
            background: #E67E22;
            transform: translateY(-3px);
            box-shadow: 0 7px 20px rgba(255, 159, 41, 0.4);
        }
        
        .btn:not(.btn-primary) {
            background: white;
            color: var(--text-color);
            border: 2px solid #EAEAEA;
        }
        
        .btn:not(.btn-primary):hover {
            background: #f9f9f9;
            border-color: #ddd;
            transform: translateY(-3px);
        }
        
        /* 반응형 스타일 */
        @media (max-width: 768px) {
            .oneday-list {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            }
            
            h2 {
                font-size: 2rem;
            }
            
            .search-box button {
                padding: 0 15px;
            }
            
            .button-container {
                display: flex;
                flex-direction: column;
                gap: 15px;
                max-width: 280px;
                margin: 40px auto;
            }
            
            .btn {
                margin: 0;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>원데이 클래스</h2>
        
        <div class="search-box">
            <form action="<c:url value='/oneday/search'/>" method="get">
                <input type="text" name="keyword" placeholder="찾고 싶은 원데이 클래스를 검색해보세요" value="${keyword}">
                <button type="submit">검색</button>
            </form>
        </div>
        
        <div class="oneday-list">
            <c:if test="${empty onedayList}">
                <p class="no-data">등록된 원데이 클래스가 없습니다.</p>
            </c:if>
            
            <c:forEach var="oneday" items="${onedayList}">
                <div class="oneday-card">
                    <div class="oneday-image">
                        <img src="<c:url value='/resources/images/oneday/${oneday.oneday_imageUrl}'/>" 
                             alt="${oneday.oneday_name}" onerror="this.src='<c:url value='/resources/images/default.jpg'/>'">
                    </div>
                    <div class="oneday-info">
                        <h3><a href="<c:url value='/oneday/detail/${oneday.oneday_index}'/>">${oneday.oneday_name}</a></h3>
                        <p class="oneday-theme">${oneday.theme_name}</p>
                        <p class="oneday-date">
                            <fmt:formatDate value="${oneday.oneday_date}" pattern="yyyy년 MM월 dd일"/>
                            ${oneday.oneday_start} ~ ${oneday.oneday_end}
                        </p>
                        <p class="oneday-location">${oneday.oneday_location}</p>
                        <div class="oneday-meta">
                            <span class="oneday-price"><fmt:formatNumber value="${oneday.oneday_price}" pattern="#,###"/>원</span>
                            <span class="oneday-personnel">
                                ${oneday.current_participants} / ${oneday.oneday_personnel}명
                                <c:if test="${oneday.available}">
                                    <span class="status available">예약가능</span>
                                </c:if>
                                <c:if test="${!oneday.available}">
                                    <span class="status full">마감</span>
                                </c:if>
                            </span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <c:if test="${not empty loginMember}">
            <c:if test="${not empty sellerIndex}">
                <div class="button-container">
                    <a href="<c:url value='/oneday/register'/>" class="btn btn-primary">원데이 클래스 등록</a>
                    <a href="<c:url value='/oneday/my-classes'/>" class="btn">내 클래스 관리</a>
                </div>
            </c:if>
        </c:if>
    </div>
</body>
</html>