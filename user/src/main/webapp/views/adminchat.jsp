<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<style>
    /* 내가 보낸 메시지 */
    .my-message {
        background-color: #d1f7c4; /* 연한 초록색 */
        text-align: right; /* 오른쪽 정렬 */
        padding: 10px;
        border-radius: 5px;
        margin: 5px 0;
    }

    /* 관리자가 보낸 메시지 */
    .admin-message {
        background-color: #f1f1f1; /* 연한 회색 */
        text-align: left; /* 왼쪽 정렬 */
        padding: 10px;
        border-radius: 5px;
        margin: 5px 0;
    }

    #all {
        height: 200px;
        overflow: auto;
        margin-top: 5px;
        background-color: #f0fafb;
    }

    #alltext {
        width: 275px;
    }

    #sendall {
        background-color: black;
        color: white;
        border-radius: 5px;
        margin-left: 5px;
    }

    #inputcontainer {
        margin-top: 5px;
    }

    #connect, #disconnect {
        display: inline-block;
        font-family: Arial, sans-serif;
        font-size: 14px;
        border-radius: 20px;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s ease, color 0.3s ease;
        margin: 2px;
    }

    #connect {
        background-color: #000;
        color: #fff;
    }

    #connect:hover {
        background-color: #333;
    }

    #disconnect {
        background-color: #f5f5f5;
        color: #000;
        border: 1px solid #ddd;
    }

    #disconnect:hover {
        background-color: #e0e0e0;
    }


    .button-container1212 {

    }

    #connect, #disconnect {
    }
</style>


<script>
    let adminchat = {
        id: '',
        stompClient: null,
        init: function () {
            $('#connect').click(() => {
                $("#status").text("연결중...");
                setTimeout(() => {
                    this.connect();
                }, 2000);
            });
            $('#disconnect').click(() => {
                this.disconnect();
            });
            $('#sendall').click(() => {
                let msg = JSON.stringify({
                    'sendid': this.id,
                    'content1': $("#alltext").val()
                });
                this.stompClient.send("/receiveall", {}, msg);
            });
            $("#alltext").keydown((event) => {
                if (event.key === "Enter") {
                    event.preventDefault();
                    $('#sendall').click();
                }
            });
        },
        connect: function () {
            let sid = this.id;
            let userid = '${sessionScope.loginid.userId}';
            let socket = new SockJS('http://10.20.34.98:82/ws');
            this.stompClient = Stomp.over(socket);

            this.stompClient.connect({}, function (frame) {
                websocket.setConnected(true);
                console.log('Connected: ' + frame);
                this.subscribe('/send', function (msg) {
                    $("#all").prepend(
                        "<h5>" + JSON.parse(msg.body).sendid + ":" +
                        JSON.parse(msg.body).content1
                        + "</h5>");
                });
                this.subscribe('/send/' + sid, function (msg) {
                    $("#me").prepend(
                        "<h5>" + JSON.parse(msg.body).sendid + ":" +
                        JSON.parse(msg.body).content1 + "</h5>");
                });
                this.subscribe('/send/to/' + sid, function (msg) {
                    $("#to").prepend(
                        "<h5>" + JSON.parse(msg.body).sendid + ":" +
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
                $("#status").text("Connected");
            } else {
                $("#status").text("Disconnected");
            }
        }
    };
    $(function () {
        adminchat.init();
    });
</script>


<div class="container-fluid">


    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary"> 관리자 1:1 채팅</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <h6 id="status">Status</h6>

                <div class="button-container1212">
                    <button id="connect">대화연결</button>
                    <button id="disconnect">대화종료</button>
                </div>

                <div id="all"></div>

                <div id="inputcontainer">
                    <input type="text" id="alltext">
                    <button id="sendall">전송</button>
                </div>

            </div>
        </div>
    </div>

</div>


