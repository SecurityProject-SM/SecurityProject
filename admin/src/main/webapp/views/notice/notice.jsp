<%--
  User: 1
  Date: 2024-11-14
  Time: 오후 4:44
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
    <link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
</head>

<style>
    .btn-14 {
        position: relative;
        padding: 10px 20px;
        font-size: 16px;
        color: #fff;
        background: rgb(0, 128, 255);
        border: none;
        cursor: pointer;
        border-radius: 5px;
        z-index: 1;
        overflow: hidden;
    }
    .btn-14:after {
        position: absolute;
        content: "";
        width: 100%;
        height: 0;
        top: 0;
        left: 0;
        z-index: -1;
        border-radius: 5px;
        background-color: #eaf818;
        background-image: linear-gradient(315deg, #eaf818 0%, #f6fc9c 74%);
        box-shadow: inset 2px 2px 2px 0px rgba(255,255,255,.5),
        7px 7px 20px 0px rgba(0,0,0,.1),
        4px 4px 5px 0px rgba(0,0,0,.1);
        transition: all 0.3s ease;
    }
    .btn-14:hover {
        color: #000;
    }
    .btn-14:hover:after {
        top: auto;
        bottom: 0;
        height: 100%;
    }
    .btn-14:active {
        top: 2px;
    }

</style>
<script>
</script>

<body class="bg-theme bg-theme9">

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

    <div class="clearfix"></div>

    <div class="content-wrapper">
        <div class="container-fluid">
            <div class="row mt-3" style="margin-top: 150px">
                <div class="col-lg-10 mx-auto"> <!-- 가운데 정렬을 위한 mx-auto 추가 -->
                    <div class="card text-center"> <!-- 텍스트 가운데 정렬 -->
                        <div class="card-body">
                            <h5 class="card-title">공지사항</h5>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th scope="col">번호</th>
                                        <th scope="col">제목</th>
                                        <th scope="col">작성일자</th>
                                        <th scope="col">작성자</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="n" items="${cpage.list}">
                                        <tr>
                                            <td><a href="/notice/detail?id=${n.noticeId}">${n.noticeId}</a>
                                            <td>${n.noticeName}</td>
                                            <td>${n.noticeTime}</td>
                                            <td>${n.adminId}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <div style="margin-top: 15px">
                                    <c:if test="${cpage.getSize() != null}">
                                        <jsp:include page="../searchnav.jsp"/>
                                    </c:if>
                                </div>
                                <div style="text-align: right; margin-top: 15px;">
                                    <button class="btn-14" onclick="location.href='notice/write'">공지사항 작성</button>
                                </div>

                        </div>
                    </div>
                </div>
            </div><!--End Row-->


        </div>
        <!-- End container-fluid-->

    </div><!--End content-wrapper-->
    <!--Start Back To Top Button-->
    <a href="javaScript:void();" class="back-to-top"><i class="fa fa-angle-double-up"></i> </a>
    <!--End Back To Top Button-->


</div><!--End wrapper-->

</body>

</html>