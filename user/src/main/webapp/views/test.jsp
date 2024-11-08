<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-11-06
  Time: 오전 9:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Weather Data Display</title>
    <!-- jQuery CDN 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- CSS 스타일 추가 -->
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            max-width: 800px;
            margin: auto;
        }
        .json-output {
            white-space: pre-wrap;
            background-color: #f8f9fa;
            padding: 10px;
            border: 1px solid #ccc;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Item Main Page</h2>
    <h5>Title description, Nov 6, 2024</h5>
    <div class="fakeimg">Fake Image</div>

    <h3>Weather Data</h3>
    <!-- JSON 데이터를 표시할 HTML 요소 -->
    <pre id="jsonOutput" class="json-output">데이터를 불러오는 중...</pre>
</div>

<script>
    let center = {
        init: function () {
            $.ajax({
                url: '/ow', // 서버 엔드포인트 URL을 설정
                success: (result) => {
                    // JSON 데이터를 보기 좋게 포맷팅하여 웹 페이지에 출력
                    const formattedJson = JSON.stringify(result, null, 2);
                    document.getElementById("jsonOutput").textContent = formattedJson;
                },
                error: (error) => {
                    console.error("데이터 요청 실패:", error);
                    document.getElementById("jsonOutput").textContent = "데이터를 불러오지 못했습니다.";
                }
            });
        }
    };

    $(function () {
        center.init();
    });
</script>

</body>
</html>

