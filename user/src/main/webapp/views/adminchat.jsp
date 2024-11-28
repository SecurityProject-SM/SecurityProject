
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
    #all {
        height: 200px;
        overflow: auto;
        border: 2px solid red;
    }


    .button-container1212 {

    }

    #connect, #disconnect {
    }
</style>


<script>
    let adminchat = {
        id:'',
        stompClient:null,
        init:function(){
            $('#connect').click(()=>{
                $("#status").text("연결중...");
                setTimeout(() => {
                    this.connect();
                },2000);
            });
            $('#disconnect').click(()=>{
                this.disconnect();
            });
            $('#sendall').click(()=>{
                let msg = JSON.stringify({
                    'sendid' : this.id,
                    'content1' : $("#alltext").val()
                });
                this.stompClient.send("/receiveall", {}, msg);
            });

        },
        connect:function(){
            let sid = this.id;
            let userid = ${sessionScope.loginid.userId};
            let socket = new SockJS('http://10.20.34.98:82/ws');
            this.stompClient = Stomp.over(socket);

            this.stompClient.connect({}, function(frame) {
                websocket.setConnected(true);
                console.log('Connected: ' + frame);
                this.subscribe('/send', function(msg) {
                    $("#all").prepend(
                        "<h4>" + JSON.parse(msg.body).sendid +":"+
                        JSON.parse(msg.body).content1
                        + "</h4>");
                });
                this.subscribe('/send/'+sid, function(msg) {
                    $("#me").prepend(
                        "<h4>" + JSON.parse(msg.body).sendid +":"+
                        JSON.parse(msg.body).content1+ "</h4>");
                });
                this.subscribe('/send/to/'+sid, function(msg) {
                    $("#to").prepend(
                        "<h4>" + JSON.parse(msg.body).sendid +":"+
                        JSON.parse(msg.body).content1
                        + "</h4>");
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
                    <input type="text" id="alltext"><button id="sendall">Send</button>

            </div>
        </div>
    </div>

</div>


