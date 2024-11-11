<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주차 요금 안내</title>
    <style>
        /* 기존 스타일은 그대로 유지 */
        .input-section {
            margin-top: 250px;
            margin-bottom: 20px;
        }
        .result-section {
            margin-top: 20px;
            color: #000000; /* 텍스트 색상 검정 */
            font-size: 24px;
            background-color: #000000; /* 배경을 흰색으로 설정 (필요한 경우) */
            padding: 10px; /* 여백 추가 */
            border-radius: 5px; /* 둥근 테두리 추가 */
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery 라이브러리 추가 -->
    <script>
        // 조회하기 버튼 클릭 시 AJAX 요청
        $(document).ready(function() {
            $('.button').click(function() {
                var carNumber = $('.input-field').val(); // 입력된 차량 번호 가져오기

                // 서버에 AJAX 요청을 보내 입차 및 출차 시간 가져오기
                $.ajax({
                    url: '/getParkingTime', // 입차/출차 시간을 가져오는 서버 URL
                    method: 'GET',
                    data: { carNumber: carNumber }, // 차량 번호를 서버에 전송
                    success: function(response) {
                        if (response.error) {
                            $('.result-section').text("오류: " + response.error);
                        } else {
                            var carIn = response.carIn;
                            var carOut = response.carOut || new Date().toISOString(); // 출차 시간이 없으면 현재 시간 사용

                            // 요금 계산을 위해 서버에 요청
                            calculateParkingFee(carIn, carOut);
                        }
                    },
                    error: function() {
                        alert("입차/출차 시간을 가져오는 중 오류가 발생했습니다.");
                    }
                });
            });

            // 주차 요금 계산 요청
            function calculateParkingFee(carIn, carOut) {
                $.ajax({
                    url: '/parksetsum',
                    method: 'GET',
                    data: { carIn: carIn, carOut: carOut },
                    success: function(response) {
                        if (response.fee !== undefined) {
                            $('.result-section').text("주차 요금: " + response.fee + "원");
                        } else {
                            $('.result-section').text("오류: 요금 정보를 불러올 수 없습니다.");
                        }
                    },
                    error: function() {
                        alert("요금 계산 중 오류가 발생했습니다.");
                    }
                });
            }
        });


    </script>
</head>
<body>
<!-- 차량번호 입력 섹션 -->
<div class="input-section">
    <div class="input-box">차량번호 입력</div>
    <input type="text" class="input-field" placeholder="차량번호를 입력하세요">
    <button class="button">조회하기 ✔</button>
</div>

<!-- 요금 계산 결과를 표시할 섹션 -->
<div class="result-section"></div>

<!-- 주차 요금 안내 표 -->
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
