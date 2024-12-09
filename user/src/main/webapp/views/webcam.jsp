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
        }
    };

    $(function () {
        pic.init();
    });
</script>

<style>
    #myVideo {
        width: 100%;
        height: 100%;
        object-fit: cover;
        position: absolute;
        top: 0;
        left: 0;
    }

    /* 비디오 컨테이너 스타일 */
    .col-sm-8 {
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0;
        left: 0;
    }

</style>
<div class="col-sm-8 text-left">
    <video id="myVideo" width="160" height="120" style="border: 1px solid #ddd;"></video>
</div>
