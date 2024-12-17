<%--&lt;%&ndash;--%>
<%--  User: 1--%>
<%--  Date: 2024-11-30--%>
<%--  Time: 오후 4:45--%>
<%--&ndash;%&gt;--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<%--<html>--%>

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
    }
</style>

<script>
    let progress = {
        ave: function (avg, latval) {
            let percentageDifference;

            if (latval >= avg) {
                percentageDifference = 100 + ((latval - avg) / avg) * 100;
            } else {
                percentageDifference = (latval / avg) * 100;
            }

            $(".progress-value").css("width", percentageDifference + "%");

            if (latval < avg * 0.8) {
                $(".progress-value").css("background", "#00ff00");
            } else if (latval >= avg * 0.8 && latval <= avg) {
                $(".progress-value").css("background", "#ffcc00");
            } else {
                $(".progress-value").css("background", "#ff4d4d");
            }

            $("#averageValue").text("평균 사용량: " + avg.toFixed(2) + " kWh");
            $("#latestValue").text(latval.toFixed(2) + " kWh");
            $("#differencePercent").text("현재 사용량이 평균값 대비 " + percentageDifference.toFixed(2) + "% 입니다.");
        }
    };

    let price = {
        calc: function (latval) {
            const ratePer100Kw = 10000; // 100kW당 비용
            const estimatedPrice = (latval / 100) * ratePer100Kw;
            const formattedPrice = estimatedPrice.toLocaleString();
            console.log("전기세" + formattedPrice);

            $('#elecprice').html('예상 전기료: <strong>' + formattedPrice + '</strong>원');
        }
    };

    let monthchart = {
        chart: null,

        init: function () {
            this.fetchData();
        },

        // 데이터 로드
        fetchData: function () {
            $.ajax({
                url: '/iot/monthelec',
                method: 'GET',
                dataType: 'json',
                success: (data) => {
                    const formattedData = data.map(item => [item.month, parseFloat(item.total_value)]);
                    this.renderChart(formattedData);

                    const months = data.map(item => item.month);
                    const values = data.map(item => parseFloat(item.total_value));
                    electable.tb(months, values);

                    const avg = values.reduce((acc, val) => acc + val, 0) / values.length;
                    const latval = values[values.length - 1];
                    progress.ave(avg, latval);
                    price.calc(latval);
                },
                error: (xhr, status, error) => {
                    console.error('Failed to load data from monthelec service:', error);
                }
            });
        },

        // 차트 렌더링
        renderChart: function (data) {
            console.log(data)
            this.chart = Highcharts.chart('container', {
                chart: {
                    type: 'column',
                    options3d: {
                        enabled: true,
                        alpha: 17,
                        beta: 20,
                        depth: 0,
                        viewDistance: 25
                    }
                },
                xAxis: {
                    type: 'category',
                    title: {
                        text: 'Month'
                    }
                },
                yAxis: {
                    title: {
                        text: 'Total Electricity Usage (kWh)'
                    }
                },
                tooltip: {
                    headerFormat: '<b>{point.key}</b><br>',
                    pointFormat: 'Electricity Usage: {point.y} kWh'
                },
                title: {
                    text: '월별 전력 사용량',
                    align: 'left'
                },
                subtitle: {
                    text: '단위 : KWh',
                    align: 'left'
                },
                legend: {
                    enabled: false
                },
                plotOptions: {
                    column: {
                        depth: 25
                    }
                },
                series: [{
                    name: 'Electricity Usage',
                    data: data,
                    colorByPoint: true
                }]
            });
        },
    };

    let electable = {
        tb: function (months, values) {
            const tableBody = document.querySelector('#data-table tbody');
            tableBody.innerHTML = '';

            months.forEach((month, index) => {
                const row = document.createElement('tr');
                const monthCell = document.createElement('td');
                monthCell.textContent = month;
                row.appendChild(monthCell);

                const valueCell = document.createElement('td');
                valueCell.textContent = values[index].toFixed(2) + ' kWh';
                row.appendChild(valueCell);

                tableBody.appendChild(row);
            });
        }
    };

    let chart = {
        chartInstance: null,
        init: function () {
            this.initchart();
            this.getdata();
            setInterval(() => {
                this.getdata();
            }, 5000);
        },
        initchart: function () {
            this.chartInstance = Highcharts.chart('container3', {
                chart: {
                    type: 'areaspline'
                },
                title: {
                    text: '전력 사용량'
                },
                xAxis: {
                    type: 'datetime', // X축에 시간 표시
                    title: {
                        text: '시간'
                    }
                },
                yAxis: {
                    title: {
                        text: '전력 값 (W)'
                    }
                },
                plotOptions: {
                    areaspline: {
                        color: '#63a0ef',
                        fillColor: {
                            linearGradient: { x1: 0, x2: 0, y1: 0, y2: 1 },
                            stops: [
                                [0, '#63a0ef'],
                                [1, '#63a0ef00']
                            ]
                        },
                        threshold: null,
                        marker: {
                            lineWidth: 1,
                            lineColor: null,
                            fillColor: 'white'
                        }
                    }
                },
                series: [
                    {
                        name: 'IoT 데이터',
                        data: [] // 초기 데이터
                    }
                ]
            });
        },
        display: function (data) {
            if (this.chartInstance) {
                const series = this.chartInstance.series[0];

                const chartData = {
                    x: new Date(data.total_time).getTime(),
                    y: data.total
                };

                series.addPoint(chartData, true, series.data.length >= 20);
            } else {
                console.error("차트가 초기화되지 않았습니다.");
            }
        },
        getdata: function () {
            $.ajax({
                url: '/iot/chartdata',
                type: 'GET',
                success: (data) => {
                    if (data) {
                        this.display(data);
                    } else {
                        console.error('서버에서 데이터를 가져오지 못했습니다.');
                    }
                },
                error: (xhr, status, error) => {
                    console.error('데이터 요청 중 오류 발생:', status, error);
                }
            });
        }
    };

    let cur = {
        init: function () {
            this.fetchTemperature();
            this.fetchHumidity();
        },

        fetchTemperature: function () {
            $.ajax({
                url: '/iot/temp',
                method: 'GET',
                success: function (data) {
                    $('#temp').text(data.toFixed(1) + '°C');
                },
                error: function (xhr, status, error) {
                    console.error('온도 데이터를 가져오지 못했습니다:', error);
                    $('#temp').text('-- °C');
                }
            });
        },

        fetchHumidity: function () {
            $.ajax({
                url: '/iot/hum',
                method: 'GET',
                success: function (data) {
                    $('#hum').text(data.toFixed(1) + '%');
                },
                error: function (xhr, status, error) {
                    console.error('습도 데이터를 가져오지 못했습니다:', error);
                    $('#hum').text('-- %');
                }
            });
        }
    };


    $(function () {
        monthchart.init();
        chart.init();
        cur.init();

        $('#chart').on('click', function () {
            $('#container').show(); // Show chart container
            $('#data-table').hide(); // Hide table container
            $(this).addClass('active'); // Highlight active button
            $('#table').removeClass('active');
        });

        $('#table').on('click', function () {
            $('#container').hide(); // Hide chart container
            $('#data-table').show(); // Show table container
            $(this).addClass('active'); // Highlight active button
            $('#chart').removeClass('active');
        });

        // Hide table by default
        $('#data-table').hide();
    });
</script>

<body>

<div class="dashboard-container">
    <!-- 상단 카드 섹션 -->
    <div class="stats-cards">
        <div class="stat-card power-usage">
            <div class="card-header">
                <h3>전력 사용량</h3>
                <div class="icon2">
                    <i class="fas fa-bolt"></i>
                </div>
            </div>


            <div class="card-content">
                <div class="usage-info">
                    <div class="main-value" id="latestValue">-- kWh</div>
                    <div class="sub-value">이번달 사용량</div>
                </div>
                <div class="progress-container">
                    <div id="progress-bar" class="progress-bar">
                        <div class="progress-value"></div>
                    </div>
                    <div class="progress-labels">
                        <span id="averageValue"></span>
                        <span id="differencePercent"></span>
                    </div>
                </div>
            </div>
        </div>

        <div class="stat-card environment">
            <div class="card-header">
                <h3>온 / 습도</h3>
                <div class="icon2">
                    <i class="fas fa-temperature-high"></i>
                </div>
            </div>
            <div class="card-content">
                <div class="env-stats">
                    <div class="temp-stat">
                        <div class="value" id="temp">--°C</div>
                        <div class="label">온도</div>
                    </div>
                    <div class="humidity-stat">
                        <div class="value" id="hum">--%</div>
                        <div class="label">습도</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="stat-card estimated-cost">
            <div class="card-header">
                <h3>예상 전기료</h3>
                <div class="icon2">
                    <i class="fas fa-won-sign"></i>
                </div>
            </div>
            <div class="card-content">
                <div id="elecprice" class="cost-value"></div>
                <div class="trend">
                    <span class="trend-icon2 up">↑</span>
                    <span class="trend-value">5.2% 전월 대비</span>
                </div>
            </div>
        </div>
    </div>

    <!-- 차트 섹션 -->
    <div class="charts-section">
        <div class="chart-container monthly-usage">
            <div class="chart-header">
                <h3>월별 전력 사용량</h3>
                <div class="chart-controls">
                    <button class="view-toggle active" id="chart">차트</button>
                    <button class="view-toggle" id="table">테이블</button>
                </div>
            </div>
            <div id="container" class="chart-content"></div>
            <table id="data-table" class="chart-content" style="display: none; width: 100%; border-collapse: collapse;">
                <thead>
                <tr>
                    <th>월</th>
                    <th>사용량 (kWh)</th>
                </tr>
                </thead>
                <tbody>
                <!-- 테이블 데이터 js로 추가 -->
                </tbody>
            </table>
        </div>


        <div class="chart-container realtime-data">
            <div class="chart-header">
                <h3>실시간 전력 사용량</h3>
            </div>
            <div id="container3" class="chart-content"></div>
        </div>
    </div>
</div>

</body>


<style>
    .dashboard-container {
        padding: 2rem;
        background: #f8f9fa;
        min-height: 100vh;
    }

    .stats-cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }

    .stat-card {
        background: white;
        border-radius: 16px;
        padding: 1.5rem;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        transition: transform 0.3s ease;
    }

    .stat-card:hover {
        transform: translateY(-5px);
    }

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1.5rem;
    }

    .card-header h3 {
        font-size: 1.25rem;
        color: #2c3e50;
        margin: 0;
    }

    .icon2 {
        width: 48px;
        height: 48px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
    }

    .power-usage .icon2 {
        background: #e3f2fd;
        color: #1976d2;
    }

    .environment .icon2 {
        background: #e8f5e9;
        color: #388e3c;
    }

    .estimated-cost .icon2 {
        background: #fff3e0;
        color: #f57c00;
    }

    .main-value {
        font-size: 1.75rem;
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 0.5rem;
    }

    .sub-value {
        color: #7f8c8d;
        font-size: 0.9rem;
    }

    .progress-container {
        margin-top: 1.5rem;
    }

    .progress-bar {
        height: 8px;
        background: #e9ecef;
        border-radius: 4px;
        overflow: hidden;
        margin-bottom: 0.5rem;
    }

    .progress-value {
        height: 100%;
        background: #4caf50;
        border-radius: 4px;
        transition: width 0.3s ease;
    }

    .env-stats {
        display: flex;
        justify-content: space-around;
    }

    .temp-stat, .humidity-stat {
        text-align: center;
    }

    .value {
        font-size: 2rem;
        font-weight: 600;
        color: #2c3e50;
    }

    .label {
        color: #7f8c8d;
        font-size: 0.9rem;
        margin-top: 0.5rem;
    }

    .cost-value {
        font-size: 2rem;
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 1rem;
    }

    .trend {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        color: #7f8c8d;
    }

    .trend-icon2.up {
        color: #4caf50;
    }

    .charts-section {
        display: grid;
        grid-template-columns: 2fr 1fr;
        gap: 1.5rem;
    }

    .chart-container {
        background: white;
        border-radius: 16px;
        padding: 1.5rem;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
    }

    .chart-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1.5rem;
    }

    .chart-controls {
        display: flex;
        gap: 0.5rem;
    }

    .view-toggle {
        padding: 0.5rem 1rem;
        border: 1px solid #e9ecef;
        border-radius: 8px;
        background: none;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .view-toggle.active {
        background: #4a90e2;
        color: white;
        border-color: #4a90e2;
    }

    .refresh-time {
        color: #7f8c8d;
        font-size: 0.9rem;
    }

    .chart-content {
        height: 400px;
    }

    #data-table tbody td {
        border-top: 2px solid black;
        margin-top: 10px;
    }
</style>