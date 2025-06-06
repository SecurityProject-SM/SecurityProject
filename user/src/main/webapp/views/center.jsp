<%--
  User: 1
  Date: 2024-11-01
  Time: 오후 1:57
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
</head>

<style>

    #chat-window {
        position: fixed; /* 이미 설정되어 있으므로 유지 */
        bottom: 70px;
        right: 10px;
        width: 300px;
        height: 400px;
        background: white;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        overflow: hidden;
        z-index: 9999; /* 높은 z-index 값 설정 */
    }


    #remainingDays {
        color: black;
        font-size: 1.2em;
        font-weight: bold;
        visibility: visible;
    }

    <%-- progress 바 --%>
    .progress {
        background: rgba(255, 255, 255, 0.1);
        justify-content: flex-start;
        border-radius: 100px;
        align-items: center;
        position: relative;
        padding: 0 5px;
        display: flex;
        /*height: 20px;*/
        width: 100%;
        max-width: 600px;
        margin-top: 10px;
    }

    .progress-value {
        animation: load 3s normal forwards;
        box-shadow: 0 10px 40px -10px rgba(0, 149, 255, 0.75);
        border-radius: 100px;
        background: linear-gradient(90deg, #ff4d4d, #ffcc00, #00ff00);
        height: 15px;
        width: 0;
        transition: width 0.5s ease;
    }


    /* 날씨 */
    .weather-icon {
        width: 70px;
        height: 70px;
        vertical-align: middle;
        margin-bottom: 5px;
    }

    #weatherContainer {
        display: flex;
        position: relative;
        flex-direction: column;
        justify-content: center;
        align-items: flex-start;
        overflow: hidden;
        white-space: normal;
        /*font-size: 1rem;*/
        padding: 10px;
        top: -8px;
    }

    #imgContainer {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        padding: 10px;
    }

    .weather-icon {
        width: 70px; /* 아이콘 크기 */
        height: 70px; /* 아이콘 크기 */
    }


    .additional-text {
        padding-top: 10px;
        font-size: 14px;
        color: #555;
    }

    .highcharts-figure,
    .highcharts-data-table table {
        min-width: 360px;
        max-width: 800px;
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

    #adminchat {
        background-color: #007bff; /* 버튼 배경 색상 */
        color: white; /* 텍스트 색상 */
        border: none; /* 테두리 제거 */
        padding: 10px 20px; /* 버튼 여백 */
        border-radius: 5px; /* 둥근 테두리 */
        cursor: pointer; /* 마우스 포인터 */
        font-size: 14px; /* 텍스트 크기 */
        font-weight: bold; /* 텍스트 굵기 */
        transition: background-color 0.3s ease, transform 0.2s ease; /* 부드러운 효과 */
        margin-left: 10px;
    }

    #adminchat:hover {
        background-color: #0056b3; /* 호버 시 색상 변경 */
        transform: scale(1.05); /* 호버 시 확대 효과 */
    }

    #adminchat:active {
        background-color: #004085; /* 클릭 시 색상 */
        transform: scale(0.95); /* 클릭 시 크기 축소 */
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
    let chart = {
        chartInstance: null,
        init: function () {
            this.initchart();
            this.getdata();
            setInterval(() => {
                this.getdata();
            }, 3000);
        },
        initchart: function () {
            this.chartInstance = Highcharts.chart('container3', {
                chart: {
                    type: 'areaspline'
                },
                title: {
                    text: 'IoT 실시간 데이터'
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

    let elec = {
        init: function () {
            this.getelec();
            setInterval(this.getelec, 3000);
        },

        getelec: function () {
            $.ajax({
                url: '<c:url value="/iot/mainpage"/>',
                method: 'GET',
                dataType: 'json',
                success: function (data) {
                    $('#elec').text(data.toFixed(2) + ' W');
                },

                error: function (error) {
                    console.error('Error fetching electricity data:', error);
                }
            });
        }
    }

    <%--메인페이지 주차 현황 보여줌--%>
    let park = {
        init: function () {
            this.parkstat()
            // setInterval(this.parkstat, 1000000);
        },

        parkstat: function () {
            $.ajax({
                url: "<c:url value="/getparkstat"/>",
                method: "GET",
                dataType: "json",
                success: function (data) {
                    let totalParking = 24;
                    let availableCount = data.availableCount;
                    let parkingCount = totalParking - availableCount;
                    let usagePercent = (parkingCount / totalParking) * 100;

                    $("#availableCount").text(availableCount);
                    $("#parkingCount").text(parkingCount);

                    $(".progress-value").css("width", usagePercent + "%");

                    if (usagePercent <= 50) {
                        $(".progress-value").css("background", "#00ff00");
                    } else if (usagePercent <= 75) {
                        $(".progress-value").css("background", "#ffcc00");
                    } else {
                        $(".progress-value").css("background", "#ff4d4d");
                    }
                },
                error: function (error) {
                    console.error("주차 상태를 불러오는 중 오류 발생:", error);
                }
            });
        }
    };

    let map = {
        init: function () {
            var mapContainer = document.getElementById('map'),
                mapOption = {
                    center: new kakao.maps.LatLng(37.511167, 127.098328),
                    level: 5
                };

            var map = new kakao.maps.Map(mapContainer, mapOption);

            var markerPosition = new kakao.maps.LatLng(37.511167, 127.098328);

            var marker = new kakao.maps.Marker({
                position: markerPosition
            });

            marker.setMap(map);
        }
    }

    let center = {
        init: function () {
            $.ajax({
                url: '<c:url value="/wh"/>',
                success: (result) => {
                    let wtext = result.response.body.items.item[0].wfSv;
                    $('#dayweather').text(wtext);
                }
            });

            $.ajax({
                url: '<c:url value="/ow"/>',
                success: (result) => {
                    $('#weatherContainer').empty();
                    $('#imgContainer').empty();

                    let closestWeather = center.getClosestWeather(result.list);

                    let temp = closestWeather.main.temp;
                    let des = closestWeather.weather[0].description;
                    let icon = closestWeather.weather[0].icon;
                    let time = closestWeather.dt_txt;

                    center.display(temp, des, icon, time);
                }
            });
        },
        getClosestWeather: function (weatherList) {
            let now = new Date().getTime();
            let closest = weatherList.reduce((prev, curr) => {
                let prevTime = new Date(prev.dt_txt).getTime();
                let currTime = new Date(curr.dt_txt).getTime();
                return Math.abs(currTime - now) < Math.abs(prevTime - now) ? curr : prev;
            });
            return closest;
        },
        display: function (temp, des, icon, time) {
            let formattedTime = time.substring(11, 16); // 시간만 잘라내기 (HH:mm)

            let weatherHTML =
                '<h5>' + '현재 온도' + '</h5><br>' +
                '<h3>기온: ' + temp + '°C</h3>';

            let weatherImg =
                '<img src="https://openweathermap.org/img/wn/' + icon + '.png" alt="' + des + '" class="weather-icon">';

            $('#weatherContainer').append(weatherHTML);
            $('#imgContainer').append(weatherImg);
        }


    };

    let dnjftp = {
        init: function () {
            // HTML 요소를 가져오기
            this.remainingDaysElement = document.getElementById("remainingDays");
            this.calculateRemainingDays();
        },
        calculateRemainingDays: function () {
            const now = new Date();
            const nextMonth = new Date(now.getFullYear(), now.getMonth() + 1, 1);
            const timeDifference = nextMonth - now;

            // 남은 일수를 계산
            const daysRemaining = Math.ceil(timeDifference / (1000 * 60 * 60 * 24));
            const message = `남은 일수: \${daysRemaining}`;

            console.log(message);

            // HTML 요소에 값 업데이트
            if (this.remainingDaysElement) {
                this.remainingDaysElement.textContent = message;
            } else {
                console.error("ID가 'remainingDays'인 요소를 찾을 수 없습니다.");
            }
        }
    };

    let chat = {
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
            // Bind click events
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
        }
    };

    let admin = {
        init: function () {
            // chatbody 요소 선택
            const chatBody = $('#chatbody');

            // 로딩 메시지 표시
            chatBody.html('<p>로딩 중...</p>');

            // adminchat.jsp 파일 로드 (정확한 경로 사용)
            chatBody.load('/views/adminchat.jsp', function (response, status, xhr) {
                if (status === "error") {
                    console.error("Failed to load adminchat.jsp: ", xhr.status, xhr.statusText);
                    chatBody.html('<p>오류가 발생했습니다. 다시 시도해주세요.</p>');
                }
            });
        }
    };

    $(function () {
        center.init();
        map.init();
        park.init();
        elec.init();
        chart.init();
        dnjftp.init();
        chat.init();

        $('#adminchat').on('click', function () {
            websocket.disconnect();
            admin.init();
        });
    });

</script>

<body>
<div class="container-fluid py-4">
    <div class="row">
        <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
            <div class="card">
                <div class="card-body p-3" style="height: 160px">
                    <div class="row">
                        <div class="col-8">
                            <h5>금일 사용 전력</h5>
                            <h2 id="elec" style="margin-top: 15px"></h2>
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
                <div class="card-body p-3" style="height: 160px">
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
                <div class="card-body p-3" style="height: 160px">
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
                <div class="card-body p-3" style="height: 160px">
                    <div class="row">
                        <div class="col-8">
                            <h5>월세 납부일</h5>
                            <h4><div id="remainingDays" style="margin-top: 30px;">남은 일수:</div></h4>
                        </div>

                        <div class="col-4">
                            <img src="<c:url value="/img/dnjftp.jpg"/>" style="width: 90%">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-lg-7 mb-lg-0 mb-4">
            <div class="card z-index-2 h-100">
                <div class="card-header pb-0 pt-3 bg-transparent">
                    <h6 class="text-capitalize">실시간 사용 전력</h6>
                </div>
                <div class="card-body">
                    <div id="container3" style="width: 100%; height: 400px;"></div>
                </div>
            </div>
        </div>
        <%--        <div class="col-lg-5">--%>
        <%--            <div class="card card-carousel overflow-hidden h-100 p-0">--%>
        <%--                <div class="card-header pb-0 pt-3 bg-transparent">--%>
        <%--                    <h6 class="text-capitalize">(여기 뭐라그래야 하냐)</h6>--%>
        <%--                </div>--%>
        <%--                <div class="card-body p-3">--%>
        <%--                    <div class="row">--%>
        <%--                        <div style="width: 50%;">--%>
        <%--                            <jsp:include page="webcam.jsp"/>--%>
        <%--                        </div>--%>
        <%--                        <img src="/img/cctv3.jpeg" style="width: 50%">--%>
        <%--                    </div>--%>
        <%--                    <div class="row">--%>
        <%--                        <img src="/img/cctv1.gif" style="width: 50%">--%>
        <%--                        <img src="/img/cctv2.gif" style="width: 50%">--%>
        <%--                    </div>--%>
        <%--                </div>--%>

        <%--            </div>--%>
        <%--        </div>--%>
        <div class="col-lg-5">
            <div class="card surveillance-dashboard">
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
                <div class="card-body p-2">
                    <div class="camera-grid">
                        <div class="camera-feed main-feed">
                            <div class="camera-overlay">
                                <span class="camera-label">CAM 01 - 정문</span>
                                <span class="timestamp">LIVE</span>
                            </div>
                            <div class="webcam-container">
                                <jsp:include page="webcam.jsp"/>
                            </div>
                        </div>
                        <div class="camera-feed">
                            <div class="camera-overlay">
                                <span class="camera-label">CAM 02 - 복도</span>
                                <span class="timestamp">LIVE</span>
                            </div>
                            <img src="/img/cctv3.jpeg" alt="CCTV Feed 2">
                        </div>
                        <div class="camera-feed">
                            <div class="camera-overlay">
                                <span class="camera-label">CAM 03 - 강의실 A</span>
                                <span class="timestamp">LIVE</span>
                            </div>
                            <img src="/img/cctv1.gif" alt="CCTV Feed 3">
                        </div>
                        <div class="camera-feed">
                            <div class="camera-overlay">
                                <span class="camera-label">CAM 04 - 강의실 B</span>
                                <span class="timestamp">LIVE</span>
                            </div>
                            <img src="/img/cctv2.gif" alt="CCTV Feed 4">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-lg-7 mb-lg-0 mb-4">
                <div class="card">
                    <div class="card-header pb-0 p-3">
                        <div class="d-flex justify-content-between">
                            <h4 class="mb-2">공지사항</h4>
                        </div>
                    </div>
                    <!-- 공지사항 내용 -->
                    <table class="table align-items-center">
                        <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성일자</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty recentNotices}">
                                <c:forEach var="n" items="${recentNotices}">
                                    <tr>
                                        <td>${n.noticeId}</td>
                                        <td>${n.noticeName}</td>
                                        <td>${n.noticeTime}</td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" class="text-center">공지사항 데이터가 없습니다.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>

                    <!-- 전체 공지사항 보기 버튼 -->
                    <div class="card-footer text-end p-3">
                        <a href="<c:url value='/notice'/>" class="btn btn-primary">전체 공지사항 보기</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="card">
                    <div class="card-header pb-0 p-3">
                        <h6 class="mb-0">찾아오시는 길</h6>
                    </div>
                    <div class="card-body p-3">
                        <div id="map" style="width:100%;height:350px;"></div>
                    </div>
                </div>
            </div>

        </div>
        <footer class="footer pt-3  ">
            <div class="container-fluid">
                <div class="row align-items-center justify-content-lg-between">
                    <div class="col-lg-6 mb-lg-0 mb-4">
                        <div class="copyright text-center text-sm text-muted text-lg-start">
                            ©
                            <script>
                                document.write(new Date().getFullYear())
                            </script>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <ul class="nav nav-footer justify-content-center justify-content-lg-end">
                        </ul>
                    </div>
                </div>
            </div>
        </footer>
    </div>


    <div class="fixed-plugin">
        <a class="fixed-plugin-button text-dark position-fixed px-3 py-2 d-flex align-items-center"
           style="margin-right: 50px">
            <img src="<c:url value='/img/barsettings.png'/>" alt="Settings" style="width: 20px;">
            <span class="visually-hidden">Settings</span>
        </a>
        <div class="card shadow-lg">
            <div class="card-header pb-0 pt-3 ">

                <div class="float-end mt-4">
                    <button class="btn btn-link text-dark p-0 fixed-plugin-close-button">
                        <i class="fa fa-close"></i>
                    </button>
                </div>
                <!-- End Toggle Button -->
            </div>
            <hr class="horizontal dark my-1">
            <div class="card-body pt-sm-3 pt-0 overflow-auto">
                <!-- Sidebar Backgrounds -->
                <div>
                    <h6 class="mb-0">사이드 바 색상</h6>
                </div>
                <a href="javascript:void(0)" class="switch-trigger background-color">
                    <div class="badge-colors my-2 text-start">
                    <span class="badge filter bg-gradient-primary active" data-color="primary"
                          onclick="sidebarColor(this)"></span>
                        <span class="badge filter bg-gradient-dark" data-color="dark"
                              onclick="sidebarColor(this)"></span>
                        <span class="badge filter bg-gradient-info" data-color="info"
                              onclick="sidebarColor(this)"></span>
                        <span class="badge filter bg-gradient-success" data-color="success"
                              onclick="sidebarColor(this)"></span>
                        <span class="badge filter bg-gradient-warning" data-color="warning"
                              onclick="sidebarColor(this)"></span>
                        <span class="badge filter bg-gradient-danger" data-color="danger"
                              onclick="sidebarColor(this)"></span>
                    </div>
                </a>
                <!-- Sidenav Type -->
                <div class="mt-3">
                    <h6 class="mb-0">사이드 바 색상</h6>
                </div>
                <div class="d-flex">
                    <button class="btn bg-gradient-primary w-100 px-3 mb-2 active me-2" data-class="bg-white"
                            onclick="sidebarType(this)">White
                    </button>
                    <button class="btn bg-gradient-primary w-100 px-3 mb-2" data-class="bg-default"
                            onclick="sidebarType(this)">Dark
                    </button>
                </div>
                <p class="text-sm d-xl-none d-block mt-2">You can change the sidenav type just on desktop view.</p>
                <hr class="horizontal dark my-sm-4">
                <div class="mt-2 mb-5 d-flex">
                    <h6 class="mb-0">다크모드</h6>
                    <div class="form-check form-switch ps-0 ms-auto my-auto">
                        <input class="form-check-input mt-1 ms-auto" type="checkbox" id="dark-version"
                               onclick="darkMode(this)">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="fixed-plugin">
    <a id="chat-button" class="fixed-plugin-button text-dark position-fixed px-3 py-2 d-flex align-items-center"
       style="right: 10px;">
        <img src="<c:url value='img/chatbot.png'/>" alt="Chat" style="width: 20px;">
        <span class="visually-hidden">Chat</span>
    </a>
</div>


<div id="chat-window" class="chat-window"
     style="display: none; position: fixed; bottom: 70px; right: 10px; width: 425px; height: 515px; background: white; box-shadow: 0 4px 6px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden;">
    <div class="chat-header" style="padding: 10px; background: #007bff; color: white; font-size: 16px;">
        AI 상담사

        <button id="adminchat" class="adminchat">
            <span>관리자와 연결</span>
        </button>

        <button id="close-chat"
                style="float: right; background: none; border: none; color: white; font-size: 18px; cursor: pointer;">×
        </button>
    </div>
    <div class="chat-body" style="padding: 10px; overflow-y: auto; height: calc(100% - 50px);" id="chatbody">
        <jsp:include page="chatbot.jsp"/>
    </div>
</div>


<!--   Core JS Files   -->
<script src="<c:url value="/js/core/popper.min.js"/>"></script>
<script src="<c:url value="/js/core/bootstrap.min.js"/>"></script>
<script src="<c:url value="/js/plugins/perfect-scrollbar.min.js"/>"></script>
<script src="<c:url value="/js/plugins/smooth-scrollbar.min.js"/>"></script>
<script src="<c:url value="/js/plugins/chartjs.min.js"/>"></script>
<script>
    var ctx1 = document.getElementById("chart-line").getContext("2d");

    var gradientStroke1 = ctx1.createLinearGradient(0, 230, 0, 50);

    gradientStroke1.addColorStop(1, 'rgba(94, 114, 228, 0.2)');
    gradientStroke1.addColorStop(0.2, 'rgba(94, 114, 228, 0.0)');
    gradientStroke1.addColorStop(0, 'rgba(94, 114, 228, 0)');
    new Chart(ctx1, {
        type: "line",
        data: {
            labels: ["Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
            datasets: [{
                label: "Mobile apps",
                tension: 0.4,
                borderWidth: 0,
                pointRadius: 0,
                borderColor: "#5e72e4",
                backgroundColor: gradientStroke1,
                borderWidth: 3,
                fill: true,
                data: [50, 40, 300, 220, 500, 250, 400, 230, 500],
                maxBarThickness: 6

            }],
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false,
                }
            },
            interaction: {
                intersect: false,
                mode: 'index',
            },
            scales: {
                y: {
                    grid: {
                        drawBorder: false,
                        display: true,
                        drawOnChartArea: true,
                        drawTicks: false,
                        borderDash: [5, 5]
                    },
                    ticks: {
                        display: true,
                        padding: 10,
                        color: '#fbfbfb',
                        font: {
                            size: 11,
                            family: "Open Sans",
                            style: 'normal',
                            lineHeight: 2
                        },
                    }
                },
                x: {
                    grid: {
                        drawBorder: false,
                        display: false,
                        drawOnChartArea: false,
                        drawTicks: false,
                        borderDash: [5, 5]
                    },
                    ticks: {
                        display: true,
                        color: '#ccc',
                        padding: 20,
                        font: {
                            size: 11,
                            family: "Open Sans",
                            style: 'normal',
                            lineHeight: 2
                        },
                    }
                },
            },
        },
    });
</script>
<script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
        var options = {
            damping: '0.5'
        }
        Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
</script>
<!-- Github buttons -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
<!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
<script src="<c:url value="/js/argon-dashboard.min.js?v=2.1.0"/>"></script>

</body>
</html>