<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>My Page</title>
</head>

<script>
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

<body>
<main class="main-content mt-0">
    <section>
        <div class="page-header min-vh-100">
            <div class="container">
                <div class="row">
                    <div class="col-xl-10 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto">
                        <div class="card card-plain">
                            <div class="card-header pb-0 text-start">
                                <h4 class="font-weight-bolder">마이페이지</h4>
                                <p class="mb-0" style="font-size: 14px">회원 정보를 수정하세요</p>
                            </div>
                            <div class="card-body">
                                <form id="update_form">
                                    <div class="form-group">
                                        <label for="id">아이디:</label>
                                        <input type="text" readonly value="${user.userId}" readonly class="form-control" id="id" name="userId" style="background:rgba(211,206,206,0.79)">
                                    </div>
                                    <div class="form-group">
                                        <label for="pwd">비밀번호:</label>
                                        <input type="password" value="${user.userPwd}" class="form-control" id="pwd" name="userPwd">
                                    </div>
                                    <div class="form-group">
                                        <label for="tel">전화번호:</label>
                                        <input type="text" value="${user.userTel}" class="form-control" id="tel" name="userTel">
                                    </div>
                                    <div class="form-group">
                                        <label for="mail">이메일:</label>
                                        <input type="email" value="${user.userMail}" class="form-control" id="mail" name="userMail">
                                    </div>
                                    <div class="form-group">
                                        <label for="name">이름:</label>
                                        <input type="text" value="${user.userName}" class="form-control" id="name" name="userName">
                                    </div>
                                    <button type="button" id="update_btn" class="btn btn-primary">수정</button>
                                    <button type="button" id="delete_btn" class="btn btn-danger">회원 탈퇴</button>
                                    <a href="<c:url value='/contract'/>" class="btn btn-light" role="button">내 계약서 보기</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>
</body>
</html>
