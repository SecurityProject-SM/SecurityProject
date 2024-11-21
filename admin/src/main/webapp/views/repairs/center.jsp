<!DOCTYPE html>
<html>
<head>
    <title>Google Calendar</title>
    <meta charset='utf-8' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
    <script src="https://apis.google.com/js/api.js"></script>
    <script src="https://accounts.google.com/gsi/client"></script>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <style>
        body {
            margin: 40px 10px;
            padding: 0;
            font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
        }
        #calendar {
            max-width: 1100px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
<div id="calendar"></div>

<script>
    const CLIENT_ID = '819413479729-h0djsa73ccab5100nidvhkbfo6mq90q5.apps.googleusercontent.com';
    const API_KEY = 'AIzaSyAw5ATyRPtGDxeZLu5GoPjqZCENrKLoxuw';
    const DISCOVERY_DOC = 'https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest';
    const SCOPES = 'https://www.googleapis.com/auth/calendar.readonly';

    let tokenClient;
    let gapiInited = false;
    let gisInited = false;

    let calendar = {
        init: function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                editable: true,
                selectable: true,

                // 날짜 선택시 일정 추가
                select: this.select,

                // 일정 클릭시 수정/삭제
                eventClick: this.eventClick,

                // 일정 드래그 & 드롭
                eventDrop: this.eventDrop,

                // DB 데이터 로드
                events: this.getEvents
            });

            calendar.render();

            // 5초마다 데이터 갱신
            setInterval(function() {
                calendar.refetchEvents();
            }, 5000);
        },

        // DB 데이터 로드
        getEvents: function(fetchInfo, successCallback, failureCallback) {
            $.ajax({
                url: '/repairs/getrepairs',
                type: 'GET',
                success: function(result) {
                    let events = [];
                    result.repairsData.forEach(function(repair) {
                        events.push({
                            title: '[유지보수] ' + repair.repairLoc,
                            start: repair.repairStart,
                            backgroundColor: repair.repairStat === 'A' ? '#E74C3C' : '#3498DB',
                            extendedProps: {
                                repairId: repair.repairId,
                                repairStat: repair.repairStat
                            }
                        });
                    });
                    successCallback(events);
                }
            });
        },

        // 일정 추가
        select: function(info) {
            let title = prompt('일정 제목을 입력하세요:');
            if (title) {
                $.ajax({
                    url: '/repairs/add',
                    type: 'POST',
                    data: {
                        title: title,
                        start: info.startStr,
                        end: info.endStr
                    },
                    success: function(response) {
                        calendar.addEvent({
                            title: title,
                            start: info.startStr,
                            end: info.endStr,
                            allDay: info.allDay
                        });
                    }
                });
            }
            calendar.unselect();
        },

        // 일정 삭제
        eventClick: function(info) {
            if(confirm('선택한 일정을 삭제하시겠습니까?')) {
                $.ajax({
                    url: '/repairs/delete',
                    type: 'POST',
                    data: {
                        repairId: info.event.extendedProps.repairId
                    },
                    success: function(response) {
                        info.event.remove();
                    }
                });
            }
        },

        // 일정 수정 (드래그 & 드롭)
        eventDrop: function(info) {
            if(confirm('일정을 수정하시겠습니까?')) {
                $.ajax({
                    url: '/repairs/update',
                    type: 'POST',
                    data: {
                        repairId: info.event.extendedProps.repairId,
                        start: info.event.startStr,
                        end: info.event.endStr
                    },
                    success: function(response) {
                        // 성공시 자동으로 반영됨
                    },
                    error: function() {
                        info.revert();
                    }
                });
            } else {
                info.revert();
            }
        }
    };

    // 문서 준비되면 실행
    $(function() {
        calendar.init();
    });

</script>
</body>
</html>