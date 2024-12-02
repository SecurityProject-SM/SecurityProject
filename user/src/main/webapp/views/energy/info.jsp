<%--
  User: 1
  Date: 2024-11-30
  Time: 오후 4:45
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
    }

    #main-container {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: flex-start;
        gap: 2rem;
        width: 100%;
        max-width: 100%; /* 페이지 전체 너비 사용 */
        padding: 2rem;
        box-sizing: border-box; /* 패딩 포함 */
    }

    #chart-container {
        margin-top: 25px;
        flex: 3; /* 차트 영역 크기 비율 */
        display: flex;
        flex-direction: column;
        align-items: stretch; /* 차트가 컨테이너에 맞게 확장 */
        min-width: 0; /* 유연한 크기 조정 */
    }

    #table-container {
        margin-top: 55px;

        flex: 2; /* 테이블 영역 크기 비율 */
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 1rem;
        background-color: #f9f9f9;
        min-width: 0;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    table th, table td {
        border: 1px solid #ddd;
        padding: 0.5rem;
        text-align: left;
    }

    table th {
        background-color: #f4f4f4;
    }


    #container {
        height: 400px;
        margin: 0 auto;
        border: 1px solid #ccc;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 차트 상자 그림자 */
        border-radius: 8px;
        background-color: #f9f9f9; /* 배경 색상 */
    }

    .highcharts-figure {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        max-width: 800px;
        margin: 2rem auto; /* 중앙 정렬 및 상하 간격 */
        padding: 1rem;
        border: 1px solid #ddd;
        border-radius: 10px;
        background-color: #ffffff;
    }


</style>

<script>
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

    $(function () {
        monthchart.init();
    });
</script>


<body>

<div class="row">
    <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
        <div class="card">
            <div class="card-body p-3">
                <div class="row">
                    <div class="col-8">
                        <h4>금일 사용 전력</h4>
                        <h3 id="elec"></h3>
                    </div>
                    <div class="col-4">
                        <img src="img/electric.png" style="width: 90%">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- 주차 --%>
    <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
        <div class="card">
            <div class="card-body p-3">
                <div class="row">
                    <div class="col-8">
                        <div class="status-box" id="park_stat">
                            <h6>총주차칸 : 24</h6>
                            <h6 style="float:left">주차가능 : </h6>
                            <h6 id="availableCount">...</h6>
                            <h6 style="float:left">주차중 :</h6>
                            <h6 id="parkingCount">...</h6>
                        </div>
                    </div>
                    <div class="col-4">
                        <img src="img/park.png" style="width: 90%">
                    </div>
                </div>
                <div class="progress">
                    <div class="progress-value"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
        <div class="card">
            <div class="card-body p-3">
                <div class="row">
                    <div class="col-8">
                        <pre class="card-body" id="weatherContainer">날씨 데이터를 불러오는 중...</pre>
                    </div>
                    <div class="col-4">
                        <div id="imgContainer" style="width: 90%"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
        <div class="card">
            <div class="card-body p-3">
                <div class="row">
                    <div class="col-8">
                        <h3>월세 납부일</h3>
                        <div id="remainingDays">남은 일수:</div>
                    </div>

                    <div class="col-4">
                        <img src="<c:url value="img/dnjftp.jpg"/>" style="width: 90%">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div id="main-container">
    <!-- 차트 영역 -->
    <div id="chart-container">
        <figure class="highcharts-figure">
            <div id="container"></div>
        </figure>
    </div>

    <!-- 테이블 영역 -->
    <div id="table-container">
        <h3>월간 사용 전력</h3>
        <table id="data-table">
            <thead>
            <tr>
                <th>년월</th>
                <th>총 사용 전력 (kWh)</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>