<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .bg-gray-100{
        --bd-pink-rgb: 214, 51, 132;
        background-image: linear-gradient(180deg, rgba(var(--bs-body-bg-rgb), 0.01), rgba(var(--bs-body-bg-rgb), 1) 85%),
            radial-gradient(ellipse at top left, rgba(var(--bs-primary-rgb), 0.5), transparent 50%),
            radial-gradient(ellipse at top right, rgba(var(--bd-accent-rgb), 0.5), transparent 50%),
            radial-gradient(ellipse at center right, rgba(var(--bd-violet-rgb), 0.5), transparent 50%),
            radial-gradient(ellipse at center left, rgba(var(--bd-pink-rgb), 0.5), transparent 50%);
    }
    .card-body{
        background-color: #ffffff;
    }
    .card-footer{
        background-color: #ffffff;
    }
    .card.card-plain{
        box-shadow: rgb(38, 57, 77) 0px 20px 30px -10px;
    }


</style>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <!-- Fonts and icons -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet"/>
    <!-- Nucleo Icons -->
    <link href="https://demos.creative-tim.com/argon-dashboard-pro/assets/css/nucleo-icons.css" rel="stylesheet"/>
    <link href="https://demos.creative-tim.com/argon-dashboard-pro/assets/css/nucleo-svg.css" rel="stylesheet"/>
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <!-- jQuery CDN 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" ></script>
<%--    integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRkBsu0Ml5l4Klp2aKBu6pNFz9I7O07Ksr/6Ak3zx" crossorigin="anonymous"--%>
    <!-- CSS Files -->
    <link id="pagestyle" href="<c:url value='/css/argon-dashboard.css?v=2.1.0'/>" rel="stylesheet"/>

    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<script>
    let login = {
        init: function () {
            $('#login_form > button').click(() => {
                this.check();
            });
            // Enter 키 눌렀을 때 폼 제출되도록 추가
            $('#login_form').on('keyup', (event) => {
                if (event.keyCode === 13) {  // Enter key code is 13
                    this.check();
                }
            });
        },

        check: function () {
            let id = $('#id').val();
            let pwd = $('#pwd').val();
            if (id == '' || id == null) {
                alert('id is mandatory');
                $('#id').focus();
                return;
            }
            if (pwd == '' || pwd == null) {
                alert('pwd is mandatory');
                $('#pwd').focus();
                return;
            }
            this.send();
        },

        send: function () {
            // method, action
            $('#login_form').attr('method', 'post');
            $('#login_form').attr('action', '/loginimpl');
            $('#login_form').submit();
        }
    };

    $(function () {
        login.init();
    })
</script>

<body class="bg-gray-100">

<!-- Navbar 유지 -->
<div class="container position-sticky z-index-sticky top-0">
    <div class="row">
        <div class="col-12">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg blur border-radius-lg top-0 z-index-3 shadow position-absolute mt-4 py-2 start-0 end-0 mx-4">
                <div class="container-fluid">
                    <a class="navbar-brand font-weight-bolder ms-lg-0 ms-3 " href="<c:url value="/"/> ">
                        <img src="img/gunamul2.jpeg" style="width: 50px">
                        건어물
                    </a>
                    <button class="navbar-toggler shadow-none ms-2" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navigation" aria-controls="navigation" aria-expanded="false"
                            aria-label="Toggle navigation">
              <span class="navbar-toggler-icon mt-2">
                <span class="navbar-toggler-bar bar1"></span>
                <span class="navbar-toggler-bar bar2"></span>
                <span class="navbar-toggler-bar bar3"></span>
              </span>
                    </button>
                    <div class="collapse navbar-collapse" id="navigation">
                        <ul class="navbar-nav mx-auto">
<%--                            <li class="nav-item">--%>
<%--                                <a class="nav-link d-flex align-items-center me-2 active" aria-current="page"--%>
<%--                                   href="<c:url value="/"/> ">--%>
<%--                                    <i class="fa fa-chart-pie opacity-6 text-dark me-1"></i>--%>
<%--                                    메인 페이지--%>
<%--                                </a>--%>
<%--                            </li>--%>
<%--                            <li class="nav-item">--%>
<%--                                <a class="nav-link me-2" href="#">--%>
<%--                                    <i class="fa fa-user opacity-6 text-dark me-1"></i>--%>
<%--                                    버튼1--%>
<%--                                </a>--%>
<%--                            </li>--%>
                            <li class="nav-item">
                                <a class="nav-link me-2" href="/login">
                                    <i class="fas fa-key opacity-6 text-dark me-1"></i>
                                    로그인
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link me-2" href="/register">
                                    <i class="fas fa-user-circle opacity-6 text-dark me-1"></i>
                                    회원가입
                                </a>
                            </li>

                        </ul>
                    </div>
                </div>
            </nav>
            <!-- End Navbar -->
        </div>
    </div>
</div>

<!-- 로그인 폼 -->
<main class="main-content mt-0">
    <section>
        <div class="page-header min-vh-100">
            <div class="container">
                <div class="row">
                    <!-- 로그인 폼 (왼쪽) -->
                    <div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto">
                        <div class="card card-plain">
                            <div class="card-header pb-0 text-start">
                                <h4 class="font-weight-bolder">Sign In</h4>
                                <p class="mb-0">Enter your ID and password to sign in</p>
                            </div>
                            <div class="card-body">

                                <!-- 에러 메시지 출력 -->
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger" role="alert">
                                            ${errorMessage}
                                    </div>
                                </c:if>

                                <form id="login_form">
                                    <div class="form-group">
                                        <label for="id">id: </label>
                                        <input type="text" class="form-control" placeholder="Enter id" id="id" name="id" value="user01">
                                    </div>
                                    <div class="form-group">
                                        <label for="pwd">Password:</label>
                                        <input type="password" class="form-control" placeholder="Enter password" id="pwd" name="pwd" value="password1">
                                    </div>
                                    <button type="button" class="btn btn-primary">Submit</button>
                                </form>
                                <a href="<c:url value="/oauth/kakao"/> ">
                                    <img src="<c:url value="/img/kakao_login_medium_narrow.png"/> ">
                                </a>
                            </div>
                            <div class="card-footer text-center pt-0 px-lg-2 px-1">
                                <p class="mb-4 text-sm mx-auto">
                                    Don't have an account?
                                    <a href="/register" class="text-primary text-gradient font-weight-bold">Sign up</a>
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- 오른쪽 이미지 (배경) -->
                    <div class="col-6 d-lg-flex d-none h-100 my-auto pe-0 position-absolute top-0 end-0 text-center justify-content-center flex-column">
                        <div class="position-relative bg-gradient-primary h-100 m-3 px-7 border-radius-lg d-flex flex-column justify-content-center overflow-hidden"
                             style="background-image: url('https://raw.githubusercontent.com/HosikKim/SmartBuilding-Management-System/refs/heads/cmlee/user/src/main/resources/static/img/photo-1478186014654-5a7e3898daa5.jpg?token=GHSAT0AAAAAAC2OQ7SK6V7QA3H3VYAZMXBKZZVTOSQ');
                                    background-size: contain;">
                            <span class="mask bg-gradient-primary opacity-6"></span>
                            <h4 class="mt-5 text-white font-weight-bolder position-relative" style="text-shadow:3px 3px #a8b8d8">"지능형 스마트 빌딩 관리, 지금 시작하세요."</h4>
                            <p class="text-white position-relative">에너지 최적화, 유지보수, 자동화, 사용자 편의성 극대화</p>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
</main>

</body>
</html>
