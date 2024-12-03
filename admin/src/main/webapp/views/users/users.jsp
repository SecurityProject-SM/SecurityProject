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
    .room-card {
        width: 300px;
        border: 1px solid #ccc;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        background-color: #fff;
        margin: 10px auto;
        overflow: hidden;
        display: flex;
        flex-direction: column;
    }

    .room-header {
        background-color: #6c757d;
        color: #fff;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px;
        font-weight: bold;
    }

    .room-header .status {
        background-color: #28a745;
        padding: 3px 6px;
        border-radius: 5px;
        font-size: 12px;
    }

    .room-header .room-number {
        font-size: 18px;
    }

    .room-details {
        padding: 15px;
        font-size: 14px;
        color: #333;
    }

    .room-details p {
        margin: 5px 0;
    }

    .room-details strong {
        font-weight: bold;
    }

</style>

<script>
    let ghtlf = {}

    $(function () {
        ghtlf.init();
    })
</script>

<body class="bg-theme bg-theme1">


<!-- Start wrapper-->
<div id="wrapper">

    <div class="clearfix"></div>

    <div class="content-wrapper">
        <div class="container-fluid">

            <div class="row mt-3">
                <div class="col-lg-10 mx-auto">
                    <div class="alarm-container">
                        <h3>알람 띄울거임</h3>
                    </div>

                    <div class="container">
                        <c:forEach var="item" items="${ghtlf}">
                            <div class="room-card">
                                <div class="room-header">
                                    <!-- 입주 상태 표시: epty가 0이면 공실, 1이면 입주중 -->
                                    <span class="status">
                    <c:choose>
                        <c:when test="${item.epty == 1}">입주중</c:when>
                        <c:otherwise>공실</c:otherwise>
                    </c:choose>
                </span>
                                    <span class="room-number">${item.room}호</span>
                                </div>
                                <div class="room-details">
                                    <p><strong>상호명:</strong>
                                        <c:out value="${item.bname}" default="미등록"/></p>
                                    <p><strong>연락처:</strong>
                                        <c:out value="${item.tel}" default="미등록"/></p>
                                    <p><strong>계약일:</strong>
                                        <c:out value="${item.stday}" default="N/A"/> ~
                                        <c:out value="${item.edday}" default="N/A"/></p>
                                </div>
                            </div>
                        </c:forEach>
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