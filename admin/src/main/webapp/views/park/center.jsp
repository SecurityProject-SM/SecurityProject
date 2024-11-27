<%--
  User: 1
  Date: 2024-11-18
  Time: 오후 1:38
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
</head>

<style>
    /* 로딩 스피너 스타일 추가 */
    .loading-wrap {
        display: none; /* 처음에는 숨김 */
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.2);
        z-index: 9999;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
    }

    .loading-spinner {
        width: 40px;
        height: 40px;
        border: 5px solid #3498db;
        border-top: 5px solid transparent;
        border-radius: 50%;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        from { transform: rotate(0deg); }
        to { transform: rotate(360deg); }
    }
    /* 로딩 스피너 스타일 끝 */


    .park-container {
        display: flex; /* Flexbox로 가로 배치 */
        align-items: flex-start; /* 위쪽 정렬 */
        /*margin-top: 200px;*/
        position: relative;
    }

    .parking-lot {
        position: relative;
        border-radius : 10px;
        margin-left: 30px;
        margin-top: 10px; /* 요소 전체를 아래로 이동 */
        width: 799px; /* 도면 이미지 너비 */
        height: 600px; /* 도면 이미지 높이 */
        background-image: url('<c:url value="/img/park/parkimg.png"/>');
        background-size: cover;
        overflow: hidden; /* 컨테이너 밖으로 삐져나오지 않도록 설정 */
    }

    .parking-spot {
        position: absolute;
        width: 90px;  /* 각 주차 공간의 크기 */
        height: 98px;
        opacity: 0.5;
        transition: all 1s ease; /* 마우스 효과 부드러운 전환 */
    }
    .info-container {
        display: flex;
        flex-direction: column; /* 세로 배치 */
        margin-top: 10px; /* 주차 도면과 같은 높이 맞추기 */
        margin-left: 20px; /* 주차 도면과의 간격 조절 */
        /*background-color: white; !* 뒷 배경이 겹치는 것을 방지 *!*/
    }

    .time-box, .status-box {
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 10px;
        width: 400px;
        height: fit-content; /* 내용에 맞게 높이 조정 */
    }

    .time-box{
        align-items: center; /* 수평 중앙 정렬 */
        justify-content: center; /* 수직 중앙 정렬 */
        text-align: center; /* 텍스트 중앙 정렬 */
    }
    .status-box {
        margin-top: 20px; /* 시간 박스와의 간격 */

    }

    .oldspot {
        /*#spot1 { top: 8px; left: 173px; background-color: green; }*/
        /*#spot2 { top: 8px; left: 268px; background-color: green; }*/
        /*#spot3 { top: 8px; left: 363px; background-color: green; }*/
        /*#spot4 { top: 8px; left: 457px; background-color: green; }*/
        /*#spot5 { top: 8px; left: 552px; background-color: green; }*/
        /*#spot6 { top: 8px; left: 646px; background-color: green; }*/

        /*#spot7 { top: 199px; left: 224px; background-color: green; }*/
        /*#spot8 { top: 199px; left: 319px; background-color: green; }*/
        /*#spot9 { top: 199px; left: 413px; background-color: green; }*/
        /*#spot10 { top: 199px; left: 507px; background-color: green; }*/
        /*#spot11 { top: 199px; left: 603px; background-color: green; }*/

        /*#spot12 { top: 302px; left: 224px; background-color: green; }*/
        /*#spot13 { top: 302px; left: 319px; background-color: green; }*/
        /*#spot14 { top: 302px; left: 413px; background-color: green; }*/
        /*#spot15 { top: 302px; left: 507px; background-color: green; }*/
        /*#spot16 { top: 302px; left: 603px; background-color: green; }*/

        /*#spot17 { top: 496px; left: 173px; background-color: green; }*/
        /*#spot18 { top: 496px; left: 267px; background-color: green; }*/
        /*#spot19 { top: 496px; left: 362px; background-color: green; }*/
        /*#spot20 { top: 496px; left: 457px; background-color: green; }*/
        /*#spot21 { top: 496px; left: 552px; background-color: green; }*/
        /*#spot22 { top: 496px; left: 646px; background-color: green; }*/

        /*#spot23 { top: 305px; left: 15px; width: 97px; height: 89px; background-color: green; }*/
        /*#spot24 { top: 400px; left: 15px; width: 97px; height: 89px; background-color: green; }*/
    }
    #spot1 { top: 8px; left: 173px; background-color: green; }
    #spot1:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot2 { top: 8px; left: 268px; background-color: green; }
    #spot2:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot3 { top: 8px; left: 363px; background-color: green; }
    #spot3:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot4 { top: 8px; left: 457px; background-color: green; }
    #spot4:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot5 { top: 8px; left: 552px; background-color: green; }
    #spot5:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot6 { top: 8px; left: 646px; background-color: green; }
    #spot6:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot7 { top: 199px; left: 224px; background-color: green; }
    #spot7:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot8 { top: 199px; left: 319px; background-color: green; }
    #spot8:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot9 { top: 199px; left: 413px; background-color: green; }
    #spot9:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot10 { top: 199px; left: 507px; background-color: green; }
    #spot10:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot11 { top: 199px; left: 603px; background-color: green; }
    #spot11:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot12 { top: 302px; left: 224px; background-color: green; }
    #spot12:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot13 { top: 302px; left: 319px; background-color: green; }
    #spot13:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot14 { top: 302px; left: 413px; background-color: green; }
    #spot14:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot15 { top: 302px; left: 507px; background-color: green; }
    #spot15:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot16 { top: 302px; left: 603px; background-color: green; }
    #spot16:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot17 { top: 496px; left: 173px; background-color: green; }
    #spot17:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot18 { top: 496px; left: 267px; background-color: green; }
    #spot18:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot19 { top: 496px; left: 362px; background-color: green; }
    #spot19:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot20 { top: 496px; left: 457px; background-color: green; }
    #spot20:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot21 { top: 496px; left: 552px; background-color: green; }
    #spot21:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot22 { top: 496px; left: 646px; background-color: green; }
    #spot22:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot23 { top: 305px; left: 15px; width: 97px; height: 89px; background-color: green; }
    #spot23:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }

    #spot24 { top: 400px; left: 15px; width: 97px; height: 89px; background-color: green; }
    #spot24:hover {
        opacity: 1;
        border: 2px solid yellow;
        background-color: orange;
        cursor: pointer;
    }


    .popup-wrap {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        display: none;
        justify-content: center;
        align-items: center;
    }

    .popup-content {
        background: white;
        border-radius: 10px;
        padding: 20px;
        width: 400px;
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .popup-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .popup-header h3 {
        margin: 0;
        color: black;
    }

    .popup-close {
        background: transparent;
        border: none;
        font-size: 20px;
        cursor: pointer;
    }

    .popup-photo {
        display: flex;
        justify-content: center;
        align-items: center;
        border: 1px dashed #ccc;
        height: 150px;
    }

    .popup-detect {
        text-align: center;
    }

    #detect-button {
        padding: 10px 20px;
        background-color: #3498db;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .popup-info {
        display: flex;
        flex-direction: column;
        gap: 10px;
        color: black;
    }

</style>

<script>
    let park = {
        loadingShown: false, // 로딩이 처음 한 번만 나타나도록 제어하는 플래그
        init: function () {
            // this.init();  // 초기 로드
            setInterval(this.parkstat, 1000);  // 5초마다 상태 갱신
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
                        if (spotElement) {
                            spotElement.style.backgroundColor = park.parkStat ? "green" : "red";
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
        },

    };

    $(function(){
        park.init();
        // spot7 클릭 이벤트
        document.getElementById("spot7").addEventListener("click", openPopup);
    });
    function openPopup() {
        document.getElementById("popup").style.display = "flex";
    }

    function closePopup() {
        document.getElementById("popup").style.display = "none";
    }
</script>

<body class="bg-theme bg-theme1">
<!-- 로딩 스피너 HTML 추가 -->
<div class="loading-wrap">
    <div class="loading-spinner"></div>
    <p>로딩 중입니다...</p>
</div>

<div class="content-wrapper">
    <div class="row mt-3">
        <div class="park-container">
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

            <!-- 주차장 도면 오른쪽에 시간 및 현황판 배치 -->
            <div class="info-container">
                <div class="time-box">
                    <h4>현재 시각</h4>
                    <h4 id="cday">...</h4>
                    <h1 id="ctime"></h1>
                </div>
                <div class="status-box">
                    <h4 style="align-items: center;justify-content: center; text-align: center; ">현황판</h4>
                    <h3>총주차칸 : 24</h3>
                    <h3 style="float:left">주차가능 : </h3>
                    <h3 id="availableCount">...</h3>
                    <h3 style="float:left">주차중 :</h3>
                    <h3 id="parkingCount">...</h3>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 팝업 창 -->
<div id="popup" class="popup-wrap">
    <div class="popup-content">
        <div class="popup-header">
            <h3>차량 감지</h3>
            <button class="popup-close" onclick="closePopup()">×</button>
        </div>
        <div class="popup-body">
            <div class="popup-photo">
                <div class="photo-placeholder"><jsp:include page="webcam.jsp" /></div>
            </div>
            <div class="popup-detect">
                <button id="detect-button" onclick="pic.takeSnapshotAndSend()">감지</button>
<%--                <button id="detect-button" onclick="pic.takeSnapshot()">감지</button>--%>
<%--                <button onclick="pic.send()">전송</button>--%>
            </div>
            <div class="popup-info">
                <div><strong>라벨:</strong> 감지된 차량</div>
                <div><strong>차량번호:</strong> <span id="detected-car-number">없음</span></div>
                <div><strong>입차시간:</strong> <span id="detected-entry-time">없음</span></div>
            </div>
        </div>
    </div>
</div>

</body>
</html>