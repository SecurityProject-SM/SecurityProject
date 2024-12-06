<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>공지사항</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/feather-icons/dist/feather.min.js"></script>
    <style>
        .notice-container {
            background-color: white;
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .page-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #1a202c;
            margin-bottom: 2rem;
        }

        .search-container {
            margin-bottom: 2rem;
            padding: 1rem;
            background-color: #f7fafc;
            border-radius: 8px;
        }

        .search-input {
            width: 300px;
            padding: 0.5rem 1rem 0.5rem 2.5rem;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            transition: all 0.2s;
        }

        .search-input:focus {
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.1);
            outline: none;
        }

        .search-button {
            background-color: #4299e1;
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 6px;
            margin-left: 0.5rem;
            transition: all 0.2s;
        }

        .search-button:hover {
            background-color: #3182ce;
        }

        .notice-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .notice-table th {
            background-color: #f7fafc;
            padding: 1rem;
            font-weight: 600;
            text-align: left;
            border-bottom: 2px solid #e2e8f0;
        }

        .notice-table td {
            padding: 1rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .notice-table tr:hover {
            background-color: #f7fafc;
        }

        .notice-link {
            color: #4299e1;
            text-decoration: none;
            transition: color 0.2s;
        }

        .notice-link:hover {
            color: #2b6cb0;
        }

        .pagination {
            margin-top: 2rem;
            display: flex;
            justify-content: center;
        }

        .reset-button {
            background-color: #718096;
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 6px;
            margin-left: 0.5rem;
            transition: all 0.2s;
        }

        .reset-button:hover {
            background-color: #4a5568;
        }

        .no-results {
            text-align: center;
            padding: 3rem 0;
            color: #718096;
            font-size: 1.1rem;
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
</head>
<body class="bg-gray-50">
<div class="notice-container">
    <h1 class="page-title">공지사항</h1>
    <div class="search-container">
        <form action="/notice" method="get" class="flex items-center">
            <div class="relative">
                <i data-feather="search" class="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-4 w-4"></i>
                <input type="text"
                       name="search"
                       placeholder="검색어를 입력하세요"
                       class="search-input"
                       <c:if test="${search.search != null}">value="${search.search}"</c:if>>
            </div>
            <button type="submit" class="search-button">
                검색
            </button>
            <c:if test="${search.search != null}">
                <a href="/notice" class="reset-button">
                    초기화
                </a>
            </c:if>
        </form>
    </div>

    <table class="notice-table">
        <thead>
        <tr>
            <th width="10%">번호</th>
            <th width="50%">제목</th>
            <th width="20%">작성일자</th>
            <th width="20%">작성자</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${empty cpage.list}">
                <tr>
                    <td colspan="4" class="no-results">
                        검색 결과가 없습니다.
                    </td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="n" items="${cpage.list}">
                    <tr onclick="location.href='/notice/detail?id=${n.noticeId}'" style="cursor: pointer;"
                        class="hover:bg-gray-100 transition-colors duration-200">
                        <td>${n.noticeId}</td>
                        <td>${n.noticeName}</td>
                        <td>${n.noticeTime}</td>
                        <td>${n.adminId}</td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>

    <div class="pagination">
        <c:if test="${cpage.getSize() != null}">
            <jsp:include page="../searchnav.jsp"/>
        </c:if>
    </div>
</div>

<script>
    feather.replace();
</script>
</body>
</html>