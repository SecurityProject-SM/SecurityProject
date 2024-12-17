<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-11-06
  Time: 오전 11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--구글 이모티콘--%>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<%--결제 SDK--%>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>


<style>

  @keyframes spin {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
  }
  /* 로딩 스피너 스타일 끝 */


  /* 전체 컨테이너 스타일 개선 */
  .park-container {
    display: flex;
    align-items: flex-start;
    margin-top: 100px; /* 상단 여백 줄임 */
    padding: 30px;
    background: linear-gradient(to bottom, #f8f9fa, #ffffff);
    border-radius: 20px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.05);
    width: fit-content;
    position: absolute;
    left: 200px;

  }

  /* 주차현황 제목 스타일 개선 */
  .주차현황 {
    font-size: 28px;
    font-weight: 600;
    color: #2c3e50;
    margin-bottom: 25px;
    position: relative;
    padding-left: 20px;
    letter-spacing: -0.5px;
  }

  .주차현황::before {
    content: '';
    position: absolute;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 5px;
    height: 28px;
    background: linear-gradient(to bottom, #3498db, #2980b9);
    border-radius: 3px;
  }

  /* 시간 박스 디자인 개선 */
  .time-box {
    background: linear-gradient(135deg, #ffffff, #f8f9fa);
    border: none;
    box-shadow: 0 4px 15px rgba(0,0,0,0.05);
    padding: 25px;
    border-radius: 15px;
    transition: transform 0.3s ease;
  }

  .time-box:hover {
    transform: translateY(-3px);
  }

  #ctime {
    font-size: 2.5em;
    color: #2c3e50;
    margin: 10px 0;
    font-weight: 600;
  }

  #cday {
    color: #7f8c8d;
    font-size: 1.1em;
  }

  /* 현황판 디자인 개선 */
  .status-box {
    background: linear-gradient(135deg, #ffffff, #f8f9fa);
    border: none;
    box-shadow: 0 4px 15px rgba(0,0,0,0.05);
    padding: 25px;
    border-radius: 15px;
    margin-top: 25px;
    transition: transform 0.3s ease;
  }

  .status-box:hover {
    transform: translateY(-3px);
  }

  .status-header {
    margin-bottom: 20px;
  }

  .status-header h4 {
    font-size: 1.4rem;
    color: #2c3e50;
    font-weight: 600;
  }

  .count-badge {
    font-size: 1.1rem;
    padding: 8px 16px;
    border-radius: 25px;
    font-weight: 500;
  }

  .count-badge.total {
    background: linear-gradient(135deg, #4a90e2, #357abd);
  }

  .count-badge.available {
    background: linear-gradient(135deg, #2ecc71, #27ae60);
  }

  .count-badge.occupied {
    background: linear-gradient(135deg, #e74c3c, #c0392b);
  }

  /* 주차 공간 스타일 개선 */
  .parking-spot {
    transition: all 0.3s ease;
    border-radius: 8px;
  }

  .parking-spot:hover {
    transform: scale(1.05);
    z-index: 2;
  }

  /* 로딩 스피너 개선 */
  .loading-wrap {
    background-color: rgba(0, 0, 0, 0.3);
    backdrop-filter: blur(5px);
  }

  .loading-spinner {
    border: 5px solid rgba(52, 152, 219, 0.2);
    border-top: 5px solid #3498db;
    width: 50px;
    height: 50px;
  }

  /* 정산하기 버튼 스타일 개선 */
  .status-box .btn-light {
    display: block;
    width: 100%;
    padding: 12px;
    background: linear-gradient(135deg, #3498db, #2980b9);
    color: white;
    border: none;
    border-radius: 10px;
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 1px;
    transition: all 0.3s ease;
  }

  .status-box .btn-light:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
  }


  .parking-lot {
    position: relative;
    border-radius : 10px;
    margin-left: 30px;
    margin-top: 10px; /* 요소 전체를 아래로 이동 */
    width: 799px; /* 도면 이미지 너비 */
    height: 600px; /* 도면 이미지 높이 */
    background-image: url('<c:url value="/img/park/parkimg2.png"/>');
    background-size: cover;
    overflow: hidden; /* 컨테이너 밖으로 삐져나오지 않도록 설정 */
  }

  .parking-spot {
    position: absolute;
    width: 89px;  /* 각 주차 공간의 크기 */
    height: 98px;
    opacity: 0;
    transition: opacity 2s ease; /* 천천히 나타나는 애니메이션 */


    transform-origin: center center; /* 회전 중심점 설정 */

  }
  .info-container {
    display: flex;
    flex-direction: column; /* 세로 배치 */
    margin-top: 10px; /* 주차 도면과 같은 높이 맞추기 */
    margin-left: 20px; /* 주차 도면과의 간격 조절 */
    /*background-color: white; !* 뒷 배경이 겹치는 것을 방지 *!*/
  }


  #cday{
    position: relative;
    top: -10px;
    right: -7px;

  }
  #clock{
    position: relative;
    left: 122px;
    top: 2px;
  }

  .status-box {
    padding: 1.5rem;
    background: white;
    border-radius: 15px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
  }

  .status-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 1.2rem;
    padding-bottom: 0.8rem;
    border-bottom: 1px solid #eee;
  }

  .status-header h4 {
    margin: 0;
    font-size: 1.25rem;
    color: #333;
  }

  .status-header .material-symbols-outlined {
    color: #666;
    font-size: 1.5rem;
  }

  .status-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 1rem;
    padding: 0.5rem 0;
  }

  .status-label {
    color: #555;
    font-size: 1rem;
    font-weight: 500;
  }

  .btnOrange {
    display: block;
    position: relative;
    float: left;
    width: 100%;
    padding: 0;
    margin: 10px 20px 10px 0;
    font-weight: 600;
    text-align: center;
    line-height: 50px;
    color: #090909;
    border-radius: 5px;
    transition: all 0.2s;
    border: 0.5px solid #8f8989;
  }

  .btnOrange.btnPush {
    box-shadow: 0px 5px 0px 0px #8f8989;
  }

  .btnPush:hover {
    margin-top: 15px;
    margin-bottom: 5px;
  }

  .btnOrange.btnPush:hover {
    box-shadow: 0px 0px 0px 0px #A66615;
  }


  /* background-color: #32ec70; */
  #spot1 { top: 6px; left: 166px; }
  #spot2 { top: 6px; left: 261px; }
  #spot3 { top: 6px; left: 356px; }
  #spot4 { top: 6px; left: 450px; }
  #spot5 { top: 6px; left: 545px; }
  #spot6 { top: 6px; left: 640px; }

  #spot7 { top: 195px; left: 215px; }
  #spot8 { top: 195px; left: 310px;}
  #spot9 { top: 195px; left: 404px;}
  #spot10 { top: 195px; left: 500px; }
  #spot11 { top: 195px; left: 595px;}

  #spot12 { top: 299px; left: 215px;}
  #spot13 { top: 299px; left: 310px;}
  #spot14 { top: 299px; left: 404px;}
  #spot15 { top: 299px; left: 499px;}
  #spot16 { top: 299px; left: 595px;}

  #spot17 { top: 496px; left: 168px;}
  #spot18 { top: 496px; left: 262px;}
  #spot19 { top: 496px; left: 357px;}
  #spot20 { top: 496px; left: 452px;}
  #spot21 { top: 496px; left: 547px;}
  #spot22 { top: 496px; left: 641px;}

  #spot23 { top: 303px; left: 7px; width: 97px; height: 89px;}
  #spot24 { top: 398px; left: 7px; width: 97px; height: 89px;}
</style>
<script>
  let park = {
    loadingShown: false, // 로딩이 처음 한 번만 나타나도록 제어하는 플래그
    init: function () {
      // this.init();  // 초기 로드
      // setInterval(this.parkstat, 1000);  // 5초마다 상태 갱신
      this.parkstat() //한번만 불러오기
      setInterval(this.getTime, 1000);
    },
    getTime:function(){
      $.ajax({
        'url' : '<c:url value="/getctime"/>',
        'success' : (result)=>{
          $('#cday').html(result.cday);
          $('#ctime').html(result.ctime);
        }
      });
    },

    // AJAX로 주차 상태를 가져오는 함수
    parkstat: function () {
      $.ajax({
        url: "/getparkstat",
        method: "GET",
        dataType: "json",
        success: function (data) {
          var parkingCount = 24-data.availableCount;
          $("#availableCount").text(data.availableCount);
          $("#parkingCount").text(parkingCount);
          // 데이터가 성공적으로 로드되면 각 주차칸의 색상을 업데이트
          data.parkingData.forEach(function (park) {
            const spotElement = document.getElementById("spot" + park.parkId);
            // if (spotElement) {
            //   spotElement.style.backgroundColor = park.parkStat ? "#32ec70" : "red";
            // }
            if (spotElement) {
              if(park.parkStat==true){
                // spotElement.style.backgroundColor = "#32ec70";
                spotElement.style.backgroundColor = "#32ec70";
                spotElement.style.backgroundImage = ""; // 기존 이미지를 제거
                spotElement.style.opacity = "0.6"; // 기존 투명도 초기화
                spotElement.style.transform = ""; // 회전 초기화
              }else{
                spotElement.style.backgroundColor = ""; // 배경색 제거
                spotElement.style.backgroundImage = "url('<c:url value="/img/park/parkingcar.png"/>')";
                spotElement.style.backgroundSize = "cover"; // 이미지 크기 조정
                spotElement.style.opacity = "1"; // 투명도 초기화
              }
              // 특정 주차 공간만 180도 회전
              if (park.parkId >= 7 && park.parkId <= 11 || park.parkId >= 17 && park.parkId <= 22) {
                spotElement.style.transform = "rotate(180deg)";
              } else {
                spotElement.style.transform = ""; // 회전 초기화
              }

              if(park.parkId >= 23 && park.parkId <= 24 && park.parkStat==false){
                spotElement.style.backgroundImage = "url('<c:url value="/img/park/parkingcar2.png"/>')";
                spotElement.style.backgroundSize = "cover"; // 이미지 크기 조정
                spotElement.style.opacity = "1"; // 투명도 초기화
              }
            }
          });
        },
        error: function (error) {
          console.error("주차 상태를 불러오는 중 오류 발생:", error);
        },
        complete: function () {
          $(".loading-wrap").hide(); // AJAX 완료 후 로딩 스피너 숨김
        }
      });
    }
  };

  $(function(){
    park.init();
  });
</script>


<!-- 로딩 스피너 HTML 추가 -->
<div class="loading-wrap">
  <div class="loading-spinner"></div>
  <p>로딩 중입니다...</p>
</div>

<div class="park-container">
<%--  주차 현황 그림--%>
  <div>
    <h2 class="주차현황">주차장 현황</h2>
    <div class="parking-lot">
      <!-- 주차 공간을 표시할 개별 박스들 -->
      <div class="parking-spot" id="spot1"></div>
      <div class="parking-spot" id="spot2"></div>
      <div class="parking-spot" id="spot3"></div>
      <div class="parking-spot" id="spot4"></div>
      <div class="parking-spot" id="spot5"></div>
      <div class="parking-spot" id="spot6"></div>
      <div class="parking-spot" id="spot7"></div>
      <div class="parking-spot" id="spot8"></div>
      <div class="parking-spot" id="spot9"></div>
      <div class="parking-spot" id="spot10"></div>
      <div class="parking-spot" id="spot11"></div>
      <div class="parking-spot" id="spot12"></div>
      <div class="parking-spot" id="spot13"></div>
      <div class="parking-spot" id="spot14"></div>
      <div class="parking-spot" id="spot15"></div>
      <div class="parking-spot" id="spot16"></div>
      <div class="parking-spot" id="spot17"></div>
      <div class="parking-spot" id="spot18"></div>
      <div class="parking-spot" id="spot19"></div>
      <div class="parking-spot" id="spot20"></div>
      <div class="parking-spot" id="spot21"></div>
      <div class="parking-spot" id="spot22"></div>
      <div class="parking-spot" id="spot23"></div>
      <div class="parking-spot" id="spot24"></div>
      <!-- 필요한 만큼 주차 공간을 추가 -->
    </div>
  </div>
    <!-- 주차장 도면 오른쪽에 시간 및 현황판 배치 -->
  <div class="info-container" >

    <div class="time-box" style="text-align: left">
      <div>
        <h5>현재 시각 <span class="material-symbols-outlined" id="clock">schedule</span></h5>
      </div>
      <h2 id="ctime"></h2>
      <a id="cday">...</a>
    </div>

    <div class="status-box">
      <div class="status-header">
        <h4>현황판</h4>
        <span class="material-symbols-outlined">directions_car</span>
      </div>

      <div class="status-item">
        <span class="status-label">총 주차칸</span>
        <span class="count-badge total" style="color: white">22</span>
      </div>

      <div class="status-item">
        <span class="status-label">주차 가능</span>
        <h3 id="availableCount" class="count-badge available" style="color: white">...</h3>
      </div>

      <div class="status-item">
        <span class="status-label">주차 중</span>
        <h3 id="parkingCount" class="count-badge occupied" style="color: white">...</h3>
      </div>
    </div>

    <div class="status-box">
      <h4> 정산하기</h4>
    <a href="<c:url value="/park/parkset"/>" class="button btnPush btnOrange" role="button" style="text-align: center">정산하기</a>
    </div>
  </div>
</div>

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<!-- 모달 오버레이 및 컨테이너 -->
<div id="parkingModal" class="modal-overlay" style="display: none;">
  <div class="modal-container">
    <!-- 닫기 버튼 -->
    <button class="close-button">
      <i class="fas fa-times"></i>
    </button>

    <!-- 정산 컨텐츠 -->
    <div class="modal-content">
      <div class="header">
        주차 요금 정산
      </div>

      <div class="input-section">
        <input type="text" class="input-field" placeholder="예: 12가3456">
        <div class="button-group">
          <button class="button search-button">
            <i class="fas fa-search"></i> 조회하기
          </button>
          <button class="button pay-button" disabled>
            <i class="fas fa-credit-card"></i> 결제하기
          </button>
        </div>
      </div>

      <div class="result-section"></div>

      <div class="fee-section">
        <div class="fee-header">주차요금 안내</div>
        <div class="fee-row">
          <span class="fee-label">최초 30분</span>
          <span class="fee-amount">3,000원</span>
        </div>
        <div class="fee-row">
          <span class="fee-label">추가요금 (30분당)</span>
          <span class="fee-amount">5,000원</span>
        </div>
        <div class="fee-row">
          <span class="fee-label">일일 최대요금</span>
          <span class="fee-amount">60,000원</span>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  /* 모달 오버레이 스타일 */
  .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.5);
    backdrop-filter: blur(5px);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
    opacity: 0;
    transition: opacity 0.3s ease;
  }

  .modal-overlay.show {
    opacity: 1;
  }

  /* 모달 컨테이너 스타일 */
  .modal-container {
    background: white;
    width: 500px;
    border-radius: 16px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    position: relative;
    transform: translateY(-20px);
    transition: transform 0.3s ease;
    overflow: hidden;
  }

  .modal-overlay.show .modal-container {
    transform: translateY(0);
  }

  /* 닫기 버튼 스타일 */
  .close-button {
    position: absolute;
    top: 15px;
    right: 15px;
    background: none;
    border: none;
    color: white;
    font-size: 1.5rem;
    cursor: pointer;
    z-index: 1;
    transition: transform 0.2s ease;
  }

  .close-button:hover {
    transform: rotate(90deg);
  }

  /* 기존 스타일 유지하되 필요한 부분만 수정 */
  .header {
    background: #4a90e2;
    color: white;
    padding: 20px;
    text-align: center;
    font-size: 1.5rem;
    font-weight: 600;
  }

  .input-section {
    padding: 30px 20px;
  }

  .input-field {
    width: 100%;
    height: 50px;
    padding: 10px 15px;
    border: 2px solid #e1e1e1;
    border-radius: 8px;
    font-size: 1.1rem;
    text-align: center;
    margin-bottom: 15px;
    transition: border-color 0.3s ease;
  }

  .button-group {
    display: flex;
    gap: 10px;
    margin-top: 15px;
  }

  .button {
    flex: 1;
    padding: 12px;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s ease;
    border: none;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
  }
  /* 버튼 스타일 */
  .search-button {
    background: #4a90e2;
    color: white;
  }

  .search-button:hover {
    background: #357abd;
  }

  .pay-button {
    background: #2ecc71;
    color: white;
  }

  .pay-button:hover:not(:disabled) {
    background: #27ae60;
  }

  .pay-button:disabled {
    background: #95a5a6;
    cursor: not-allowed;
  }

  /* 결과 섹션 스타일 */
  .result-section {
    padding: 15px 20px;
    margin: 15px 20px;
    background: #f8f9fa;
    border-radius: 8px;
    font-size: 1rem;
    display: none;
  }

  .result-section.visible {
    display: block;
  }

  /* 요금 안내 섹션 스타일 */
  .fee-section {
    padding: 20px;
    border-top: 1px solid #eee;
  }

  .fee-header {
    color: #2c3e50;
    font-size: 1.1rem;
    font-weight: 600;
    margin-bottom: 15px;
  }

  .fee-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid #eee;
  }

  .fee-row:last-child {
    border-bottom: none;
  }

  .fee-label {
    color: #2c3e50;
    font-weight: 500;
  }

  .fee-amount {
    color: #4a90e2;
    font-weight: 600;
  }

  /* ... 나머지 스타일은 이전과 동일 ... */
</style>

<script>
  // 모달 관련 JavaScript
  $(document).ready(function() {
    // 정산하기 버튼 클릭 시 모달 표시
    $('.btnOrange').click(function(e) {
      e.preventDefault();
      $('#parkingModal').css('display', 'flex');
      setTimeout(() => {
        $('#parkingModal').addClass('show');
      }, 10);
    });

    // 닫기 버튼 및 오버레이 클릭 시 모달 닫기
    // $('.close-button, .modal-overlay').click(function(e) {
    //   if (e.target === this) {
    //     $('#parkingModal').removeClass('show');
    //     setTimeout(() => {
    //       $('#parkingModal').css('display', 'none');
    //     }, 300);
    //   }
    // });
    // 닫기 버튼과 오버레이 클릭 시 모달 닫기 이벤트를 분리
    $('.modal-overlay').click(function(e) {
      if (e.target === this) {  // 오버레이 클릭 시에만 체크
        closeModal();
      }
    });

    $('.close-button').click(function() {  // 닫기 버튼은 무조건 닫기
      closeModal();
    });

// 모달 닫기 함수
    function closeModal() {
      $('#parkingModal').removeClass('show');
      setTimeout(() => {
        $('#parkingModal').css('display', 'none');
      }, 300);
    }

    // 기존의 AJAX 요청 및 결제 관련 코드는 그대로 유지
    var totalFee = 0;

    $('.search-button').click(function() {
      var carNumber = $('.input-field').val();

      $.ajax({
        url: '/parksetsum',
        method: 'GET',
        data: { carNumber: carNumber },
        success: function(response) {
          if (response.error) {
            $('.result-section')
                    .html(`<div style="color: #e74c3c"><i class="fas fa-exclamation-circle"></i> \${response.error}</div>`)
                    .addClass('visible');
            $('.pay-button').prop('disabled', true);
          } else {
            $('.result-section')
                    .html(`
                            <div style="display: flex; justify-content: space-between; margin: 15px;">
                                <span><i class="fas fa-clock"></i> 총 주차 시간</span>
                                <strong>\${response.totalTime}</strong>
                            </div>
                            <div style="display: flex; justify-content: space-between; margin: 15px;">
                                <span><i class="fas fa-won-sign"></i> 정산 금액</span>
                                <strong>\${response.totalFee.toLocaleString()}원</strong>
                            </div>
                        `)
                    .addClass('visible');

            totalFee = response.totalFee;
            $('.pay-button').prop('disabled', false);
          }
        },
        error: function() {
          alert("요금 정보를 가져오는 중 오류가 발생했습니다.");
          $('.pay-button').prop('disabled', true);
        }
      });
    });

    $('.pay-button').click(function() {
      if (totalFee <= 0) {
        alert("결제 금액이 유효하지 않습니다. 차량 번호를 다시 조회하세요.");
        return;
      }

      const IMP = window.IMP;
      IMP.init('imp84274542');

      IMP.request_pay({
        pg: 'tosspayments',
        pay_method: 'card',
        merchant_uid: 'order_' + new Date().getTime(),
        name: '주차 정산 요금',
        amount: totalFee
      }, function(rsp) {
        if (rsp.success) {
          alert('결제가 완료되었습니다.\n결제 금액: ' + rsp.paid_amount.toLocaleString() + '원');

          fetch('/park/payment', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({ impUid: rsp.imp_uid }),
          })
                  .then(response => response.text())
                  .then(data => {
                    alert(data);
                    // 결제 완료 후 모달 닫기
                    $('#parkingModal').removeClass('show');
                    setTimeout(() => {
                      $('#parkingModal').css('display', 'none');
                    }, 300);
                  })
                  .catch(error => console.error('결제 검증 중 오류:', error));
        } else {
          alert('결제에 성공하였습니다. \n' + '결제금액 : ' + totalFee);
        }
      });
    });
  });
</script>


































