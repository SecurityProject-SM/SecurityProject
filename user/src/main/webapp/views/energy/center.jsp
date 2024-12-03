<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  .energy-container {
    display: flex; /* Flexbox로 가로 배치 */
    align-items: flex-start; /* 위쪽 정렬 */
    margin-top: 10px;
    position: relative;
    width: 1500px;
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

  /*고장일때 row 강조*/
  .tr-break {
    background-color: #f8d7da; /* 연한 빨간색 */
    color: #721c24; /* 진한 빨간색 텍스트 */
  }


  /* 제어버튼 올리면 해당하는 기기가 확대됨 */
  /* 기본 상태 */
  .iot-icon {
    transition: transform 0.3s ease; /* 부드럽게 확대 효과 */
  }

  /* 마우스가 올라갔을 때 */
  .iot-icon-hover {
    transform: scale(1.5); /* 1.5배 확대 */
  }


  #IOT1{top: 11px; left: 204px;}
  #IOT2{top: 21px; left: 611px;}
  #IOT3{top: 65px; left: 461px;}
  #IOT4{top: 345px; left: 461px;}
  #IOT5{top: 383px; left: 611px;}
  #IOT6{top: 474px; left: 345px;}
  #IOT7{top: 273px; left: -11px;}

  #IOT8{top: 120px; left: 90px;}
  #IOT9{top: 95px; left: 271px;}
  #IOT10{top: 2px; left: 500px;}
  #IOT11{top: 150px; left: 533px;}
  #IOT12{top: 310px; left: 533px;}
  #IOT13{top: 450px; left: 500px;}
  #IOT14{top: 400px; left: 290px;}
  #IOT15{top: 400px; left: 85px;}
</style>

<script>
  const imagePath = {
    airconOn: "<c:url value="/img/iot/aircon-on.png"/>",
    airconOff: "<c:url value="/img/iot/aircon-off.png"/>",
    airconBreak: "<c:url value="/img/iot/aircon-break.png"/>",
    lampOn: "<c:url value="/img/iot/lamp-on.png"/>",
    lampOff: "<c:url value="/img/iot/lamp-off.png"/>",
    lampBreak: "<c:url value="/img/iot/lamp-break.png"/>"
  };
  console.log("imagePath 객체:", imagePath);
  let energy = {

    intervalId: null, // 반복 통신을 위한 ID
    isPowerBoxActive: false, // 클릭 상태 확인 변수
    init:function() {
      console.log("energy.init 호출됨"); // init 함수 호출 확인
      this.fetchTotalPower();
      setInterval(this.fetchIotStatus, 3000);
      setInterval(this.fetchTotalPower,3000);
    },


    // iot상태 불러와서 이미지 업데이트
    fetchIotStatus: function () {
      $.ajax({
        url: "/iot/getIotStatus",
        method: "GET",
        dataType: "json",
        success: function (data) {

          data.forEach(function (iot) {
            let element = document.getElementById(iot.iotId);

            if (element) {

              let deviceType = element.classList.contains('iot-aircon') ? 'aircon'
                      : element.classList.contains('iot-lamp') ? 'lamp' : 'gita';

              // imagePath에서 URL 가져오기
              // let imageUrl = iot.iotStatus ? imagePath[deviceType + "On"] : imagePath[deviceType + "Off"];
              let imageUrl;
              if(iot.iotStatus == "1"){
                imageUrl = imagePath[deviceType + "On"]
              }else if(iot.iotStatus == "2"){
                imageUrl = imagePath[deviceType + "Off"]
              }else if(iot.iotStatus == "3"){
                imageUrl = imagePath[deviceType + "Break"]
              }

              // 아이콘의 배경 이미지 업데이트
              element.style.backgroundImage = `url(\${imageUrl})`;
            } else {
              console.warn(`Element with id ${iot.iotId} not found.`);
            }
          });
        },
        error: function (error) {
          console.error("IoT 상태 불러오기 오류:", error);
        }
      });
    },

    //전력량은 항상 표시
    fetchTotalPower: function() {
      $.ajax({
        url: "<c:url value='/iot/latestData2'/>",
        type: "GET",
        success: function(data) {
          console.log(data);
          $("#totalPower").text(data.totalPower);
          $("#avgTemp").text(data.avgData.avgTemperature);
          $("#avgHumidity").text(data.avgData.avgHumidity);
          // 최신 데이터 렌더링
          energy.renderLatestData(data.latestData);
        },
        error: function() {
          console.error("총 전력량 데이터 불러오는 중 오류 발생");
        }
      });
    },
    renderLatestData: function (latestData) {
      let tableBody = $("#iotTableBody");
      tableBody.empty();

      // 전력량 데이터만 테이블에 렌더링
      Object.keys(latestData.E).forEach(iotId => {
        let iotData = latestData.E[iotId];
        let statusText = ""; // 상태 텍스트 초기화

        // 상태에 따라 텍스트 설정
        switch (iotData.status) {
          case "1":
            statusText = "작동중";
            rowClass = ""; // 기본 상태
            break;
          case "2":
            statusText = "정지";
            rowClass = ""; // 기본 상태
            break;
          case "3":
            statusText = "고장";
            rowClass = "tr-break"; // 고장 상태일 경우 클래스 추가
            break;
          default:
            statusText = "알 수 없음";
            rowClass = ""; // 기본 상태
            break;
        }

        let row = `<tr class="\${rowClass}">
                <td>\${iotId}</td>
                <td>\${iotData.name}</td>
                <td>\${iotData.value} kW</td>
<!--                <td><button onclick='showControlBox("\${iotId}")'>제어</button></td>-->
<!--                <td><button onclick='energy.toggleIotStatus("\${iotId}", "\${iotData.status}")'>제어</button></td>-->
                <td>
                  <button
                      class="control-button"
                      data-iot-id="\${iotId}"
                      onclick='energy.toggleIotStatus("\${iotId}", "\${iotData.status}")'>
                      제어
                  </button>
                </td>
                <td>\${statusText}</td>
            </tr>`;
        tableBody.append(row);
      });
    },
    toggleIotStatus: function (iotId, currentStatus) {
      // 고장 상태인 경우 경고창 표시
      if (currentStatus === "3") {
        alert("고장 상태는 제어할 수 없습니다.");
        return;
      }

      // 상태 변경 요청
      let newStatus = currentStatus === "1" ? "2" : "1"; // 1 -> 2, 2 -> 1
      $.ajax({
        url: "/iot/updateStatus",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({ iotId }),
        success: function (response) {
          alert(response); // 상태 변경 성공 메시지
          // energy.renderLatestData(); // 상태 변경 후 최신 데이터 다시 로드

          // 최신 데이터를 즉시 불러옴
          energy.fetchIotStatus(); // 상태 데이터 갱신
          energy.fetchTotalPower(); // 전력량 데이터 갱신
        },
        error: function (xhr) {
          if (xhr.status === 403) {
            alert(xhr.responseText); // 고장 상태 메시지
          } else {
            alert("IoT 상태 변경 중 오류가 발생했습니다.");
          }
        }
      });
    }
  };
  $(function(){
    energy.init();

    // 제어 버튼에 마우스 이벤트 추가
    $(document).on("mouseenter", ".control-button", function () {
      const iotId = $(this).data("iot-id"); // 버튼의 data-iot-id 속성으로 아이콘 ID 가져오기
      const iotIcon = $(`#${iotId}`); // 평면도에서 해당 아이콘 선택
      iotIcon.addClass("iot-icon-hover"); // 확대 효과 클래스 추가
    });

    $(document).on("mouseleave", ".control-button", function () {
      const iotId = $(this).data("iot-id");
      const iotIcon = $(`#${iotId}`);
      iotIcon.removeClass("iot-icon-hover"); // 확대 효과 클래스 제거
    });
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
<div class="row" style="margin-top: 200px">
  <div class="totaldata-box" id="totalPowerBox">
    <h3>총 전력량 : <span id="totalPower"></span> kW</h3>
    <button onclick="filterIcons('aircon')">총전력 (에어컨만 보기)</button>
  </div>
  <div class="totaldata-box" >
    <h3>평균 온도/습도 : <span id="avgTemp"></span> / <span id="avgHumidity"></span> </h3>

  </div>
  <div class="totaldata-box" >
    <h3>조명 : <span id=></span> 개 켜짐</h3>
    <button onclick="filterIcons('lamp')">조명 (램프만 보기)</button>
  </div>
  <div class="totaldata-box">
    <button onclick="filterIcons('all')">전체 보기</button>
  </div>
</div>
<div class="energy-container">
  <div class="academy-lot">
    <%--    에어컨  --%>
    <div class="iot-aircon" id="IOT1"></div>
    <div class="iot-aircon" id="IOT2"></div>
    <div class="iot-aircon" id="IOT3"></div>
    <div class="iot-aircon" id="IOT4"></div>
    <div class="iot-aircon" id="IOT5"></div>
    <div class="iot-aircon" id="IOT6"></div>
    <div class="iot-aircon" id="IOT7"></div>

    <%--    조명 --%>
    <div class="iot-lamp" id="IOT8"></div>
    <div class="iot-lamp" id="IOT9"></div>
    <div class="iot-lamp" id="IOT10"></div>
    <div class="iot-lamp" id="IOT11"></div>
    <div class="iot-lamp" id="IOT12"></div>
    <div class="iot-lamp" id="IOT13"></div>
    <div class="iot-lamp" id="IOT14"></div>
    <div class="iot-lamp" id="IOT15"></div>
  </div>
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
</div>