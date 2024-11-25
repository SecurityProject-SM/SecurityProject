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
        // 캘린더 초기화 및 기본 설정
        init: function() {
            var calendarEl = document.getElementById('calendar'); // 캘린더가 들어갈 div 요소 가져오기
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',  // 처음 보여질 때 월간 보기로 설정
                headerToolbar: {  // 상단 툴바 설정
                    left: 'prev,next today',     // 왼쪽: 이전,다음,오늘 버튼
                    center: 'title',             // 중앙: 현재 년월 표시
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'  // 오른쪽: 월,주,일 보기 버튼
                },
                editable: true,    // 이벤트 드래그&드롭 가능
                selectable: true,  // 날짜 선택 가능

                select: this.select,          // 날짜 선택시 실행할 함수
                eventClick: this.eventClick,  // 이벤트 클릭시 실행할 함수
                eventDrop: this.eventDrop,    // 이벤트 드래그&드롭시 실행할 함수
                events: this.getEvents        // 이벤트 데이터 가져오는 함수
            });

            calendar.render();  // 캘린더 렌더링

            // 5초마다 이벤트 데이터 새로고침
            setInterval(function() {
                calendar.refetchEvents();
            }, 5000);
        },

        // DB에서 이벤트 데이터 가져오기
        getEvents: function(fetchInfo, successCallback, failureCallback) {
            $.ajax({
                url: '/repairs/getrepairs',  // 서버 요청 URL
                type: 'GET',
                success: function(result) {
                    let events = [];
                    // DB에서 가져온 각 repair 데이터를 캘린더 이벤트 형식으로 변환
                    result.repairsData.forEach(function(repair) {
                        events.push({
                            title: '[유지보수] ' + repair.repairLoc,  // 이벤트 제목
                            start: repair.repairStart,                // 시작 날짜
                            backgroundColor: repair.repairStat === 'A' ? '#E74C3C' : '#3498DB',  // 상태에 따른 색상
                            extendedProps: {  // 추가 속성 저장
                                repairId: repair.repairId,
                                repairStat: repair.repairStat
                            }
                        });
                    });
                    successCallback(events);  // 변환된 이벤트 데이터 전달
                }
            });
        },

        // 날짜 선택시 새 일정 추가
        select: function(info) {
            let repairLoc = prompt('일정 정보를 입력하세요:');  // 사용자에게 일정 정보 입력받기
            if (repairLoc) {
                $.ajax({
                    url: '/repairs/add',  // 서버 요청 URL
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',  // JSON 형식으로 데이터 전송
                    data: JSON.stringify({  // 서버로 보낼 데이터
                        buildingId: null,
                        iotId: null,
                        repairStat: null,
                        repairStart: info.startStr,  // 선택한 날짜
                        repairLoc: repairLoc        // 입력받은 일정 정보
                    }),
                    success: function(response) {
                        // 서버 저장 성공시 캘린더에 이벤트 추가
                        info.view.calendar.addEvent({
                            title: repairLoc,
                            start: info.startStr,
                            backgroundColor: '#3498DB'
                        });
                    },
                    error: function(error) {
                        console.log('Error:', error);
                        alert('일정 추가에 실패했습니다.');
                    }
                });
            }
            info.view.calendar.unselect();  // 날짜 선택 상태 해제
        },

        // 이벤트 클릭시 삭제
        eventClick: function(info) {
            if(confirm('선택한 일정을 삭제하시겠습니까?')) {
                $.ajax({
                    url: '/repairs/delete',  // 서버 요청 URL
                    type: 'POST',
                    data: {
                        repairId: info.event.extendedProps.repairId  // 삭제할 이벤트 ID
                    },
                    success: function(response) {
                        info.event.remove();  // 캘린더에서 이벤트 제거
                    }
                });
            }
        },

        // 이벤트 드래그&드롭으로 수정
        eventDrop: function(info) {
            if(confirm('일정을 수정하시겠습니까?')) {
                $.ajax({
                    url: '/repairs/update',  // 서버 요청 URL
                    type: 'POST',
                    data: {
                        repairId: info.event.extendedProps.repairId,  // 수정할 이벤트 ID
                        start: info.event.startStr,    // 변경된 시작 날짜
                        end: info.event.endStr         // 변경된 종료 날짜
                    },
                    success: function(response) {
                        // 성공시 자동으로 반영됨
                    },
                    error: function() {
                        info.revert();  // 실패시 원래 위치로 되돌리기
                    }
                });
            } else {
                info.revert();  // 취소시 원래 위치로 되돌리기
            }
        }
    };

    // 문서가 완전히 로드된 후 캘린더 초기화
    $(function() {
        calendar.init();
    });

</script>
</body>
</html>