<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css">

<style>


    /* IoT 필터 버튼 스타일 */
    button.전체보기,
    button.조명만보기,
    button.에어컨만보기 {
        padding: 0.5rem 1rem;
        background-color: white;
        border: 1px solid #e5e7eb;
        border-radius: 0.375rem;
        font-size: 0.875rem;
        color: #4b5563;
        cursor: pointer;
        transition: all 0.15s ease;
        font-weight: 500;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        line-height: 1.25;
    }

    /* 호버 효과 */
    button.전체보기:hover,
    button.조명만보기:hover,
    button.에어컨만보기:hover {
        background-color: #f3f4f6;
        border-color: #d1d5db;
    }

    /* 클릭 효과 */
    button.전체보기:active,
    button.조명만보기:active,
    button.에어컨만보기:active {
        transform: translateY(1px);
    }

    /* 선택된 상태 (pressed) */
    button.전체보기.pressed,
    button.조명만보기.pressed,
    button.에어컨만보기.pressed {
        background-color: #f3f4f6;
        color: #090909;
        border-color: #f3f4f6;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
    }

    /* 선택된 상태의 호버 효과 */
    button.전체보기.pressed:hover,
    button.조명만보기.pressed:hover,
    button.에어컨만보기.pressed:hover {
        background-color: #f3f4f6;
        border-color: #f3f4f6;
    }

    /* 반응형 디자인 */
    @media (max-width: 640px) {
        .card-header {
            padding: 1rem;
        }

        button.전체보기,
        button.조명만보기,
        button.에어컨만보기 {
            padding: 0.375rem 0.75rem;
            font-size: 0.813rem;
        }
    }


    /* 주차현황 제목 스타일 개선 */
    .에너지현황 {
        font-size: 28px;
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 25px;
        position: relative;
        padding-left: 20px;
        letter-spacing: -0.5px;
    }
    .에너지현황::before {
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


    .userEnergy-container{
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
        flex-direction: column;
    }
    .energy-container {
        display: flex; /* Flexbox로 가로 배치 */
        align-items: flex-start; /* 위쪽 정렬 */
        margin-top: 10px;
        position: relative;
        width: 1200px;
        height: 630px;
        /*background-color: #11c;*/
    }



    .academy-lot {
        position: relative;
        border-radius: 10px;
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
        0% {
            transform: translateY(0);
        }
        50% {
            transform: translateY(-5px);
        }
        /* 위로 5px 이동 */
        100% {
            transform: translateY(0);
        }
    }

    .iot-aircon {
        position: absolute;
        width: 100px; /* 에어컨 아이콘 크기 */
        height: 100px;
        background-image: url("<c:url value="/img/iot/aircon-off3.png"/>");
        background-size: contain; /* 이미지 크기를 컨테이너에 맞춤 */
        background-repeat: no-repeat; /* 이미지 반복 방지 */
        background-position: center; /* 이미지 중앙 정렬 */

        /* 애니메이션 속성 추가 */
        animation: float 3s ease-in-out infinite; /* 3초 주기로 무한 반복 */
    }

    .iot-lamp {
        position: absolute;
        width: 100px; /* 에어컨 아이콘 크기 */
        height: 100px;
        background-image: url("<c:url value="/img/iot/lamp-off3.png"/>");
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


    #IOT1 {
        top: 11px;
        left: 204px;
    }

    #IOT2 {
        top: 21px;
        left: 611px;
    }

    #IOT3 {
        top: 65px;
        left: 461px;
    }

    #IOT4 {
        top: 345px;
        left: 461px;
    }

    #IOT5 {
        top: 383px;
        left: 611px;
    }

    #IOT6 {
        top: 474px;
        left: 345px;
    }

    #IOT7 {
        top: 273px;
        left: -11px;
    }

    #IOT8 {
        top: 120px;
        left: 90px;
    }

    #IOT9 {
        top: 95px;
        left: 271px;
    }

    #IOT10 {
        top: 2px;
        left: 500px;
    }

    #IOT11 {
        top: 150px;
        left: 533px;
    }

    #IOT12 {
        top: 310px;
        left: 533px;
    }

    #IOT13 {
        top: 450px;
        left: 500px;
    }

    #IOT14 {
        top: 400px;
        left: 290px;
    }

    #IOT15 {
        top: 400px;
        left: 85px;
    }

    /* 상태 박스 기본 스타일 */
    .status-box {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 10px;
        color: white;
        font-size: 12px;
        font-weight: bold;
        text-align: center;
        width: 80px; /* 일정한 너비로 통일 */
    }

    /* 상태별 색상 */
    .status-active {
        background-color: #28a745; /* 초록색 (작동중) */
    }

    .status-inactive {
        background-color: #6c757d; /* 회색 (정지) */
    }

    .status-error {
        background-color: #dc3545; /* 빨간색 (고장) */
    }

    .status-unknown {
        background-color: #ffc107; /* 노란색 (알 수 없음) */
    }


    .table-responsive {
        max-height: 500px; /* 필요한 높이로 설정 */
        overflow-y: auto; /* 수직 스크롤바 추가 */
        border: 1px solid #dee2e6; /* 테두리 추가 (선택 사항) */
        padding-right: 10px; /* 스크롤바 공간 확보 */
    }


    /* 제어 버튼 CSS */
    *, *:after, *:before {
        box-sizing: border-box;
    }

    section {
        float: left;
        min-width: 150px;
        width: 33.33%;
        padding: 25px 0;
        min-height: 100px;
    }

    /*=====================*/
    .checkbox {
        position: relative;
        display: inline-block;
    }

    .checkbox:after, .checkbox:before {
        font-family: FontAwesome;
        font-feature-settings: normal;
        -webkit-font-kerning: auto;
        font-kerning: auto;
        font-language-override: normal;
        font-stretch: normal;
        font-style: normal;
        font-synthesis: weight style;
        font-variant: normal;
        font-weight: normal;
        text-rendering: auto;
    }

    .checkbox label {
        width: 90px;
        height: 42px;
        background: #ccc;
        position: relative;
        display: inline-block;
        border-radius: 46px;
        /*transition: 0.4s;*/
    }

    .checkbox label:after {
        content: '';
        position: absolute;
        width: 50px;
        height: 50px;
        border-radius: 100%;
        left: 0;
        top: -5px;
        z-index: 2;
        background: #fff;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
        /*transition: 0.4s;*/
    }

    .checkbox input {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        z-index: 5;
        opacity: 0;
        cursor: pointer;
    }

    .checkbox input:hover + label:after {
        box-shadow: 0 2px 15px 0 rgba(0, 0, 0, 0.2), 0 3px 8px 0 rgba(0, 0, 0, 0.15);
    }

    .checkbox input:checked + label:after {
        left: 40px;
    }

    .model-13 .checkbox:after {
        content: 'OFF';
        font-family: Arial;
        position: absolute;
        color: #666;
        top: 12px;
        right: 15px;
    }

    .model-13 .checkbox label {
        background: none;
        border: 3px solid #777;
        height: 40px;
        border-radius: 20px;
    }

    .model-13 .checkbox label:after {
        content: 'ON';
        font-family: Arial;
        color: #fff;
        line-height: 28px;
        text-indent: 100px;
        background: #777;
        overflow: hidden;
        box-shadow: none;
        border-radius: 14px;
        transform: translateX(-50px);
        /*-moz-transition: all 0.4s 0.2s, width 0.2s linear, text-indent 0.4s linear;*/
        /*-o-transition: all 0.4s 0.2s, width 0.2s linear, text-indent 0.4s linear;*/
        /*-webkit-transition: all 0.4s, width 0.2s linear, text-indent 0.4s linear;*/
        /*-webkit-transition-delay: 0.2s, 0s, 0s;*/
        /*transition: all 0.4s 0.2s, width 0.2s linear, text-indent 0.4s linear;*/
        top: 3px;
        left: auto;
        right: 2px;
        width: 28px;
        height: 28px;
    }

    .model-13 .checkbox input:checked + label {
        border-color: #329043;
    }

    .model-13 .checkbox input:checked + label:after {
        background: #3fb454;
        left: auto;
        transform: translateX(0px);
        /*-moz-transition: all 0.4s, width 0.2s linear 0.4s, text-indent 0.3s linear 0.4s;*/
        /*-o-transition: all 0.4s, width 0.2s linear 0.4s, text-indent 0.3s linear 0.4s;*/
        /*-webkit-transition: all 0.4s, width 0.2s linear, text-indent 0.3s linear;*/
        /*-webkit-transition-delay: 0s, 0.4s, 0.4s;*/
        /*transition: all 0.4s, width 0.2s linear 0.4s, text-indent 0.3s linear 0.4s;*/
        width: 80px;
        text-indent: 0;
    }



    /* 컨테이너 스타일 */
    .data-container {
        display: flex;
        justify-content: space-around; /* 요소 간격 균등 */
        align-items: center;
        width: 1116px;
        margin-left: 30px;
        background-color: #ffff; /* 배경색 */
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
        font-family: Arial, sans-serif;
    }

    .data-box {
        flex: 1; /* 동일한 크기 */
        text-align: left; /* 중앙 정렬 */
        padding: 20px;
        margin: 0 10px;
        border-radius: 10px;
        background-color: #ffffff; /* 박스 배경 */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .data-box h5 {
        font-size: 18px;
        margin-bottom: 10px;
        color: #6c757d; /* 텍스트 색상 */
    }

    .data-box h3 {
        font-size: 28px;
        font-weight: bold;
        margin: 0;
        color: #343a40;
    }

    .data-box .icon {
        font-size: 24px;
        color: #6c757d;
    }

    .data-box .status {
        margin-top: 10px;
        font-size: 14px;
        color: #28a745; /* 상태 텍스트 색상 */
    }

</style>

<script>
    const imagePath = {
        airconOn: "<c:url value="/img/iot/aircon-on2.png"/>",
        airconOff: "<c:url value="/img/iot/aircon-off3.png"/>",
        airconBreak: "<c:url value="/img/iot/aircon-break.png"/>",
        lampOn: "<c:url value="/img/iot/lamp-on2.png"/>",
        lampOff: "<c:url value="/img/iot/lamp-off3.png"/>",
        lampBreak: "<c:url value="/img/iot/lamp-break.png"/>"
    };
    console.log("imagePath 객체:", imagePath);
    let currentFilter = 'all'; //현재 필터값을 위한 값
    let energy = {

        totalLights: 8, // 전체 조명 수

        intervalId: null, // 반복 통신을 위한 ID
        isPowerBoxActive: false, // 클릭 상태 확인 변수
        init: function () {
            console.log("energy.init 호출됨"); // init 함수 호출 확인
            this.fetchTotalPower();
            setInterval(this.fetchIotStatus, 3000);
            setInterval(this.fetchTotalPower, 3000);

            // DOM이 로드된 후 실행
            setTimeout(() => {
                const allButton = document.querySelector('.전체보기');
                if (allButton) {
                    allButton.classList.add('pressed');
                }
            }, 0);
        },



        // iot상태 불러와서 이미지 업데이트
        fetchIotStatus: function () {
            $.ajax({
                url: "/iot/getIotStatus",
                method: "GET",
                dataType: "json",
                success: function (data) {

                    let lightsOn = 0; // 켜진 조명의 갯수 초기화

                    data.forEach(function (iot) {
                        if (iot.deviceType === "LAMP" && iot.iotStatus === "1") {
                            lightsOn++; // 켜진 조명 카운트 증가
                        }

                        let element = document.getElementById(iot.iotId);
                        if (element) {

                            let deviceType = element.classList.contains('iot-aircon') ? 'aircon'
                                : element.classList.contains('iot-lamp') ? 'lamp' : 'gita';

                            // imagePath에서 URL 가져오기
                            // let imageUrl = iot.iotStatus ? imagePath[deviceType + "On"] : imagePath[deviceType + "Off"];
                            let imageUrl;
                            if (iot.iotStatus == "1") {
                                imageUrl = imagePath[deviceType + "On"]
                            } else if (iot.iotStatus == "2") {
                                imageUrl = imagePath[deviceType + "Off"]
                            } else if (iot.iotStatus == "3") {
                                imageUrl = imagePath[deviceType + "Break"]
                            }

                            // 아이콘의 배경 이미지 업데이트
                            element.style.backgroundImage = `url(\${imageUrl})`;
                        } else {
                            console.warn(`Element with id ${iot.iotId} not found.`);
                        }
                    });
                    // 켜진 조명 상태를 UI에 업데이트
                    $("#lightsOn").text(lightsOn); // 켜진 조명 갯수 업데이트
                },
                error: function (error) {
                    console.error("IoT 상태 불러오기 오류:", error);
                }
            });
        },

        //전력량은 항상 표시
        fetchTotalPower: function () {
            $.ajax({
                url: "<c:url value='/iot/latestData2'/>",
                type: "GET",
                success: function (data) {
                    console.log(data);
                    $("#totalPower").text(data.totalPower);
                    $("#avgTemp").text(data.avgData.avgTemperature);
                    $("#avgHumidity").text(data.avgData.avgHumidity);
                    // 최신 데이터 렌더링
                    energy.renderLatestData(data.latestData);
                },
                error: function () {
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

                let statusHtml = ""; // 상태 HTML 초기화

                // 상태에 따라 HTML 설정
                switch (iotData.status) {
                    case "1": // 작동 중
                        statusHtml = `<div class="status-box status-active">\${iotData.value} kW</div>`;
                        break;
                    case "2": // 정지
                        statusHtml = `<div class="status-box status-inactive">정지</div>`;
                        break;
                    case "3": // 고장
                        statusHtml = `<div class="status-box status-error">고장</div>`;
                        break;
                    default: // 알 수 없음
                        statusHtml = `<div class="status-box status-unknown">알 수 없음</div>`;
                        break;
                }
                // ON/OFF 스위치 상태 설정
                let isChecked = iotData.status === "1" ? "checked" : "";
                let isDisabled = iotData.status === "3" ? "disabled" : "";

                let row = `<tr>
<!--            <td>\${iotId}</td>-->
            <td class="iot-name"  style="text-align: center;">\${iotData.name}</td>
<!--            <td>\${iotData.value} kW</td>-->
            <td style="text-align: center;">\${statusHtml}</td>
            <td style="text-align: center;">
              <div class="model-13">
                <div class="checkbox">
                  <input type="checkbox" id="toggle-\${iotId}" \${isChecked} \${isDisabled}
                         onchange="energy.toggleIotStatus('\${iotId}', this.checked)">
<!--                  <label for="toggle-\${iotId}"></label>-->
                     <label for="toggle-\${iotId}"
                         data-iot-id="\${iotId}"
                         onmouseenter="highlightIcon('\${iotId}')"
                         onmouseleave="resetIcon('\${iotId}')"></label>
                </div>
              </div>
<!--              <button-->
<!--                  class="control-button"-->
<!--                  data-iot-id="\${iotId}"-->
<!--                  onclick='energy.toggleIotStatus("\${iotId}", "\${iotData.status}")'>-->
<!--                  제어-->
<!--              </button>-->

            </td>

        </tr>`;
                tableBody.append(row);
            });
            // 필터 상태에 따라 테이블 필터링 재적용
            filterTable(currentFilter);
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
                data: JSON.stringify({iotId}),
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

    // function showControlBox(iotId) {
    //   alert(iotId + " 제어 박스 표시");  // 실제 제어 박스 기능 추가 예정
    // }
    function filterIcons(type) {
        currentFilter = type;

        // 모든 버튼에서 pressed 클래스 제거
        document.querySelector('.전체보기').classList.remove('pressed');
        document.querySelector('.조명만보기').classList.remove('pressed');
        document.querySelector('.에어컨만보기').classList.remove('pressed');

        // 클릭된 버튼에만 pressed 클래스 추가
        if (type === 'all') {
            document.querySelector('.전체보기').classList.add('pressed');
        } else if (type === 'lamp') {
            document.querySelector('.조명만보기').classList.add('pressed');
        } else if (type === 'aircon') {
            document.querySelector('.에어컨만보기').classList.add('pressed');
        }

        // 기존 아이콘 필터링 로직
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

        // 테이블 필터링
        filterTable(type);
    }

    function filterTable(type) {

        let tableRows = document.querySelectorAll('#iotTableBody tr');

        tableRows.forEach(row => {
            let deviceNameCell = row.querySelector('.iot-name'); // 기기 이름 가져오기

            if (!deviceNameCell) {
                console.warn('Device name cell not found in row:', row);
                return; // 요소가 없으면 해당 행 건너뜀
            }
            let deviceName = deviceNameCell.textContent.trim(); // 기기 이름 가져오기


            if (type === 'aircon') {
                // "에어컨"만 표시
                row.style.display = deviceName.includes('에어컨') ? 'table-row' : 'none';
            } else if (type === 'lamp') {
                // "조명"만 표시
                row.style.display = deviceName.includes('조명') ? 'table-row' : 'none';
            } else {
                // 전체 표시
                row.style.display = 'table-row';
            }
        });

    }


    function highlightIcon(iotId) {
        const iconElement = document.getElementById(iotId); // 아이콘 요소 선택
        if (iconElement) {
            console.log(`아이콘 확대: \${iotId}`);
            iconElement.classList.add('iot-icon-hover'); // 아이콘 확대 클래스 추가
        } else {
            console.warn(`아이콘 요소를 찾을 수 없습니다: \${iotId}`);
        }
    }

    function resetIcon(iotId) {
        const iconElement = document.getElementById(iotId); // 아이콘 요소 선택
        if (iconElement) {
            iconElement.classList.remove('iot-icon-hover'); // 아이콘 확대 클래스 제거
        }
    }
    $(function () {
        energy.init();
    });
</script>
<div class="userEnergy-container">
    <h2 class="에너지현황">에너지 현황</h2>
    <div class="data-container">
        <!-- 전력량 박스 -->
        <div class="data-box">
            <h5>총 전력량 <i class="icon fa fa-bolt"></i></h5>
            <h3><span id="totalPower"></span> kW</h3>
        </div>

        <!-- 온도/습도 박스 -->
        <div class="data-box">
            <h5>평균 온도/습도</h5>
            <h3><span id="avgTemp"></span>°C <span id="avgHumidity" style="margin-left: 20px"></span>%</h3>
        </div>

        <!-- 조명 상태 박스 -->
        <div class="data-box">
            <h5>조명 상태</h5>
            <h3><span id="lightsOn"></span> / 8</h3>
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
        <div class="card mb-4" style="margin-left: 32px">

            <div class="card-header pb-0">
                <h4>IoT 기기 전력량</h4>
                <button class="전체보기" onclick="filterIcons('all')" style="margin-right: 10px">전체 보기</button>
                <button class="조명만보기" onclick="filterIcons('lamp')" style="margin-right: 10px">조명만 보기</button>
                <button class="에어컨만보기" onclick="filterIcons('aircon')">에어컨만 보기</button>

            </div>
            <div class="card-body px-0 pt-0 pb-2">
                <div class="table-responsive p-0">
                    <table class="table align-items-center justify-content-center mb-0">
                        <thead>
                        <tr>
                            <%--            <th>IoT아이디</th>--%>
                            <th style="text-align: center;">이름</th>
                            <%--            <th>사용전력</th>--%>
                            <th style="text-align: center;">상태</th>
                            <th style="text-align: center;">제어</th>
                        </tr>
                        </thead>
                        <tbody id="iotTableBody">
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>