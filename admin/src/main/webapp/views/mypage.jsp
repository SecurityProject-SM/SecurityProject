<!DOCTYPE html>
<html lang="en">
<%--페이지 한글 설정--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--구글 이모티콘--%>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<head>

</head>
<body class="bg-theme bg-theme1">
<!-- Start wrapper-->
<div id="wrapper">

    <div class="clearfix"></div>

    <div class="content-wrapper">
        <div class="container-fluid">

            <div class="row mt-3">
                <div class="col-lg-4">
                    <div class="card profile-card-2">
                        <div class="card-img-block">
                            <img class="img-fluid" src="https://via.placeholder.com/800x500" alt="Card image cap">
                        </div>
                        <div class="card-body pt-5">
                            <img src="https://via.placeholder.com/110x110" alt="profile-image" class="profile">
                            <h5 class="card-title">관리자</h5>
                            <p class="card-text">"안녕하세요, 관리자님
                                오늘도 시스템과 회원 관리를 위해 수고해주셔서 감사합니다.
                                이 페이지에서 회원 관리, 게시물 관리, 시스템 설정 등 모든 관리 기능을 이용하실 수 있습니다."</p>
                            <div class="icon-block">
                                <a href="javascript:void();"><i class="fa fa-facebook bg-facebook text-white"></i></a>
                                <a href="javascript:void();"> <i class="fa fa-twitter bg-twitter text-white"></i></a>
                                <a href="javascript:void();"> <i class="fa fa-google-plus bg-google-plus text-white"></i></a>
                            </div>
                        </div>

                        <div class="card-body border-top border-light">
                            <div class="media align-items-center">
                                <div>
                                    <span class="material-symbols-outlined">flash_on</span>
                                </div>
                                <div class="media-body text-left ml-3">
                                    <div class="progress-wrapper">
                                        <p>건물 총 전력량 <span class="float-right">65%</span></p>
                                        <div class="progress" style="height: 5px;">
                                            <div class="progress-bar" style="width:65%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="media align-items-center">
                                <div><span class="material-symbols-outlined">house</span></div>
                                <div class="media-body text-left ml-3">
                                    <div class="progress-wrapper">
                                        <p> 공실률 <span class="float-right">15%</span></p>
                                        <div class="progress" style="height: 5px;">
                                            <div class="progress-bar" style="width:15%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>

                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-body">
                            <ul class="nav nav-tabs nav-tabs-primary top-icon nav-justified">
                                <li class="nav-item">
                                    <a href="javascript:void();" data-target="#edit" data-toggle="pill" class="nav-link"><i class="icon-note"></i> <span class="hidden-xs">내 정보 수정</span></a>
                                </li>
                            </ul>
                            <%-- 내 정보 수정 --%>
                            <div class="tab-content p-3">
                                <div class="tab-pane active" id="profile">
                                    <form>
                                        <div class="form-group row">
                                            <label class="col-lg-3 col-form-label form-control-label">First name</label>
                                            <div class="col-lg-9">
                                                <input class="form-control" type="text" value="관리자">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-3 col-form-label form-control-label">Last name</label>
                                            <div class="col-lg-9">
                                                <input class="form-control" type="text" value="관리자">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-3 col-form-label form-control-label">Email</label>
                                            <div class="col-lg-9">
                                                <input class="form-control" type="email" value="mark@example.com">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-3 col-form-label form-control-label">Change profile</label>
                                            <div class="col-lg-9">
                                                <input class="form-control" type="file">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-3 col-form-label form-control-label">Website</label>
                                            <div class="col-lg-9">
                                                <input class="form-control" type="url" value="">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-3 col-form-label form-control-label">Address</label>
                                            <div class="col-lg-9">
                                                <input class="form-control" type="text" value="" placeholder="Street">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-3 col-form-label form-control-label"></label>
                                            <div class="col-lg-6">
                                                <input class="form-control" type="text" value="" placeholder="City">
                                            </div>
                                            <div class="col-lg-3">
                                                <input class="form-control" type="text" value="" placeholder="State">
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-lg-3 col-form-label form-control-label">Username</label>
                                            <div class="col-lg-9">
                                                <input class="form-control" type="text" value="jhonsanmark">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-3 col-form-label form-control-label">Password</label>
                                            <div class="col-lg-9">
                                                <input class="form-control" type="password" value="11111122333">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-3 col-form-label form-control-label">Confirm password</label>
                                            <div class="col-lg-9">
                                                <input class="form-control" type="password" value="11111122333">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-3 col-form-label form-control-label"></label>
                                            <div class="col-lg-9">
                                                <input type="reset" class="btn btn-secondary" value="Cancel">
                                                <input type="button" class="btn btn-primary" value="Save Changes">
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <!-- End container-fluid-->
    </div><!--End content-wrapper-->

</div>
<!--End wrapper-->
</body>


</html>
