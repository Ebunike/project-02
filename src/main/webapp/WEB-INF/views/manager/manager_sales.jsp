<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>manager_sales</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<!-- 네이버 폰트 -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGaRamYeonGgoc.css" rel="stylesheet">
<style>
    .sale_container {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        text-align: center;
        margin-top: 20px;
    }
    .title {
        align-items: center;
        height: 50px;
        width: 100%;
        border-bottom: 2px solid;
        text-align: center;
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
        <h1>내 판매 현황</h1>
    </div>

    <!-- 주간 판매 차트 컨테이너 -->
    <div class="sale_container">
        <h3>주간 판매 현황</h3>
        <div id="weekly_sales_chart" style="width: 700px; height: 400px;"></div>
    </div>

    <!-- 월간 판매 차트 컨테이너 -->
    <div class="sale_container">
        <h3>월간 판매 현황</h3>
        <div id="monthly_sales_chart" style="width: 700px; height: 400px;"></div>
    </div>

    <!-- 구글 차트 라이브러리 로드 -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
    google.charts.load("current", {packages:['corechart']});
    google.charts.setOnLoadCallback(drawCharts);

    function drawCharts() {
        drawWeeklyChart();
        drawMonthlyChart();
    }

    function drawWeeklyChart() {
        var data = google.visualization.arrayToDataTable([
            ["날짜", "판매 금액"],
            <c:forEach var="sale" items="${weeklySales}">
                ["${sale.sale_date}", ${sale.total_amount}],
            </c:forEach>
        ]);

        var options = {
            title: "이번 주 판매 현황",
            width: 700,
            height: 400,
            bar: {groupWidth: "50%"},
            legend: { position: "none" }
        };

        var chart = new google.visualization.ColumnChart(document.getElementById("weekly_chart"));
        chart.draw(data, options);
    }

    function drawMonthlyChart() {
        var data = google.visualization.arrayToDataTable([
            ["주차", "판매 금액"],
            <c:forEach var="sale" items="${monthlySales}">
                ["${sale.week}주차", ${sale.total_amount}],
            </c:forEach>
        ]);

        var options = {
            title: "월간 판매 현황",
            width: 700,
            height: 400,
            bar: {groupWidth: "50%"},
            legend: { position: "none" }
        };

        var chart = new google.visualization.ColumnChart(document.getElementById("monthly_chart"));
        chart.draw(data, options);
    }
</script>

<div class="sale_container">
    <h3>이번 주 판매 데이터</h3>
    <div id="weekly_chart" style="width: 700px; height: 400px;"></div>

    <h3>월간 판매 데이터</h3>
    <div id="monthly_chart" style="width: 700px; height: 400px;"></div>
</div>
</div>

<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>
