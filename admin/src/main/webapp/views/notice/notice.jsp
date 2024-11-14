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

    <div class="content-wrapper">
        <div class="container-fluid">

            <div class="row mt-3">
                <div class="col-lg-10">
                    <div class="card">
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