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

    <!-- jQuery, Popper, Bootstrap from CDN -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<style>
</style>

<script>
    let login = {
        init: function () {
            $('#login_form > button').click(() => {
                console.log("Submit button clicked");  // 버튼 클릭 확인용 로그
                // this.check();
                this.send();
            });

            // Enter 키 눌렀을 때 폼 제출되도록 추가
            $('#login_form').on('keyup', (event) => {
                if (event.keyCode === 13) {  // Enter key code is 13
                    // this.check();
                    this.send();
                }
            });
        },

        // check: function () {
        //     let pwd = $('#pwd').val();
        //     let tel = $('#tel').val();
        //     let mail = $('#mail').val();
        //
        //     if (pwd == '' || pwd == null) {
        //         alert('pwd is mandatory');
        //         $('#pwd').focus();
        //         return;
        //     }
        //
        //     if (tel == '' || tel == null) {
        //         alert('tel is mandatory');
        //         $('#tel').focus();
        //         return;
        //     }
        //
        //     if (mail == '' || mail == null) {
        //         alert('mail is mandatory');
        //         $('#mail').focus();
        //         return;
        //     }
        //     this.send();
        // },

        send: function () {
            console.log("Submitting form");  // 폼 전송 확인용 로그
            $('#login_form').attr('method', 'post');
            $('#login_form').attr('action', '/registerimpl');
            $('#login_form').submit();
        }
    };

    $(function () {
        login.init();
    })
</script>

<body class="bg-theme bg-theme1">

<!-- start loader -->
<div id="pageloader-overlay" class="visible incoming">
    <div class="loader-wrapper-outer">
        <div class="loader-wrapper-inner">
            <div class="loader"></div>
        </div>
    </div>
</div>
<!-- end loader -->

<!-- Start wrapper-->
<div id="wrapper">

    <div class="loader-wrapper">
        <div class="lds-ring">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>
    <div class="card card-authentication1 mx-auto my-5">
        <div class="card-body">
            <div class="card-content p-2">
                <div class="text-center">
                    <img src="<c:url value="/assets/images/logo-icon.png"/>" alt="logo icon">
                </div>
                <div class="card-title text-uppercase text-center py-3">Sign In</div>
                <form id="login_form" method="post" action="/registerimpl">
                    <div class="form-group">
                        <label for="adminId" class="sr-only">Id</label>
                        <input type="text" id="adminId" class="form-control input-shadow" name="adminId" placeholder="Enter Username">
                    </div>

                    <div class="form-group">
                        <label for="adminPwd" class="sr-only">Password</label>
                        <input type="password" id="adminPwd" class="form-control input-shadow" name="adminPwd" placeholder="Enter Password">
                    </div>

                    <div class="form-group">
                        <label for="adminTel" class="sr-only">Tel</label>
                        <input type="text" id="adminTel" class="form-control input-shadow" name="adminTel" placeholder="Enter Tel">
                    </div>

                    <div class="form-group">
                        <label for="adminEmail" class="sr-only">Email</label>
                        <input type="email" id="adminEmail" class="form-control input-shadow" name="adminEmail" placeholder="Enter Email">
                    </div>

                    <div class="form-group">
                        <label for="adminName" class="sr-only">Name</label>
                        <input type="text" id="adminName" class="form-control input-shadow" name="adminName" placeholder="Enter Name">
                    </div>

                    <button type="button" class="btn btn-light btn-block" onclick="login.check()">Sign In</button>
                </form>
            </div>
        </div>
        <div class="card-footer text-center py-3">
            <p class="text-warning mb-0">Do not have an account? <a href="<c:url value="//register"/>"> Sign Up here</a></p>
        </div>
    </div>


</div><!--wrapper-->

<!-- Bootstrap core JavaScript-->
<script src="<c:url value="/js/jquery.min.js"/>"></script>
<script src="<c:url value="/js/popper.min.js"/>"></script>
<script src="<c:url value="/js/bootstrap.min.js"/>"></script>

<!-- sidebar-menu js -->
<script src="<c:url value="/js/sidebar-menu.js"/>"></script>

<!-- Custom scripts -->
<script src="<c:url value="/js/app-script.js"/>"></script>


</body>
</html>