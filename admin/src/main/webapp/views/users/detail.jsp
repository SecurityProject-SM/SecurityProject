<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>회원관리</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .user-wrapper {
            background: linear-gradient(135deg, #2B4365 0%, #364765 100%);
            min-height: 100vh;
            padding: 2rem;
        }

        .user-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 24px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.15);
            margin: 0 auto;
            max-width: 1600px;
            padding: 2.5rem;
            height: calc(100vh - 4rem);
            overflow-y: auto;
            backdrop-filter: blur(10px);
        }

        .user-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 3px solid #e3f2fd;
        }

        .user-header h2 {
            color: #2B4365;
            font-size: 2.2rem;
            font-weight: 700;
            margin: 0;
        }

        .user-stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
            margin-bottom: 2.5rem;
        }

        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .stat-card h3 {
            color: #5c6bc0;
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
        }

        .stat-card .value {
            font-size: 2rem;
            font-weight: 700;
            color: #1a237e;
        }

        .user-alerts {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .user-alert-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            overflow: hidden;
            display: flex;
            transition: all 0.3s ease;
        }

        .user-alert-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }

        .user-alert-marker {
            width: 8px;
            background: #ffd700;
        }

        .user-alert-content {
            padding: 1.5rem;
            flex: 1;
        }

        .user-room-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 2rem;
        }

        .user-room-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            overflow: hidden;
            transition: all 0.3s ease;
            position: relative;
        }

        .user-room-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
        }

        .user-room-header {
            padding: 1.5rem;
            background: linear-gradient(135deg, #3D5174, #4A628B);
            color: white;
            position: relative;
        }

        .user-room-header.user-vacant {
            background: linear-gradient(135deg, #ef5350, #e53935);
        }

        .user-room-status {
            position: absolute;
            top: 1rem;
            right: 1rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(5px);
        }

        .user-room-number {
            font-size: 1.8rem;
            font-weight: 700;
            color: white;
            text-decoration: none;
            display: block;
            margin-bottom: 0.5rem;
        }

        .user-room-details {
            padding: 1.5rem;
        }

        .user-room-details p {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid #f5f5f5;
        }

        .user-room-details strong {
            color: #1a237e;
            font-weight: 500;
            font-size: 1.1rem;
        }

        .user-room-details span {
            color: #546e7a;
            font-weight: 400;
        }

        .contract-status {
            display: inline-block;
            padding: 0.3rem 0.8rem;
            border-radius: 12px;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }

        .contract-active {
            background: #e8f5e9;
            color: #2e7d32;
        }

        .contract-expired {
            background: #ffebee;
            color: #c62828;
        }

        @media (max-width: 768px) {
            .user-wrapper {
                padding: 1rem;
            }

            .user-container {
                padding: 1.5rem;
            }

            .user-stats {
                grid-template-columns: repeat(2, 1fr);
            }

            .user-room-grid {
                grid-template-columns: 1fr;
            }
        }

        .user-container::-webkit-scrollbar {
            width: 10px;
        }

        .user-container::-webkit-scrollbar-track {
            background: #f5f5f5;
            border-radius: 5px;
        }

        .user-container::-webkit-scrollbar-thumb {
            background: #90a4ae;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .user-container::-webkit-scrollbar-thumb:hover {
            background: #78909c;
        }
    </style>
</head>
<body>
<div class="user-wrapper">
    <div class="user-container">
        <div class="user-header">
            <h2>회원관리 시스템</h2>
            <div class="user-stats">
                <div class="stat-card">
                    <h3>전체 호실</h3>
                    <div class="value">20</div>
                </div>
                <div class="stat-card">
                    <h3>입주중</h3>
                    <div class="value">15</div>
                </div>
                <div class="stat-card">
                    <h3>공실</h3>
                    <div class="value">5</div>
                </div>
                <div class="stat-card">
                    <h3>계약 만료 예정</h3>
                    <div class="value">3</div>
                </div>
            </div>
        </div>

        <div class="user-alerts">
            <c:forEach var="d" items="${rentCalc}">
                <div class="user-alert-card">
                    <div class="user-alert-marker"></div>
                    <div class="user-alert-content">
                        <h4 style="font-size: 1.3rem; margin: 0 0 0.8rem 0; color: #1a237e;">${d.room}호</h4>
                        <p style="margin: 0; color: #546e7a; line-height: 1.6;">
                            <strong style="color: #ef5350;">계약 만료 임박</strong><br>
                            계약 종료일: ${d.edday}
                        </p>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="user-room-grid">
            <c:forEach var="floor" items="${ghtlf}">
                <c:forEach var="item" items="${floor.value}">
                    <div class="user-room-card">
                        <div class="user-room-header ${item.epty == 1 ? '' : 'user-vacant'}">
                            <span class="user-room-status">
                                <c:choose>
                                    <c:when test="${item.epty == 1}">입주중</c:when>
                                    <c:otherwise>공실</c:otherwise>
                                </c:choose>
                            </span>
                            <a href="/users/detail?ghtlfid=${item.ghtlfid}" class="user-room-number">
                                    ${item.room}호
                            </a>
                        </div>
                        <div class="user-room-details">
                            <p>
                                <strong>상호명</strong>
                                <span><c:out value="${item.bname}" default="미등록"/></span>
                            </p>
                            <p>
                                <strong>연락처</strong>
                                <span><c:out value="${item.tel}" default="미등록"/></span>
                            </p>
                            <p>
                                <strong>계약기간</strong>
                                <span>
                                    <c:out value="${item.stday}" default="N/A"/> ~
                                    <c:out value="${item.edday}" default="N/A"/>
                                </span>
                            </p>
                            <p style="border-bottom: none; margin-bottom: 0;">
                                <strong>계약상태</strong>
                                <span class="contract-status ${item.epty == 1 ? 'contract-active' : 'contract-expired'}">
                                        ${item.epty == 1 ? '계약중' : '만료'}
                                </span>
                            </p>
                        </div>
                    </div>
                </c:forEach>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>