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
    .info_container {
        width: 400px;
    }

    .info_header {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .info_header a,
    .info_header h2 {
        margin: 0;
        text-align: left;
    }

    .info_header h5 {
        margin: 0;
        text-align: right;
        margin-left: auto;
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

    <div class="content-wrapper d-flex justify-content-center">
        <div class="container-fluid">
            <div>
                <div class="info_header">
                    <a href="<c:url value="/users"/>" style="font-size: 17px">< 뒤로가기</a>
                    <h2 style="margin-left: 30px">상세 정보</h2>
                    <h5>${ghtlf.room}호</h5>
                </div>
            </div>

            <div class="row mt-3 justify-content-center">

                <div class="row">
                    <div class="info_container">
                        <div class="card">
                            <div class="card-body">
                                <div class="card-title text-center">입주자 정보</div>
                                <hr>
                                <form action="/users/updateimpl" method="post">
                                    <input type="hidden" name="usersId" value="${ghtlf.ghtlfid}">

                                    <div class="form-group">
                                        <label for="userPwd">상호명</label>
                                        <input type="text" class="form-control form-control-rounded" id="bname"
                                               name="bname"
                                               value="${ghtlf.bname}">
                                    </div>

                                    <div class="form-group">
                                        <label for="userPwd">호실</label>
                                        <input type="text" class="form-control form-control-rounded" id="userPwd"
                                               name="userPwd"
                                               value="${ghtlf.room}">
                                    </div>

                                    <div class="form-group">
                                        <label for="userMail">이름</label>
                                        <input type="email" class="form-control form-control-rounded" id="userMail"
                                               name="userMail"
                                               value="${ghtlf.dlfma}">
                                    </div>

                                    <div class="form-group">
                                        <label for="userName">전화번호</label>
                                        <input type="text" class="form-control form-control-rounded" id="userName"
                                               name="userName"
                                               value="${ghtlf.tel}">
                                    </div>

                                    <%--  회원 권한설정 하는 부분 select or checkbox 사용 추가 필  --%>


                                    <div class="form-group text-right">
                                        <button type="submit" class="btn btn-light btn-round px-5">수정</button>
                                        <form action="/users/deleteimpl" method="post" style="display:inline;">
                                            <input type="hidden" name="usersId" value="${users.userId}">
                                            <button type="submit" class="btn btn-danger btn-round px-5"
                                                    onclick="return confirm('정말 삭제하시겠습니까?');">삭제
                                            </button>
                                        </form>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>

                <div style="margin-left: 50px">
                    <div class="info_container">
                        <div class="card">
                            <div class="card-body">
                                <div class="card-title text-center">계약 정보</div>
                                <hr>
                                <form action="/users/updateimpl" method="post">
                                    <input type="hidden" name="usersId" value="${ghtlf.ghtlfid}">

                                    <div class="form-group">
                                        <label for="userPwd">계약일자</label>
                                        <input type="text" class="form-control form-control-rounded" id="stday"
                                               name="userPwd"
                                               value="${ghtlf.stday}">
                                    </div>

                                    <div class="form-group">
                                        <label for="userTel">만료일자</label>
                                        <input type="text" class="form-control form-control-rounded" id="edday"
                                               name="userTel"
                                               value="${ghtlf.edday}">
                                    </div>

                                    <div class="form-group">
                                        <label for="userMail">보증금</label>
                                        <input type="email" class="form-control form-control-rounded" id="deposit"
                                               name="userMail"
                                               value="${ghtlf.deposit}">
                                    </div>

                                    <div class="form-group">
                                        <label for="userName">월세</label>
                                        <input type="text" class="form-control form-control-rounded" id="dnjftp"
                                               name="userName"
                                               value="${ghtlf.dnjftp}">
                                    </div>

                                    <%--  회원 권한설정 하는 부분 select or checkbox 사용 추가 필  --%>


                                    <div class="form-group text-right">
                                        <button type="submit" class="btn btn-light btn-round px-5">수정</button>
                                        <form action="/users/deleteimpl" method="post" style="display:inline;">
                                            <input type="hidden" name="usersId" value="${users.userId}">
                                            <button type="submit" class="btn btn-danger btn-round px-5"
                                                    onclick="return confirm('정말 삭제하시겠습니까?');">삭제
                                            </button>
                                        </form>
                                    </div>
                                </form>

                            </div>
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