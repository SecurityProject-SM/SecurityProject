<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--  <title>Canvas Example</title>--%>
<%--  <style>--%>
<%--    canvas {--%>
<%--      border: 1px solid #ddd; /* Canvas 테두리 (테스트용) */--%>
<%--    }--%>
<%--  </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="content-wrapper">--%>
<%--  <canvas id="canvas" width="200" height="100"></canvas>--%>
<%--</div>--%>
<%--<script>--%>
<%--  const canvas = document.getElementById('canvas');--%>
<%--  const ctx = canvas.getContext('2d');--%>
<%--  const img = new Image();--%>

<%--  const powerUsage = 70; // 전력량 예시--%>
<%--  let color = 'rgba(1, 65, 0, 0.5)'; // 기본 색상--%>

<%--  // 전력량에 따라 색상 동적 변경--%>
<%--  if (powerUsage > 80) {--%>
<%--    color = 'rgba(255, 0, 0, 0.5)'; // 빨간색--%>
<%--  } else if (powerUsage > 50) {--%>
<%--    color = 'rgba(255, 5 , 0, 0.5)'; // 노란색--%>
<%--  }--%>

<%--  img.src = '<c:url value="/img/building/left5f.png"/>'; // 이미지 경로--%>
<%--  img.onload = () => {--%>
<%--    ctx.drawImage(img, 0, 0, canvas.width, canvas.height);--%>

<%--    // 도형 위에 색상 필터 적용--%>
<%--    ctx.globalCompositeOperation = 'source-in';--%>
<%--    ctx.fillStyle = color;--%>
<%--    ctx.fillRect(0, 0, canvas.width, canvas.height);--%>
<%--  };--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>






<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Building Floor Overlay</title>
  <style>
    canvas {
      /*border: 1px solid #ddd; !* 테스트용 테두리 *!*/

    }
  </style>
</head>
<body>
<div class="content-wrapper">
  <canvas id="buildingCanvas" width="800" height="600"></canvas> <!-- 건물 전체 캔버스 -->
</div>

<script>
  const canvas = document.getElementById('buildingCanvas');
  const ctx = canvas.getContext('2d');

  // 건물 배경 이미지
  const buildingImg = new Image();
  buildingImg.src = '<c:url value="/img/building/image.png"/>'; // 건물 이미지 경로

  // 각 층 이미지 정보
  const floors = [
    { src: '<c:url value="/img/building/left5f.png"/>', x: 82, y: 25, width: 395, height: 190 ,opacity: 0.8 ,floorPlan: '<c:url value="/img/building/floor5f.jpg"/>',img: new Image()},
    { src: '<c:url value="/img/building/right5f.png"/>', x: 520, y: 123, width: 210, height: 125 ,opacity: 0.8 ,floorPlan: '<c:url value="/img/building/floor5f.jpg"/>',img: new Image()},

    { src: '<c:url value="/img/building/left4f.png"/>', x: 75, y: 114, width: 400, height: 160 ,opacity: 0.8,img: new Image()},
    { src: '<c:url value="/img/building/right4f.png"/>', x: 518, y: 192, width: 213, height: 106 ,opacity: 0.8 ,img: new Image()},

    { src: '<c:url value="/img/building/left3f.png"/>', x: 68, y: 190, width: 405, height: 148 ,opacity: 0.8 ,img: new Image()},
    { src: '<c:url value="/img/building/right3f.png"/>', x: 518, y: 251, width: 215, height: 96 ,opacity: 0.8 ,img: new Image()},

    { src: '<c:url value="/img/building/left2f.png"/>', x: 61, y: 271, width: 411, height: 131 ,opacity: 0.8 ,img: new Image()},
    { src: '<c:url value="/img/building/right2f.png"/>', x: 518, y: 307, width: 219, height: 92 ,opacity: 0.8 ,img: new Image()},

    { src: '<c:url value="/img/building/left1f.png"/>', x: 52, y: 352, width: 420, height: 117 ,opacity: 0.8 ,img: new Image() },
    { src: '<c:url value="/img/building/right1f.png"/>', x: 519, y: 367, width: 220, height: 86 ,opacity: 0.8,img: new Image() }
  ];


  // // 이미지 로드 후 그리기
  // buildingImg.onload = () => {
  //   ctx.drawImage(buildingImg, 0, 0, canvas.width, canvas.height);
  //
  //   // 각 층 이미지를 순차적으로 그리기
  //   floors.forEach(floor => {
  //     const floorImg = new Image();
  //     floorImg.src = floor.src;
  //
  //     floorImg.onload = () => {
  //       ctx.globalAlpha = floor.opacity; // 층별 투명도 적용
  //       ctx.drawImage(floorImg, floor.x, floor.y, floor.width, floor.height);
  //       // 투명도 초기화 (다음 그리기에 영향을 주지 않도록)
  //       ctx.globalAlpha = 1.0;
  //     };
  //   });
  // };
  //
  // function showFloorPlan(floorPlanSrc) {
  //   const floorPlanImg = new Image();
  //   floorPlanImg.src = floorPlanSrc;
  //
  //   // 평면도 이미지 로드 후 애니메이션 실행
  //   floorPlanImg.onload = () => {
  //     let opacity = 1;
  //
  //     // 페이드아웃 효과
  //     const fadeOut = setInterval(() => {
  //       opacity -= 0.05;
  //       ctx.clearRect(0, 0, canvas.width, canvas.height);
  //       ctx.globalAlpha = opacity;
  //       ctx.drawImage(buildingImg, 0, 0, canvas.width, canvas.height);
  //
  //       if (opacity <= 0) {
  //         clearInterval(fadeOut);
  //         ctx.globalAlpha = 1.0; // 투명도 초기화
  //
  //         // 평면도 페이드인 효과
  //         let fadeInOpacity = 0;
  //         const fadeIn = setInterval(() => {
  //           fadeInOpacity += 0.05;
  //           ctx.clearRect(0, 0, canvas.width, canvas.height);
  //           ctx.globalAlpha = fadeInOpacity;
  //           ctx.drawImage(floorPlanImg, 0, 0, canvas.width, canvas.height);
  //
  //           if (fadeInOpacity >= 1) {
  //             clearInterval(fadeIn);
  //             ctx.globalAlpha = 1.0; // 투명도 초기화
  //           }
  //         }, 30); // 페이드인 속도
  //       }
  //     }, 30); // 페이드아웃 속도
  //   };
  //
  //   // 이미지 로드 실패 시 오류 처리
  //   floorPlanImg.onerror = () => {
  //     console.error('Failed to load floor plan image:', floorPlanSrc);
  //   };
  // }
  //
  // // 클릭 이벤트 처리
  // canvas.addEventListener('click', event => {
  //   const rect = canvas.getBoundingClientRect();
  //   const clickX = event.clientX - rect.left; // 캔버스 내 클릭 X 좌표
  //   const clickY = event.clientY - rect.top;  // 캔버스 내 클릭 Y 좌표
  //
  //   // 클릭한 영역이 어느 층인지 확인
  //   const clickedFloor = floors.find(floor =>
  //           clickX >= floor.x &&
  //           clickX <= floor.x + floor.width &&
  //           clickY >= floor.y &&
  //           clickY <= floor.y + floor.height
  //   );
  //
  //   if (clickedFloor) {
  //     // 클릭한 층의 평면도로 전환
  //     showFloorPlan(clickedFloor.floorPlan);
  //     // showFloorPlanWithZoom(clickedFloor);
  //   }
  // });

  // 강조된 층 (마우스가 올라간 층)
  let highlightedFloor = null;

  // 층 이미지 미리 로드
  floors.forEach(floor => {
    floor.img.src = floor.src;
  });

  // 빌딩과 층 이미지를 렌더링
  function renderBuilding() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // 빌딩 이미지 그리기
    ctx.globalAlpha = 1.0;
    ctx.drawImage(buildingImg, 0, 0, canvas.width, canvas.height);

    // 각 층 이미지 그리기
    floors.forEach(floor => {
      // 강조된 층이면 투명도를 더 높여서 강조
      ctx.globalAlpha = highlightedFloor === floor ? 1.0 : floor.opacity;
      ctx.drawImage(floor.img, floor.x, floor.y, floor.width, floor.height);

      // 강조된 층이면 테두리 추가
      // if (highlightedFloor === floor) {
      //   ctx.globalAlpha = 1.0;
      //   ctx.strokeStyle = 'yellow'; // 강조 색상
      //   ctx.lineWidth = 3;
      //   ctx.strokeRect(floor.x, floor.y, floor.width, floor.height);
      // }
    });

    ctx.globalAlpha = 1.0; // 투명도 초기화
  }

  // 평면도 애니메이션 전환
  function showFloorPlan(floorPlanSrc) {
    const floorPlanImg = new Image();
    floorPlanImg.src = floorPlanSrc;

    floorPlanImg.onload = () => {
      let opacity = 1;

      // 페이드아웃
      const fadeOut = setInterval(() => {
        opacity -= 0.05;
        // renderBuilding(); // 빌딩 그리기
        ctx.globalAlpha = opacity;

        if (opacity <= 0) {
          clearInterval(fadeOut);

          // 평면도 페이드인
          let fadeInOpacity = 0;
          const fadeIn = setInterval(() => {
            fadeInOpacity += 0.05;
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.globalAlpha = fadeInOpacity;
            ctx.drawImage(floorPlanImg, 0, 0, canvas.width, canvas.height);

            if (fadeInOpacity >= 1) {
              clearInterval(fadeIn);
              ctx.globalAlpha = 1.0; // 투명도 초기화
            }
          }, 30);
        }
      }, 30);
    };

    floorPlanImg.onerror = () => {
      console.error('Failed to load floor plan image:', floorPlanSrc);
    };
  }



  // 마우스 이동 이벤트 처리
  canvas.addEventListener('mousemove', event => {
    const rect = canvas.getBoundingClientRect();
    const mouseX = event.clientX - rect.left; // 캔버스 내 마우스 X 좌표
    const mouseY = event.clientY - rect.top;  // 캔버스 내 마우스 Y 좌표

    // 현재 마우스가 위치한 층 찾기
    const floorUnderMouse = floors.find(floor =>
            mouseX >= floor.x &&
            mouseX <= floor.x + floor.width &&
            mouseY >= floor.y &&
            mouseY <= floor.y + floor.height
    );

    // 강조된 층 변경
    if (highlightedFloor !== floorUnderMouse) {
      highlightedFloor = floorUnderMouse;
      renderBuilding(); // 화면 다시 그리기
    }
  });

  // 마우스가 캔버스에서 벗어났을 때 강조 해제
  canvas.addEventListener('mouseleave', () => {
    highlightedFloor = null;
    renderBuilding();
  });



  // 확대 애니메이션 추가
  function zoomFloor(clickedFloor) {
    const targetScale = 3; // 확대 비율
    const animationSpeed = 0.05; // 확대 속도
    let scale = 1; // 초기 확대 비율

    const centerX = clickedFloor.x + clickedFloor.width / 2; // 클릭한 층의 중심 X 좌표
    const centerY = clickedFloor.y + clickedFloor.height / 2; // 클릭한 층의 중심 Y 좌표

    function animateZoom() {
      ctx.clearRect(0, 0, canvas.width, canvas.height); // 캔버스 초기화

      ctx.save(); // 현재 상태 저장
      ctx.translate(canvas.width / 2, canvas.height / 2); // 캔버스 중심으로 이동
      ctx.scale(scale, scale); // 확대 적용
      ctx.translate(-centerX, -centerY); // 클릭한 층 중심으로 이동

      // 빌딩과 층 렌더링
      ctx.drawImage(buildingImg, 0, 0, canvas.width, canvas.height);
      floors.forEach(floor => {
        ctx.globalAlpha = highlightedFloor === floor ? 1.0 : floor.opacity;
        ctx.drawImage(floor.img, floor.x, floor.y, floor.width, floor.height);
      });

      ctx.restore(); // 저장된 상태 복원

      // 확대 애니메이션 진행
      if (scale < targetScale) {
        scale += animationSpeed;
        requestAnimationFrame(animateZoom); // 다음 프레임 호출
      } else {
        // 확대 완료 후 평면도 표시
        showFloorPlan(clickedFloor.floorPlan);
      }
    }

    animateZoom(); // 확대 애니메이션 시작
  }


  // 클릭 이벤트 처리
  canvas.addEventListener('click', event => {
    const rect = canvas.getBoundingClientRect();
    const clickX = event.clientX - rect.left; // 캔버스 내 클릭 X 좌표
    const clickY = event.clientY - rect.top;  // 캔버스 내 클릭 Y 좌표

    // 클릭한 영역이 어느 층인지 확인
    const clickedFloor = floors.find(floor =>
            clickX >= floor.x &&
            clickX <= floor.x + floor.width &&
            clickY >= floor.y &&
            clickY <= floor.y + floor.height
    );

    if (clickedFloor) {
      // showFloorPlan(clickedFloor.floorPlan); // 평면도 표시
      zoomFloor(clickedFloor); // 클릭한 층 확대
    }
  });

  // 초기 빌딩 렌더링
  buildingImg.onload = () => {
    renderBuilding();
  };
</script>
</body>
</html>




