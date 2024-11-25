
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


</style>
<script>
    let websocket = {
        id:'',
        stompClient:null,
        init:function(){
            this.id = $('#login_id').text();
            this.connect();
            $('#connect').click(()=>{
                this.connect();
            });
            $('#disconnect').click(()=>{
                this.disconnect();
            });

            $('#sendto').click(()=>{
                var msg = JSON.stringify({
                    'sendid' : this.id,
                    'content1' : $('#totext').val()
                });
                this.stompClient.send('/sendchatbot', {}, msg);
                $("#to").prepend(
                    "<h4>" + this.id +":"+
                    $('#totext').val()
                    + "</h4>");
            });
        },
        connect:function(){
            let sid = this.id;
            let socket = new SockJS('/chatbot');
            this.stompClient = Stomp.over(socket);

            this.stompClient.connect({}, function(frame) {
                websocket.setConnected(true);
                console.log('Connected: ' + frame);
                this.subscribe('/sendto/' + sid, function(msg) {
                    let parsedMsg = JSON.parse(msg.body);

                    let content = parsedMsg.content1 || ""; // 기본 메시지 내용
                    let url = parsedMsg.url || ""; // 기본 URL 값

                    // URL이 `content1`에 포함된 경우 추출
                    if (!url.trim() && content.includes("http")) {
                        let urlMatch = content.match(/https?:\/\/[^\s]+/);
                        if (urlMatch) {
                            url = urlMatch[0]; // 첫 번째 URL 추출
                            content = content.replace(url, ""); // URL 제거 후 메시지만 남기기
                        }
                    }

                    // 메시지 렌더링
                    if (url.trim() !== "") {
                        // URL이 있는 경우
                        $("#to").prepend(
                            "<h4>" +
                            "Chatbot:<br>" + content.trim() + "<br>" +
                            "<button id='movebutton' onclick=\"window.location.href='" + url + "'\">이동</button>" +
                            "</h4>"
                        );
                    } else {
                        // URL이 없는 경우
                        $("#to").prepend(
                            "<h4>" +
                            "Chatbot:<br>" + content.trim() +
                            "</h4>"
                        );
                    }
                });
            });
        },
        disconnect:function(){
            if (this.stompClient !== null) {
                this.stompClient.disconnect();
            }
            websocket.setConnected(false);
            console.log("Disconnected");
        },
        setConnected:function(connected){
            if (connected) {
                $("#status").text("Connected");
            } else {
                $("#status").text("Disconnected");
            }
        }
    };
    $(function(){
        websocket.init();
    });
</script>
<div class="col-sm-10">
<%--    <h2>ChatBot Page</h2>--%>
<%--    <div class="col-sm-5">--%>
<%--        <h1 id="login_id">${sessionScope.loginid.custId}</h1>--%>
<%--        <H1 id="status">Status</H1>--%>
<%--        <button id="connect">Connect</button>--%>
<%--        <button id="disconnect">Disconnect</button>--%>


        <div id="to"></div>
    <input type="text" id="totext"><button id="sendto">Send</button>


<%--    </div>--%>

</div>