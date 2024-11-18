<!DOCTYPE html>
<html lang="en">

    <!-- Full Calendar CSS -->
    <link href="plugins/fullcalendar/css/fullcalendar.min.css" rel="stylesheet"/>
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet"/>
    <!-- Custom Style -->
    <link href="css/app-style.css" rel="stylesheet"/>

<body class="bg-theme bg-theme1">

<div class="container mt-5">
    <h2 class="text-center">유지보수 캘린더</h2>
    <div id="calendar"></div>
</div>

<!-- Bootstrap core JavaScript -->
<script src="js/jquery.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!-- Full Calendar -->
<script src="plugins/fullcalendar/js/moment.min.js"></script>
<script src="plugins/fullcalendar/js/fullcalendar.min.js"></script>
<script>
    $(document).ready(function() {
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            events: [
                {
                    title: '예제 이벤트 1',
                    start: '2024-11-20',
                    end: '2024-11-22',
                    description: '상세 설명 1'
                },
                {
                    title: '예제 이벤트 2',
                    start: '2024-11-25',
                    description: '상세 설명 2'
                }
            ]
        });
    });
</script>

</body>
</html>
