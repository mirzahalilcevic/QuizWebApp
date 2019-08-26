<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>Home</title>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <!-- Bootstrap core CSS -->
    <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="<%=request.getContextPath()%>/css/mdb.min.css" rel="stylesheet">
    <!-- Custom styles -->
    <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">

</head>
<body>

<div class="animated flash">
    <%@ include file="/include/navigation.jsp" %>
</div>

<div id="particles" class="animated zoomIn slow"></div>

<div class="container">
    <div class="row" style="margin-top: 15%">

        <div class="col flex-center animated zoomIn slow">
            <div style="width: 300px">

                <button type="button" class="btn btn-lg blue-gradient btn-rounded btn-block"
                        onclick="window.location='<%=request.getContextPath()%>/quiz/random'">
                    <i class="fas fa-dice-five"></i>&nbsp; Play random
                </button>
                <br>
                <button type="button" class="btn btn-lg blue-gradient btn-rounded btn-block"
                        onclick="window.location='<%=request.getContextPath()%>/quiz/random?n=2'">
                    <i class="fas fa-dice"></i>&nbsp; Play 2 random
                </button>
                <br>
                <button type="button" class="btn btn-lg blue-gradient btn-rounded btn-block"
                        onclick="window.location='<%=request.getContextPath()%>/quiz/browse'">
                    <i class="fas fa-search"></i>&nbsp; Browse
                </button>
                <br><br>
                <p class="text-center animated fadeIn delay-2s">
                    Mirza Halilčević &middot; Jasmin Hadžić
                </p>

            </div>
        </div>

    </div>
</div>

<!-- SCRIPTS -->
<!-- JQuery -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.4.1.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/mdb.min.js"></script>
<!-- Particles -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/particles.min.js"></script>
<script>
    particlesJS.load('particles', '<%=request.getContextPath()%>/assets/particles.json');
</script>
<!-- Custom scripts -->
<script>

    let socket = new WebSocket("ws://<%=request.getServerName()%>:<%=request.getServerPort()%>/players");

    socket.onmessage = function (event) {
        $('#player-count').text('Players: ' + event.data);
    };

</script>

</body>
</html>
