<%--
  User: 1
  Date: 2024-11-30
  Time: 오후 4:45
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<style>
    #container {
        height: 400px;
        margin: 0 auto;
        border: 1px solid #ccc; /* 차트 테두리 추가 */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 차트 상자 그림자 */
        border-radius: 8px; /* 부드러운 모서리 */
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

    #sliders {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        gap: 1rem; /* 슬라이더 사이 간격 */
        margin-top: 1rem;
        width: 100%;
        max-width: 600px;
    }

    #sliders table {
        width: 100%;
        border-spacing: 0.5rem;
    }

    #sliders td {
        padding-right: 1rem;
        white-space: nowrap;
        font-size: 0.9rem;
        color: #333; /* 텍스트 색상 */
    }

    #sliders input[type="range"] {
        width: 100%; /* 슬라이더 너비 조정 */
        cursor: pointer;
        accent-color: #007bff; /* 슬라이더 강조 색상 */
    }

    .highcharts-description {
        text-align: center;
        font-size: 0.9rem;
        color: #666; /* 설명 텍스트 색상 */
        margin-top: 1rem;
        line-height: 1.4;
    }


</style>

<script>
    let monthchart = {
        chart: null,

        // 초기화 메서드
        init: function () {
            this.fetchData();
            this.setupSliders();
        },

        // 데이터 로드 메서드 (Spring Service 활용)
        fetchData: function () {
            $.ajax({
                url: '/iot/monthelec',
                method: 'GET',
                dataType: 'json',
                success: (data) => {
                    // 데이터를 포맷해서 차트 렌더링
                    const formattedData = data.map(item => [item.month, parseFloat(item.total_value)]);
                    this.renderChart(formattedData);
                },
                error: (xhr, status, error) => {
                    console.error('Failed to load data from monthelec service:', error);
                }
            });
        },

        // 차트 렌더링 메서드
        renderChart: function (data) {
            console.log(data)
            this.chart = Highcharts.chart('container', {
                chart: {
                    type: 'column',
                    options3d: {
                        enabled: true,
                        alpha: 0,
                        beta: 0,
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
                    text: 'Monthly Electricity Usage',
                    align: 'left'
                },
                subtitle: {
                    text: 'Source: Smart Building System',
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

        // 슬라이더 설정 메서드
        setupSliders: function () {
            const self = this;

            // 슬라이더 이벤트 핸들러
            $('#sliders input').on('input', function () {
                const { id, value } = this;
                if (self.chart) {
                    self.chart.options.chart.options3d[id] = parseFloat(value);
                    self.chart.redraw(false);
                    self.showValues();
                }
            });

            this.showValues();
        },

        // 슬라이더 값 표시 메서드
        showValues: function () {
            if (!this.chart) return;

            $('#alpha-value').text(this.chart.options.chart.options3d.alpha);
            $('#beta-value').text(this.chart.options.chart.options3d.beta);
            $('#depth-value').text(this.chart.options.chart.options3d.depth);
        }
    };

    // 초기화
    $(function () {
        monthchart.init();
    });
</script>


<body>
<figure class="highcharts-figure">
    <div id="container"></div>

    <div id="sliders">
        <table>
            <tr>
                <td><label for="alpha">Alpha Angle</label></td>
                <td><input id="alpha" type="range" min="0" max="45" value="15"/> <span id="alpha-value" class="value"></span></td>
            </tr>
            <tr>
                <td><label for="beta">Beta Angle</label></td>
                <td><input id="beta" type="range" min="-45" max="45" value="15"/> <span id="beta-value" class="value"></span></td>
            </tr>
            <tr>
                <td><label for="depth">Depth</label></td>
                <td><input id="depth" type="range" min="20" max="100" value="50"/> <span id="depth-value" class="value"></span></td>
            </tr>
        </table>
    </div>
</figure>




</body>
</html>