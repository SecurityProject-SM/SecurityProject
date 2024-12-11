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
                this.check();
            });
            // Enter 키 눌렀을 때 폼 제출되도록 추가
            $('#login_form').on('keyup', (event) => {
                if (event.keyCode === 13) {  // Enter key code is 13
                    this.check();
                }
            });
        },

        check: function () {
            let id = $('#id').val();
            let pwd = $('#pwd').val();
            if (id == '' || id == null) {
                alert('id is mandatory');
                $('#id').focus();
                return;
            }
            if (pwd == '' || pwd == null) {
                alert('pwd is mandatory');
                $('#pwd').focus();
                return;
            }
            this.send();
        },

        send: function () {
            // method, action
            $('#login_form').attr('method', 'post');
            $('#login_form').attr('action', '/loginimpl');
            $('#login_form').submit();
        }
    };

    $(function () {
        login.init();
    })
</script>


<body class="bg-theme bg-theme9">

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
                <div class="text-center" >
                    <img style="width: 50px" src="<c:url value="/img/gunamul2.jpeg"/>">
                </div>
                <div class="card-title text-uppercase text-center py-3">로그인</div>
                <form id="login_form" method="post" action="/loginimpl">
                    <div class="form-group">
                        <label for="id" class="sr-only">Username</label>
                        <div class="position-relative has-icon-right">
                            <input type="text" id="id" class="form-control input-shadow" value="admin01" name="id"
                                   placeholder="Enter Username">
                            <div class="form-control-position" style="top: 11px">
                                <i class="icon-user"></i>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="pwd" class="sr-only">Password</label>
                        <div class="position-relative has-icon-right">
                            <input type="password" id="pwd" class="form-control input-shadow" value="adminpass1" name="pwd"
                                   placeholder="Enter Password">
                            <div class="form-control-position"  style="top: 11px">
                                <i class="icon-lock"></i>
                            </div>
                        </div>
                    </div>

                    <button type="button" class="btn btn-light btn-block">Sign In</button>
<%--                    <div class="text-center mt-3">Sign In With</div>--%>

<%--                    <div class="form-row mt-6">--%>
<%--                        <div class="form-group mb-0 col-12" style="margin-top: 15px">--%>
<%--                            <button type="button" class="btn btn-light btn-block"><i class="fa fa-facebook-square"></i>--%>
<%--                                Facebook--%>
<%--                            </button>--%>
<%--                        </div>--%>
<%--                    </div>--%>

                </form>
            </div>
        </div>
        <div class="card-footer text-center py-3">
            <p class="text-warning mb-0">계정이 없으신가요? <a href="<c:url value="/register"/>"> 회원가입</a></p>
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