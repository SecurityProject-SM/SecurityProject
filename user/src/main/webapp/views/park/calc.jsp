<%--
  User: 1
  Date: 2024-11-07
  Time: 오전 9:28
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
</head>

<style>
</style>

<script>
</script>

<body>
<div style="align-items: center">
    <div class="card-body" style="width: 300px">
        <form id="update_form">
            <div class="form-group">
                <label for="id">차량 번호:</label>
                <input type="text" value="${user.userId}" readonly class="form-control" id="id" name="userId">
            </div>

            <button type="button" id="update_btn" class="btn btn-primary">찾기</button>
        </form>
    </div>
    <div class="row mt-4">
        <div class="col-lg-7 mb-lg-0 mb-4">
            <div class="card ">
                <div class="card-header pb-0 p-3">
                    주차 요금 안내
                </div>
                <div class="table-responsive">
                    <table class="table align-items-center ">
                        <thead>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="w-30">
                                <h6>추가요금 (30분당)</h6>
                            </td>
                            <td>
                                <div class="text-center">
                                    <h6 class="text-xs font-weight-bold mb-0">5000원</h6>

                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="w-30">
                                <h6>최초 30분</h6>
                            </td>
                            <td>
                                <div class="text-center">
                                    <h6 class="text-xs font-weight-bold mb-0">3000원</h6>

                                </div>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>