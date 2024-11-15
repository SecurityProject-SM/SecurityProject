<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--결제 SDK--%>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

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
            color: #ffffff;
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
        .search-button, .pay-button {
            padding: 10px 20px;
            background-color: #596cff;
            color: #ffffff;
            border: 1px solid #ffffff;
            border-radius: 5px;
            cursor: pointer;
            display: block;
            margin: 10px auto;
        }
        .pay-button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
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
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            var totalFee = 0; // 결제 금액 초기화

            // 조회하기 버튼 클릭 이벤트
            $('.search-button').click(function () {
                var carNumber = $('.input-field').val();

                // 서버에 요금 계산 요청
                $.ajax({
                    url: '/parksetsum',
                    method: 'GET',
                    data: { carNumber: carNumber },
                    success: function (response) {
                        if (response.error) {
                            $('.result-section').text("오류: " + response.error);

                            // 결제 버튼 비활성화
                            $('.pay-button').prop('disabled', true);
                        } else {
                            // 조회 결과 표시
                            $('.result-section').text("총 주차 시간: " + response.totalTime + ", 요금: " + response.totalFee + "원");

                            // 결제 금액 저장
                            totalFee = response.totalFee;

                            // 결제 요청 데이터 로그 출력
                            console.log("결제 요청 데이터:", {
                                pg: 'tosspayments',
                                pay_method: 'card',
                                merchant_uid: 'order_' + new Date().getTime(),
                                name: '주차 정산 요금',
                                amount: totalFee
                            });

                            // 결제 버튼 활성화
                            $('.pay-button').prop('disabled', false);
                        }
                    },
                    error: function () {
                        alert("요금 정보를 가져오는 중 오류가 발생했습니다.");
                        // 결제 버튼 비활성화
                        $('.pay-button').prop('disabled', true);
                    }
                });
            });

            // 결제 버튼 클릭 이벤트
            $('.pay-button').click(function () {
                if (totalFee <= 0) {
                    alert("결제 금액이 유효하지 않습니다. 차량 번호를 다시 조회하세요.");
                    return;
                }

                const IMP = window.IMP; // 포트원 결제 객체 초기화
                IMP.init('imp84274542'); // 내 포트원 식별코드 변경하면 안됌

                // 결제 요청
                IMP.request_pay({
                    pg: 'tosspayments', // 테스트 환경의 PG사 설정
                    pay_method: 'card',
                    merchant_uid: 'order_' + new Date().getTime(),
                    name: '주차 정산 요금',
                    amount: totalFee
                }, function (rsp) {
                    if (rsp.success) {
                        alert('결제가 완료되었습니다.\n결제 금액: ' + rsp.paid_amount + '원');

                        // 서버에 결제 검증 요청
                        fetch('/park/payment', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({ impUid: rsp.imp_uid }),
                        })
                            .then(response => response.text())
                            .then(data => alert(data))
                            .catch(error => console.error('결제 검증 중 오류:', error));
                    } else {
                        alert('결제에 성공하였습니다.');
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
    <button class="search-button">조회하기 ✔</button>
    <button class="pay-button" disabled>결제하기 ✔</button>
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
