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
    let calc = {
        init: function () {
            $('#car_find > button').click(() => {
                this.send();
            });
        },
        send: function () {
            $.ajax({
                url: '/car_find',
                type: 'GET',
                data: { carNum: $('#carNum').val() },
                success: function (data) {
                    console.log("AJAX 성공:", data); // 확인용 콘솔 출력
                    display(data);
                },
                error: function () {
                    alert("데이터를 가져오는 데 실패했습니다.");
                }
            });
        }
    }

    function display(datas) {
        let result = '';
        $(datas).each(function (index, data) {
            result += '<tr>';
            result += '<td>' + data.parkLogId + '</td>';
            result += '<td>' + data.parkId + '</td>';
            result += '<td>' + data.carNum + '</td>';
            result += '<td>' + data.carIn + '</td>';
            result += '<td>' + (data.carOut ? data.carOut : '미출차') + '</td>';
            result += '<td>' + "5000원" + '</td>';
            result += '</tr>';
        });
        $('#cdata > tbody').html(result);
    }

    $(document).ready(function () {
        calc.init();
    });
</script>


<body>
<div style="align-items: center">`11
    <div class="card-body" style="width: 300px">
        <form id="car_find">
            <div class="form-group">
                <label for="carNum">차량 번호:</label>
                <input type="text" class="form-control" id="carNum" name="carNum">
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

            <table class="table align-items-center justify-content-center mb-0" style="margin-top: 30px; background-color: white; border-radius: 5px" id="cdata">
                <thead>
                <tr>
                    <th>Park Log ID</th>
                    <th>Park ID</th>
                    <th>차량 번호</th>
                    <th>입차 시간</th>
                    <th>출차 시간</th>
                    <th>요금</th>
                </tr>
                </thead>
                <tbody>
                <!-- 검색 결과가 여기에 표시됩니다 -->
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>