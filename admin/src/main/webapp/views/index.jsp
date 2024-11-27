<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>건어물 - 건물을 효율적으로!</title>
    <!-- loader-->
    <link href="<c:url value='/css/pace.min.css'/>" rel="stylesheet"/>
    <script src="<c:url value='/js/pace.min.js'/>"></script>
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

    <%-- 웹소켓 라이브러리--%>
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>

    <!-- jQuery, Popper, Bootstrap from CDN -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body class="bg-theme bg-theme1">
<!-- Start wrapper -->
<div id="wrapper">
    <!-- Start topbar header -->
    <header class="topbar-nav">
        <nav class="navbar navbar-expand fixed-top">
            <ul class="navbar-nav mr-auto align-items-center">
                <li class="nav-item">
                    <a class="nav-link toggle-menu" href="<c:url value='/javascript:void();'/>">
                        <i class="icon-menu menu-icon"></i>
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav align-items-center right-nav-link">
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


                <li class="nav-item">
                    <a class="nav-link dropdown-toggle dropdown-toggle-nocaret" data-toggle="dropdown" href="#">
                        <span class="user-profile"><img src="https://via.placeholder.com/110x110" class="img-circle" alt="user avatar"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li class="dropdown-item user-details">
                            <a href="<c:url value='/javascript:void();'/>">
                                <div class="media">
                                    <div class="avatar"><img class="align-self-start mr-3" src="https://via.placeholder.com/110x110" alt="user avatar"></div>
                                    <div class="media-body">
                                        <h6 class="mt-2 user-title">Sarajhon Mccoy</h6>
                                        <p class="user-subtitle">mccoy@example.com</p>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="dropdown-divider"></li>
                        <li class="dropdown-item"><i class="icon-envelope mr-2"></i> Inbox</li>
                        <li class="dropdown-divider"></li>
                        <li class="dropdown-item"><i class="icon-wallet mr-2"></i> Account</li>
                        <li class="dropdown-divider"></li>
                        <li class="dropdown-item"><i class="icon-settings mr-2"></i> Setting</li>
                        <li class="dropdown-divider"></li>
                        <li class="dropdown-item"><i class="icon-power mr-2"></i> Logout</li>
                    </ul>
                </li>
            </ul>
        </nav>
    </header>
    <!-- End topbar header -->

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

<!-- Additional Scripts -->
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
<script src="<c:url value='/js/index.js'/>"></script>
</body>
</html>
