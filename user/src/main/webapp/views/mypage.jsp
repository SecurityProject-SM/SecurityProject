<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="min-h-screen bg-gradient-to-b from-gray-50 to-gray-100/50 gap-1">
<%--   마이페이지--%>
    <div class="mx-auto max-w-7xl p-4 md:p-6 lg:p-8">
    <div class="grid gap-3 lg:grid-cols-12">
        <!-- Profile Header -->
        <div class="col-span-full p-6 lg:p-8 bg-white rounded-lg shadow">
            <div class="flex flex-col gap-6 md:flex-row md:items-center md:gap-8">
                <div class="relative">
                    <div class="h-32 w-32 overflow-hidden rounded-full">
                        <img src="<c:url value='/img/gunamul2.jpeg'/>" alt="프로필 이미지" class="w-full h-full object-cover">
                    </div>
                </div>
                <div class="flex-1 space-y-4">
                    <div>
                        <h1 class="text-2xl font-bold">${user.userName}</h1>
                        <p class="text-gray-500">컴퓨터공학과</p>
                    </div>
                    <div class="flex flex-wrap gap-2">
                        <div class="flex items-center gap-1 text-sm text-gray-500">
                            <i data-lucide="map-pin" class="h-4 w-4"></i>
                            탕정면, 선문대학교
                        </div>
                        <div class="flex items-center gap-1 text-sm text-gray-500">
                            <i data-lucide="briefcase" class="h-4 w-4"></i>
                            23살
                        </div>
                    </div>
                </div>
                <div class="flex gap-3">
                    <button class="flex-1 bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded">
                        <i data-lucide="message-circle" class="h-4 w-4 inline mr-2"></i>
                        메시지
                    </button>
                    <a href="<c:url value='/contract'/>" class="flex-1 border border-gray-300 px-4 py-2 rounded text-center">
                        내 계약서
                    </a>
                </div>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="col-span-full grid gap-4 sm:grid-cols-2 lg:col-span-4 lg:grid-cols-1">
            <div class="bg-white rounded-lg shadow overflow-hidden">
                <div class="grid grid-cols-3 gap-2 p-6">
                    <div class="text-center">
                        <div class="text-2xl font-bold">22</div>
                        <div class="mt-1 text-sm text-gray-500">친구</div>
                    </div>
                    <div class="text-center">
                        <div class="text-2xl font-bold">10</div>
                        <div class="mt-1 text-sm text-gray-500">사진</div>
                    </div>
                    <div class="text-center">
                        <div class="text-2xl font-bold">89</div>
                        <div class="mt-1 text-sm text-gray-500">댓글</div>
                    </div>
                </div>
            </div>
            <div class="bg-white rounded-lg shadow">
                <div class="p-6">
                    <h3 class="font-semibold">최근 활동</h3>
                    <div class="mt-4 space-y-4">
                        <div class="flex items-center gap-4">
                            <i data-lucide="users" class="h-5 w-5 text-blue-500"></i>
                            <div class="text-sm">새로운 친구 2명이 추가됨</div>
                        </div>
                        <div class="flex items-center gap-4">
                            <i data-lucide="image" class="h-5 w-5 text-purple-500"></i>
                            <div class="text-sm">새 사진 3장 업로드됨</div>
                        </div>
                        <div class="flex items-center gap-4">
                            <i data-lucide="message-square" class="h-5 w-5 text-green-500"></i>
                            <div class="text-sm">새 댓글 5개가 달림</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Profile Form -->
        <div class="col-span-full lg:col-span-8 bg-white rounded-lg shadow">
            <div class="p-6">
                <div class="space-y-6">
                    <div>
                        <h2 class="text-xl font-semibold">프로필 정보</h2>
                        <p class="text-sm text-gray-500">회원님의 기본 정보를 수정할 수 있습니다</p>
                    </div>
                    <form id="update_form" class="grid gap-6">
                        <div class="grid gap-2">
                            <label for="id" class="text-sm font-medium">아이디</label>
                            <input id="id" name="userId" type="text" value="${user.userId}" readonly class="w-full px-3 py-2 border rounded-md bg-gray-50">
                        </div>
                        <div class="grid gap-2">
                            <label for="pwd" class="text-sm font-medium">비밀번호</label>
                            <input id="pwd" name="userPwd" type="password" value="${user.userPwd}" class="w-full px-3 py-2 border rounded-md">
                        </div>
                        <div class="grid gap-4 md:grid-cols-2">
                            <div class="grid gap-2">
                                <label for="mail" class="text-sm font-medium">이메일</label>
                                <div class="flex items-center gap-2">
                                    <i data-lucide="mail" class="h-4 w-4 text-gray-500"></i>
                                    <input id="mail" name="userMail" type="email" value="${user.userMail}" class="w-full px-3 py-2 border rounded-md">
                                </div>
                            </div>
                            <div class="grid gap-2">
                                <label for="tel" class="text-sm font-medium">전화번호</label>
                                <div class="flex items-center gap-2">
                                    <i data-lucide="phone" class="h-4 w-4 text-gray-500"></i>
                                    <input id="tel" name="userTel" type="tel" value="${user.userTel}" class="w-full px-3 py-2 border rounded-md">
                                </div>
                            </div>
                        </div>
                        <div class="grid gap-2">
                            <label for="name" class="text-sm font-medium">이름</label>
                            <input id="name" name="userName" type="text" value="${user.userName}" class="w-full px-3 py-2 border rounded-md">
                        </div>
                        <div class="flex gap-3 justify-end">
                            <button type="button" id="update_btn" class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded">저장하기</button>
                            <button type="button" id="delete_btn" class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded">회원 탈퇴</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    </div>


<script>
    lucide.createIcons();

    let mypage = {
        init: function () {
            $('#update_btn').click(() => {
                this.check();
            });
            $('#delete_btn').click(() => {
                let id = $('#id').val();
                let c = confirm("정말 삭제하시겠습니까?");
                if(c == true){
                    location.href='<c:url value="/deleteimpl"/>'+'?id='+id;
                }
            });
        },
        check:function(){
            let id = $('#id').val();
            let pwd = $('#pwd').val();
            let tel = $('#tel').val();
            let mail = $('#mail').val();
            let name = $('#name').val();

            if(id == '' || id == null){
                alert('Id is Mandatory');
                $('#id').focus();
                return;
            }
            if(pwd == '' || pwd == null){
                alert('Pwd is Mandatory');
                $('#pwd').focus();
                return;
            }
            if(name == '' || name == null){
                alert('Name is Mandatory');
                $('#name').focus();
                return;
            }
            if(tel == '' || tel == null){
                alert('tel is Mandatory');
                $('#tel').focus();
                return;
            }
            if(mail == '' || mail == null){
                alert('mail is Mandatory');
                $('#mail').focus();
                return;
            }
            this.send();
        },
        send:function(){
            $('#update_form').attr('method','post');
            $('#update_form').attr('action','/updateimpl');
            $('#update_form').submit();
        }
    }

    $(function () {
        mypage.init();
    })
</script>
</body>
</html>