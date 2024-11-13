<%--
  User: 1
  Date: 2024-11-13
  Time: 오후 4:35
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
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

<style>
</style>

<script>
</script>



<body class="bg-theme bg-theme1">

<!-- start loader -->
<div id="pageloader-overlay" class="visible incoming"><div class="loader-wrapper-outer"><div class="loader-wrapper-inner" ><div class="loader"></div></div></div></div>
<!-- end loader -->

<!-- Start wrapper-->
<div id="wrapper">

    <div class="loader-wrapper"><div class="lds-ring"><div></div><div></div><div></div><div></div></div></div>
    <div class="card card-authentication1 mx-auto my-5">
        <div class="card-body">
            <div class="card-content p-2">
                <div class="text-center">
                    <img src="assets/images/logo-icon.png" alt="logo icon">
                </div>
                <div class="card-title text-uppercase text-center py-3">Sign In</div>
                <form>
                    <div class="form-group">
                        <label for="exampleInputUsername" class="sr-only">Username</label>
                        <div class="position-relative has-icon-right">
                            <input type="text" id="exampleInputUsername" class="form-control input-shadow" placeholder="Enter Username">
                            <div class="form-control-position">
                                <i class="icon-user"></i>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword" class="sr-only">Password</label>
                        <div class="position-relative has-icon-right">
                            <input type="password" id="exampleInputPassword" class="form-control input-shadow" placeholder="Enter Password">
                            <div class="form-control-position">
                                <i class="icon-lock"></i>
                            </div>
                        </div>
                    </div>

                    <button type="button" class="btn btn-light btn-block">Sign In</button>
                    <div class="text-center mt-3">Sign In With</div>

                    <div class="form-row mt-6">
                        <div class="form-group mb-0 col-12" style="margin-top: 15px">
                            <button type="button" class="btn btn-light btn-block"><i class="fa fa-facebook-square"></i> Facebook</button>
                        </div>
                    </div>

                </form>
            </div>
        </div>
        <div class="card-footer text-center py-3">
            <p class="text-warning mb-0">Do not have an account? <a href="/register"> Sign Up here</a></p>
        </div>
    </div>



</div><!--wrapper-->

<!-- Bootstrap core JavaScript-->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/popper.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>

<!-- sidebar-menu js -->
<script src="assets/js/sidebar-menu.js"></script>

<!-- Custom scripts -->
<script src="assets/js/app-script.js"></script>


</body>
</html>