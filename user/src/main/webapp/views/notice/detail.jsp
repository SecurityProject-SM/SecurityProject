<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>공지사항 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<style>
    .notice-detail {
        max-width: 900px;
        margin: 2rem auto;
        padding: 2rem;
        background: white;
        border-radius: 12px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }

    .notice-header {
        border-bottom: 2px solid #f0f0f0;
        padding-bottom: 1.5rem;
        margin-bottom: 1.5rem;
    }

    .notice-title {
        font-size: 1.5rem;
        font-weight: 600;
        color: #1a202c;
        margin-bottom: 1rem;
    }

    .notice-meta {
        display: flex;
        gap: 2rem;
        color: #666;
        font-size: 0.95rem;
    }

    .notice-content {
        min-height: 200px;
        line-height: 1.8;
        color: #2d3748;
        font-size: 1.05rem;
        background: #fcfcfc;
        padding: 2rem;
        border-radius: 8px;
        margin: 1.5rem 0;
    }

    .back-button {
        display: inline-flex;
        align-items: center;
        padding: 0.75rem 1.5rem;
        background-color: #4a5568;
        color: white;
        border-radius: 6px;
        transition: all 0.2s;
        text-decoration: none;
    }

    .back-button:hover {
        background-color: #2d3748;
        transform: translateY(-1px);
    }

    .back-button svg {
        margin-right: 0.5rem;
    }

    /* navbar 브랜드 스타일 강화 */
    .navbar-brand {
        display: flex !important;  /* !important로 강제 적용 */
        align-items: center !important;
        text-decoration: none;
    }

    .navbar-brand span {
        display: inline-block !important;
        vertical-align: middle !important;
    }
</style>

<body class="bg-gray-50">
<div class="notice-detail">
    <div class="notice-header">
        <h1 class="notice-title">${notice.noticeName}</h1>
        <div class="notice-meta">
               <span>
                   <svg xmlns="http://www.w3.org/2000/svg" class="inline h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                       <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                   </svg>
                   ${notice.adminId}
               </span>
            <span>
                   <svg xmlns="http://www.w3.org/2000/svg" class="inline h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                       <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                   </svg>
                   ${notice.noticeTime}
               </span>
            <span>
                   <svg xmlns="http://www.w3.org/2000/svg" class="inline h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                       <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 20l4-16m2 16l4-16M6 9h14M4 15h14" />
                   </svg>
                   No. ${notice.noticeId}
               </span>
        </div>
    </div>

    <div class="notice-content">
        ${notice.noticeDetail}
    </div>

    <div class="text-center mt-8">
        <a href="/notice" class="back-button">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
            </svg>
            목록으로 돌아가기
        </a>
    </div>
</div>
</body>
</html>