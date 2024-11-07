<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 부트스트랩 아이콘 링크 추가 --%>
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css">

<style>
    /* 주차 관리 드롭다운 스타일 */
    .nav-item .dropdown-menu {
        display: none; /* 기본적으로 숨김 */
        position: absolute;
        background-color: #f8f9fa;
        border-radius: 0.25rem;
        padding: 0.5rem 0;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);

    }

    /* 드롭다운이 활성화될 때 표시될 클래스 */
    .dropdown-open .dropdown-menu {
        display: block;
    }
</style>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // 모든 드롭다운 요소에 대해 클릭 이벤트 추가
        const dropdowns = document.querySelectorAll(".nav-item.dropdown");

        dropdowns.forEach(dropdown => {
            const link = dropdown.querySelector(".nav-link");

            // 드롭다운 메뉴 열기 및 닫기 기능
            link.addEventListener("click", function (event) {
                event.preventDefault(); // 링크 기본 동작 방지
                dropdown.classList.toggle("dropdown-open");
            });

            // 페이지의 다른 부분을 클릭했을 때 드롭다운 닫기
            document.addEventListener("click", function (event) {
                if (!dropdown.contains(event.target)) {
                    dropdown.classList.remove("dropdown-open");
                }
            });
        });
    });
</script>

<html>
<body>
<aside class="sidenav bg-white navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-4 "
       id="sidenav-main">
    <div class="sidenav-header">
        <i class="fas fa-times p-3 cursor-pointer text-secondary opacity-5 position-absolute end-0 top-0 d-none d-xl-none"
           aria-hidden="true" id="iconSidenav"></i>
        <a class="navbar-brand m-0" href="<c:url value="/"/>">
            <img src="<c:url value="/img/gunamul2.jpeg"/>" width="50px" height="50px"
                 class="navbar-brand-img h-100"
                 alt="main_logo">
            <span class="ms-1 font-weight-bold">건어물</span>
        </a>
    </div>
    <hr class="horizontal dark mt-0">
    <div class="collapse navbar-collapse  w-auto " id="sidenav-collapse-main">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link active" href="<c:url value="/"/> ">
                    <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="ni ni-tv-2 text-dark text-sm opacity-10"></i>
                    </div>
                    <span class="nav-link-text ms-1">Dashboard</span>
                </a>
            </li>
            <%--  에너지 관리--%>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="energyDropdown" role="button" data-bs-toggle="dropdown"
                   aria-expanded="false">
                    <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="bi bi-lightbulb text-dark text-sm opacity-10"></i> <!-- 에너지 관리 아이콘 (전구 모양) -->
                    </div>
                    <span class="nav-link-text ms-1">에너지관리</span>
                </a>

                <ul class="dropdown-menu" aria-labelledby="energyDropdown">
                    <li><a class="dropdown-item" href="../pages/electricity.html">전력 관리</a></li>
                    <li><a class="dropdown-item" href="../pages/water.html">물 관리</a></li>
                    <li><a class="dropdown-item" href="../pages/gas.html">가스 관리</a></li>
                </ul>
            </li>

            <%-- 주차관리 및 아이콘 추가 --%>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="parkingDropdown" role="button"
                   data-bs-toggle="dropdown"
                   aria-expanded="false">
                    <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="bi bi-car-front-fill text-dark text-sm opacity-10"></i> <!-- 주차관리 아이콘 -->
                    </div>
                    <span class="nav-link-text ms-1">주차관리</span>
                </a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="<c:url value="/park/calc"/>">사전정산</a></li>
                    <li><a class="dropdown-item" href="<c:url value="/park/lot"/> ">주차 가능 여부</a></li>
                </ul>
            </li>

            <%-- 공지사항 및 아이콘 추가 --%>
            <li class="nav-item">
                <a class="nav-link" href="<c:url value="/notice"/> ">
                    <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="bi bi-asterisk text-dark text-sm opacity-10"></i> <!-- 공지사항 아이콘 -->
                    </div>
                    <span class="nav-link-text ms-1">공지사항</span>
                </a>
            </li>

            <li class="nav-item mt-3">
                <h6 class="ps-4 ms-2 text-uppercase text-xs font-weight-bolder opacity-6">회원</h6>
            </li>
            <c:choose>
                <c:when test="${sessionScope.loginid == null}">

                    <li class="nav-item">
                        <a class="nav-link " href="<c:url value="/login"/> ">
                            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="bi bi-box-arrow-left text-dark opacity-10"
                                   style="font-size: 1.2em; text-shadow: 1px 0 currentColor, -1px 0 currentColor, 0 1px currentColor, 0 -1px currentColor;"></i>
                            </div>
                            <span class="nav-link-text ms-1">로그인</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link " href="<c:url value="/register"/>">
                            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="ni ni-single-02 text-dark text-sm opacity-10"></i>
                            </div>
                            <span class="nav-link-text ms-1">회원가입</span>
                        </a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a class="nav-link " href="<c:url value='/mypage'/>">
                            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="ni ni-single-02 text-dark text-sm opacity-10"></i>
                            </div>
                            <span class="nav-link-text ms-1">마이페이지</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link " href="<c:url value='/logoutimpl'/>">
                            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="ni ni-single-02 text-dark text-sm opacity-10"></i>
                            </div>
                            <span class="nav-link-text ms-1">로그아웃</span>
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>


        </ul>
    </div>
    <div class="sidenav-footer mx-3 ">
        <div class="card card-plain shadow-none" id="sidenavCard">
            <img class="w-50 mx-auto" src="<c:url value="/img/gunamul2.jpeg"/>"
                 alt="sidebar_illustration">
            <div class="card-body text-center p-3 w-100 pt-0">
            </div>
        </div>
    </div>
</aside>
</body>
