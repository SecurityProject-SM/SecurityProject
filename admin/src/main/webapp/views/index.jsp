<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 추가 스크립트-->
<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<!-- simplebar js -->
<script src="<c:url value='/plugins/simplebar/js/simplebar.js'/>"></script>
<!-- sidebar-menu js -->
<script src="<c:url value='/js/sidebar-menu.js'/>"></script>
<!-- loader scripts -->
<%--<script src="<c:url value='/js/jquery.loading-indicator.js'/>"></script>--%>
<!-- Custom scripts -->
<script src="<c:url value='/js/app-script.js'/>"></script>
<!-- Chart js -->
<script src="<c:url value='/plugins/Chart.js/Chart.min.js'/>"></script>
<!-- Index js -->
<%--<script src="<c:url value='/js/index.js'/>"></script>--%>
<!-- HighCharts -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>

<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>건어물 - 건물을 효율적으로!</title>

    <link rel="icon" href="<c:url value='/img/gunamul_icon.ico'/>" type="image/x-icon">
    <!-- simplebar CSS-->
    <link href="<c:url value='/plugins/simplebar/css/simplebar.css'/>" rel="stylesheet"/>
    <!-- Bootstrap core CSS-->
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet"/>
    <!-- animate CSS-->
    <link href="<c:url value='/css/animate.css'/>" rel="stylesheet" type="text/css"/>
    <!-- Icons CSS-->
    <link href="<c:url value='/css/icons.css'/>" rel="stylesheet" type="text/css"/>
    <!-- Sidebar CSS-->
    <link href="<c:url value='/css/sidebar-menu.css'/>" rel="stylesheet"/>
    <!-- Custom Style-->
    <link href="<c:url value='/css/app-style.css'/>" rel="stylesheet"/>

    <%-- 웹소켓 라이브러리--%>
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>

    <!-- jQuery, Popper, Bootstrap from CDN -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<style>
    /* 알림 아이콘 컨테이너 */
    .nav-alarmicon {
        position: relative;
        display: inline-block;
        cursor: pointer;
        padding: 10px;
    }

    /* 알림 드롭다운 */
    .notification-dropdown {
        display: none;
        position: absolute;
        right: 0;
        top: 100%;
        background: white;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        width: 300px;
        z-index: 1000;
    }

    /* 알림 내용 영역 */
    .notification-content {
        max-height: 300px;
        overflow-y: auto;
        padding: 10px;
    }

    /* 알림 아이템 */
    .notification-item {
        padding: 12px;
        border-bottom: 1px solid #eee;
        cursor: pointer;
        transition: background-color 0.2s ease;
        margin-bottom: 5px;
    }

    .notification-item:last-child {
        border-bottom: none;
        margin-bottom: 0;
    }

    .notification-item:hover {
        background-color: #f8f9fa;
    }

    /* 알림 상태 스타일 */
    .notification-item.status-A {
        border-left: 4px solid #E74C3C;
    }

    .notification-item.status-B {
        border-left: 4px solid #67e73c;
    }

    /* 알림 제목 */
    .notification-title {
        font-weight: bold;
        margin-bottom: 5px;
        color: #333;
        font-size: 14px;
    }

    /* 알림 날짜 */
    .notification-date {
        font-size: 12px;
        color: #666;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    /* 알림 뱃지 */
    .notification-badge {
        position: absolute;
        top: 10px;
        right: 9px;
        background-color: #E74C3C;
        color: white;
        border-radius: 50%;
        padding: 2px 4px;
        font-size: 11px;
        min-width: 18px;
        height: 18px;
        text-align: center;
        line-height: 14px;
        border: 1px solid #fff;
        display: none;
    }

    /* 페이지네이션 */
    .notification-pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 10px;
        gap: 5px;
        border-top: 1px solid #eee;
    }

    .pagination-btn {
        border: 1px solid #ddd;
        background: white;
        color: #333;
        padding: 5px 10px;
        border-radius: 3px;
        cursor: pointer;
        font-size: 12px;
    }

    .pagination-btn.active {
        background-color: #007bff;
        color: white;
        border-color: #007bff;
    }

    .notification-dropdown {
        width: 280px;
        right: -70px;
    }
    .notification-footer {
        padding: 10px;
        border-top: 1px solid #eee;
        text-align: center;
    }

    .notification-footer .see-all {
        display: block;
        color: #444;
        font-size: 13px;
        font-weight: 600;
        text-decoration: none;
        padding: 5px;
    }

    .notification-footer .see-all:hover {
        background-color: #f8f9fa;
        border-radius: 4px;
    }

    .notification-date {
        font-size: 11px;
    }
</style>

<script>

    // 알림 객체 정의
    let alarm = {
        // 페이징 관련 설정
        pageSize: 5,     // 페이지당 표시할 알림 수
        currentPage: 1,  // 현재 페이지
        totalItems: 0,   // 전체 알림 수

        // 초기화 함수
        init: function() {
            this.onclick();
            this.initEventHandlers();
            this.loadNotifications();
            // this.markAsRead();
        },



        // 알림 아이콘 클릭 이벤트
        onclick: function() {
            $('.nav-alarmicon .nav-link').click(function(e) {
                e.preventDefault();
                e.stopPropagation();
                $('.notification-dropdown').toggle();
            });
        },

        // 이벤트 핸들러 초기화
        initEventHandlers: function() {
            $(document).click(function() {
                $('.notification-dropdown').hide();
            });

            $('.notification-dropdown').click(function(e) {
                e.stopPropagation();
            });

            // 페이지네이션 버튼 클릭 이벤트
            $(document).on('click', '.pagination-btn', function(e) {
                e.preventDefault();
                const page = $(this).data('page');
                if (page !== alarm.currentPage) {
                    alarm.currentPage = page;
                    alarm.loadNotifications();
                }
            });
        },

        // 페이지네이션 HTML 생성
        createPagination: function(totalPages) {
            const paginationContainer = $('<div>').addClass('notification-pagination');

            // 이전 페이지 버튼
            if (this.currentPage > 1) {
                paginationContainer.append(
                    $('<button>')
                        .addClass('pagination-btn')
                        .data('page', this.currentPage - 1)
                        .text('이전')
                );
            }

            // 페이지 번호 버튼들
            for (let i = 1; i <= totalPages; i++) {
                const pageBtn = $('<button>')
                    .addClass('pagination-btn')
                    .data('page', i)
                    .text(i);

                if (i === this.currentPage) {
                    pageBtn.addClass('active');
                }

                paginationContainer.append(pageBtn);
            }

            // 다음 페이지 버튼
            if (this.currentPage < totalPages) {
                paginationContainer.append(
                    $('<button>')
                        .addClass('pagination-btn')
                        .data('page', this.currentPage + 1)
                        .text('다음')
                );
            }

            return paginationContainer;
        },

        // DB에서 알림 데이터 로드
        loadNotifications: function() {
            $.ajax({
                url: '/getrepairs',
                type: 'GET',
                success: function(result) {
                    const notifications = result.repairsData;
                    const container = $('#notification-list');
                    alarm.totalItems = notifications.length;

                    // 알림 컨테이너 비우기
                    container.empty();

                    // 알림 수 표시
                    if (notifications.length > 0) {
                        $('#notification-count').text(notifications.length).show();
                    } else {
                        $('#notification-count').hide();
                    }

                    // 페이징 처리
                    const startIndex = (alarm.currentPage - 1) * alarm.pageSize;
                    const endIndex = Math.min(startIndex + alarm.pageSize, notifications.length);
                    const totalPages = Math.ceil(notifications.length / alarm.pageSize);

                    // 현재 페이지의 알림만 표시
                    for (let i = startIndex; i < endIndex; i++) {
                        const repair = notifications[i];
                        const date = new Date(repair.repairStart);
                        const formattedDate = date.toLocaleDateString('ko-KR', {
                            year: 'numeric',
                            month: 'long',
                            day: 'numeric',
                            weekday: 'long'
                        });

                        const statusText = repair.repairStat === 'A' ? '진행중' : '완료';

                        // 알림 항목 HTML 생성
                        const notificationItem = $('<div>')
                            .addClass('notification-item')
                            .addClass('status-' + repair.repairStat)
                            .click(function(e) {
                                // 기본 링크 동작 방지
                                e.preventDefault();
                                // 클릭한 알림 항목 숨기기
                                $(this).hide();
                                // 알림 카운트 감소
                                const currentCount = parseInt($('#notification-count').text());
                                if (currentCount > 1) {
                                    $('#notification-count').text(currentCount - 1);
                                } else {
                                    $('#notification-count').hide();
                                }
                            });

                        const titleDiv = $('<div>')
                            .addClass('notification-title')
                            .text('[유지보수] ' + repair.repairLoc);

                        const dateDiv = $('<div>')
                            .addClass('notification-date')
                            .text(formattedDate + ' (' + statusText + ')');

                        notificationItem.append(titleDiv, dateDiv);
                        container.append(notificationItem);
                    }

                    // 페이지네이션 추가
                    if (totalPages > 1) {
                        container.append(alarm.createPagination(totalPages));
                    }
                }
            });
        }
    };

    // 문서 로드 완료 시 알림 시스템 초기화
    $(function() {
        alarm.init();



        setInterval(function() {
            alarm.loadNotifications();
        }, 3000);
    });
</script>

<body class="bg-theme bg-theme9">
<!-- Start wrapper -->
<div id="wrapper">

    <!-- 상단 nev 바 시작 -->
    <header class="topbar-nav">
        <nav class="navbar navbar-expand fixed-top">
            <ul class="navbar-nav mr-auto align-items-center">
                <li class="nav-item">
                    <a class="nav-link toggle-menu" href="<c:url value='/javascript:void();'/>">
                        <i class="icon-menu menu-icon"></i>
                    </a>
                </li>
            </ul>
            <%-- 상단 nev바 오른쪽 아이콘  --%>
            <ul class="navbar-nav align-items-center right-nav-link">

                <!-- 알림 아이콘 영역 -->
                <div class="nav-alarmicon">
                    <a href="#" class="nav-link">
                        <i class="fa fa-bell-o"></i>
                        <span class="notification-badge" id="notification-count"></span>
                    </a>

                    <!-- 알림 드롭다운 메뉴 -->
                    <div class="notification-dropdown">
                        <!-- 알림 내용 -->
                        <div class="notification-content" id="notification-list">
                            <!-- loadNotifications() 함수에 의해 동적으로 채워짐 -->
                        </div>
                        <!-- 알림 푸터 -->
                        <div class="notification-footer">
                            <a href="/repairs" class="see-all">
                                내 캘린더 바로가기 <i class="fa fa-angle-right"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${sessionScope.loginid == null}">
                        <li>
                            <a href="<c:url value="/login"/>">
                                <i class="zmdi zmdi-view-dashboard"></i> <span>sign in</span>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li>
                            <a href="<c:url value="/logoutimpl"/>">
                                <i class="zmdi zmdi-view-dashboard"></i> <span>sign out</span>
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>


            </ul>
        </nav>
    </header>
    <!-- 상단 nev 바 끝 -->

    <!-- Back To Top Button -->
    <a href="<c:url value='/javascript:void();'/>" class="back-to-top"><i class="fa fa-angle-double-up"></i></a>

    <!-- Sidebar and Main Content -->
    <div class="col-auto" style="max-width: 16.625rem;">
        <c:choose>
            <c:when test="${left == null}">
                <jsp:include page="left.jsp"/>
            </c:when>
            <c:otherwise>
                <jsp:include page="${left}.jsp"/>
            </c:otherwise>
        </c:choose>
    </div>

    <div>
        <c:choose>
            <c:when test="${center == null}">
                <jsp:include page="center.jsp"/>
            </c:when>
            <c:otherwise>
                <jsp:include page="${center}.jsp"/>
            </c:otherwise>
        </c:choose>
    </div>



    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="text-center">
                Copyright © 2024 건어물
            </div>
        </div>
    </footer>
</div>
<!-- End wrapper -->

</body>
</html>
