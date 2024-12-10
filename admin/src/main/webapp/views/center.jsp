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

<script>
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
        }
    };

    // 캘린더 객체 정의
    let calendar = {
        init: function() {
            // calendar div 요소를 가져옴
            var calendarEl = document.getElementById('calendar');
            // FullCalendar 인스턴스 생성
            var calendarInstance = new FullCalendar.Calendar(calendarEl, {
                // 캘린더 헤더 툴바 설정
                headerToolbar: {
                    left: '',  // 왼쪽 영역 비움
                    center: 'title', // 중앙에 타이틀 표시
                    right: '' // 오른쪽 영역 비움
                },
                initialView: 'dayGridMonth', // 월간 뷰로 초기화
                googleCalendarApiKey: 'AIzaSyAw5ATyRPtGDxeZLu5GoPjqZCENrKLoxuw', // 구글 캘린더 API 키
                // 구글 캘린더 이벤트 소스 설정
                eventSources: [{
                    googleCalendarId: '457db7e99562960f71fa24849c40b96f5151eee93309bb77281efe4876fc89b2@group.calendar.google.com',
                    success: (events) => {
                        console.log('구글 캘린더 이벤트 로드 성공:', events);
                    },
                    failure: function(error) {
                        console.log('구글 캘린더 로드 실패:', error);
                    }
                }],
                locale: 'ko', // 한국어 설정
                // 이벤트 클릭 핸들러
                eventClick: function(info) {
                    info.jsEvent.preventDefault(); // 기본 동작 방지
                }
            });

            // 캘린더 렌더링
            calendarInstance.render();
            // DB 이벤트 로드
            this.getEvents(calendarInstance);
        },

        // DB값 가져오기
        getEvents: function(calendarInstance) {
            $.ajax({
                url: '/getrepairs',
                type: 'GET',
                success: (result) => {
                    console.log(result);
                    result.repairsData.forEach((repair) => {
                        calendarInstance.addEvent({
                            title: '[유지보수] ' + repair.repairLoc,
                            start: repair.repairStart,
                            backgroundColor: repair.repairStat === 'A' ? '#E74C3C' : '#3498DB',
                            extendedProps: {
                                isDBEvent: true,
                                repairId: repair.repairId,
                                repairStat: repair.repairStat
                            }
                        });
                    });
                }
            });
        }
    };

    $(function () {
        userchat.init();
        calendar.init();
    });
</script>

<body>
<div class="content-wrapper">
    <div class="container-fluid">

        <!--Start Dashboard Content-->

        <div class="card mt-3">
            <div class="card-content">
                <div class="row row-group m-0">
                    <div class="col-12 col-lg-6 col-xl-3 border-light">
                        <div class="card-body">
                            <h5 class="text-white mb-0">9526 <span class="float-right"><i
                                    class="fa fa-shopping-cart"></i></span></h5>
                            <div class="progress my-3" style="height:3px;">
                                <div class="progress-bar" style="width:55%"></div>
                            </div>
                            <p class="mb-0 text-white small-font">Total Orders <span class="float-right">+4.2% <i
                                    class="zmdi zmdi-long-arrow-up"></i></span></p>
                        </div>
                    </div>
                    <div class="col-12 col-lg-6 col-xl-3 border-light">
                        <div class="card-body">
                            <h5 class="text-white mb-0">8323 <span class="float-right"><i class="fa fa-usd"></i></span>
                            </h5>
                            <div class="progress my-3" style="height:3px;">
                                <div class="progress-bar" style="width:55%"></div>
                            </div>
                            <p class="mb-0 text-white small-font">Total Revenue <span class="float-right">+1.2% <i
                                    class="zmdi zmdi-long-arrow-up"></i></span></p>
                        </div>
                    </div>
                    <div class="col-12 col-lg-6 col-xl-3 border-light">
                        <div class="card-body">
                            <h5 class="text-white mb-0">6200 <span class="float-right"><i class="fa fa-eye"></i></span>
                            </h5>
                            <div class="progress my-3" style="height:3px;">
                                <div class="progress-bar" style="width:55%"></div>
                            </div>
                            <p class="mb-0 text-white small-font">Visitors <span class="float-right">+5.2% <i
                                    class="zmdi zmdi-long-arrow-up"></i></span></p>
                        </div>
                    </div>
                    <div class="col-12 col-lg-6 col-xl-3 border-light">
                        <div class="card-body">
                            <h5 class="text-white mb-0">5630 <span class="float-right"><i
                                    class="fa fa-envira"></i></span></h5>
                            <div class="progress my-3" style="height:3px;">
                                <div class="progress-bar" style="width:55%"></div>
                            </div>
                            <p class="mb-0 text-white small-font">Messages <span class="float-right">+2.2% <i
                                    class="zmdi zmdi-long-arrow-up"></i></span></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12 col-lg-8 col-xl-8">
                <div class="card">
                    <div class="card-header">Site Traffic
                        <div class="card-action">
                            <div class="dropdown">
                                <a href="<c:url value="/javascript:void();"/>"
                                   class="dropdown-toggle dropdown-toggle-nocaret" data-toggle="dropdown">
                                    <i class="icon-options"></i>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <a class="dropdown-item" href="<c:url value="/javascript:void();"/>">Action</a>
                                    <a class="dropdown-item" href="<c:url value="/javascript:void();"/>">Another
                                        action</a>
                                    <a class="dropdown-item" href="<c:url value="/javascript:void();"/>">Something else
                                        here</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="<c:url value="/javascript:void();"/>">Separated
                                        link</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <ul class="list-inline">
                            <li class="list-inline-item"><i class="fa fa-circle mr-2 text-white"></i>New Visitor</li>
                            <li class="list-inline-item"><i class="fa fa-circle mr-2 text-light"></i>Old Visitor</li>
                        </ul>
                        <div class="chart-container-1">
                            <canvas id="chart1"></canvas>
                        </div>
                    </div>

                    <div class="row m-0 row-group text-center border-top border-light-3">
                        <div class="col-12 col-lg-4">
                            <div class="p-3">
                                <h5 class="mb-0">45.87M</h5>
                                <small class="mb-0">Overall Visitor <span> <i
                                        class="fa fa-arrow-up"></i> 2.43%</span></small>
                            </div>
                        </div>
                        <div class="col-12 col-lg-4">
                            <div class="p-3">
                                <h5 class="mb-0">15:48</h5>
                                <small class="mb-0">Visitor Duration <span> <i class="fa fa-arrow-up"></i> 12.65%</span></small>
                            </div>
                        </div>
                        <div class="col-12 col-lg-4">
                            <div class="p-3">
                                <h5 class="mb-0">245.65</h5>
                                <small class="mb-0">Pages/Visit <span> <i
                                        class="fa fa-arrow-up"></i> 5.62%</span></small>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="col-12 col-lg-4 col-xl-4">
                <div class="card">
                    <div class="card-header">Weekly sales
                        <div class="card-action">
                            <div class="dropdown">
                                <a href="<c:url value="/javascript:void();"/>"
                                   class="dropdown-toggle dropdown-toggle-nocaret" data-toggle="dropdown">
                                    <i class="icon-options"></i>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <a class="dropdown-item" href="<c:url value="/javascript:void();"/>">Action</a>
                                    <a class="dropdown-item" href="<c:url value="/javascript:void();"/>">Another
                                        action</a>
                                    <a class="dropdown-item" href="<c:url value="/javascript:void();"/>">Something else
                                        here</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="<c:url value="/javascript:void();"/>">Separated
                                        link</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="chart-container-2">
                            <canvas id="chart2"></canvas>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table align-items-center">
                            <tbody>
                            <tr>
                                <td><i class="fa fa-circle text-white mr-2"></i> Direct</td>
                                <td>$5856</td>
                                <td>+55%</td>
                            </tr>
                            <tr>
                                <td><i class="fa fa-circle text-light-1 mr-2"></i>Affiliate</td>
                                <td>$2602</td>
                                <td>+25%</td>
                            </tr>
                            <tr>
                                <td><i class="fa fa-circle text-light-2 mr-2"></i>E-mail</td>
                                <td>$1802</td>
                                <td>+15%</td>
                            </tr>
                            <tr>
                                <td><i class="fa fa-circle text-light-3 mr-2"></i>Other</td>
                                <td>$1105</td>
                                <td>+5%</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div><!--End Row-->

        <%--캘린더 영역 시작--%>
        <div class="card">
        <div class="content-wrapper">
            <div class="row" style="display: flex; height: 100vh;">
                <!-- 캘린더 영역 -->
                <div class="col-sm-12">
                    <div id='calendar' style="width: 90%; height: 90%; margin: 20px auto;"></div>
                </div>
            </div>
        </div>
        <%--캘린더 영역 끝--%>
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