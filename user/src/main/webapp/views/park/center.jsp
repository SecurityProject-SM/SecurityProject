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
    <a href="<c:url value="/park/parkset"/>" class="btn btn-light" role="button" style="text-align: center">정산하기</a>
    </div>
  </div>
  </div>
































