<%--
  User: 1
  Date: 2024-11-13
  Time: 오후 3:33
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>Dashtreme Admin - Free Dashboard for Bootstrap 4 by Codervent</title>
    <!-- loader-->
    <link href="<c:url value="/css/pace.min.css"/>" rel="stylesheet"/>
    <script src="<c:url value="/js/pace.min.js"/>"></script>
    <!--favicon-->
    <link rel="icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon">
    <!-- Vector CSS -->
    <link href="<c:url value="/plugins/vectormap/jquery-jvectormap-2.0.2.css"/>" rel="stylesheet"/>
    <!-- simplebar CSS-->
    <link href="<c:url value="/plugins/simplebar/css/simplebar.css"/>" rel="stylesheet"/>
    <!-- Bootstrap core CSS-->
    <link href="<c:url value="/css/bootstrap.min.css"/>" rel="stylesheet"/>
    <!-- animate CSS-->
    <link href="<c:url value="/css/animate.css"/>" rel="stylesheet" type="text/css"/>
    <!-- Icons CSS-->
    <link href="<c:url value="/css/icons.css"/>" rel="stylesheet" type="text/css"/>
    <!-- Sidebar CSS-->
    <link href="<c:url value="/css/sidebar-menu.css"/>" rel="stylesheet"/>
    <!-- Custom Style-->
    <link href="<c:url value="/css/app-style.css"/>" rel="stylesheet"/>

</head>

<body class="bg-theme bg-theme1">

<!-- Start wrapper-->
<div id="wrapper">

    <!--Start sidebar-wrapper-->
    <!--End sidebar-wrapper-->

    <!--Start topbar header-->
    <header class="topbar-nav">
        <nav class="navbar navbar-expand fixed-top">
            <ul class="navbar-nav mr-auto align-items-center">
                <li class="nav-item">
                    <a class="nav-link toggle-menu" href="<c:url value="/javascript:void();"/>">
                        <i class="icon-menu menu-icon"></i>
                    </a>
                </li>
                <li class="nav-item">
                    <form class="search-bar">
                        <input type="text" class="form-control" placeholder="Enter keywords">
                        <a href="<c:url value="/javascript:void();"/>"><i class="icon-magnifier"></i></a>
                    </form>
                </li>
            </ul>

            <ul class="navbar-nav align-items-center right-nav-link">
                <li class="nav-item dropdown-lg">
                    <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="<c:url value="/javascript:void();"/>">
                        <i class="fa fa-envelope-open-o"></i></a>
                </li>
                <li class="nav-item dropdown-lg">
                    <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="<c:url value="/javascript:void();"/>">
                        <i class="fa fa-bell-o"></i></a>
                </li>
                <li class="nav-item language">
                    <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="<c:url value="/javascript:void();"/>"><i class="fa fa-flag"></i></a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li class="dropdown-item"> <i class="flag-icon flag-icon-gb mr-2"></i> English</li>
                        <li class="dropdown-item"> <i class="flag-icon flag-icon-fr mr-2"></i> French</li>
                        <li class="dropdown-item"> <i class="flag-icon flag-icon-cn mr-2"></i> Chinese</li>
                        <li class="dropdown-item"> <i class="flag-icon flag-icon-de mr-2"></i> German</li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link dropdown-toggle dropdown-toggle-nocaret" data-toggle="dropdown" href="#">
                        <span class="user-profile"><img src="https://via.placeholder.com/110x110" class="img-circle" alt="user avatar"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li class="dropdown-item user-details">
                            <a href="<c:url value="/javaScript:void();"/>">
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
    <!--End topbar header-->

    <div class="clearfix"></div>

    <!--End content-wrapper-->
    <!--Start Back To Top Button-->
    <a href="<c:url value="/javaScript:void();"/>" class="back-to-top"><i class="fa fa-angle-double-up"></i> </a>
    <!--End Back To Top Button-->

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

    <!-- center (오른쪽) -->
    <div>
        <c:choose>
            <c:when test="${center == null}">
                <jsp:include page="center.jsp"/>
            </c:when>
            <c:otherwise>
                <jsp:include page="${center}.jsp"/>
            </c:otherwise>
        </c:choose>

    <!--Start footer-->
    <footer class="footer">
        <div class="container">
            <div class="text-center">
                Copyright © 2018 Dashtreme Admin
            </div>
        </div>
    </footer>
    <!--End footer-->





<%--    <!--start color switcher-->--%>
<%--    <div class="right-sidebar">--%>
<%--        <div class="switcher-icon">--%>
<%--            <i class="zmdi zmdi-settings zmdi-hc-spin"></i>--%>
<%--        </div>--%>
<%--        <div class="right-sidebar-content">--%>

<%--            <p class="mb-0">Gaussion Texture</p>--%>
<%--            <hr>--%>

<%--            <ul class="switcher">--%>
<%--                <li id="theme1"></li>--%>
<%--                <li id="theme2"></li>--%>
<%--                <li id="theme3"></li>--%>
<%--                <li id="theme4"></li>--%>
<%--                <li id="theme5"></li>--%>
<%--                <li id="theme6"></li>--%>
<%--            </ul>--%>

<%--            <p class="mb-0">Gradient Background</p>--%>
<%--            <hr>--%>

<%--            <ul class="switcher">--%>
<%--                <li id="theme7"></li>--%>
<%--                <li id="theme8"></li>--%>
<%--                <li id="theme9"></li>--%>
<%--                <li id="theme10"></li>--%>
<%--                <li id="theme11"></li>--%>
<%--                <li id="theme12"></li>--%>
<%--                <li id="theme13"></li>--%>
<%--                <li id="theme14"></li>--%>
<%--                <li id="theme15"></li>--%>
<%--            </ul>--%>

<%--        </div>--%>
<%--    </div>--%>
<%--    <!--end color switcher-->--%>

</div><!--End wrapper-->

<!-- Bootstrap core JavaScript-->
<script src="<c:url value="/js/jquery.min.js"/>"></script>
<script src="<c:url value="/js/popper.min.js"/>"></script>
<script src="<c:url value="/js/bootstrap.min.js"/>"></script>

<!-- simplebar js -->
<script src="<c:url value="/plugins/simplebar/js/simplebar.js"/>"></script>
<!-- sidebar-menu js -->
<script src="<c:url value="/js/sidebar-menu.js"/>"></script>
<!-- loader scripts -->
<script src="<c:url value="/js/jquery.loading-indicator.js"/>"></script>
<!-- Custom scripts -->
<script src="<c:url value="/js/app-script.js"/>"></script>
<!-- Chart js -->

<script src="<c:url value="/plugins/Chart.js/Chart.min.js"/>"></script>

<!-- Index js -->
<script src="<c:url value="/js/index.js"/>"></script>


</body>
</html>
