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
    button.svg-wrapper {
        position: relative;
        display: inline-flex; /* 텍스트와 선의 정렬을 위한 플렉스 사용 */
        justify-content: center; /* 가로 가운데 정렬 */
        align-items: center; /* 세로 가운데 정렬 */
        width: 100px; /* 버튼 너비 */
        height: 30px; /* 버튼 높이 */
        background: transparent; /* 버튼 배경 투명 */
        border: none; /* 기본 테두리 제거 */
        padding: 0; /* 여백 제거 */
        cursor: pointer; /* 클릭 가능 */
        overflow: hidden; /* 내부 요소가 버튼을 벗어나지 않도록 */
        border-radius: 5px; /* 모서리 둥글게 */
        text-align: center; /* 텍스트 가운데 정렬 */
        transition: transform 0.3s ease; /* 호버 시 살짝 확대 */
    }

    button.svg-wrapper:hover {
        transform: scale(1.05); /* 호버 시 확대 효과 */
    }

    button.svg-wrapper svg {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%; /* SVG가 버튼 너비를 채우도록 */
        height: 100%; /* SVG가 버튼 높이를 채우도록 */
        z-index: 0; /* SVG를 배경으로 이동 */
    }

    button.svg-wrapper rect {
        stroke-width: 3px; /* 기본 선 두께 */
        fill: transparent;
        stroke: #009FFD; /* 기본 선 색상 */
        stroke-dasharray: 85 400; /* 기본 대시 효과 */
        stroke-dashoffset: -220; /* 기본 대시 위치 */
        transition: 1s all ease; /* 애니메이션 속도 */
    }

    button.svg-wrapper:hover rect {
        stroke-dasharray: 50 0; /* 호버 시 대시 효과 제거 */
        stroke-width: 3px; /* 선 두께 유지 */
        stroke-dashoffset: 0; /* 대시 위치 조정 */
        stroke: #06D6A0; /* 선 색상 변경 */
    }

    button.svg-wrapper span {
        position: relative; /* 텍스트 위치 설정 */
        z-index: 1; /* 텍스트가 SVG 위에 표시되도록 */
        color: white; /* 텍스트 색상 */
        font-weight: 600; /* 텍스트 굵기 */
        font-size: 1em; /* 텍스트 크기 */
        pointer-events: none; /* 텍스트 클릭 방지 */
    }

</style>

<script>
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

    <div class="clearfix"></div>

    <div class="content-wrapper">
        <div class="container-fluid">

            <div class="row mt-3">
                <div class="col-lg-10 mx-auto"> <!-- 가운데 정렬을 위한 mx-auto 추가 -->
                    <div class="card text-center"> <!-- 텍스트 가운데 정렬 -->
                        <div class="card-body">
                            <h5 class="card-title">공지사항</h5>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th scope="col">번호</th>
                                        <th scope="col">건물 ID</th>
                                        <th scope="col">담당자</th>
                                        <th scope="col">상태</th>
                                        <th scope="col">고장 감지일</th>
                                        <th scope="col">고장 품목</th>
                                        <th scope="col">위치</th>
                                        <th scope="col">완료</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="repair" items="${cpage.list}">
                                        <tr>
                                            <td><a href="/repairs/detail?id=${repair.repairId}">${repair.repairId}</a></td>
                                            <td>${repair.buildingId}</td>
                                            <td>${repair.adminId}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${repair.repairStat == 'A'}">완료</c:when>
                                                    <c:when test="${repair.repairStat == 'B'}">진행 중</c:when>
                                                    <c:when test="${repair.repairStat == 'C'}">대기 중</c:when>
                                                    <c:otherwise>알 수 없음</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${repair.repairStart}</td>
                                            <td>${repair.repairSen}</td>
                                            <td>${repair.repairLoc}</td>
                                            <td>
                                                <button class="svg-wrapper"
                                                        onclick="if(confirm('이 작업을 완료 처리하시겠습니까?')) location.href='/repairs/success?id=${repair.repairId}';">
                                                    <svg height="30" width="100">
                                                        <rect height="30" width="100"></rect>
                                                    </svg>
                                                    <span>완료 확인</span>
                                                </button>

                                            </td>

                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>

                                <button onclick="location.href='/repairs/calender'"> 캘린더 이동버튼 (임시) <- 디자인 나중에 수정</button>


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