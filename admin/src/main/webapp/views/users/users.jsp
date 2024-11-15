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

    <div class="clearfix"></div>

    <div class="content-wrapper">
        <div class="container-fluid">

            <div class="row mt-3">
                <div class="col-lg-10 mx-auto">
                    <div class="card text-center">
                        <div class="card-body">
                            <h5 class="card-title">회원 관리</h5>

                            <form class="search-bar" action="/users/findimpl" method="get">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="search" placeholder="이름"
                                           value="${search.search}">
                                    <button class="btn btn-primary" type="submit">검색</button>
                                </div>
                            </form>

                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">이메일</th>
                                        <th scope="col">이름</th>
                                        <th scope="col">전화번호</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="user" items="${cpage.list}">
                                        <tr>
                                            <td>${user.userId}</td>
                                            <td>${user.userMail}</td>
                                            <td>${user.userName}</td>
                                            <td>${user.userTel}</td>
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