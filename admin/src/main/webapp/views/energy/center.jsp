<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Building Floor Overlay</title>


    <style>
        /* 현재 사용량 차트 CSS */
        .highcharts-figure,
        .highcharts-data-table table {
            min-width: 310px;
            max-width: 500px;
            margin: 1em auto;
        }

        .highcharts-data-table table {
            font-family: Verdana, sans-serif;
            border-collapse: collapse;
            border: 1px solid #ebebeb;
            margin: 10px auto;
            text-align: center;
            width: 100%;
            max-width: 500px;
        }

        .highcharts-data-table caption {
            padding: 1em 0;
            font-size: 1.2em;
            color: #555;
        }

        .highcharts-data-table th {
            font-weight: 600;
            padding: 0.5em;
        }

        .highcharts-data-table td,
        .highcharts-data-table th,
        .highcharts-data-table caption {
            padding: 0.5em;
        }

        .highcharts-data-table thead tr,
        .highcharts-data-table tr:nth-child(even) {
            background: #f8f8f8;
        }

        .highcharts-data-table tr:hover {
            background: #f1f7ff;
        }

        .highcharts-description {
            margin: 0.3rem 10px;
        }


        /*월별 차트 CSS*/
        .highcharts-figure,
        .highcharts-data-table table {
            min-width: 310px;
            max-width: 800px;
            margin: 1em auto;
        }

        #datatable {
            font-family: Verdana, sans-serif;
            border-collapse: collapse;
            border: 1px solid #ebebeb;
            margin: 10px auto;
            text-align: center;
            width: 100%;
            max-width: 500px;
        }

        #datatable caption {
            padding: 1em 0;
            font-size: 1.2em;
            color: #555;
        }

        #datatable th {
            font-weight: 600;
            padding: 0.5em;
        }

        #datatable td,
        #datatable th,
        #datatable caption {
            padding: 0.5em;
        }

        #datatable thead tr,
        #datatable tr:nth-child(even) {
            background: #f8f8f8;
        }

        #datatable tr:hover {
            background: #f1f7ff;
        }

        .highcharts-description {
            margin: 0.3rem 10px;
        }


        #totalContainer {
            width: 400px;
            height: 300px;
            /*border: 2px solid red;*/
        }

        #monthContainer {
            width: 1000px;
            height: 600px;
        }

        /* 전체 컨테이너 */
        .main-container {
            display: flex;
            justify-content: space-between;
            width: 100%;
            height: 550px;
        }

        /* 오른쪽 정보 패널 */
        .info-panel {
            overflow-y: auto; /* 내부 콘텐츠가 panel 크기를 초과할 경우 스크롤 생성 */
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border: none;

            border-radius: 10px;
            background-color: rgba(0, 0, 0, .2);

            width: 50%;
            padding: 20px;
            height: 500px;
        }

        .info-panel h2 {
            margin-top: 0;
            color: #000; /* 텍스트 색상을 검은색으로 설정 */
        }

        .info-panel p {
            color: #000; /* 텍스트 색상을 검은색으로 설정 */
            font-size: 1rem; /* 필요시 글자 크기 조정 */
        }

        .floor-data-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
        }

        .room-card {
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #e8f5e9; /* 기본: 초록색 배경 */
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .room-card[data-status="warning"] {
            background-color: #fff3e0; /* 주의: 주황색 배경 */
        }

        .room-card[data-status="critical"] {
            background-color: #ffebee; /* 경고: 빨간색 배경 */
        }

        .room-card .room-title {
            font-weight: bold;
            color: #000; /* 글씨 색상 검정 */
        }

        .room-card .room-info {
            font-size: 0.9rem;
            /*color: #555;*/
            color: #000;
        / * 글씨 색상 검정 * /
        }

        .info-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .info-title {
            display: flex;
            flex-direction: column;
        }

        .info-title h2 {
            font-size: 1.5rem;
            margin: 0;
            color: #000; /* 검은색 글씨 */
        }

        .info-title .subtitle {
            font-size: 0.9rem;
            color: #666; /* 회색 글씨 */
        }

        .status-indicators {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .status-indicator {
            display: flex;
            align-items: center;
            font-size: 0.9rem;
            color: #000; /* 검은색 글씨 */
            gap: 5px;
            /*background-color: rgba(255, 255, 255); !* 흰색 배경 + 50% 투명도 *!*/
            background: linear-gradient(135deg, #93c5fd, #c4b5fd);
            border-radius: 10px;
            border: 2px solid gray;
            padding: 1px 6px; /* 위아래 5px, 좌우 10px 여백 추가 */
        }

        .status-indicator span {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            display: inline-block;
        }

        .status-normal span {
            background-color: #4caf50; /* 녹색 */
        }

        .status-warning span {
            background-color: #ff9800; /* 주황색 */
        }

        .status-critical span {
            background-color: #f44336; /* 빨간색 */
        }


        .info-row {
            display: flex; /* 플렉스 컨테이너로 설정 */
            align-items: center; /* 세로 정렬 */
            gap: 15px; /* 아이콘과 텍스트 사이 간격 */
        }

        .floor-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            /*background-color: #4caf50; !* 초록색 배경 *!*/
            /*background-color: #7c3aed;*/
            background: linear-gradient(135deg, #93c5fd, #7c3aed);
            color: white; /* 흰색 글씨 */
            font-size: 1.5rem; /* 글씨 크기 */
            font-weight: bold; /* 굵은 글씨 */
            width: 60px; /* 아이콘 너비 */
            height: 60px; /* 아이콘 높이 */
            border-radius: 10px; /* 모서리 둥글게 */
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
        }

        .floor-details {
            display: flex;
            flex-direction: column; /* 텍스트를 위아래로 정렬 */
        }


        /* 컨테이너 스타일 */
        .building-container {
            position: relative;
            flex-shrink: 0; /* 크기 축소 방지 */
            width: 800px;
            height: 600px;
            background-image: url('<c:url value="/img/building/image.png"/>'); /* 건물 배경 이미지 */
            /*background-size: cover;*/
            background-size: contain; /* 비율 유지하면서 div에 맞추기 */
            background-repeat: no-repeat; /* 반복 제거 */
            /*background-position: center;*/
        }

        /* 층 이미지 스타일 */
        .floor {
            position: absolute;
            opacity: 0.8; /* 기본 투명도 */
            cursor: pointer;
            /*transition: opacity 0.3s, transform 0.3s; !* 효과 추가 *!*/
            transition: filter 5s ease-in-out, transform 0.3s; /* 필터 변경과 확대 효과 부드럽게 적용 */
            /*background-size: contain; !* 비율 유지하면서 div에 맞추기 *!*/
            background-size: cover; /* 비율 유지하면서 div에 맞추기 */
            filter: grayscale(100%);
            background-repeat: no-repeat; /* 반복 제거 */
            /*background-position: center; !* 중앙 정렬 *!*/
        }

        /* 마우스오버 시 강조 */
        .floor:hover {
            opacity: 1;
            transform: scale(1.05); /* 약간 확대 */
        }

        /* 층 위치 및 크기 */
        .floor-left5f {
            top: 21px;
            left: 82px;
            width: 392px;
            height: 159px;
            background-image: url('<c:url value="/img/building/left5f3.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }

        .floor-right5f {
            top: 105px;
            left: 520px;
            width: 209px;
            height: 102px;
            background-image: url('<c:url value="/img/building/right5f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }

        .floor-left4f {
            top: 96px;
            left: 76px;
            width: 398px;
            height: 134px;
            background-image: url('<c:url value="/img/building/left4f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }

        .floor-right4f {
            top: 162px;
            left: 518px;
            width: 213px;
            height: 85px;
            background-image: url('<c:url value="/img/building/right4f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }


        .floor-left3f {
            top: 161px;
            left: 67px;
            width: 405px;
            height: 123px;
            background-image: url('<c:url value="/img/building/left3f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }

        .floor-right3f {
            top: 210px;
            left: 518px;
            width: 215px;
            height: 82px;
            background-image: url('<c:url value="/img/building/right3f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }

        .floor-left2f {
            top: 227px;
            left: 60px;
            width: 411px;
            height: 111px;
            background-image: url('<c:url value="/img/building/left2f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }

        .floor-right2f {
            top: 259px;
            left: 518px;
            width: 219px;
            height: 77px;
            background-image: url('<c:url value="/img/building/right2f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }

        .floor-left1f {
            top: 295px;
            left: 52px;
            width: 419px;
            height: 99px;
            background-image: url('<c:url value="/img/building/left1f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }

        .floor-right1f {
            top: 310px;
            left: 520px;
            width: 220px;
            height: 69px;
            background-image: url('<c:url value="/img/building/right1f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }
    </style>


    <script>


        let buildingEnergy = {
            totalChart: null,
            intervalId: null, // 주기적 갱신을 위한 Interval ID
            buildingData: {}, // 최신 JSON 데이터를 저장
            selectedFloor: null, // 클릭한 층

            init: function () {
                this.initClickEvents(); // 클릭 이벤트 초기화
                this.startRealTimeMonitoring(); // JSON 데이터 주기적 갱신 시작
            },

            startRealTimeMonitoring: function () {
                if (this.intervalId) {
                    clearInterval(this.intervalId); // 기존 interval 중지
                }

                this.fetchAllFloorData(); // 초기 데이터 로드
                this.intervalId = setInterval(() => {
                    this.fetchAllFloorData(); // 주기적으로 JSON 데이터 갱신
                }, 5000); // 5초마다 갱신
            },

            initClickEvents: function () {
                const floors = document.querySelectorAll('.floor');
                floors.forEach(floor => {
                    floor.addEventListener('click', () => {
                        this.selectedFloor = floor.dataset.floor; // 클릭한 층 저장
                        this.renderSelectedFloorData(); // 클릭된 층의 데이터를 표시
                    });
                });
            },

            fetchAllFloorData: function () {
                $.ajax({
                    url: "<c:url value="/getFloorStats"/>", // JSON 데이터를 가져오는 API
                    method: 'GET',
                    dataType: 'json',
                    success: (data) => {
                        this.buildingData = data.buildingStats; // 최신 데이터를 저장
                        this.updateAllFloorColors(); // 모든 층의 색상 업데이트

                        // 클릭된 층이 있으면 해당 층 데이터 업데이트
                        if (this.selectedFloor) {
                            this.renderSelectedFloorData();
                        }
                    },
                    error: (error) => {
                        console.error("JSON 데이터를 불러오는 중 오류 발생:", error);
                    }
                });
            },

            updateAllFloorColors: function () {
                this.buildingData.forEach(floorData => {
                    const floorElements = document.querySelectorAll(`.floor[data-floor="\${floorData.floor}"]`);
                    const filterValue = this.getFilterValue(floorData.totalPower);

                    floorElements.forEach(element => {
                        element.style.filter = filterValue; // CSS filter 적용
                    });
                });
            },

            renderSelectedFloorData: function () {
                if (!this.selectedFloor || !this.buildingData) return;

                // 선택된 층의 데이터를 검색
                const floorData = this.buildingData.find(f => f.floor === this.selectedFloor);
                if (!floorData) {
                    console.error(`선택된 층(\${this.selectedFloor})의 데이터를 찾을 수 없습니다.`);
                    return;
                }


                // info-header에 층 정보와 총 전력량 표시
                const infoHeader = $('.info-header'); // info-header 선택
                // 기존 subtitle과 status-indicators는 유지
                // infoHeader.find('.info-title').html(`
                //     <div class=row><h3 style="color: #000;">\${floorData.floor}층</h3>
                //     <h3 style="color: #000;">\${floorData.floor}층</h3>
                //     </div>
                //     <div id="total-power" style="margin-top: 10px; font-weight: bold; color: #000;">
                //         총 전력: \${floorData.totalPower}kW
                //     </div>
                // `);
                infoHeader.find('.info-title').html(`
            <div class="info-row">
                <div class="floor-icon">
                    \${floorData.floor}
                </div>
                <div class="floor-details">
                    <h3 style="margin: 0; color: #000;">\${floorData.floor}층</h3>
                    <div id="total-power" style="margin-top: 5px; font-weight: bold; color: #000;">
                        총 전력: \${floorData.totalPower}kW
                    </div>
                </div>
            </div>
        `);

                // floor-data-container에 호실 정보 표시
                const floorDataContainer = $('#floor-data');
                floorDataContainer.empty(); // 기존 데이터를 초기화

                const roomCards = floorData.rooms.map(room => `
            <div class="room-card" data-status="\${room.status}">
                <div class="room-title">\${room.roomId}</div>
                <div class="room-info">전력: \${room.power}kW</div>
                <div class="room-info">온도: \${room.temperature}</div>
            </div>
        `).join('');

                floorDataContainer.append(roomCards);
                //   // 총 전력량 표시
                //   floorDataContainer.append(
                //           `<div id="total-power" style="margin-top: 10px; font-weight: bold; color: #000;">
                //   총 전력: \${floorData.totalPower}kW
                // </div>`
                //   );
            },

            getFilterValue: function (totalPower) {
                // 전력량 기준으로 색상 결정
                if (totalPower > 2200) {
                    return "invert(38%) sepia(81%) saturate(1362%) hue-rotate(332deg) brightness(110%) contrast(96%)"; // 빨간색
                } else if (totalPower > 2000) {
                    return "invert(66%) sepia(89%) saturate(371%) hue-rotate(335deg) brightness(101%) contrast(96%)"; // 주황색
                } else if (totalPower > 1800) {
                    return "invert(84%) sepia(39%) saturate(672%) hue-rotate(16deg) brightness(117%) contrast(96%)"; // 노란색
                } else if (totalPower > 1600) {
                    return "invert(99%) sepia(95%) saturate(3739%) hue-rotate(10deg) brightness(99%) contrast(96%)"; // 연두색
                } else {
                    return "invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%)"; // 초록색
                }
            }
        };


        // 페이지가 로드되었을 때 초기화
        $(function () {
            buildingEnergy.init();

            Highcharts.chart("totalContainer", {
                chart: {
                    type: "gauge",
                    plotBackgroundColor: null,
                    plotBackgroundImage: null,
                    plotBorderWidth: 0,
                    plotShadow: false,
                    height: "80%",
                },

                title: {
                    text: "Speedometer",
                },

                pane: {
                    startAngle: -90,
                    endAngle: 89.9,
                    background: null,
                    center: ["50%", "75%"],
                    size: "110%",
                },

                // the value axis
                yAxis: {
                    min: 0,
                    max: 200,
                    tickPixelInterval: 72,
                    tickPosition: "inside",
                    tickColor: Highcharts.defaultOptions.chart.backgroundColor || "#FFFFFF",
                    tickLength: 20,
                    tickWidth: 2,
                    minorTickInterval: null,
                    labels: {
                        distance: 20,
                        style: {
                            fontSize: "14px",
                        },
                    },
                    lineWidth: 0,
                    plotBands: [
                        {
                            from: 0,
                            to: 130,
                            color: "#55BF3B", // green
                            thickness: 20,
                            borderRadius: "50%",
                        },
                        {
                            from: 150,
                            to: 200,
                            color: "#DF5353", // red
                            thickness: 20,
                            borderRadius: "50%",
                        },
                        {
                            from: 120,
                            to: 160,
                            color: "#DDDF0D", // yellow
                            thickness: 20,
                        },
                    ],
                },

                series: [
                    {
                        name: "Speed",
                        data: [80],
                        tooltip: {
                            valueSuffix: " km/h",
                        },
                        dataLabels: {
                            format: "{y} kw",
                            borderWidth: 0,
                            color:
                                (Highcharts.defaultOptions.title &&
                                    Highcharts.defaultOptions.title.style &&
                                    Highcharts.defaultOptions.title.style.color) ||
                                "#333333",
                            style: {
                                fontSize: "16px",
                            },
                        },
                        dial: {
                            radius: "80%",
                            backgroundColor: "gray",
                            baseWidth: 12,
                            baseLength: "0%",
                            rearLength: "0%",
                        },
                        pivot: {
                            backgroundColor: "gray",
                            radius: 6,
                        },
                    },
                ],
            })
// Add some life
            setInterval(() => {
                const chart = Highcharts.charts[0]
                if (chart && !chart.renderer.forExport) {
                    const point = chart.series[0].points[0],
                        inc = Math.round((Math.random() - 0.5) * 20)

                    let newVal = point.y + inc
                    if (newVal < 0 || newVal > 200) {
                        newVal = point.y - inc
                    }

                    point.update(newVal)
                }
            }, 3000)


            Highcharts.chart('monthContainer', {
                data: {
                    table: 'datatable'
                },
                chart: {
                    type: 'column'
                },
                title: {
                    text: '월별 에너지 사용량'
                },
                subtitle: {
                    text:
                        '<a href="https://www.ssb.no/en/statbank/table/04231" target="_blank"></a>'
                },
                xAxis: {
                    type: 'category'
                },
                yAxis: {
                    allowDecimals: false,
                    title: {
                        text: '에너지사용량'
                    }
                }
            });

        });
    </script>
<body>
<div class="content-wrapper">
    <h1>에너지 관리</h1>
    <div class="main-container">
        <div class="building-container">

            <!-- 층을 나타내는 div -->
            <div class="floor floor-left5f" data-floor="5F"></div>
            <div class="floor floor-right5f" data-floor="5F"></div>
            <div class="floor floor-left4f" data-floor="4F"></div>
            <div class="floor floor-right4f" data-floor="4F"></div>
            <div class="floor floor-left3f" data-floor="3F"></div>
            <div class="floor floor-right3f" data-floor="3F"></div>
            <div class="floor floor-left2f" data-floor="2F"></div>
            <div class="floor floor-right2f" data-floor="2F"></div>
            <div class="floor floor-left1f" data-floor="1F"></div>
            <div class="floor floor-right1f" data-floor="1F"></div>
        </div>


        <!-- 오른쪽 정보 패널 -->
        <div class="info-panel">
            <%--    <div class="card">--%>
            <!-- 상단 헤더 -->
            <div class="info-header">
                <%--      <div class="card-header">--%>
                <div class="info-title">
                    <h2>층별 정보</h2>
                    <div class="subtitle" style="color: white">실시간 에너지 사용 현황</div>
                </div>
                <div class="status-indicators">
                    <div class="status-indicator status-normal">
                        <span></span>
                        정상
                    </div>
                    <div class="status-indicator status-warning">
                        <span></span>
                        주의
                    </div>
                    <div class="status-indicator status-critical">
                        <span></span>
                        경고
                    </div>
                </div>
            </div>
            <!-- 데이터 표시 영역 -->
            <div class="card-body" style="background: linear-gradient(135deg, #93c5fd, #c4b5fd); border-radius: 8px;">
                <div id="floor-data" class="floor-data-container">
                    <h2>층을 클릭하면 정보가 표시됩니다.</h2>
                    <div id="total-power" style="margin-top: 10px; font-weight: bold; color: #000;">총 전력: -- kW</div>
                </div>
            </div>
        </div>
    </div>
    <div class="main-container">
        <div id="totalContainer"></div>
        <div id="monthContainer"></div>
        <table id="datatable">
            <thead>
            <tr>
                <th></th>
                <th>2023년</th>
                <th>2024년</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th>1월</th>
                <td>28 430</td>
                <td>26 690</td>
            </tr>
            <tr>
                <th>2월</th>
                <td>28 042</td>
                <td>26 453</td>
            </tr>
            <tr>
                <th>3월</th>
                <td>27 063</td>
                <td>25 916</td>
            </tr>
            <tr>
                <th>4월</th>
                <td>28 684</td>
                <td>27 376</td>
            </tr>
            <tr>
                <th>5월</th>
                <td>26 445</td>
                <td>25 035</td>
            </tr>
            <tr>
                <th>6월</th>
                <td>26 564</td>
                <td>25 416</td>
            </tr>
            <tr>
                <th>7월</th>
                <td>28 430</td>
                <td>26 690</td>
            </tr>
            <tr>
                <th>8월</th>
                <td>28 042</td>
                <td>26 453</td>
            </tr>
            <tr>
                <th>9월</th>
                <td>27 063</td>
                <td>25 916</td>
            </tr>
            <tr>
                <th>10월</th>
                <td>28 684</td>
                <td>27 376</td>
            </tr>
            <tr>
                <th>11월</th>
                <td>26 445</td>
                <td>25 035</td>
            </tr>
            <tr>
                <th>12월</th>
                <td>26 564</td>
                <td>25 416</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>



