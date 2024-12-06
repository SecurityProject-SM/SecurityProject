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
    .page_info {
        border-right: 2px solid whitesmoke;
        height: 200px;
    }

    .room-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px;
        font-weight: bold;
        border-radius: 8px 8px 0 0;
    }

    .room-header .status {
        background-color: #28a745;
        padding: 3px 6px;
        border-radius: 5px;
        font-size: 12px;
        text-align: left; /* 상태는 왼쪽 정렬 */
    }

    .room-header .room-number {
        margin-left: auto; /* 오른쪽으로 이동 */
        font-size: 18px;
        text-align: right; /* 오른쪽 정렬 */
    }


    .container {
        display: flex;
        flex-direction: column-reverse;
        gap: 30px;
    }

    .floor-row {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .floor-header {
        font-size: 1.5rem;
        font-weight: bold;
        color: #555;
        text-align: left;
        padding-bottom: 10px;
        border-bottom: 2px solid #ddd;
    }

    .room-container {
        display: grid;
        grid-template-columns: repeat(3, minmax(150px, 1fr));
        gap: 20px;
        justify-content: center;
    }

    .room-card {
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        background-color: #fff;
        color: black;
    }

    .room-header {
        background-color: #6c757d;
        color: #fff;
        display: flex;
        justify-content: space-between;
        padding: 10px;
        font-weight: bold;
        border-radius: 8px 8px 0 0;
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
        padding: 10px;
        font-size: 14px;
        color: #333;
    }

    .room-details p {
        margin: 5px 0;
    }

    .room-details strong {
        font-weight: bold;
    }

    .rent_calc {
        width: 250px;
        border: 2px solid whitesmoke;
        /*padding: 10px;*/
    }
</style>

<script>
</script>

<body class="bg-theme bg-theme1">


<!-- Start wrapper-->
<div id="wrapper">

    <div class="clearfix"></div>

    <div class="content-wrapper">
        <div class="container-fluid">
            <h1 style="margin-left: 10px">회원 관리</h1>
            <div class="row mt-3">
                <div class="col-lg-10 mx-auto">
                    <div class="row" style="justify-content: space-between">
                        <div class="page_info">
                            <h2 style="margin-top: 50px; margin-right: 300px">회원관리</h2>
                        </div>
                        <div class="alarm-container">
                            <c:forEach var="d" items="${rentCalc}">
                                <div class="rent_calc"
                                     style="display: flex; margin: 10px; align-items: center; border: 1px solid #ccc; border-radius: 5px; overflow: hidden;">
                                    <div style="background-color: yellow; width: 7px; height: 121px;"></div>

                                    <div style="padding: 10px; flex: 1;">
                                        <h4 style="margin: 0; font-weight: bold;">${d.room}호</h4>
                                        <p style="margin: 5px 0 0 0;">${d.room}호 계약만료가 얼마 남지 않았습니다. <br> 계약
                                            종료일: ${d.edday}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>


                    <div class="container" style="margin-top: 100px">
                        <c:forEach var="floor" items="${ghtlf}">
                            <div class="floor-row">
                                <div class="room-container">
                                    <c:forEach var="item" items="${floor.value}">
                                        <div class="room-card">
                                            <div class="room-header"
                                                 style="background-color: ${item.epty == 1 ? '#6c757d' : 'red'};">
                                                <span class="status">
                                                    <c:choose>
                                                        <c:when test="${item.epty == 1}">입주중</c:when>
                                                        <c:otherwise>공실</c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <a href="/users/detail?ghtlfid=${item.ghtlfid}">
                                                    <span class="room-number">${item.room}호</span>
                                                </a>
                                            </div>
                                            <div class="room-details">
                                                <p><strong>상호명:</strong> <c:out value="${item.bname}" default="미등록"/>
                                                </p>
                                                <p><strong>연락처:</strong> <c:out value="${item.tel}" default="미등록"/></p>
                                                <p><strong>계약일:</strong> <c:out value="${item.stday}" default="N/A"/> ~
                                                    <c:out value="${item.edday}" default="N/A"/></p>
                                            </div>
                                        </div>
                                    </c:forEach>
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