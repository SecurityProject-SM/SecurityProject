<%--
  User: 1
  Date: 2024-11-14
  Time: 오후 5:50
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
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
    <div class="clearfix"></div>

    <div class="content-wrapper d-flex justify-content-center">
        <div class="container-fluid">
            <div class="row mt-3 justify-content-center">
                <div class="col-lg-10">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-title text-center">공지사항 수정</div>
                            <hr>
                            <form action="/users/updateimpl" method="post">
                                <input type="hidden" name="usersId" value="${users.userId}">

                                <div class="form-group">
                                    <label for="userPwd">password</label>
                                    <input type="password" class="form-control form-control-rounded" id="userPwd" name="userPwd"
                                           value="${users.userPwd}">
                                </div>

                                <div class="form-group">
                                    <label for="userTel">Tel</label>
                                    <input type="text" class="form-control form-control-rounded" id="userTel" name="userTel"
                                           value="${users.userTel}">
                                </div>

                                <div class="form-group">
                                    <label for="userMail">Mail</label>
                                    <input type="email" class="form-control form-control-rounded" id="userMail" name="userMail"
                                           value="${users.userMail}">
                                </div>

                                <div class="form-group">
                                    <label for="userName">Name</label>
                                    <input type="text" class="form-control form-control-rounded" id="userName" name="userName"
                                           value="${users.userName}">
                                </div>

                                <%--  회원 권한설정 하는 부분 select or checkbox 사용 추가 필  --%>



                                <div class="form-group text-right">
                                    <button type="submit" class="btn btn-light btn-round px-5">수정</button>
                                    <form action="/users/deleteimpl" method="post" style="display:inline;">
                                        <input type="hidden" name="usersId" value="${users.userId}">
                                        <button type="submit" class="btn btn-danger btn-round px-5" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
                                    </form>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
            <!--End Row-->

            <!--start overlay-->
            <div class="overlay toggle-menu"></div>
            <!--end overlay-->

        </div>

    </div>
    <!--End content-wrapper-->

    <!--Start Back To Top Button-->
    <a href="javaScript:void();" class="back-to-top"><i class="fa fa-angle-double-up"></i> </a>
    <!--End Back To Top Button-->

</div>
<!--End wrapper-->
</body>
</html>