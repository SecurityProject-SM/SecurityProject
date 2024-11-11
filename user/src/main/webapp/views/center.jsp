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
    .weather-item {
        display: inline-block;
        padding: 10px;
        white-space: nowrap;
        text-align: center;
        min-width: 120px;
        background-color: #f9f9f9;
        border-radius: 8px;
        margin-right: 8px;
        position: relative;
    }

    .weather-item:not(:last-child)::after {
        content: "";
        position: absolute;
        top: 10px;
        right: -4px;
        width: 1px;
        height: calc(100% - 20px); /* 위, 아래에 여백 */
        background-color: #ddd; /* 수직선 색상 */
    }

    .weather-icon {
        width: 30px;
        height: 30px;
        vertical-align: middle;
        margin-bottom: 5px;
    }

    #weatherContainer {
        display: flex;
        overflow-x: auto;
        white-space: nowrap;
        padding: 5px;
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

    .highcharts-description {
        margin: 0.3rem 10px;
    }

</style>

<script>
    let center = {
        init: function () {
            $.ajax({
                url:'<c:url value="/wh"/>',
                success : (result)=>{
                    let wtext = result.response.body.items.item[0].wfSv;
                    $('#dayweather').text(wtext);
                }
            });

            $.ajax({
                url: '<c:url value="/ow"/>',
                success: (result) => {
                    $('#weatherContainer').empty();
                    result.list.forEach((item) => {
                        let temp = item.main.temp;
                        let des = item.weather[0].description;
                        let icon = item.weather[0].icon;
                        let time = item.dt_txt;
                        console.log(temp, des, icon, time)

                        center.display(temp, des, icon, time);
                    });
                }
            });
        },
        display: function (temp, des, icon, time) {
            let formattedTime = time.substring(5, 16);

            const weatherHTML =
                '<div class="weather-item">' +
                '<img src="https://openweathermap.org/img/wn/' + icon + '.png" alt="' + des + '" class="weather-icon">' +
                '' + formattedTime + '<br>' +
                '<strong>기온:</strong> ' + temp + '°C<br>' +
                '<strong>' + des + '</strong><br>' +
                '</div>';

            $('#weatherContainer').append(weatherHTML);
        }
    };

    $(function () {
        center.init();
    });
</script>


<body>
<div class="container-fluid py-4">
    <div class="row mt-4">
        <div class="col-lg-7 mb-lg-0 mb-4">
            <div class="card z-index-2 h-100">
                <div class="card-header pb-0 pt-3 bg-transparent">
                    <h6 class="text-capitalize">Sales overview</h6>
                    <p class="text-sm mb-0">
                        <i class="fa fa-arrow-up text-success"></i>
                        <span class="font-weight-bold">4% more</span> in 2021
                    </p>
                </div>
                <div class="card-body p-3">
                    <div class="chart">
                        <canvas id="chart-line" class="chart-canvas" height="300"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="card card-carousel overflow-hidden h-100 p-0">
                <div class="card-header pb-0 pt-3 bg-transparent">
                    <h6 class="text-capitalize">날씨</h6>
                </div>
                <pre class="card-body" id="weatherContainer">날씨 데이터를 불러오는 중...</pre>
                <div>test</div>
                <p id="dayweather"></p>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-lg-7 mb-lg-0 mb-4">
                <div class="card">
                    <div class="card-header pb-0 p-3">
                        <div class="d-flex justify-content-between">
                            <h6 class="mb-2">날씨 차트 띄울예정</h6>
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
                        <h6 class="mb-0">Categories</h6>
                    </div>
                    <div class="card-body p-3">
                        <ul class="list-group">
                            <li class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2 border-radius-lg">
                                <div class="d-flex align-items-center">
                                    <div class="icon icon-shape icon-sm me-3 bg-gradient-dark shadow text-center">
                                        <i class="ni ni-mobile-button text-white opacity-10"></i>
                                    </div>
                                    <div class="d-flex flex-column">
                                        <h6 class="mb-1 text-dark text-sm">Devices</h6>
                                        <span class="text-xs">250 in stock, <span
                                                class="font-weight-bold">346+ sold</span></span>
                                    </div>
                                </div>
                                <div class="d-flex">
                                    <button class="btn btn-link btn-icon-only btn-rounded btn-sm text-dark icon-move-right my-auto">
                                        <i class="ni ni-bold-right" aria-hidden="true"></i></button>
                                </div>
                            </li>
                            <li class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2 border-radius-lg">
                                <div class="d-flex align-items-center">
                                    <div class="icon icon-shape icon-sm me-3 bg-gradient-dark shadow text-center">
                                        <i class="ni ni-tag text-white opacity-10"></i>
                                    </div>
                                    <div class="d-flex flex-column">
                                        <h6 class="mb-1 text-dark text-sm">Tickets</h6>
                                        <span class="text-xs">123 closed, <span
                                                class="font-weight-bold">15 open</span></span>
                                    </div>
                                </div>
                                <div class="d-flex">
                                    <button class="btn btn-link btn-icon-only btn-rounded btn-sm text-dark icon-move-right my-auto">
                                        <i class="ni ni-bold-right" aria-hidden="true"></i></button>
                                </div>
                            </li>
                            <li class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2 border-radius-lg">
                                <div class="d-flex align-items-center">
                                    <div class="icon icon-shape icon-sm me-3 bg-gradient-dark shadow text-center">
                                        <i class="ni ni-box-2 text-white opacity-10"></i>
                                    </div>
                                    <div class="d-flex flex-column">
                                        <h6 class="mb-1 text-dark text-sm">Error logs</h6>
                                        <span class="text-xs">1 is active, <span
                                                class="font-weight-bold">40 closed</span></span>
                                    </div>
                                </div>
                                <div class="d-flex">
                                    <button class="btn btn-link btn-icon-only btn-rounded btn-sm text-dark icon-move-right my-auto">
                                        <i class="ni ni-bold-right" aria-hidden="true"></i></button>
                                </div>
                            </li>
                            <li class="list-group-item border-0 d-flex justify-content-between ps-0 border-radius-lg">
                                <div class="d-flex align-items-center">
                                    <div class="icon icon-shape icon-sm me-3 bg-gradient-dark shadow text-center">
                                        <i class="ni ni-satisfied text-white opacity-10"></i>
                                    </div>
                                    <div class="d-flex flex-column">
                                        <h6 class="mb-1 text-dark text-sm">Happy users</h6>
                                        <span class="text-xs font-weight-bold">+ 430</span>
                                    </div>
                                </div>
                                <div class="d-flex">
                                    <button class="btn btn-link btn-icon-only btn-rounded btn-sm text-dark icon-move-right my-auto">
                                        <i class="ni ni-bold-right" aria-hidden="true"></i></button>
                                </div>
                            </li>
                        </ul>
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
        <a class="fixed-plugin-button text-dark position-fixed px-3 py-2">
            <i class="fa fa-cog py-2"> </i>
        </a>
        <div class="card shadow-lg">
            <div class="card-header pb-0 pt-3 ">
                <div class="float-start">
                    <h5 class="mt-3 mb-0">Argon Configurator</h5>
                    <p>See our dashboard options.</p>
                </div>
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
                    <h6 class="mb-0">Sidebar Colors</h6>
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
                    <h6 class="mb-0">Sidenav Type</h6>
                    <p class="text-sm">Choose between 2 different sidenav types.</p>
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
                <!-- Navbar Fixed -->
                <div class="d-flex my-3">
                    <h6 class="mb-0">Navbar Fixed</h6>
                    <div class="form-check form-switch ps-0 ms-auto my-auto">
                        <input class="form-check-input mt-1 ms-auto" type="checkbox" id="navbarFixed"
                               onclick="navbarFixed(this)">
                    </div>
                </div>
                <hr class="horizontal dark my-sm-4">
                <div class="mt-2 mb-5 d-flex">
                    <h6 class="mb-0">Light / Dark</h6>
                    <div class="form-check form-switch ps-0 ms-auto my-auto">
                        <input class="form-check-input mt-1 ms-auto" type="checkbox" id="dark-version"
                               onclick="darkMode(this)">
                    </div>
                </div>

            </div>
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