<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script>
    let pic = {
        myVideoStream: null,
        init: function () {
            this.myVideoStream = document.querySelector('#myVideo');
            this.getVideo();
        },
        getVideo: function () {
            navigator.getMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
            navigator.getMedia(
                {video: true, audio: false},
                function (stream) {
                    pic.myVideoStream.srcObject = stream;
                    pic.myVideoStream.play();
                },
                function (error) {
                    alert('Webcam not working');
                }
            );
        },
        takeSnapshot:function(){
            var myCanvasElement = document.querySelector('#myCanvas');
            // var myVideoElement = document.querySelector('#myVideo');
            var myCTX = myCanvasElement.getContext('2d');
            myCTX.drawImage(this.myVideoStream, 0, 0, myCanvasElement.width, myCanvasElement.height);
        },
        send:function(){
            const canvas = document.querySelector('#myCanvas');
            const imgBase64 = canvas.toDataURL('image/jpeg', 'image/octet-stream');
            const decodImg = atob(imgBase64.split(',')[1]);
            let array = [];
            for (let i = 0; i < decodImg .length; i++) {
                array.push(decodImg .charCodeAt(i));
            }
            const file = new Blob([new Uint8Array(array)], {type: 'image/jpeg'});
            const fileName = 'snapshot_' + new Date().getMilliseconds() + '.jpg';
            let formData = new FormData();
            formData.append('file', file, fileName);
            $.ajax({
                type: 'post',
                url: '/saveimg/',
                enctype: 'multipart/form-data',
                cache: false,
                data: formData,
                processData: false,
                contentType: false,
                success: function (data) {
                    $('#imgname').val(data);
                }
            });
        }
    };

    $(function () {
        pic.init();
    });
</script>

<div class="col-sm-8 text-left">
    <video id="myVideo" width="80" height="40" style="border: 1px solid #ddd;"></video>
    <canvas id="myCanvas" width="80" height="40" style="border: 1px solid #ddd;"></canvas>
</div>
