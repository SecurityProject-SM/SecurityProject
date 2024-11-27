<!DOCTYPE html>
<html>
<head>
    <title>Calendar</title>
    <meta charset='utf-8' />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.15/index.global.min.js'></script>

    <script src='https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.15/locales/ko.global.min.js'></script>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
</head>
<body>
<div class="content-wrapper">
    <div id='calendar'></div>

</div>
<script>
    // 캘린더 객체 정의
    let calendar = {
        init: function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                googleCalendarApiKey: 'AIzaSyAw5ATyRPtGDxeZLu5GoPjqZCENrKLoxuw',
                events: {
                    // googleCalendarId: 'c_e038e7f3d11c0e4f1a472dc492ede21ca5ac621b92d64c9d7179f0412761cff1@group.calendar.google.com'
                    googleCalendarId: '457db7e99562960f71fa24849c40b96f5151eee93309bb77281efe4876fc89b2@group.calendar.google.com'
                },
                locale: 'ko',
                eventClick: function(info) {
                    // 구글 오픈
                    // info.jsEvent.preventDefault();

                    // DB 이벤트인 경우에만 색상 토글
                    if (info.event.extendedProps.isDBEvent) {
                        // 현재 상태 확인
                        const currentStatus = info.event.extendedProps.repairStat;
                        // 새로운 상태와 색상 설정
                        const newStatus = currentStatus === 'A' ? 'B' : 'A';
                        const newColor = newStatus === 'A' ? '#E74C3C' : '#67e73c';

                        // 이벤트 색상 변경
                        info.event.setProp('backgroundColor', newColor);

                        // DB 업데이트를 위한 AJAX 호출
                        $.ajax({
                            url: '/updateRepairStatus',
                            type: 'POST',
                            data: {
                                repairId: info.event.extendedProps.repairId,
                                repairStat: newStatus
                            },
                            success: function(response) {
                                info.event.setExtendedProp('repairStat', newStatus);
                            }
                        });
                        alert('제목: ' + info.event.title);
                    } else {
                        // 구글 캘린더 이벤트인 경우 기존 처리
                        alert('제목: ' + info.event.title);
                        console.log(info.event.extendedProps.description);
                    }
                }
            });
            calendar.render();
            this.getEvents(calendar);
        },

        // DB값 가져오기
        getEvents: function(calendarInstance) {
            $.ajax({
                url: '/getrepairs',
                type: 'GET',
                success: function(result){
                    console.log(result);
                    result.repairsData.forEach(function(repair) {
                        // 캘린더에 이벤트 추가할 때 DB 이벤트임을 표시하는 속성 추가
                        calendarInstance.addEvent({
                            title: '[유지보수] ' + repair.repairLoc,
                            start: repair.repairStart,
                            backgroundColor: repair.repairStat === 'A' ? '#E74C3C' : '#3498DB',
                            extendedProps: {
                                isDBEvent: true,  // DB에서 가져온 이벤트임을 표시
                                repairId: repair.repairId,
                                repairStat: repair.repairStat
                            }
                        });
                    });
                }
            });
        },

        updateStatus: function(newStatus) {
            if (!currentEvent) return;

            $.ajax({
                url: '/updateRepairStatus',
                type: 'POST',
                data: {
                    repairId: currentEvent.extendedProps.repairId,
                    repairStat: newStatus
                },
                success: function(response) {
                    // 이벤트 상태와 색상 업데이트
                    currentEvent.setExtendedProp('repairStat', newStatus);
                    currentEvent.setProp('backgroundColor', newStatus === 'B' ? '#67e73c' : '#3498DB');

                    // 다이얼로그 닫기
                    closeDialog();

                    // 성공 알림 표시
                    const successAlert = document.getElementById('successAlert');
                    successAlert.style.display = 'block';

                    // 캘린더 새로고침 (선택사항)
                    calendar.refetchEvents();

                    // 3초 후 알림 숨기기
                    setTimeout(function() {
                        successAlert.style.display = 'none';
                    }, 3000);
                }
            });
        }
    };

    // 문서 로드 완료 시 캘린더 초기화
    $(function() {
        calendar.init();
    });

</script>
</body>
</html>
