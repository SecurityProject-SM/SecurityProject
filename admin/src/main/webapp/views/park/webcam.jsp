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
        // takeSnapshotAndSend: function () {
        //     // Create a canvas element to capture the video frame
        //     let canvas = document.createElement('canvas');
        //     let video = this.myVideoStream;
        //     canvas.width = video.videoWidth;
        //     canvas.height = video.videoHeight;
        //
        //     let ctx = canvas.getContext('2d');
        //     ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
        //
        //     // Convert canvas to Base64 image
        //     const imgBase64 = canvas.toDataURL('image/jpeg', 'image/octet-stream');
        //     const decodImg = atob(imgBase64.split(',')[1]);
        //     let array = [];
        //     for (let i = 0; i < decodImg.length; i++) {
        //         array.push(decodImg.charCodeAt(i));
        //     }
        //
        //     // Create a Blob from the image data
        //     const file = new Blob([new Uint8Array(array)], {type: 'image/jpeg'});
        //     const fileName = 'snapshot_' + new Date().getMilliseconds() + '.jpg';
        //
        //     // Prepare FormData for upload
        //     let formData = new FormData();
        //     formData.append('file', file, fileName);
        //     console.log(formData);
        //     // Send the image via AJAX
        //     $.ajax({
        //         type: 'post',
        //         url: '/saveimg',
        //         enctype: 'multipart/form-data',
        //         cache: false,
        //         data: formData,
        //         processData: false,
        //         contentType: false,
        //         success: function (data) {
        //             $('#imgname').val(data); // Handle response as needed
        //             alert('Image saved successfully!');
        //         },
        //         error: function (xhr, status, error) {
        //             alert('Image upload failed: ' + error);
        //         }
        //     });
        // },
        takeSnapshotAndSend: function () {
            let canvas = document.createElement('canvas');
            let video = this.myVideoStream;
            canvas.width = video.videoWidth;
            canvas.height = video.videoHeight;

            let ctx = canvas.getContext('2d');
            ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

            const imgBase64 = canvas.toDataURL('image/jpeg', 'image/octet-stream');
            const decodImg = atob(imgBase64.split(',')[1]);
            let array = [];
            for (let i = 0; i < decodImg.length; i++) {
                array.push(decodImg.charCodeAt(i));
            }

            const file = new Blob([new Uint8Array(array)], { type: 'image/jpeg' });
            const fileName = 'snapshot_' + new Date().getMilliseconds() + '.jpg';

            let formData = new FormData();
            formData.append('file', file, fileName);

            // 서버에 이미지 전송
            $.ajax({
                type: 'post',
                url: '/ocr/check-car-number', // 차량 번호 처리 엔드포인트
                enctype: 'multipart/form-data',
                cache: false,
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    console.log("Server Response:", response);
                    // 응답 데이터 확인 및 DOM 업데이트
                    if (response.carNumber) {
                        // 차량 번호와 입차 시간 DOM에 삽입
                        $('#detected-car-number').text(response.carNumber || '없음');
                        $('#detected-entry-time').text(response.entryTime || '없음');
                        $('#detected-exit-time').text(response.exitTime || '없음');
                    } else {
                        $('#detected-car-number').text('일치하는 차량 번호가 없습니다');
                        $('#detected-entry-time').text('N/A');
                        $('#detected-exit-time').text('N/A');
                    }
                },
                error: function (xhr, status, error) {
                    alert('OCR 처리 실패: ' + error);
                    $('#detected-car-number').text('처리 실패');
                    $('#detected-entry-time').text('N/A');
                    $('#detected-exit-time').text('N/A');
                }
            });
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
                url: '/saveimg',
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
    <video id="myVideo" width="200" height="150" style="border: 1px solid #ddd;"></video>
<%--    <canvas id="myCanvas" width="80" height="40" style="border: 1px solid #ddd;"></canvas>--%>
</div>
