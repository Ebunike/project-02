<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출 현황</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- Google Charts -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- 네이버 폰트 -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<style>
    body {
        font-family: 'NanumSquare', sans-serif;
        background-color: #f9f9f9;
    }
    
    .sales-container {
        max-width: 1000px;
        margin: 50px auto;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        padding: 30px;
    }
    
    .sales-header {
        text-align: center;
        margin-bottom: 30px;
    }
    
    .sales-header h2 {
        color: #333;
        font-weight: 700;
        margin-bottom: 5px;
    }
    
    .sales-header p {
        color: #666;
        font-size: 16px;
    }
    
    .sales-date {
        font-weight: bold;
        color: #3498db;
    }
    
    .sales-summary {
        background-color: #f1f8fe;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .total-sales {
        text-align: center;
    }
    
    .total-sales h3 {
        font-size: 18px;
        color: #555;
        margin-bottom: 10px;
    }
    
    .total-sales .amount {
        font-size: 28px;
        font-weight: 700;
        color: #2980b9;
    }
    
    .chart-container {
        height: 400px;
        margin-top: 20px;
    }
    
    .stat-card {
        background: white;
        border-radius: 8px;
        padding: 15px;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        text-align: center;
        width: 23%;
    }
    
    .stat-title {
        font-size: 14px;
        color: #777;
        margin-bottom: 5px;
    }
    
    .stat-value {
        font-size: 20px;
        font-weight: 700;
        color: #333;
    }
    
    .trend-up {
        color: #27ae60;
    }
    
    .trend-down {
        color: #e74c3c;
    }
    
    .trend-neutral {
        color: #f39c12;
    }
    
    .card-container {
        display: flex;
        justify-content: space-between;
        margin-bottom: 30px;
    }
</style>
<script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        // 현재 sales 값 가져오기
        const currentSales = ${sales};
        
        // 일주일치 데이터 생성 (3월 27일 ~ 4월 2일)
        // 실제 데이터가 아닌 예시 데이터로, 필요에 따라 수정
        const dailyData = [
            ['날짜', '매출액(원)', { role: 'style' }],
            ['3월 29일', Math.round(currentSales * 0.7), '#76A7FA'],  // 월요일
            ['3월 30일', Math.round(currentSales * 0.8), '#76A7FA'],  // 화요일
            ['3월 31일', Math.round(currentSales * 0.9), '#76A7FA'],  // 수요일
            ['4월 1일', Math.round(currentSales * 0.75), '#76A7FA'], // 목요일
            ['4월 2일', Math.round(currentSales * 1.1), '#76A7FA'],  // 금요일
            ['4월 3일', Math.round(currentSales * 1.2), '#76A7FA'],   // 토요일
            ['4월 4일', currentSales, '#3366CC']                      // 일요일 (오늘)
        ];

        var data = google.visualization.arrayToDataTable(dailyData);

        var options = {
            title: '일일 매출 현황 (3월 27일 ~ 4월 2일)',
            titleTextStyle: {
                color: '#333',
                fontSize: 18,
                bold: true
            },
            hAxis: {
                title: '날짜',
                titleTextStyle: {color: '#333', italic: false}
            },
            vAxis: {
                title: '매출액(원)',
                titleTextStyle: {color: '#333', italic: false},
                format: '₩#,###'
            },
            legend: { position: 'none' },
            animation: {
                startup: true,
                duration: 1000,
                easing: 'out'
            },
            colors: ['#3366CC'],
            chartArea: {
                width: '80%',
                height: '70%'
            }
        };

        var chart = new google.visualization.ColumnChart(document.getElementById('sales_chart'));
        chart.draw(data, options);
        
        // 주간 평균 계산
        let totalWeek = 0;
        for (let i = 1; i < dailyData.length; i++) {
            totalWeek += dailyData[i][1];
        }
        const weeklyAverage = Math.round(totalWeek / (dailyData.length - 1));
        
        // 어제 대비 증감률
        const yesterdaySales = dailyData[dailyData.length - 2][1];
        const growthRate = ((currentSales - yesterdaySales) / yesterdaySales * 100).toFixed(1);
        
        // 통계 업데이트
        document.getElementById('weekly-average').innerText = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(weeklyAverage);
        document.getElementById('yesterday-sales').innerText = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(yesterdaySales);
        
        const growthElement = document.getElementById('daily-growth');
        growthElement.innerText = growthRate + '%';
        if (growthRate > 0) {
            growthElement.classList.add('trend-up');
            growthElement.innerText = '▲ ' + growthRate + '%';
        } else if (growthRate < 0) {
            growthElement.classList.add('trend-down');
            growthElement.innerText = '▼ ' + Math.abs(growthRate) + '%';
        } else {
            growthElement.classList.add('trend-neutral');
        }
        
        // 주간 최고 매출 계산
        let maxSales = 0;
        let maxDay = '';
        for (let i = 1; i < dailyData.length; i++) {
            if (dailyData[i][1] > maxSales) {
                maxSales = dailyData[i][1];
                maxDay = dailyData[i][0];
            }
        }
        document.getElementById('highest-day').innerText = maxDay;
    }
</script>
</head>
<body>
   <div class="side">
        <c:import url="/WEB-INF/views/include/manager_side.jsp" />
    </div>
<div class="sales-container">
    <div class="sales-header">
        <h2>하루 매출 현황</h2>
        <p><span class="sales-date">2025년 4월 2일</span> 기준 매출 데이터</p>
    </div>
    
    <div class="sales-summary">
        <div class="total-sales">
            <h3>오늘 총 매출액</h3>
            <div class="amount">
                <fmt:formatNumber value="${sales}" type="currency" currencySymbol="₩" maxFractionDigits="0"/>
            </div>
        </div>
    </div>
    
    <div class="card-container">
        <div class="stat-card">
            <div class="stat-title">주간 평균 매출</div>
            <div class="stat-value" id="weekly-average">-</div>
        </div>
        <div class="stat-card">
            <div class="stat-title">어제 매출</div>
            <div class="stat-value" id="yesterday-sales">-</div>
        </div>
        <div class="stat-card">
            <div class="stat-title">전일 대비</div>
            <div class="stat-value" id="daily-growth">-</div>
        </div>
        <div class="stat-card">
            <div class="stat-title">주간 최고 매출일</div>
            <div class="stat-value" id="highest-day">-</div>
        </div>
    </div>
    
    <div class="chart-container" id="sales_chart"></div>
</div>

<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>