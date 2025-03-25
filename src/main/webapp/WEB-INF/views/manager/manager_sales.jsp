<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매 현황 대시보드</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- 네이버 폰트 -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGaRamYeonGgoc.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
    body {
        background-color: #f8f9fa;
        font-family: 'Noto Sans KR', sans-serif;
    }
    
    .main {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }
    
    .dashboard-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }
    
    .title {
        background-color: #fff;
        padding: 15px 0;
        margin-bottom: 30px;
        border-bottom: 2px solid #333;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    
    .title h1 {
        font-family: 'NanumGaRamYeonGgoc', sans-serif;
        text-align: center;
        margin: 0;
        color: #333;
    }
    
    .summary-cards {
        display: flex;
        justify-content: space-between;
        margin-bottom: 30px;
        flex-wrap: wrap;
    }
    
    .summary-card {
        background: white;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        flex: 1;
        margin: 0 10px;
        min-width: 200px;
        text-align: center;
        transition: transform 0.3s;
    }
    
    .summary-card:hover {
        transform: translateY(-5px);
    }
    
    .summary-card i {
        font-size: 2.5rem;
        margin-bottom: 15px;
        color: #4e73df;
    }
    
    .summary-card .card-title {
        font-size: 1rem;
        color: #666;
        margin-bottom: 10px;
    }
    
    .summary-card .card-value {
        font-size: 1.8rem;
        font-weight: bold;
        color: #333;
    }
    
    .chart-container {
        background: white;
        border-radius: 8px;
        padding: 25px;
        margin-bottom: 30px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .chart-title {
        font-size: 1.4rem;
        margin-bottom: 20px;
        color: #333;
        font-weight: 600;
        display: flex;
        align-items: center;
    }
    
    .chart-title i {
        margin-right: 10px;
        color: #4e73df;
    }
    
    .chart-description {
        margin-top: 10px;
        color: #666;
        font-size: 0.9rem;
    }
    
    .chart-notes {
        margin-top: 15px;
        padding: 15px;
        background-color: #f8f9fa;
        border-radius: 5px;
        font-size: 0.9rem;
    }
    
    .chart-notes ul {
        padding-left: 20px;
        margin-bottom: 0;
    }
    
    .chart-notes li {
        margin-bottom: 5px;
    }
    
    .date-filter {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .date-filter label {
        margin-right: 10px;
        font-weight: 600;
    }
    
    .date-filter select {
        padding: 8px 15px;
        border-radius: 4px;
        border: 1px solid #ddd;
        margin-right: 15px;
    }
    
    @media (max-width: 768px) {
        .summary-cards {
            flex-direction: column;
        }
        
        .summary-card {
            margin: 10px 0;
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
    <div class="dashboard-container">
        <div class="title">
            <h1>내 판매 현황</h1>
        </div>
        
        <!-- 요약 정보 카드 -->
        <div class="summary-cards">
            <div class="summary-card">
                <i class="fas fa-shopping-cart"></i>
                <div class="card-title">오늘 판매량</div>
                <div class="card-value">12건</div>
            </div>
            <div class="summary-card">
                <i class="fas fa-won-sign"></i>
                <div class="card-title">오늘 매출</div>
                <div class="card-value">320,000원</div>
            </div>
            <div class="summary-card">
                <i class="fas fa-chart-line"></i>
                <div class="card-title">이번 주 총 매출</div>
                <div class="card-value">1,540,000원</div>
            </div>
            <div class="summary-card">
                <i class="fas fa-calendar-check"></i>
                <div class="card-title">이번 달 총 매출</div>
                <div class="card-value">4,820,000원</div>
            </div>
        </div>
        
        <!-- 주간 판매 차트 컨테이너 -->
        <div class="chart-container">
            <div class="chart-title">
                <i class="fas fa-chart-bar"></i>
                주간 판매 현황
            </div>
            <div class="date-filter">
                <label for="weekSelect">기준 주:</label>
                <select id="weekSelect" onchange="updateWeeklyChart()">
                    <option value="current">현재 주 (${currentWeekStartDate} ~ ${currentWeekEndDate})</option>
                    <option value="prev1">1주 전</option>
                    <option value="prev2">2주 전</option>
                    <option value="prev3">3주 전</option>
                </select>
            </div>
            <div id="weekly_chart" style="width: 100%; height: 400px;"></div>
            <div class="chart-description">
                위 그래프는 선택한 주의 일별 판매 금액을 보여줍니다.
            </div>
            <div class="chart-notes">
                <strong>차트 정보:</strong>
                <ul>
                    <li>X축: 날짜 (월요일 ~ 일요일)</li>
                    <li>Y축: 일별 총 판매 금액 (원)</li>
                    <li>데이터 업데이트: 매일 자정에 업데이트됩니다.</li>
                </ul>
            </div>
        </div>
        
        <!-- 월간 판매 차트 컨테이너 -->
        <div class="chart-container">
            <div class="chart-title">
                <i class="fas fa-chart-line"></i>
                월간 판매 현황
            </div>
            <div class="date-filter">
                <label for="monthSelect">기준 월:</label>
                <select id="monthSelect" onchange="updateMonthlyChart()">
                    <option value="current">현재 월 (${currentMonth})</option>
                    <option value="prev1">1개월 전</option>
                    <option value="prev2">2개월 전</option>
                    <option value="prev3">3개월 전</option>
                </select>
            </div>
            <div id="monthly_chart" style="width: 100%; height: 400px;"></div>
            <div class="chart-description">
                위 그래프는 선택한 월의 주차별 판매 금액을 보여줍니다.
            </div>
            <div class="chart-notes">
                <strong>차트 정보:</strong>
                <ul>
                    <li>X축: 주차 (1주차 ~ 5주차)</li>
                    <li>Y축: 주차별 총 판매 금액 (원)</li>
                    <li>데이터 업데이트: 매주 월요일 자정에 업데이트됩니다.</li>
                    <li>주차 계산: 각 월의 1일부터 시작하여 7일 단위로 주차를 계산합니다.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- 구글 차트 라이브러리 로드 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    // 구글 차트 로드
    google.charts.load("current", {packages:['corechart']});
    google.charts.setOnLoadCallback(drawCharts);
    
    // 현재 날짜 정보 가져오기
    const today = new Date();
    const currentYear = today.getFullYear();
    const currentMonth = today.getMonth(); // 0-11
    const currentDay = today.getDate();
    
    // 이번 주의 시작일과 종료일 계산
    function getWeekDates(offsetWeeks = 0) {
        let currentDate = new Date();
        currentDate.setDate(currentDate.getDate() + (offsetWeeks * 7));
        
        // 이번 주 월요일 구하기
        let monday = new Date(currentDate);
        monday.setDate(currentDate.getDate() - currentDate.getDay() + 1); // 월요일로 설정
        
        // 이번 주 일요일 구하기
        let sunday = new Date(monday);
        sunday.setDate(monday.getDate() + 6);
        
        return {
            start: monday,
            end: sunday
        };
    }
    
    // 날짜 포맷팅 함수 (YYYY-MM-DD)
    function formatDate(date) {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    }
    
    // 요일 이름 가져오기
    function getDayName(date) {
        const days = ['일', '월', '화', '수', '목', '금', '토'];
        return days[date.getDay()];
    }
    
    // 차트 그리기 함수
    function drawCharts() {
        drawWeeklyChart('current');
        drawMonthlyChart('current');
    }
    
    // 주간 차트 업데이트
    function updateWeeklyChart() {
        const weekSelect = document.getElementById('weekSelect');
        drawWeeklyChart(weekSelect.value);
    }
    
    // 월간 차트 업데이트
    function updateMonthlyChart() {
        const monthSelect = document.getElementById('monthSelect');
        drawMonthlyChart(monthSelect.value);
    }
    
    // 주간 차트 그리기
    function drawWeeklyChart(weekOption) {
        // 선택된 주에 따라 날짜 범위 계산
        let weekOffset = 0;
        switch(weekOption) {
            case 'prev1': weekOffset = -1; break;
            case 'prev2': weekOffset = -2; break;
            case 'prev3': weekOffset = -3; break;
            default: weekOffset = 0; // current
        }
        
        const weekDates = getWeekDates(weekOffset);
        const startDate = weekDates.start;
        const endDate = weekDates.end;
        
        // 임시 데이터 생성 (실제로는 DB에서 가져올 데이터)
        const dailySalesData = [];
        
        // 월요일부터 일요일까지의 데이터 생성
        for (let i = 0; i < 7; i++) {
            const currentDate = new Date(startDate);
            currentDate.setDate(startDate.getDate() + i);
            
            // 판매액 - 임의의 데이터 생성 (실제로는 DB에서 가져와야 함)
            // 주말에는 매출이 더 높게, 평일에는 평균적으로 설정
            let salesAmount;
            const dayOfWeek = currentDate.getDay(); // 0(일) ~ 6(토)
            
            if (dayOfWeek === 0 || dayOfWeek === 6) { // 주말
                salesAmount = Math.floor(Math.random() * 300000) + 200000; // 200,000원 ~ 500,000원
            } else { // 평일
                salesAmount = Math.floor(Math.random() * 200000) + 100000; // 100,000원 ~ 300,000원
            }
            
            // 과거 데이터는 약간 낮게 설정
            if (weekOffset < 0) {
                salesAmount = salesAmount * (1 + (weekOffset * 0.1)); // 과거로 갈수록 10%씩 낮게
            }
            
            const formattedDate = formatDate(currentDate);
            const dayName = getDayName(currentDate);
            
            dailySalesData.push([`${formattedDate} (${dayName})`, salesAmount]);
        }
        
        // 차트 데이터 생성
        var data = new google.visualization.DataTable();
        data.addColumn('string', '날짜');
        data.addColumn('number', '판매 금액');
        data.addRows(dailySalesData);
        
        // 차트 옵션 설정
        var options = {
            title: `판매 현황: ${formatDate(startDate)} ~ ${formatDate(endDate)}`,
            width: '100%',
            height: 400,
            bar: {groupWidth: "70%"},
            legend: { position: "none" },
            hAxis: {
                title: '날짜',
                titleTextStyle: {
                    fontName: 'Noto Sans KR',
                    fontSize: 12,
                    italic: false
                }
            },
            vAxis: {
                title: '판매 금액 (원)',
                titleTextStyle: {
                    fontName: 'Noto Sans KR',
                    fontSize: 12,
                    italic: false
                },
                format: '#,###원'
            },
            colors: ['#4e73df'],
            animation: {
                startup: true,
                duration: 1000,
                easing: 'out'
            }
        };
        
        // 차트 그리기
        var chart = new google.visualization.ColumnChart(document.getElementById("weekly_chart"));
        chart.draw(data, options);
    }
    
    // 월간 차트 그리기
    function drawMonthlyChart(monthOption) {
        // 선택된 월에 따라 날짜 범위 계산
        let monthOffset = 0;
        switch(monthOption) {
            case 'prev1': monthOffset = -1; break;
            case 'prev2': monthOffset = -2; break;
            case 'prev3': monthOffset = -3; break;
            default: monthOffset = 0; // current
        }
        
        const selectedDate = new Date();
        selectedDate.setMonth(selectedDate.getMonth() + monthOffset);
        
        const selectedYear = selectedDate.getFullYear();
        const selectedMonth = selectedDate.getMonth();
        
        // 선택된 월의 이름
        const monthNames = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
        const selectedMonthName = monthNames[selectedMonth];
        
        // 선택된 월의 주차 수 계산
        const firstDayOfMonth = new Date(selectedYear, selectedMonth, 1);
        const lastDayOfMonth = new Date(selectedYear, selectedMonth + 1, 0);
        const totalDaysInMonth = lastDayOfMonth.getDate();
        
        // 주차 수 계산 (올림하여 계산)
        const weeksInMonth = Math.ceil(totalDaysInMonth / 7);
        
        // 임시 데이터 생성 (실제로는 DB에서 가져올 데이터)
        const weeklySalesData = [];
        
        for (let week = 1; week <= weeksInMonth; week++) {
            // 주차별 판매액 - 임의의 데이터 생성 (실제로는 DB에서 가져와야 함)
            let salesAmount;
            
            // 월초와 월말은 상대적으로 매출이 낮게, 중간은 높게 설정
            if (week === 1 || week === weeksInMonth) {
                salesAmount = Math.floor(Math.random() * 400000) + 300000; // 300,000원 ~ 700,000원
            } else {
                salesAmount = Math.floor(Math.random() * 500000) + 500000; // 500,000원 ~ 1,000,000원
            }
            
            // 과거 데이터는 약간 낮게 설정
            if (monthOffset < 0) {
                salesAmount = salesAmount * (1 + (monthOffset * 0.1)); // 과거로 갈수록 10%씩 낮게
            }
            
            weeklySalesData.push([`${week}주차`, salesAmount]);
        }
        
        // 차트 데이터 생성
        var data = new google.visualization.DataTable();
        data.addColumn('string', '주차');
        data.addColumn('number', '판매 금액');
        data.addRows(weeklySalesData);
        
        // 차트 옵션 설정
        var options = {
            title: `${selectedYear}년 ${selectedMonthName} 판매 현황`,
            width: '100%',
            height: 400,
            bar: {groupWidth: "70%"},
            legend: { position: "none" },
            hAxis: {
                title: '주차',
                titleTextStyle: {
                    fontName: 'Noto Sans KR',
                    fontSize: 12,
                    italic: false
                }
            },
            vAxis: {
                title: '판매 금액 (원)',
                titleTextStyle: {
                    fontName: 'Noto Sans KR',
                    fontSize: 12,
                    italic: false
                },
                format: '#,###원'
            },
            colors: ['#36b9cc'],
            animation: {
                startup: true,
                duration: 1000,
                easing: 'out'
            }
        };
        
        // 차트 그리기
        var chart = new google.visualization.ColumnChart(document.getElementById("monthly_chart"));
        chart.draw(data, options);
    }
</script>

<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>