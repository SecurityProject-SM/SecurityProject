<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    #all {
        width: 400px;
        height: 200px;
        overflow: auto;
        border: 2px solid red;
    }


    #me {
        width: 400px;
        height: 200px;
        overflow: auto;
        border: 2px solid blue;
    }

    #to {
        width: 400px;
        height: 400px;
        overflow: auto;
        border: 2px solid green;
    }

    #movebutton {
        position: relative;
        display: inline-block;
        text-align: center;
        font-family: Arial, sans-serif;
        font-size: 14px;
        color: #fff;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        background: #5DC8CD; /* Light Blue */
        transition: all 0.2s;
    }

    #movebutton:hover {
        transform: scale(1.1, 1.1);
        box-shadow: 0px 5px 5px -2px rgba(0, 0, 0, 0.25);
        background: #00A0B0; /* Darker Blue */
    }

    /* 입력창임 */
    #totext {
        width: 349px;
    }

    /* 사용자 메시지 (오른쪽 정렬) */
    .user-message {
        text-align: right;
        color: #000000; /* 사용자 메시지 색상 */
        margin: 10px;
    }

    /* 챗봇 메시지 (왼쪽 정렬) */
    .chatbot-message {
        text-align: left;
        color: #0cedd7; /* 챗봇 메시지 색상 */
        margin: 10px;
    }


</style>
<script>
    let websocket = {
        id: '',
        stompClient: null,
        init: function () {
            this.id = $('#login_id').text();
            this.connect();
            $('#connect').click(() => {
                this.connect();
            });
            $('#disconnect').click(() => {
                this.disconnect();
            });

            $('#totext').keypress((event) => {
                if (event.key === 'Enter') {
                    event.preventDefault();
                    $('#sendto').click();
                }
            });

            $('#sendto').click(() => {
                var msg = JSON.stringify({
                    'sendid': this.id,
                    'content1': $('#totext').val()
                });

                $("#to").prepend(
                    "<h4 class='user-message'>" +
                    this.id  + $('#totext').val() +
                    "</h4>"
                );

                this.stompClient.send('/sendchatbot', {}, msg);
                $('#totext').val('');
            });
        },
        connect: function () {
            let sid = this.id;
            let socket = new SockJS('/chatbot');
            this.stompClient = Stomp.over(socket);

            this.stompClient.connect({}, function (frame) {
                websocket.setConnected(true);
                console.log('Connected: ' + frame);
                this.subscribe('/sendto/' + sid, function (msg) {
                    let parsedMsg = JSON.parse(msg.body);

                    let content = parsedMsg.content1 || "";
                    let url = parsedMsg.url || "";

                    if (!url.trim() && content.includes("http")) {
                        let urlMatch = content.match(/https?:\/\/[^\s]+/);
                        if (urlMatch) {
                            url = urlMatch[0];
                            content = content.replace(url, "");
                        }
                    }

                    url = typeof url === "string" ? url : "";

                    if (url.trim() !== "") {
                        // URL이 있는 경우
                        $("#to").prepend(
                            "<h4 class='chatbot-message'>" +
                            "Chatbot:<br>" + content.trim() + "<br>" +
                            "<button id='movebutton' onclick=\"window.location.href='" + url + "'\">이동</button>" +
                            "</h4>"
                        );
                    } else {
                        // URL이 없는 경우
                        $("#to").prepend(
                            "<h4 class='chatbot-message'>" +
                            "Chatbot:<br>" + content.trim() +
                            "</h4>"
                        );
                    }
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
        websocket.init();
    });
</script>
<div>
    <%--    <h2>ChatBot Page</h2>--%>
    <%--    <div class="col-sm-5">--%>
    <%--        <h1 id="login_id">${sessionScope.loginid.custId}</h1>--%>
    <%--        <H1 id="status">Status</H1>--%>
    <%--        <button id="connect">Connect</button>--%>
    <%--        <button id="disconnect">Disconnect</button>--%>


    <div id="to"></div>
    <input type="text" id="totext">
    <button id="sendto"><img src="img/chat.png" style="height: 30px"></button>


    <%--    </div>--%>

</div>