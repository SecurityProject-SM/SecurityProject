<%--
  User: 1
  Date: 2024-11-07
  Time: 오전 9:28
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--결제 SDK--%>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>


<html>
<head>
    <title>주차 요금 정산</title>
</head>

<style>
</style>

<script>
    // 포트원 결제 요청 함수
    function requestPay() {
        const IMP = window.IMP; // 포트원 결제 객체 초기화
        IMP.init('store-0d2d51f1-bdca-4fa2-8574-90baab8f7a48'); // 상점 아이디 (포트원에서 발급받은 상점 아이디)

        // 결제 요청 정보
        IMP.request_pay({
            pg: 'html5_inicis', // 사용할 PG사 (예: html5_inicis, kakao 등)
            pay_method: 'card', // 결제수단 (카드, 계좌이체 등)
            merchant_uid: 'order_' + new Date().getTime(), // 주문 번호 (유니크한 값)
            name: '주차 정산 요금', // 주문명
            amount: 5000, // 결제 금액 (원화 단위)
            buyer_email: 'buyer@example.com', // 구매자 이메일
            buyer_name: '홍길동', // 구매자 이름
            buyer_tel: '010-1234-5678', // 구매자 전화번호
            buyer_addr: '서울특별시 강남구', // 구매자 주소 (선택)
            buyer_postcode: '123-456', // 구매자 우편번호 (선택)
        }, function (rsp) {
            if (rsp.success) {
                // 결제 성공 시 처리 로직
                alert('결제가 완료되었습니다.\n결제 금액: ' + rsp.paid_amount + '원');

                // 서버에 결제 검증 요청 (imp_uid 전송)
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
                // 결제 실패 시 처리 로직
                alert('결제에 실패하였습니다.\n에러 내용: ' + rsp.error_msg);
            }
        });
    }
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
            <a class="btn btn-light" role="button" onclick="requestPay()" style="text-align: center">정산하기</a>
        </form>
    </div>

</div>
</body>

<footer>
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
</footer>

</html>
