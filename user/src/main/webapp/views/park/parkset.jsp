<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주차 요금 안내</title>
    <style>
        /* 기존 스타일 유지 */
        .input-section {
            margin-top: 250px;
            margin-bottom: 20px;
        }
        .result-section {
            margin-top: 20px;
            color: #000000;
            font-size: 24px;
            background-color: #000000;
            padding: 10px;
            border-radius: 5px;
        }
        .input-box {
            background-color: #333;
            color: #ffffff;
            border: 1px solid #ffffff;
            padding: 10px;
            text-align: center;
            border-radius: 5px;
            width: 15%;
            margin: 10px auto;
        }
        .input-field {
            width: 40%;
            height: 100px;
            padding: 10px;
            border: 1px solid #ffffff;
            background-color: #333;
            color: #ffffff;
            border-radius: 5px;
            display: block;
            margin: 10px auto;
            font-size: 35px;
            text-align: center;
        }
        .button {
            padding: 10px 20px;
            background-color: #596cff;
            color: #ffffff;
            border: 1px solid #ffffff;
            border-radius: 5px;
            cursor: pointer;
            display: block;
            margin: 10px auto;
        }
        .fee-table {
            width: 60%;
            border-collapse: collapse;
            margin: 50px auto;
            border: 1px solid #ffffff;
            color: #000000;
        }
        .fee-table th, .fee-table td {
            border: 1px solid #000000;
            padding: 10px;
            text-align: center;
        }
        .fee-table th {
            background-color: #333;
            color: #ffffff;
        }
        .result-section {
            margin-top: 20px;
            color: #ffffff;
            font-size: 24px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.button').click(function() {
                var carNumber = $('.input-field').val();

                // 서버에 요금 계산 요청
                $.ajax({
                    url: '/parksetsum',
                    method: 'GET',
                    data: { carNumber: carNumber },
                    success: function(response) {
                        if (response.error) {
                            $('.result-section').text("오류: " + response.error);
                        } else {
                            $('.result-section').text("총 주차 시간: " + response.totalTime + ", 요금: " + response.totalFee + "원");
                        }
                    },
                    error: function() {
                        alert("요금 정보를 가져오는 중 오류가 발생했습니다.");
                    }
                });
            });
        });
    </script>
</head>
<body>
<div class="input-section">
    <div class="input-box">차량번호 입력</div>
    <input type="text" class="input-field" placeholder="차량번호를 입력하세요">
    <button class="button">조회하기 ✔</button>
</div>

<div class="result-section"></div>

<table class="fee-table">
    <thead>
    <tr>
        <th colspan="2">주차요금 안내</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>최초 30분</td>
        <td>3,000원</td>
    </tr>
    <tr>
        <td>추가요금 (30분당)</td>
        <td>5,000원</td>
    </tr>
    <tr>
        <td>일일 최대요금</td>
        <td>60,000원</td>
    </tr>
    </tbody>
</table>
</body>
</html>
