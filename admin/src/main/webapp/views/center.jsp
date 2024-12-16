<%--
  User: 1
  Date: 2024-11-13
  Time: 오후 4:27
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
    <meta charset='utf-8'/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.15/index.global.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.15/locales/ko.global.min.js'></script>
</head>
<%--챗봇 스타일--%>
<style>
<%--    챗봇 스타일 시작 --%>
    #chat-button {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 60px;
        height: 60px;
        background-color: #007bff;
        color: white;
        border-radius: 50%;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        font-size: 24px;
        z-index: 1000;
    }

    #chat-window {
        position: fixed;
        bottom: 80px;
        right: 20px;
        width: 400px;
        height: 500px;
        background-color: white;
        border: 1px solid #ddd;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        border-radius: 8px;
        display: none;
        flex-direction: column;
        z-index: 1000;
    }

    #chat-window .chat-header {
        background-color: #007bff;
        color: white;
        padding: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-top-left-radius: 8px;
        border-top-right-radius: 8px;
    }

    #close-chat {
        background: none;
        border: none;
        color: white;
        font-size: 16px;
        cursor: pointer;
    }

    #chat-window .chat-body {
        padding: 10px;
        flex-grow: 1;
        overflow-y: auto;
        font-size: 14px;
        line-height: 1.5;
    }

    #chat-button {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 60px;
        height: 60px;
        background-color: #007bff;
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
        z-index: 1000;
        transition: all 0.3s;
    }

    #chat-button.new-message {
        background-color: #ff0000;
        transform: scale(1.2);
        animation: pulse 1s infinite;
    }

    @keyframes pulse {
        0% {
            transform: scale(1.2);
        }
        50% {
            transform: scale(1.3);
        }
        100% {
            transform: scale(1.2);
        }
    }
<%--    챗봇 스타일 끝 --%>
</style>

<%--빌딩 CSS--%>
<style>
    /* 컨테이너 스타일 */
    .building-container {
        position: relative;
        flex-shrink: 0; /* 크기 축소 방지 */
        width: 600px;
        height: 400px;
        background-image: url('<c:url value="/img/building/image.png"/>'); /* 건물 배경 이미지 */
        background-size: contain; /* 비율 유지하면서 div에 맞추기 */
        background-repeat: no-repeat; /* 반복 제거 */
        /* 층 이미지 스타일 */
        .floor {
            position: absolute;
            opacity: 0.8; /* 기본 투명도 */
            /*cursor: pointer;*/
            /*transition: opacity 0.3s, transform 0.3s; !* 효과 추가 *!*/
            transition: filter 5s ease-in-out, transform 0.3s; /* 필터 변경과 확대 효과 부드럽게 적용 */
            /*background-size: contain; !* 비율 유지하면서 div에 맞추기 *!*/
            background-size: cover; /* 비율 유지하면서 div에 맞추기 */
            filter: grayscale(100%);
            background-repeat: no-repeat; /* 반복 제거 */
            /*background-position: center; !* 중앙 정렬 *!*/
        }

        /*!* 마우스오버 시 강조 *!*/
        /*.floor:hover {*/
        /*    opacity: 1;*/
        /*    transform: scale(1.05); !* 약간 확대 *!*/
        /*}*/

        /* 층 위치 및 크기 */
        .floor-left5f {
            top: 16px;
            left: 61px;
            width: 295px;
            height: 120px;
            background-image: url('<c:url value="/img/building/left5f3.png"/>');
            filter: invert(38%) sepia(81%) saturate(1362%) hue-rotate(332deg) brightness(110%) contrast(96%);
        }

        .floor-right5f {
            top: 78px;
            left: 390px;
            width: 157px;
            height: 78px;
            background-image: url('<c:url value="/img/building/right5f.png"/>');
            filter: invert(38%) sepia(81%) saturate(1362%) hue-rotate(332deg) brightness(110%) contrast(96%);
        }

        .floor-left4f {
            top: 72px;
            left: 56px;
            width: 299px;
            height: 101px;
            background-image: url('<c:url value="/img/building/left4f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }

        .floor-right4f {
            top: 121px;
            left: 389px;
            width: 160px;
            height: 64px;
            background-image: url('<c:url value="/img/building/right4f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }


        .floor-left3f {
            top: 121px;
            left: 49px;
            width: 305px;
            height: 92px;
            background-image: url('<c:url value="/img/building/left3f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }

        .floor-right3f {
            top: 157px;
            left: 389px;
            width: 161px;
            height: 62px;
            background-image: url('<c:url value="/img/building/right3f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }

        .floor-left2f {
            top: 170px;
            left: 44px;
            width: 309px;
            height: 86px;
            background-image: url('<c:url value="/img/building/left2f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }

        .floor-right2f {
            top: 193px;
            left: 389px;
            width: 162px;
            height: 60px;
            background-image: url('<c:url value="/img/building/right2f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }

        .floor-left1f {
            top: 222px;
            left: 38px;
            width: 316px;
            height: 74px;
            background-image: url('<c:url value="/img/building/left1f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }

        .floor-right1f {
            top: 232px;
            left: 390px;
            width: 165px;
            height: 52px;
            background-image: url('<c:url value="/img/building/right1f.png"/>');
            filter: invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%);
        }
    }
</style>

<%--차트--%>
<style>
    .highcharts-figure,
    .highcharts-data-table table {
        min-width: 310px;
        max-width: 800px;
        margin: 1em auto;
    }

    #floorChartContainer {
        height: 400px;
        width:400px;

        margin-left: 20px;
        border-radius: 12px;
        background-color: #1F2937;
        border-radius: 12px;
        padding: 20px;
        /*margin: 20px;*/
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



</style>

<%--CCTV--%>
<style>
    .surveillance-dashboard {
        background: #1a1f2d;
        border: none;
        border-radius: 12px;
        overflow: hidden;
    }

    .surveillance-dashboard .card-header {
        background: #242a38;
        padding: 1rem;
        border-bottom: 1px solid rgba(255,255,255,0.1);
    }

    .surveillance-dashboard .card-header h6 {
        color: #fff;
        font-weight: 500;
    }

    .status-indicator {
        display: flex;
        align-items: center;
        gap: 8px;
        color: #8a9ab0;
        font-size: 0.875rem;
    }

    .status-dot {
        width: 8px;
        height: 8px;
        background: #00ff4c;
        border-radius: 50%;
        display: inline-block;
        animation: pulse 2s infinite;
    }

    .camera-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 8px;
        padding: 8px;
    }

    .camera-feed {
        position: relative;
        aspect-ratio: 16/9;
        background: #000;
        border-radius: 8px;
        overflow: hidden;
    }

    .camera-feed img,
    .camera-feed .webcam-container {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }


    .camera-overlay {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        padding: 8px;
        background: linear-gradient(to bottom, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0) 100%);
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        z-index: 1;
    }

    .camera-label {
        color: #fff;
        font-size: 0.875rem;
        font-weight: 500;
    }

    .timestamp {
        color: #ff3a3a;
        font-size: 0.75rem;
        font-weight: 600;
        background: rgba(255,0,0,0.2);
        padding: 2px 8px;
        border-radius: 4px;
    }

    @keyframes pulse {
        0% {
            box-shadow: 0 0 0 0 rgba(0, 255, 76, 0.4);
        }
        70% {
            box-shadow: 0 0 0 10px rgba(0, 255, 76, 0);
        }
        100% {
            box-shadow: 0 0 0 0 rgba(0, 255, 76, 0);
        }
    }

    /* 다크 모드 스타일 */
    .camera-feed:hover .camera-overlay {
        background: linear-gradient(to bottom, rgba(0,0,0,0.9) 0%, rgba(0,0,0,0.2) 100%);
    }
</style>



<script>
    let maincard = {
        init: function(){
            this.startRealTimeMonitoring(); // JSON 데이터 주기적 갱신 시작
            setInterval(this.getTime, 1000);
            this.getFloorChart();
        },
        getTime:function(){
            $.ajax({
                'url' : '<c:url value="/getctime"/>',
                'success' : (result)=>{
                    $('#cday').html(result.cday);
                    $('#ctime').html(result.ctime);
                }
            });
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
        fetchAllFloorData: function () {
            $.ajax({
                url: "<c:url value='/getFloorStats'/>", // JSON 데이터를 가져오는 API
                method: 'GET',
                dataType: 'json',
                success: (data) => {
                    this.buildingData = data.buildingStats; // 최신 데이터를 저장

                    // 층별 색상 업데이트
                    this.updateAllFloorColors();

                    // 차트 업데이트
                    const floorNames = this.buildingData.map(floor => floor.floor);
                    const totalPowers = this.buildingData.map(floor => floor.totalPower);

                    if (this.chart) {
                        // 이미 차트가 생성된 경우 데이터만 갱신
                        this.chart.xAxis[0].setCategories(floorNames);
                        this.chart.series[0].setData(totalPowers);
                    } else {
                        // 차트가 없으면 새로 생성
                        this.chart = Highcharts.chart('floorChartContainer', {
                            colors: ['#3B82F6'],
                            credits: {
                                enabled: false
                            },
                            exporting: {
                                enabled: false
                            },
                            chart: {
                                type: 'column',
                                backgroundColor: '#1F2937',
                                style: {
                                    fontFamily: '"Noto Sans KR", sans-serif',
                                    fontSize: '16px'
                                }
                            },
                            title: {
                                text: '층별 전력 실시간 사용량',
                                style: {
                                    color: '#ffffff'
                                }
                            },
                            xAxis: {
                                categories: floorNames,
                                crosshair: true,
                                labels: {
                                    style: {
                                        color: '#9CA3AF',
                                        fontSize: '20px'
                                    }
                                },
                            },
                            yAxis: {
                                min: 0,
                                title: {
                                    text: '전력사용량 (kWh)'
                                },
                                labels: {
                                    formatter: function() {
                                        return this.value.toLocaleString() + ' kWh';
                                    }
                                }
                            },
                            tooltip: {
                                headerFormat: '<b>{point.x}층</b><br/>',
                                pointFormat: '전력사용량: {point.y:,.0f} kWh'
                            },
                            plotOptions: {
                                column: {
                                    pointPadding: 0.2,
                                    borderWidth: 0,
                                    borderRadius: 5
                                }
                            },
                            series: [
                                {
                                    name: '전력 사용량',
                                    data: totalPowers,
                                }
                            ]
                        });
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
        getFilterValue: function (totalPower) {
            // 전력량 기준으로 색상 결정
            if (totalPower > 700) {
                return "invert(38%) sepia(81%) saturate(1362%) hue-rotate(332deg) brightness(110%) contrast(96%)"; // 빨간색
            } else if (totalPower > 560) {
                return "invert(66%) sepia(89%) saturate(371%) hue-rotate(335deg) brightness(101%) contrast(96%)"; // 주황색
            } else if (totalPower > 460) {
                // return "invert(84%) sepia(39%) saturate(672%) hue-rotate(16deg) brightness(117%) contrast(96%)"; // 노란색
                return "invert(99%) sepia(95%) saturate(3739%) hue-rotate(10deg) brightness(99%) contrast(96%)"; // 노란색
            } else if (totalPower > 440) {
                // return "invert(99%) sepia(95%) saturate(3739%) hue-rotate(10deg) brightness(99%) contrast(96%)"; // 연두색
                return "invert(76%) sepia(30%) saturate(741%) hue-rotate(40deg) brightness(93%) contrast(104%)"; // 연두색
            } else {
                return "invert(31%) sepia(97%) saturate(375%) hue-rotate(82deg) brightness(94%) contrast(92%)"; // 초록색
            }
        },
        getFloorChart: function(){
            Highcharts.theme = {
                colors: ['#3B82F6'],
                chart: {
                    backgroundColor: '#1F2937',
                    style: {
                        fontFamily: '"Noto Sans KR", sans-serif'
                    }
                },
                title: {
                    style: {
                        color: '#ffffff'
                    }
                },
                xAxis: {
                    gridLineColor: '#374151',
                    labels: {
                        style: {
                            color: '#9CA3AF'
                        }
                    },
                    lineColor: '#4B5563'
                },
                yAxis: {
                    gridLineColor: '#374151',
                    labels: {
                        style: {
                            color: '#9CA3AF'
                        }
                    },
                    title: {
                        style: {
                            color: '#9CA3AF'
                        }
                    }
                },
                legend: {
                    itemStyle: {
                        color: '#9CA3AF'
                    }
                },
                tooltip: {
                    backgroundColor: '#374151',
                    style: {
                        color: '#ffffff'
                    }
                }
            };

            Highcharts.setOptions(Highcharts.theme);

            Highcharts.chart('floorChartContainer', {
                colors: ['#3B82F6'],
                credits: {
                    enabled: false
                },
                exporting: {
                    enabled: false
                },
                chart: {
                    type: 'column',
                    backgroundColor: '#1F2937',
                    style: {
                        fontFamily: '"Noto Sans KR", sans-serif',
                        fontSize: '16px'  /* 기본 글자 크기 증가 */
                    }
                },
                title: {
                    text: '층별 전력 사용량',
                    style: {
                        color: '#ffffff'
                    }
                },
                xAxis: {
                    categories: ['1F', '2F', '3F', '4F', '5F'],
                    crosshair: true,
                    labels: {
                        style: {
                            color: '#9CA3AF',
                            fontSize: '20px'  /* X축 레이블 글자 크기 */
                        }
                    },
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: '전력사용량 (kWh)'
                    },
                    labels: {
                        formatter: function() {
                            return this.value.toLocaleString() + ' kWh';
                        }
                    }
                },
                tooltip: {
                    headerFormat: '<b>{point.x}층</b><br/>',
                    pointFormat: '전력사용량: {point.y:,.0f} kWh'
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        borderRadius: 5
                    }
                },
                series: [
                    {
                        // name: 'Wheat',
                        data: [0, 0, 0, 0, 0],
                    }
                ]

            });
        },
    };
    let userchat = {
        init: function () {
            this.cacheDom();
            this.bindEvents();
        },
        cacheDom: function () {
            this.$chatButton = $('#chat-button'); // Chat button
            this.$chatWindow = $('#chat-window'); // Chat window
            this.$closeButton = $('#close-chat'); // Close button inside chat window
        },
        bindEvents: function () {
            this.$chatButton.on('click', this.toggleChat.bind(this));
            this.$closeButton.on('click', this.closeChat.bind(this));
        },
        toggleChat: function () {
            if (this.$chatWindow.css('display') === 'none') {
                this.$chatWindow.show();
            } else {
                this.$chatWindow.hide();
            }
        },
        closeChat: function () {
            this.$chatWindow.hide();
        },


    };
    let park_progress = {
        get: function () {
            this.parkstat()
            setInterval(this.parkstat, 1000000);
        },

        parkstat: function () {
            $.ajax({
                url: "/getparkstat",
                method: "GET",
                dataType: "json",
                success: function (data) {
                    let totalParking = 24;
                    let availableCount = data.availableCount;
                    let parkingCount = totalParking - availableCount;
                    let usagePercent = (parkingCount / totalParking) * 100;

                    $("#availableCount").contents().filter(function() {
                        return this.nodeType === 3;
                    }).first().replaceWith(availableCount);

                    $("#parkingCount").text(parkingCount);
                    $(".progress-bar").css("width", usagePercent + "%");
                },
                error: function (error) {
                    console.error("주차 상태를 불러오는 중 오류 발생:", error);
                }
            });
        }
    };
    let elec_progress = {
        fetchData: function () {
            $.ajax({
                url: '/iot/monthelec',
                method: 'GET',
                dataType: 'json',
                success: (data) => {
                    const values = data.map(item => parseFloat(item.total_value));
                    const avg = values.reduce((acc, val) => acc + val, 0) / values.length;
                    const latval = values[values.length - 1];
                    this.ave(avg, latval);
                },
                error: (xhr, status, error) => {
                    console.error('Failed to load data from monthelec service:', error);
                }
            });
        },

        ave: function (avg, latval) {
            let percentageDifference;

            if (latval >= avg) {
                percentageDifference = 100 + ((latval - avg) / avg) * 100;
            } else {
                percentageDifference = (latval / avg) * 100;
            }

            $("#elec_progress").css("width", percentageDifference + "%");

            $("#latestValue").contents().filter(function() {
                return this.nodeType === 3;
            }).first().replaceWith(latval.toFixed(2) + " kWh ");

            $("#elec_percent").contents().filter(function() {
                return this.nodeType === 3;
            }).first().replaceWith(percentageDifference.toFixed(2) + "% ");
        },
    }


    $(function () {
        maincard.init();
        userchat.init();
        park_progress.get();
        elec_progress.fetchData();
    });
</script>

<body>
<div class="content-wrapper">
    <div class="container-fluid">

        <!--Start Dashboard Content-->

        <%-- 상단 progress bar 4개 --%>
        <div class="card mt-3">
            <div class="card-content">
                <div class="row row-group m-0">
                    <div class="col-12 col-lg-6 col-xl-3 border-light">
                        <div class="card-body">
                            <h5 class="text-white mb-0" id="latestValue">9526 <span class="float-right"><i class="fa fa-bolt" aria-hidden="true"></i></span></h5>
                            <div class="progress my-3" style="height:3px;">
                                <div class="progress-bar" id="elec_progress"></div>
                            </div>
                            <p class="mb-0 text-white small-font">전력 사용량 <span class="float-right" id="elec_percent">+4.2% <i class="zmdi zmdi-long-arrow-up"></i></span></p>
                        </div>
                    </div>


                    <div class="col-12 col-lg-6 col-xl-3 border-light">
                        <div class="card-body">
                            <h5 class="text-white mb-0" id="availableCount"> <span class="float-right"><i class="fa fa-car" aria-hidden="true"></i></span></h5>
                            <div class="progress my-3" style="height:3px;">
                                <div class="progress-bar" style="width:55%"></div>
                            </div>
                            <p class="mb-0 text-white small-font">주차 대수 <span class="float-right" id="parkingCount"></span></p>
                        </div>
                    </div>

                    <div class="col-12 col-lg-6 col-xl-3 border-light">
                        <div class="card-body">
                            <h5 class="text-white mb-0">4 <span class="float-right"><i class="fa fa-users" aria-hidden="true"></i></span></h5>
                            <div class="progress my-3" style="height:3px;">
                                <div class="progress-bar" style="width:25%"></div>4
                            </div>
                            <p class="mb-0 text-white small-font">공실률 <span class="float-right">+25% </span></p>
                        </div>
                    </div>

                    <div class="col-12 col-lg-6 col-xl-3 border-light">
                        <div class="card-body">
                            <h5 class="text-white mb-0">현재 시각<span class="float-right"><i class="icon-clock"></i></span></h5>
                            <h2 id="ctime" style="margin-top: 5px; margin-left: -5px"></h2>
                            <p class="mb-0 text-white small-font"><a id="cday">...</a> </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12 col-lg-8 col-xl-8">
                <div class="card">
                    <div class="card-header">에너지 사용량 모니터링</div>
                    <div class="card-body">
                        <div class="row">
                            <div class="building-panel">
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
                            </div>
                            <div id="floorChartContainer"></div>
                        </div>
                    </div>

                    <div class="row m-0 row-group text-center border-top border-light-3">
                        <div class="col-12 col-lg-4">
                            <div class="p-3">
                                <h5 class="mb-0">일일 방문자수 : 126명</h5>
                                <small class="mb-0">전일 대비 <span> <i class="fa fa-arrow-up" STYLE="color: indianred"></i> 12%</span></small>
                            </div>
                        </div>
                        <div class="col-12 col-lg-4">
                            <div class="p-3">
                                <h5 class="mb-0">외부온도 : 4°C</h5>
                                <small class="mb-0">전일 대비 <span> <i class="fa fa-arrow-down" STYLE="color: deepskyblue"></i> 2°C</span></small>
                            </div>
                        </div>
                        <div class="col-12 col-lg-4">
                            <div class="p-3">
                                <h5 class="mb-0">외부습도 : 32%</h5>
                                <small class="mb-0">전일 대비 <span> <i class="fa fa-arrow-down" STYLE="color: deepskyblue"></i> 3%</span></small>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="col-12 col-lg-4 col-xl-4">
                <div class="card">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-0">실시간 보안 모니터링</h6>
                                <small class="text-muted">Live Security Feed</small>
                            </div>
                            <div class="status-indicator">
                                <span class="status-dot"></span>
                                실시간 모니터링 중
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="camera-grid">
                            <div class="camera-feed main-feed">
                                <div class="camera-overlay">
                                    <span class="camera-label">CAM 01 - 로비 A</span>
                                    <span class="timestamp">LIVE</span>
                                </div>
                                <img src="/img/cctv/lobby2.png" alt="CCTV Feed 1">
<%--                                <div class="webcam-container">--%>
<%--                                    <jsp:include page="webcam.jsp"/>--%>
<%--                                </div>--%>
                            </div>
                            <div class="camera-feed">
                                <div class="camera-overlay">
                                    <span class="camera-label">CAM 02 - 로비 B</span>
                                    <span class="timestamp">LIVE</span>
                                </div>
                                <img src="/img/cctv/lobby.png" alt="CCTV Feed 2">
                            </div>
                            <div class="camera-feed">
                                <div class="camera-overlay">
                                    <span class="camera-label">CAM 03 - 2층계단</span>
                                    <span class="timestamp">LIVE</span>
                                </div>
                                <img src="/img/cctv/gedan.png" alt="CCTV Feed 3">
                            </div>
                            <div class="camera-feed">
                                <div class="camera-overlay">
                                    <span class="camera-label">CAM 04 - 2층복도</span>
                                    <span class="timestamp">LIVE</span>
                                </div>
                                <img src="/img/cctv/bokdo.png" alt="CCTV Feed 4">
                            </div>
                            <div class="camera-feed">
                                <div class="camera-overlay">
                                    <span class="camera-label">CAM 05 - 주차장 A</span>
                                    <span class="timestamp">LIVE</span>
                                </div>
                                <img src="/img/cctv/parkA.jpg" alt="CCTV Feed 5">
                            </div>
                            <div class="camera-feed">
                                <div class="camera-overlay">
                                    <span class="camera-label">CAM 06 - 주차장 B</span>
                                    <span class="timestamp">LIVE</span>
                                </div>
                                <img src="/img/cctv/parkC.png" alt="CCTV Feed 6">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div><!--End Row-->

        <%--유지보수 일정  영역 시작--%>
        <div class="card">
            <div class="col-sm-12">
                <!-- 유지보수 일정 테이블 -->
                <div style="width: 90%; margin: 20px auto;">
                    <h5 class="text-white" style="margin-bottom: 15px;">유지보수 일정</h5>
                    <table class="table table-bordered" style="background-color: #2a3441">
                        <thead>
                        <tr style="background-color: #1F2937">
                            <th scope="col">날짜</th>
                            <th scope="col">시간</th>
                            <th scope="col">위치</th>
                            <th scope="col">내용</th>
                            <th scope="col">상태</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>2024-12-01</td>
                            <td>오전 10:00</td>
                            <td>3층 회의실</td>
                            <td>에어컨 점검</td>
                            <td><span class="badge bg-success">완료</span></td>
                        </tr>
                        <tr>
                            <td>2024-12-03</td>
                            <td>오후 2:30</td>
                            <td>5층 강의실 A</td>
                            <td>전등 교체</td>
                            <td><span class="badge bg-warning">진행 중</span></td>
                        </tr>
                        <tr>
                            <td>2024-12-05</td>
                            <td>오전 11:00</td>
                            <td>1층 로비</td>
                            <td>화재 경보기 점검</td>
                            <td><span class="badge bg-danger">대기</span></td>
                        </tr>
                        <tr>
                            <td>2024-12-06</td>
                            <td>오후 3:00</td>
                            <td>2층 복도</td>
                            <td>습기 제거</td>
                            <td><span class="badge bg-warning">진행 중</span></td>
                        </tr>
                        <tr>
                            <td>2024-12-07</td>
                            <td>오전 9:30</td>
                            <td>4층 연구실</td>
                            <td>전력 점검</td>
                            <td><span class="badge bg-success">완료</span></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        <%--유지보수 일정 영역 끝--%>
        </div>
        <div id="chat-button" class="floating-button">
            💬
        </div>

        <div id="chat-window" class="chat-window" style="margin-bottom: 15px">
            <div class="chat-header">
                <span>Chat</span>
                <button id="close-chat">X</button>
            </div>
            <div class="chat-body">
                <jsp:include page="chat.jsp"/>
            </div>
        </div>

        <!--End Dashboard Content-->

        <!--start overlay-->
        <div class="overlay toggle-menu"></div>
        <!--end overlay-->

    </div>
    <!-- End container-fluid-->

</div>

</body>
</html>