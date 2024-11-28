
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 웹소켓 라이브러리--%>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>

<!-- jQuery, Popper, Bootstrap from CDN -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
    #all {
        height: 280px;
        overflow: auto;
        margin-top: 5px;
        background-color: #f0fafb;
    }

    /* 사용자가 보낸 메시지 */
    .user-massage {
        background-color: #d1f7c4; /* 연한 초록색 */
        text-align: left; /* 오른쪽 정렬 */
        padding: 10px;
        border-radius: 5px;
        color: black;
        margin: 5px 0;
    }

    /* 관리자가 보낸 메시지 */
    .admin-message {
        background-color: #f1f1f1; /* 연한 회색 */
        text-align: right; /* 왼쪽 정렬 */
        padding: 10px;
        border-radius: 5px;
        color: black;
        margin: 5px 0;
    }

    #alltext {
        width: 260px;
    }

    #sendall {
        background-color: black;
        color: white;
        border-radius: 5px;
        margin-left: 5px;
    }



</style>

<script>
    let websocket = {
        id: '',
        stompClient: null,
        init: function () {
            this.id = $('#adm_id').text();
            $('#connect').click(() => {
                this.connect();
            });

            $('#disconnect').click(() => {
                this.disconnect();
            });

            $('#alltext').keydown((event) => {
                if (event.key === "Enter") {
                    event.preventDefault();
                    $('#sendall').click();
                }
            });

            $('#sendall').click(() => {
                let msg = JSON.stringify({
                    'content1': $("#alltext").val()
                });
                this.stompClient.send("/send/admin", {}, msg);
            });
        },
        connect: function () {
            let sid = this.id;
            let socket = new SockJS('http://10.20.34.98:82/ws');
            this.stompClient = Stomp.over(socket);

            this.stompClient.connect({}, function (frame) {
                websocket.setConnected(true);
                console.log('Connected: ' + frame);
                this.subscribe('/send/user', function (msg) {
                    $("#all").prepend(
                        "<h5 class='user-massage'>" + "사용자 : " +
                        JSON.parse(msg.body).content1
                        + "</h5>");
                    websocket.onNewMessage();
                });

                this.subscribe('/send/admin', function (msg) {
                    $("#all").prepend(
                        "<h5 class='admin-message'>" +
                        JSON.parse(msg.body).content1
                        + "</h5>");
                });
            });
        },
        disconnect: function () {
            if (this.stompClient !== null) {
                this.stompClient.disconnect();
            }
            websocket.setConnected(false);
            console.log("Disconnected");
        },
        setConnected: function (connected) {
            if (connected) {
                $("#status").text("연결됨");
            } else {
                $("#status").text("연결 끊김");
            }
        },
        onNewMessage: function () {
            if (window.parent) {
                const chatButton = window.parent.document.querySelector('#chat-button');
                if (chatButton) {
                    chatButton.classList.add('new-message');

                    setTimeout(() => {
                        chatButton.classList.remove('new-message');
                    }, 5000);
                }
            }
        }
    };
    $(function(){
        websocket.init();
        websocket.connect();
    });
</script>



<div class="container-fluid">

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-body">
            <div class="table-responsive">
                <div>
                    <H3 id="status">Status</H3>
<%--                    <button id="connect">Connect</button>--%>
<%--                    <button id="disconnect">Disconnect</button>--%>

                    <div id="all"></div>
                    <div style="margin-top: 5px">
                    <input type="text" id="alltext"><button id="sendall">전송</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

</div>


