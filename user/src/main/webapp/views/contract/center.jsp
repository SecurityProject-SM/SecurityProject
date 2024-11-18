<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .card-body{
        background-color: #ffffff;
        border-bottom-left-radius: inherit;
        border-bottom-right-radius: inherit;
    }
</style>
<html>
<head>
    <title>계약서 보기</title>
</head>

<%--<script>--%>
<%--    $(function () {--%>
<%--        let contract = {--%>
<%--            init: function () {--%>
<%--                const hasContract = <%= session.getAttribute("contract") != null ? "true" : "false" %>;--%>

<%--                if (hasContract === "false") {--%>
<%--                    alert("계약 정보가 없습니다");--%>
<%--                    location.href = '/mypage'; // /mypage로 이동--%>
<%--                }--%>
<%--            }--%>
<%--        }--%>

<%--        contract.init();--%>
<%--    });--%>
<%--</script>--%>


<body>
<main class="main-content mt-0">
    <section>
        <div class="page-header min-vh-100">
            <div class="container">
                <div class="row">
                    <div class="col-xl-10 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto">
                        <div class="card card-plain">
                            <div class="card-header pb-0 text-start">
                                <h4 class="font-weight-bolder">계약서 정보</h4>
                                <p class="mb-0" style="font-size: 14px">아래는 사용자의 계약 정보입니다.</p>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="contractId">계약 ID:</label>
                                    <input type="text" readonly value="${contractDto.contractId}" class="form-control"
                                           id="contractId" style="background:rgba(211,206,206,0.79)">
                                </div>
                                <div class="form-group">
                                    <label for="houseId">건물 ID:</label>
                                    <input type="text" readonly value="${contractDto.houseId}" class="form-control"
                                           id="houseId" style="background:rgba(211,206,206,0.79)">
                                </div>
                                <div class="form-group">
                                    <label for="contractDay">계약 시작일:</label>
                                    <input type="text" readonly value="${contractDto.contractDay}" class="form-control"
                                           id="contractDay" style="background:rgba(211,206,206,0.79)">
                                </div>
                                <div class="form-group">
                                    <label for="contractEnd">계약 종료일:</label>
                                    <input type="text" readonly value="${contractDto.contractEnd}" class="form-control"
                                           id="contractEnd" style="background:rgba(211,206,206,0.79)">
                                </div>
                                <div class="form-group">
                                    <label for="contractPay">계약 금액:</label>
                                    <input type="text" readonly value="${contractDto.contractPay}" class="form-control"
                                           id="contractPay" style="background:rgba(211,206,206,0.79)">
                                </div>
                                <div class="form-group">
                                    <label for="contractDeposit">보증금:</label>
                                    <input type="text" readonly value="${contractDto.contractDeposit}"
                                           class="form-control" id="contractDeposit"
                                           style="background:rgba(211,206,206,0.79)">
                                </div>
                                <a href="<c:url value='/mypage'/>" class="btn btn-light" role="button"> 마이페이지로 돌아가기 </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>
</body>
</html>
