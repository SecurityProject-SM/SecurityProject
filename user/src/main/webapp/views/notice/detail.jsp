<%--
  User: 1
  Date: 2024-11-06
  Time: 오후 3:46
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>공지사항 상세</title>
</head>

<body>
<div class="container">
    <h1>공지사항 상세</h1>

    <div class="card mt-3">
        <div class="card-header">
            <h4>${notice.noticeName}</h4>
        </div>
        <div class="card-body">
            <p><strong>번호:</strong> ${notice.noticeId}</p>
            <p><strong>작성자:</strong> ${notice.adminId}</p>
            <p><strong>작성일자:</strong> ${notice.noticeTime}</p>
            <hr>
            <p><strong>내용:</strong></p>
            <p>${notice.noticeDetail}</p>
        </div>
    </div>

    <div class="mt-3">
        <a href="/notice" class="btn btn-secondary">목록으로 돌아가기</a> <!-- 목록 페이지로 돌아가기 -->
    </div>
</div>
</body>
</html>
