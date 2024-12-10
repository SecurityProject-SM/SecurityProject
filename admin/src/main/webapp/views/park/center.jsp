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

    /*주차장 박스 시작*/
    #spot1 { top: 6px; left: 166px; }
    #spot1:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot2 { top: 6px; left: 261px; }
    #spot2:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot3 { top: 6px; left: 356px; }
    #spot3:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot4 { top: 6px; left: 450px; }
    #spot4:hover {
        opacity: 1;
        border: 5px solid yellow;
        cursor: pointer;
    }
    #spot5 { top: 6px; left: 545px; }
    #spot5:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot6 { top: 6px; left: 640px; }
    #spot6:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot7 { top: 195px; left: 215px; }
    #spot7:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot8 { top: 195px; left: 310px; }
    #spot8:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot9 { top: 195px; left: 404px; }
    #spot9:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot10 { top: 195px; left: 500px; }
    #spot10:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot11 { top: 195px; left: 595px; }
    #spot11:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot12 { top: 299px; left: 215px; }
    #spot12:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot13 { top: 299px; left: 310px; }
    #spot13:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot14 { top: 299px; left: 404px; }
    #spot14:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot15 { top: 299px; left: 499px; }
    #spot15:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot16 { top: 299px; left: 595px; }
    #spot16:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot17 { top: 496px; left: 168px; }
    #spot17:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot18 { top: 496px; left: 262px; }
    #spot18:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot19 { top: 496px; left: 357px; }
    #spot19:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot20 { top: 496px; left: 452px; }
    #spot20:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot21 { top: 496px; left: 547px; }
    #spot21:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot22 { top: 496px; left: 641px; }
    #spot22:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot23 { top: 303px; left: 7px; width: 97px; height: 89px; }
    #spot23:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    #spot24 { top: 398px; left: 7px; width: 97px; height: 89px; }
    #spot24:hover {
        opacity: 1;
        border: 4px solid yellow;
        cursor: pointer;
    }
    /*주차장 박스 끝*/
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
        position: relative;
        left: 121px;
        height: 57px;
        display: flex;
        align-items: stretch; /* 자식 요소들의 높이를 컨테이너에 맞춤 */
        gap: 2rem; /* 요소들 사이의 간격 */
        padding: 2rem;
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255, 255, 255, 0.05));
        border-radius: 15px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(4px);
        border: 1px solid rgba(255, 255, 255, 0.1);
        margin: 1rem;
        min-height: calc(100vh - 150px); /* 헤더 높이를 고려한 최소 높이 */
        transition: all 0.3s ease;
    }

    .park-container:hover {
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
        transform: translateY(-2px);
    }

    /* 반응형 디자인을 위한 미디어 쿼리 */
    @media (max-width: 1200px) {
        .park-container {
            flex-direction: column;
            align-items: center;
            gap: 1.5rem;
        }
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

    .popup-wrap {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        display: none;
        justify-content: center;
        align-items: center;
        z-index: 1000;
    }

    .popup-content {
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        width: 90%;
        max-width: 500px;
        overflow: hidden;
    }

    .popup-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1.25rem;
        background: #f8f9fa;
        border-bottom: 1px solid #edf2f7;
    }

    .popup-header h3 {
        margin: 0;
        font-size: 1.25rem;
        color: #1a202c;
        font-weight: 600;
    }

    .popup-close {
        background: none;
        border: none;
        padding: 0.5rem;
        cursor: pointer;
        color: #4a5568;
        transition: color 0.2s;
    }

    .popup-close:hover {
        color: #2d3748;
    }

    .popup-body {
        padding: 1.5rem;
    }

    .photo-container {
        position: relative;
        border-radius: 8px;
        overflow: hidden;
        background: #f7fafc;
        aspect-ratio: 16/9;
        margin-bottom: 1.5rem;
        height: 300px;
        left: -2px;
        width: 100%;
    }

    /* webcam 비디오 요소에 대한 스타일 추가 */
    .photo-container video,
    .photo-container .col-sm-8,
    .photo-container #myVideo {
        position: absolute;
        top: 15px;
        left: 36px;
        width: 100% ;
        height: 89% ;
        object-fit: cover;
    }
    .camera-overlay {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        border: 2px solid #4299e1;
        border-radius: 8px;
        pointer-events: none;
    }




    /* 팝업 버튼 스타일 시작*/
    .popup-controls {
        margin-bottom: 1.5rem;
        text-align: center;
    }
    .primary-button {
        background: #4299e1;
        color: white;
        border: none;
        padding: 0.75rem 1.5rem;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        transition: all 0.2s ease;
        position: relative;
        overflow: hidden;
        transform: translateY(0);
        box-shadow: 0 4px 6px rgba(66, 153, 225, 0.2);
    }

    /* 호버 효과 */
    .primary-button:hover {
        background: #3182ce;
        transform: translateY(-2px);
        box-shadow: 0 6px 8px rgba(66, 153, 225, 0.3);
    }

    /* 클릭 효과 */
    .primary-button:active {
        transform: translateY(1px);
        box-shadow: 0 2px 4px rgba(66, 153, 225, 0.2);
        background: #2c5282;
    }

    /* 버튼 아이콘 애니메이션 */
    .button-icon {
        font-size: 1.25rem;
        transition: transform 0.3s ease;
    }

    .primary-button:hover .button-icon {
        transform: scale(1.2);
    }

    /* 물결 효과 */
    .primary-button::after {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        width: 5px;
        height: 5px;
        background: rgba(255, 255, 255, 0.5);
        opacity: 0;
        border-radius: 100%;
        transform: scale(1, 1) translate(-50%);
        transform-origin: 50% 50%;
    }

    .primary-button:active::after {
        animation: ripple 0.4s ease-out;
    }

    @keyframes ripple {
        0% {
            transform: scale(0, 0);
            opacity: 0.5;
        }
        100% {
            transform: scale(50, 50);
            opacity: 0;
        }
    }

    /* 버튼 텍스트 애니메이션 */
    .button-text {
        transition: transform 0.2s ease;
    }

    .primary-button:hover .button-text {
        transform: scale(1.05);
    }

    /* 버튼 비활성화 상태 */
    .primary-button:disabled {
        background: #a0aec0;
        cursor: not-allowed;
        transform: none;
        box-shadow: none;
    }

    /* 버튼 로딩 상태 */
    .primary-button.loading {
        background: #2b6cb0;
        cursor: wait;
    }

    .primary-button.loading::before {
        content: '';
        width: 20px;
        height: 20px;
        border: 3px solid #ffffff;
        border-top: 3px solid transparent;
        border-radius: 50%;
        animation: button-loading-spinner 1s linear infinite;
    }

    @keyframes button-loading-spinner {
        from {
            transform: rotate(0turn);
        }
        to {
            transform: rotate(1turn);
        }
    }
    /*버튼 스타일 끝*/

    .info-grid {
        display: grid;
        gap: 1rem;
        background: #f8f9fa;
        padding: 1.25rem;
        border-radius: 8px;
    }

    .info-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .info-label {
        color: #4a5568;
        font-weight: 500;
    }

    .info-value {
        color: #1a202c;
        font-weight: 600;
    }

    @media (max-width: 640px) {
        .popup-content {
            width: 95%;
            margin: 1rem;
        }

        .popup-body {
            padding: 1rem;
        }

        .info-grid {
            padding: 1rem;
        }
    }
    /* 정보 패널 컨테이너 스타일 */
    .p-info {
        display: flex;
        flex-direction: column;
        margin-top: 10px;
        margin-left: 20px;
        gap: 20px;
    }

    /* 시간 패널 스타일 */
    .p-time-panel {
        background: white;
        padding: 2rem;
        border-radius: 12px;
        text-align: center;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        border: 1px solid #e2e8f0;
        width: 400px;
        height: fit-content;
        transition: transform 0.2s ease;
    }

    .p-time-panel:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.08);
    }

    .p-time-title {
        color: #2d3748;
        font-size: 1.25rem;
        font-weight: 600;
        margin-bottom: 1rem;
    }

    .p-time-day {
        color: #4a5568;
        font-size: 1.1rem;
        margin-bottom: 0.5rem;
    }

    .p-time-current {
        color: #2b6cb0;
        font-size: 2.5rem;
        font-weight: 700;
    }

    /* 현황판 패널 스타일 */
    .p-status-panel {
        background: white;
        padding: 2rem;
        border-radius: 12px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        border: 1px solid #e2e8f0;
        width: 400px;
        transition: transform 0.2s ease;
    }

    .p-status-panel:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.08);
    }

    .p-status-title {
        color: #2d3748;
        font-size: 1.25rem;
        font-weight: 600;
        text-align: center;
        margin-bottom: 1.5rem;
    }

    .p-status-info {
        display: grid;
        gap: 1rem;
    }

    .p-status-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1rem;
        background: #f7fafc;
        border-radius: 8px;
        transition: all 0.2s ease;
    }

    .p-status-row:hover {
        background: #edf2f7;
        transform: translateX(5px);
    }

    .p-status-label {
        color: #4a5568;
        font-weight: 500;
        font-size: 1.1rem;
    }

    .p-status-value {
        color: #2b6cb0;
        font-weight: 600;
        font-size: 1.25rem;
        padding: 0.5rem 1rem;
        background: rgba(66, 153, 225, 0.1);
        border-radius: 6px;
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

<body class="bg-theme bg-theme9">
<!-- 로딩 스피너 HTML 추가 -->
<div class="loading-wrap">
    <div class="loading-spinner"></div>
    <p>로딩 중입니다...</p>
</div>


<div class="content-wrapper">
    <h1 style="margin-left: 10px">주차장 관리</h1>
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
            <div class="p-info">
                <!-- 시간 표시 패널 -->
                <div class="p-time-panel">
                    <h4 class="p-time-title">현재 시각</h4>
                    <p class="p-time-day" id="cday">...</p>
                    <h1 class="p-time-current" id="ctime"></h1>
                </div>

                <!-- 현황판 패널 -->
                <div class="p-status-panel">
                    <h4 class="p-status-title">현황판</h4>
                    <div class="p-status-info">
                        <div class="p-status-row">
                            <span class="p-status-label">총주차칸</span>
                            <span class="p-status-value">24</span>
                        </div>
                        <div class="p-status-row">
                            <span class="p-status-label">주차가능</span>
                            <span class="p-status-value" id="availableCount">...</span>
                        </div>
                        <div class="p-status-row">
                            <span class="p-status-label">주차중</span>
                            <span class="p-status-value" id="parkingCount">...</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 팝업 창 -->
<div id="popup" class="popup-wrap">
    <div class="popup-content">
        <div class="popup-header">
            <h3>차량 감지 시스템</h3>
            <button class="popup-close" onclick="closePopup()" aria-label="닫기">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M18 6L6 18M6 6l12 12"/>
                </svg>
            </button>
        </div>
        <div class="popup-body">
            <div class="popup-photo">
                <div class="photo-container">
                    <jsp:include page="webcam.jsp" />
                    <div class="camera-overlay"></div>
                </div>
            </div>
            <div class="popup-controls">
                <button id="detect-button" class="primary-button" onclick="pic.takeSnapshotAndSend()">
                    <span class="button-icon">📸</span>
                    <span class="button-text">차량 감지</span>
                </button>
            </div>
            <div class="popup-info">
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">차종</span>
                        <span class="info-value" id="detected-car-type">감지된 차량</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">번호판</span>
                        <span class="info-value" id="detected-car-number">없음</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">입차시간</span>
                        <span class="info-value" id="detected-entry-time">없음</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>