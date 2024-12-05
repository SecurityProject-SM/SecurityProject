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

    .modal {
        display: none; /* 기본 상태에서 숨김 */
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.4);
    }

    .modal_head {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .modal-content {
        color: black;
        background-color: #fff;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 30%;
        border-radius: 8px;
        text-align: center;
    }

    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }

    .hover-effect {
        transition: all 0.3s ease; /* 부드러운 애니메이션 효과 */
        cursor: pointer; /* 마우스를 손가락 모양으로 변경 */
    }

    .hover-effect:hover {
        transform: scale(0.9); /* 크기를 90%로 줄임 */
    }

    /* modal_form 클래스에만 스타일 적용 */
    .modal_form {
        color: black;
        font-family: Arial, sans-serif;
        font-size: 14px;
        background-color: #f9f9f9; /* 폼 배경색 */
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 약간의 그림자 효과 */
        border: 1px solid #ddd;
    }

    /* modal_form 안의 라벨 스타일 */
    .modal_form label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #333; /* 라벨 글자 색상 */
    }

    /* modal_form 안의 입력 필드 스타일 */
    .modal_form .form-control {
        color: black;
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
        font-size: 14px;
    }

    /* modal_form 입력 필드 포커스 스타일 */
    .modal_form .form-control:focus {
        color: black;
        border-color: #007bff;
        outline: none;
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
    }

    /* modal_form 안의 버튼 스타일 */
    .modal_form .btn {
        padding: 10px 20px;
        font-size: 14px;
        color: white;
        background-color: black;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .modal_form .btn:hover {
        background-color: #333;
    }




</style>

<script>
    let modal = {
        open: function () {
            $("#myModal").fadeIn();
        },

        close: function () {
            $("#myModal").fadeOut();
        },

        init: function () {
            const self = this;

            $("#openModalBtn").on("click", function () {
                self.open();
            });

            $(".close, #closeModalBtn").on("click", function () {
                self.close();
            });

            $(window).on("click", function (event) {
                if ($(event.target).is("#myModal")) {
                    self.close();
                }
            });
        }
    };

    $(function () {
        modal.init();
    })
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

            <a href="/users/detailud?ghtlfid=${ghtlf.ghtlfid}">
                수정
            </a>

            <div class="row mt-3 justify-content-center">

                <div class="row">
                    <div class="info_container">
                        <div class="card">
                            <div class="card-body">
                                <div class="card-title text-center">입주자 정보</div>
                                <div class="form-group text-center mt-3">
                                    <img src="/img/edit_icon.png" id="openModalBtn" class="hover-effect" style="width: 30px">
                                </div>
                                <hr>
                                <form action="/users/updateimpl" method="post">
                                    <input type="hidden" name="usersId" value="${ghtlf.ghtlfid}">

                                    <div class="form-group">
                                        <label for="userPwd">password</label>
                                        <input type="text" class="form-control form-control-rounded" id="bname"
                                               name="bname"
                                               value="${ghtlf.bname}">
                                    </div>

                                    <div class="form-group">
                                        <label for="userPwd">password</label>
                                        <input type="text" class="form-control form-control-rounded" id="userPwd"
                                               name="userPwd"
                                               value="${ghtlf.room}">
                                    </div>

                                    <div class="form-group">
                                        <label for="userMail">Mail</label>
                                        <input type="email" class="form-control form-control-rounded" id="userMail"
                                               name="userMail"
                                               value="${ghtlf.dlfma}">
                                    </div>

                                    <div class="form-group">
                                        <label for="userName">Name</label>
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
                                        <label for="userPwd">password</label>
                                        <input type="text" class="form-control form-control-rounded" id="stday"
                                               name="userPwd"
                                               value="${ghtlf.stday}">
                                    </div>

                                    <div class="form-group">
                                        <label for="userTel">Tel</label>
                                        <input type="text" class="form-control form-control-rounded" id="edday"
                                               name="userTel"
                                               value="${ghtlf.edday}">
                                    </div>

                                    <div class="form-group">
                                        <label for="userMail">Mail</label>
                                        <input type="email" class="form-control form-control-rounded" id="deposit"
                                               name="userMail"
                                               value="${ghtlf.deposit}">
                                    </div>

                                    <div class="form-group">
                                        <label for="userName">Name</label>
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

<%-- 모달창 --%>
<div id="myModal" class="modal" style="display: none;">
    <div class="modal-content">
        <div class="modal_head">
        <h3 style="color: black">입주자 정보 수정</h3>
        <span class="close" style="margin-bottom: 30px">&times;</span>
        </div>

        <form action="/users/updateimpl" method="post" style="width: 300px; margin: 0 auto;" class="modal_form">
            <input type="hidden" name="usersId" value="${ghtlf.ghtlfid}">

            <div class="form-group">
                <label for="bdname">건물명</label>
                <input type="text" id="bdname" name="bname" value="${ghtlf.bname}" class="form-control" style="color: black;">
            </div>

            <div class="form-group">
                <label for="usserPwd">호실</label>
                <input type="text" id="usserPwd" name="userPwd" value="${ghtlf.room}" class="form-control">
            </div>

            <div class="form-group">
                <label for="usesrMail">입주자 이름</label>
                <input type="email" id="usesrMail" name="userMail" value="${ghtlf.dlfma}" class="form-control">
            </div>

            <div class="form-group">
                <label for="usesrName">전화번호</label>
                <input type="text" id="usesrName" name="userName" value="${ghtlf.tel}" class="form-control">
            </div>

            <div class="form-group text-center">
                <button type="submit" class="btn btn-dark">저장</button>
            </div>
        </form>

    </div>
</div>
<%-- 모달창 끝 --%>
</body>
</html>