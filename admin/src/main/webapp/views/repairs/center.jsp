<!DOCTYPE html>
<html>
<head>
    <title>Calendar</title>
    <meta charset='utf-8' />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.15/index.global.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.15/locales/ko.global.min.js'></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
</head>

<style>
    .schedule-sidebar {
        background-color: rgba(28, 44, 80, 0.85);
        border-radius: 15px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        margin: 20px;
        padding: 25px;
        height: calc(100vh - 40px);
        backdrop-filter: blur(10px);
    }

    .schedule-title-container {
        border-bottom: 2px solid rgba(255, 255, 255, 0.1);
        margin-bottom: 20px;
        padding-bottom: 15px;
    }

    .schedule-title {
        color: #ffffff;
        font-weight: 600;
        font-size: 1.2rem;
        margin: 0;
    }

    .schedule-list-container {
        width: 100%;
    }

    .schedule-list {
        max-height: calc(100vh - 150px);
        overflow-y: auto;
        padding-right: 10px;
    }

    .schedule-list::-webkit-scrollbar {
        width: 6px;
    }

    .schedule-list::-webkit-scrollbar-track {
        background: rgba(255, 255, 255, 0.05);
        border-radius: 3px;
    }

    .schedule-list::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.2);
        border-radius: 3px;
    }

    .schedule-list::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 255, 255, 0.3);
    }

    .schedule-item {
        background: rgba(255, 255, 255, 0.07);
        margin-bottom: 10px;
        border-radius: 10px;
        border: 1px solid rgba(255, 255, 255, 0.1);
        padding: 15px;
        color: #ffffff;
        transition: all 0.2s ease;
    }

    .schedule-item:hover {
        background: rgba(255, 255, 255, 0.1);
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .col-sm-4 {
        flex: 0 0 auto;
        width: 33.333333%;
        height: 90%;
    }

</style>

<body>
<%--캘린더 영역 시작--%>
<div class="content-wrapper">
    <div class="row" style="display: flex; height: 100vh;">
        <!-- 캘린더 영역 -->
        <div class="col-sm-8">
            <div id='calendar' style="width: 90%; height: 90%; margin: 20px auto;"></div>
        </div>

        <!-- 예정된 일정 영역 -->
        <div class="col-sm-4" style="display: flex; align-items: center;">
            <div class="schedule-sidebar" style="width: 90%; height: 90%; margin: 20px auto;">
                <div class="event-list-container">
                    <div class="schedule-title-container">
                        <h5 class="schedule-title">예정된 일정</h5>
                    </div>
                    <div class="schedule-list-container">
                        <div id="eventList" class="schedule-list">
                            <!-- 여기에 일정이 동적으로 추가됨 -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--캘린더 영역 끝--%>

<script>
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
                    right: 'prev,next myCustomButton' // 오른쪽에 이전/다음 버튼과 커스텀 버튼
                },
                // 새 일정 추가 버튼 설정
                customButtons: {
                    myCustomButton: {
                        text: '➕ 새 일정',
                        click: function() {
                            // 구글 캘린더 일정 추가 페이지를 새 탭으로 열기
                            const calendarId = '457db7e99562960f71fa24849c40b96f5151eee93309bb77281efe4876fc89b2@group.calendar.google.com';
                            window.open(`https://calendar.google.com/calendar/u/0/r/eventedit?cid=${calendarId}`, '_blank');
                        }
                    }
                },
                initialView: 'dayGridMonth', // 월간 뷰로 초기화
                googleCalendarApiKey: 'AIzaSyAw5ATyRPtGDxeZLu5GoPjqZCENrKLoxuw', // 구글 캘린더 API 키
                // 구글 캘린더 이벤트 소스 설정
                eventSources: [{
                    googleCalendarId: '457db7e99562960f71fa24849c40b96f5151eee93309bb77281efe4876fc89b2@group.calendar.google.com',
                    success: (events) => {
                        console.log('구글 캘린더 이벤트 로드 성공:', events);  // 추가
                        this.updateEventList(calendarInstance);
                    },
                    failure: function(error) {
                        console.log('구글 캘린더 로드 실패:', error);  // 추가
                    }
                }],
                locale: 'ko', // 한국어 설정
                // 이벤트 클릭 핸들러
                eventClick: function(info) {
                    info.jsEvent.preventDefault(); // 기본 동작 방지

                    // DB 이벤트인 경우
                    if (info.event.extendedProps.isDBEvent) {
                        // 현재 상태 가져오기
                        const currentStatus = info.event.extendedProps.repairStat;
                        // 상태 토글 (A->B 또는 B->A)
                        const newStatus = currentStatus === 'A' ? 'B' : 'A';
                        // 새 상태에 따른 색상 설정
                        const newColor = newStatus === 'A' ? '#E74C3C' : '#67e73c';

                        // 이벤트 배경색 변경
                        info.event.setProp('backgroundColor', newColor);

                        // 서버에 상태 업데이트 요청
                        $.ajax({
                            url: '/updateRepairStatus',
                            type: 'POST',
                            data: {
                                repairId: info.event.extendedProps.repairId,
                                repairStat: newStatus
                            },
                            success: function(response) {
                                // 상태 업데이트 성공시 이벤트 속성 변경과 목록 업데이트
                                info.event.setExtendedProp('repairStat', newStatus);
                                calendar.updateEventList(calendarInstance);
                            }
                        });
                        alert('제목: ' + info.event.title);
                    } else {
                        // DB 이벤트가 아닌 경우 제목만 알림
                        alert('제목: ' + info.event.title);
                        console.log(info.event.extendedProps.description);
                    }
                }
            });

            // 캘린더 렌더링
            calendarInstance.render();
            // DB 이벤트 로드
            this.getEvents(calendarInstance);
            // 예정된 일정 목록 초기화
            setTimeout(() => {
                calendar.updateEventList(calendarInstance);
            }, 1000); // 1초 지연
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
                    this.updateEventList(calendarInstance);
                }
            });
        },

        // 예정된 일정 목록을 업데이트하는 함수
        updateEventList: function(calendarInstance) {
            const eventList = document.getElementById('eventList');
            eventList.innerHTML = ''; // 기존 목록 초기화

            // 현재 날짜 기준으로 향후 30일 간의 모든 이벤트 가져오기
            const now = new Date();
            now.setDate(now.getDate() - 1);
            const thirtyDaysFromNow = new Date();
            thirtyDaysFromNow.setDate(now.getDate() + 30);

            // 캘린더의 모든 이벤트 가져오기
            const allEvents = calendarInstance.getEvents();

            // 날짜 범위 내의 이벤트 필터링 및 정렬
            const upcomingEvents = allEvents
                .filter(event => {
                    // event.start가 null이거나 undefined인 경우 처리
                    if (!event.start) {
                        console.log('시작 시간이 없는 이벤트:', event);
                        return false;
                    }

                    const eventDate = event.start instanceof Date ?
                        event.start : new Date(event.start);

                    console.log(`이벤트 "${event.title}" 실제 날짜:`, eventDate);

                    const isInRange = eventDate >= now && eventDate <= thirtyDaysFromNow;
                    return isInRange;
                })

            // 이벤트 목록 생성
            upcomingEvents.forEach(event => {
                const eventDate = new Date(event.start);
                const eventItem = document.createElement('div');
                eventItem.className = 'schedule-item';

                // 날짜 포맷팅
                const dateString = eventDate.toLocaleDateString('ko-KR', {
                    month: 'long',
                    day: 'numeric',
                    weekday: 'short'
                });

                // 시간 포맷팅
                const timeString = eventDate.toLocaleTimeString('ko-KR', {
                    hour: '2-digit',
                    minute: '2-digit'
                });

                // 이벤트 종류에 따른 아이콘 설정
                const icon = event.extendedProps?.isDBEvent ? '🔧' : '📅';

                // 이벤트 상태에 따른 배지 설정 (DB 이벤트인 경우에만)
                let statusBadge = '';
                if (event.extendedProps?.isDBEvent) {
                    const status = event.extendedProps.repairStat === 'A' ? '대기' : '완료';
                    const badgeColor = event.extendedProps.repairStat === 'A' ?
                        'background-color: rgba(231, 76, 60, 0.2);' :
                        'background-color: rgba(103, 231, 60, 0.2);';
                    statusBadge = `<span style="
                    \${badgeColor}
                    padding: 2px 8px;
                    border-radius: 12px;
                    font-size: 0.8em;
                    margin-left: 8px;
                ">\${status}</span>`;
                }

                // HTML 구성
                eventItem.innerHTML = `
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <div style="font-size: 0.9em; color: rgba(255, 255, 255, 0.7);">
                        \${dateString} \${timeString}
                    </div>
                    \${statusBadge}
                </div>
                <div style="margin-top: 8px; display: flex; align-items: center;">
                    <span style="margin-right: 8px;">\${icon}</span>
                    <span>\${event.title}</span>
                </div>
            `;

                eventList.appendChild(eventItem);
            });

            // 이벤트가 없는 경우 메시지 표시
            if (upcomingEvents.length === 0) {
                const noEventItem = document.createElement('div');
                noEventItem.className = 'schedule-item';
                noEventItem.innerHTML = `
                <div style="text-align: center; color: rgba(255, 255, 255, 0.7);">
                    예정된 일정이 없습니다
                </div>
            `;
                eventList.appendChild(noEventItem);
            }
        }
    };

    // 문서 로드 완료 시 캘린더 초기화
    $(function() {
        calendar.init();
    });

</script>
</body>
</html>
