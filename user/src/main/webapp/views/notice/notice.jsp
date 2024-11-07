<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>공지사항</title>
</head>

<body>
<h1>공지사항</h1>
<div class="row">
    <div class="col-12">
        <div class="row">
            <div class="col-sm-2">
                <h5>Search</h5>
            </div>
            <div class="col-sm-4">
                <input type="text" class="form-control" name="search"
                <c:if test="${search.search != null}"> value="${search.search}" </c:if>
                >
            </div>
            <div class="col-sm-3">
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </div>
        <div class="card mb-4">
            <div class="card-header pb-0">
                <h6>공지사항</h6>
            </div>
            <div class="card-body px-0 pt-0 pb-2">
                <div class="table-responsive p-0">
                    <table class="table align-items-center justify-content-center mb-0">
                        <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성일자</th>
                            <th>작성자</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="n" items="${cpage.list}">
                            <tr>
                                <td><a href="/notice/detail?id=${n.noticeId}">${n.noticeId}</a>
                                <td>${n.noticeName}</td>
                                <td>${n.noticeTime}</td>
                                <td>${n.adminId}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div style="margin-top: 15px">
                        <c:if test="${cpage.getSize() != null}">
                            <jsp:include page="../searchnav.jsp"/>
                        </c:if>
                    </div>


                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
