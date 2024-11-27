<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 추가 스크립트-->
<!-- simplebar js -->
<script src="<c:url value='/plugins/simplebar/js/simplebar.js'/>"></script>
<!-- sidebar-menu js -->
<script src="<c:url value='/js/sidebar-menu.js'/>"></script>
<!-- loader scripts -->
<script src="<c:url value='/js/jquery.loading-indicator.js'/>"></script>
<!-- Custom scripts -->
<script src="<c:url value='/js/app-script.js'/>"></script>
<!-- Chart js -->
<script src="<c:url value='/plugins/Chart.js/Chart.min.js'/>"></script>
<!-- Index js -->
<script src="<c:url value='/js/index.js'/>"></script>

<style>
    .notification-icon {
        position: relative;
        cursor: pointer;
    }

    .notification-badge {
        position: absolute;
        top: 5px;
        right: 5px;
        background-color: #f41127;
        color: white;
        border-radius: 50%;
        padding: 2px 6px;
        font-size: 10px;
        display: none;
    }

    .notification-dropdown {
        display: none;
        position: absolute;
        right: 0;
        top: 100%;
        background-color: #fff;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        min-width: 280px;
        z-index: 1000;
        border-radius: 4px;
        margin-top: 10px;
    }

    .notification-list {
        max-height: 300px;
        overflow-y: auto;
    }

    .notification-item {
        padding: 10px 15px;
        border-bottom: 1px solid rgba(0,0,0,.1);
    }

    .notification-item:last-child {
        border-bottom: none;
    }

    .unread {
        background-color: rgba(0,0,0,.05);
    }



    /*----------------------------------------*/
    /* 알림 아이콘 컨테이너 */
    .nav-alarmicon {
        position: relative;
        display: flex;
        align-items: center;
        height: 44px;
    }

    /* 알림 아이콘 링크 */
    .nav-link {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 0;
        height: 44px;
        width: 44px;
        position: relative;
    }

    /* 알림 뱃지 */
    .notification-badge {
        position: absolute;
        background-color: #31CE36;
        text-align: center;
        border-radius: 10px;
        min-width: 17px;
        height: 17px;
        font-size: 10px;
        color: #ffffff;
        font-weight: 300;
        line-height: 17px;
        top: 3px;
        right: 3px;
    }

    /* 알림 드롭다운 메뉴 */
    .notification-dropdown {
        display: none;
        position: absolute;
        right: 0;
        top: 100%;
        min-width: 280px;
        background: #ffffff;
        border-radius: 4px;
        box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        margin-top: 1px;
        z-index: 1000;
    }

    /* 알림 푸터 */
    .notification-footer {
        padding: 12px 15px;
    }

    /* 전체보기 링크 */
    .see-all {
        display: block;
        text-align: center;
        color: #444;
        font-size: 13px;
        font-weight: 600;
        text-decoration: none;
    }
    /* 전체보기 링크 */

</style>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>건어물 - 건물을 효율적으로!</title>
    <!-- loader-->
<%--    <link href="<c:url value='/css/pace.min.css'/>" rel="stylesheet"/>--%>
<%--    <script src="<c:url value='/js/pace.min.js'/>"></script>--%>
    <!-- favicon -->
    <link rel="icon" href="<c:url value='/img/gunamul_icon.ico'/>" type="image/x-icon">
    <!-- Vector CSS -->
    <link href="<c:url value='/plugins/vectormap/jquery-jvectormap-2.0.2.css'/>" rel="stylesheet"/>
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

    <!-- jQuery, Popper, Bootstrap from CDN -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>


<body class="bg-theme bg-theme1">
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

                <!-- 알람 -->
                <li class="nav-alarmicon">
                    <a class="nav-link" href="#">
                        <i class="fa fa-bell-o"></i>
                        <span class="notification-badge">4</span>
                    </a>
                    <div class="notification-dropdown">
                        <div class="notification-footer">
                            <div><h2 style="color: #0a1219">알림내용</h2></div>

                            <%--알림 푸터--%>
                            <a href="<c:url value="/repairs"/>" class="see-all">
                                내 켈린더 바로가기 <i class="fa fa-angle-right"></i>
                            </a>
                        </div>
                    </div>
                </li>

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

<script>

    let alarm = {
        init: function() {
            this.onclick();
            this.initEventHandlers();  // 추가된 부분
        },

        //알림 아이콘을 눌렀을 때 이벤트
        onclick: function() {
            $('.nav-alarmicon .nav-link').click(function(e) {
                e.preventDefault();
                e.stopPropagation();
                $('.notification-dropdown').toggle();
            });
        },

        // 알림 아이콘 다시 눌렀을 때 드롭다운 닫기
        initEventHandlers: function() {
            // 문서 클릭시 드롭다운 닫기
            $(document).click(function() {
                $('.notification-dropdown').hide();
            });

            // 드롭다운 외 부분 클릭 시 드롭다운 닫기
            $('.notification-dropdown').click(function(e) {
                e.stopPropagation();
            });
        }
    };

    $(function() {
        alarm.init();
    });
</script>

</body>
</html>
