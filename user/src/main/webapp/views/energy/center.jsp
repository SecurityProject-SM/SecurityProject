<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-11-06
  Time: 오전 11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  .energy-container {
    display: flex; /* Flexbox로 가로 배치 */
    align-items: flex-start; /* 위쪽 정렬 */
    margin-top: 200px;
    position: relative;
    width: 1200px;
    height: 630px;
    /*background-color: #11c;*/
  }
  .info-container {
    display: flex;
    flex-direction: column; /* 세로 배치 */
    margin-top: 10px; /* 주차 도면과 같은 높이 맞추기 */
    margin-left: 20px; /* 주차 도면과의 간격 조절 */
    /*background-color: white; !* 뒷 배경이 겹치는 것을 방지 *!*/
  }
  .totaldata-box {
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 10px;
    width: 400px;
    height: fit-content; /* 내용에 맞게 높이 조정 */
  }
  .iotlist-box{
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 10px;
    width: 400px;
    height: fit-content; /* 내용에 맞게 높이 조정 */
  }
  .academy-lot {
    position: relative;
    border-radius : 10px;
    margin-left: 30px;
    margin-top: 10px; /* 요소 전체를 아래로 이동 */
    width: 700px; /* 도면 이미지 너비 */
    height: 600px; /* 도면 이미지 높이 */
    background-image: url('<c:url value="/img/academy.jpg"/>');
    background-size: cover;
    overflow: hidden; /* 컨테이너 밖으로 삐져나오지 않도록 설정 */
  }
  /* 아이콘 애니메이션 정의 */
  @keyframes float {
    0% { transform: translateY(0); }
    50% { transform: translateY(-5px); } /* 위로 5px 이동 */
    100% { transform: translateY(0); }
  }
  .iot-aircon{
    position: absolute;
    width: 100px;  /* 에어컨 아이콘 크기 */
    height: 100px;
    background-image: url("<c:url value="/img/iot/aircon-off.png"/>");
    background-size: contain; /* 이미지 크기를 컨테이너에 맞춤 */
    background-repeat: no-repeat; /* 이미지 반복 방지 */
    background-position: center; /* 이미지 중앙 정렬 */

    /* 애니메이션 속성 추가 */
    animation: float 3s ease-in-out infinite; /* 3초 주기로 무한 반복 */
  }
  .iot-lamp{
    position: absolute;
    width: 100px;  /* 에어컨 아이콘 크기 */
    height: 100px;
    background-image: url("<c:url value="/img/iot/lamp-off.png"/>");
    background-size: contain; /* 이미지 크기를 컨테이너에 맞춤 */
    background-repeat: no-repeat; /* 이미지 반복 방지 */
    background-position: center; /* 이미지 중앙 정렬 */

    /* 애니메이션 속성 추가 */
    animation: float 3s ease-in-out infinite; /* 3초 주기로 무한 반복 */
  }
  #aircon1{top: 11px; left: 204px;}
  #aircon2{top: 21px; left: 611px;}
  #aircon3{top: 65px; left: 461px;}
  #aircon4{top: 345px; left: 461px;}
  #aircon5{top: 383px; left: 611px;}
  #aircon6{top: 474px; left: 345px;}
  #aircon7{top: 273px; left: -11px;}

  #lamp1{top: 120px; left: 90px;}
  #lamp2{top: 95px; left: 271px;}
  #lamp3{top: 2px; left: 500px;}
  #lamp4{top: 150px; left: 533px;}
  #lamp5{top: 310px; left: 533px;}
  #lamp6{top: 450px; left: 500px;}
  #lamp7{top: 400px; left: 290px;}
  #lamp8{top: 400px; left: 85px;}
</style>

<script>
  let energy = {
    intervalId: null, // 반복 통신을 위한 ID
    isPowerBoxActive: false, // 클릭 상태 확인 변수
    init:function() {
      // setInterval(this.fetchLatestData, 2000);
      this.startTotalPowerUpdate();
      $("#totalPowerBox").click(this.togglePowerData.bind(this)); // 총 전력량 박스 클릭 이벤트
    },
    startTotalPowerUpdate: function() {
      this.intervalIdForPower = setInterval(this.fetchTotalPower.bind(this), 2000);
    },


    togglePowerData: function() {
      // 클릭할 때마다 전력량 표시 시작/정지 전환
      if (this.isPowerBoxActive) {
        clearInterval(this.intervalId);
        this.isPowerBoxActive = false;
        $("#iotTableBody").empty(); // 테이블 비우기
      } else {
        this.isPowerBoxActive = true;
        this.intervalId = setInterval(this.fetchLatestData.bind(this), 2000);
      }
    },


    //전력량은 항상 표시
    fetchTotalPower: function() {
      $.ajax({
        url: "<c:url value='/iot/latestData'/>",
        type: "GET",
        success: function(data) {
          $("#totalPower").text(data.totalPower);
        },
        error: function() {
          console.error("총 전력량 데이터 불러오는 중 오류 발생");
        }
      });
    },

    fetchLatestData: function(){
      $.ajax({
        url: "<c:url value='/iot/latestData'/>",
        type: "GET",
        success: function(data){
          let tableBody = $("#iotTableBody");
          tableBody.empty();
          $.each(data.latestData.E, function(iotId, iotData){
            let row = "<tr>" +
                    "<td>" + iotId + "</td>" +
                    "<td>" + iotData.name + "</td>" +
                    "<td>" + iotData.value + " kWh</td>" +
                    "<td><button onclick='showControlBox(\"" + iotId + "\")'>제어</button></td>" +
                    "<td>-</td>" +
                    "</tr>";
            tableBody.append(row);
          });
        },
        error: function(){
          $("#iotDataDisplay").text("데이터를 불러오는 중 오류 발생");
        }
      });
    }
  };
  $(function(){
    energy.init();
  });
  function showControlBox(iotId) {
    alert(iotId + " 제어 박스 표시");  // 실제 제어 박스 기능 추가 예정
  }
  function filterIcons(type) {
    let airconIcons = document.querySelectorAll('.iot-aircon');
    let lampIcons = document.querySelectorAll('.iot-lamp');

    if (type === 'aircon') {
      airconIcons.forEach(icon => icon.style.display = 'block');
      lampIcons.forEach(icon => icon.style.display = 'none');
    } else if (type === 'lamp') {
      airconIcons.forEach(icon => icon.style.display = 'none');
      lampIcons.forEach(icon => icon.style.display = 'block');
    } else {
      airconIcons.forEach(icon => icon.style.display = 'block');
      lampIcons.forEach(icon => icon.style.display = 'block');
    }
  }
</script>

<div class="energy-container">
  <div class="academy-lot">
    <div class="iot-aircon" id="aircon1"></div>
    <div class="iot-aircon" id="aircon2"></div>
    <div class="iot-aircon" id="aircon3"></div>
    <div class="iot-aircon" id="aircon4"></div>
    <div class="iot-aircon" id="aircon5"></div>
    <div class="iot-aircon" id="aircon6"></div>
    <div class="iot-aircon" id="aircon7"></div>

    <div class="iot-lamp" id="lamp1"></div>
    <div class="iot-lamp" id="lamp2"></div>
    <div class="iot-lamp" id="lamp3"></div>
    <div class="iot-lamp" id="lamp4"></div>
    <div class="iot-lamp" id="lamp5"></div>
    <div class="iot-lamp" id="lamp6"></div>
    <div class="iot-lamp" id="lamp7"></div>
    <div class="iot-lamp" id="lamp8"></div>
  </div>
  <div class="info-container">
    <div class="totaldata-box" id="totalPowerBox">
      <h3>총 전력량 : <span id="totalPower"></span> kWh</h3>
      <button onclick="filterIcons('aircon')">총전력 (에어컨만 보기)</button>
    </div>
    <div class="totaldata-box" >
      <h3>평균 온도/습도 : <span id=></span> </h3>

    </div>
    <div class="totaldata-box" >
      <h3>조명 : <span id=></span> 개 켜짐</h3>
      <button onclick="filterIcons('lamp')">조명 (램프만 보기)</button>
    </div>
    <div class="totaldata-box">
      <button onclick="filterIcons('all')">전체 보기</button>
    </div>
  </div>
</div>
<%--<div class="info-container">--%>
<%--  <div class="iotlist-box ">--%>
<%--    <div id="iotPowerData">--%>
<%--      <h4>IoT 기기 전력량</h4>--%>
<%--      <ul id="iotList"></ul>--%>
<%--    &lt;%&ndash;  <h5>총 전력량 : <span id="totalPower"></span> kWh</h5>&ndash;%&gt;--%>
<%--    </div>--%>
<%--  </div>--%>
<%--</div>--%>
<div class="card mb-4">
  <div class="card-header pb-0">
    <h4>IoT 기기 전력량</h4>
  </div>
  <div class="card-body px-0 pt-0 pb-2">
    <div class="table-responsive p-0">
      <table class="table align-items-center justify-content-center mb-0">
        <thead>
        <tr>
          <th>IoT아이디</th>
          <th>이름</th>
          <th>사용전력</th>
          <th>제어</th>
          <th>상태</th>
        </tr>
        </thead>
        <tbody id="iotTableBody">
        </tbody>
      </table>
    </div>
  </div>

</div>
