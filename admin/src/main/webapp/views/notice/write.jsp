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

<body class="bg-theme bg-theme9">

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
                            <div class="card-title text-center">공지사항 작성</div>
                            <hr>
                            <form action="/notice/writeimpl" method="post">
                                <div class="form-group">
                                    <label for="noticeName">제목</label>
                                    <input type="text" class="form-control form-control-rounded" id="noticeName" name="noticeName" placeholder="제목">
                                </div>

                                <div class="form-group">
                                    <label for="noticeDetail">내용</label>
                                    <textarea class="form-control form-control-rounded" id="noticeDetail" name="noticeDetail" placeholder="내용을 작성해주세요" style="height: 250px"></textarea>
                                </div>

                                <div class="form-group text-right">
                                    <button type="submit" class="btn btn-light btn-round px-5"><i class="zmdi zmdi-assignment"></i> 작성</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div><!--End Row-->

            <!--start overlay-->
            <div class="overlay toggle-menu"></div>
            <!--end overlay-->

        </div>
        <!-- End container-fluid-->

    </div><!--End content-wrapper-->
    <!--Start Back To Top Button-->
    <a href="javaScript:void();" class="back-to-top"><i class="fa fa-angle-double-up"></i> </a>
    <!--End Back To Top Button-->

</div><!--End wrapper-->
<!--End wrapper-->

</body>

</html>