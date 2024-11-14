<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주차 요금 안내</title>
    <style>

        /* 차량번호 입력 섹션 스타일 */
        .input-section {
            margin-top: 250px; /* 섹션을 상단에서 150px 아래로 이동 */
            margin-bottom: 40px; /* 섹션과 아래 표 사이에 20px 여백 추가 */
        }
        /* 차량번호 입력 안내 텍스트 스타일 */
        .input-box {
            background-color: #333; /* 헤더의 배경색 설정 */
            color: #ffffff; /* 텍스트 색상 설정 */
            border: 1px solid #ffffff; /* 흰색 테두리 설정 */
            padding: 10px; /* 내부 여백 설정 */
            text-align: center; /* 텍스트를 가운데 정렬 */
            border-radius: 5px; /* 모서리를 둥글게 설정 */
            width: 15%; /* 상자의 너비를 조정 */
            margin: 10px auto; /* 상자를 페이지 중앙에 배치 */
        }
        /* 입력 필드 스타일 */
        .input-field {
            width: 40%; /* 입력 필드의 너비 설정 */
            height: 100px; /* 입력 필드의 높이 설정 */
            padding: 10px; /* 내부 여백 설정 */
            border: 1px solid #ffffff; /* 흰색 테두리 설정 */
            background-color: #333; /* 입력 필드의 배경색 설정 */
            color: #ffffff; /* 입력 필드의 텍스트 색상 설정 */
            border-radius: 5px; /* 입력 필드의 모서리를 둥글게 설정 */
            display: block; /* 버튼과 입력 필드를 같은 라인에 두지 않기 위해 block으로 설정 */
            margin: 10px auto; /* 입력 필드를 페이지 중앙에 배치 */
            font-size: 35px; /* 입력받는 글씨의 크기를 24px로 설정 */
            text-align: center; /* 입력받는 텍스트를 가운데 정렬 */
        }

        /*조회 버튼 스타일*/
        .button {
            padding: 10px 20px; /* 버튼의 내부 여백 설정 */
            background-color: #596cff; /* 버튼 배경색 설정 */
            color: #ffffff; /* 버튼 텍스트 색상 설정 */
            border: 1px solid #ffffff; /* 흰색 테두리 설정 */
            border-radius: 5px; /* 버튼의 모서리를 둥글게 설정 */
            cursor: pointer; /* 마우스 포인터를 손가락 모양으로 설정 */
            display: block; /* 버튼을 페이지 중앙에 위치시키기 위해 block으로 설정 */
            margin: 10px auto; /* 버튼을 페이지 중앙에 배치하고 위쪽에 10px 여백 추가 */
        }
        /* 주차 요금 안내 표 스타일 */
        .fee-table {
            width: 60%; /* 표의 너비를 부모 요소의 60%로 설정 */
            border-collapse: collapse; /* 표의 테두리를 겹치게 설정 */
            margin: 50px auto; /* 표를 중앙에 배치하고 위쪽에 20px 여백 추가 */
            border: 1px solid #ffffff; /* 표의 테두리를 흰색으로 설정 */
            color: #000000; /* 표 텍스트 색상을 검정색으로 설정 */
        }
        /* 표의 셀 스타일 */
        .fee-table th, .fee-table td {
            border: 1px solid #000000; /* 표 셀의 테두리를 흰색으로 설정 */
            padding: 10px; /* 표 셀의 내부 여백 설정 */
            text-align: center; /* 셀 안의 텍스트를 가운데 정렬 */
        }
        /* 표의 헤더 스타일 */
        .fee-table th {
            background-color: #333; /* 헤더의 배경색 설정 */
            color: #ffffff; /* 헤더 텍스트 색상 설정 */
        }
    </style>
</head>
<body>
<!-- 차량번호 입력 섹션 -->
<div class="input-section">
    <div class="input-box">차량위치 찾기</div>
    <input type="text" class="input-field" placeholder="차량번호를 입력하세요 !">
    <button class="button">조회하기 ✔</button>
</div>

</body>
</html>
