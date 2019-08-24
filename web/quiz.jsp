<%@ page import="qwa.domain.Quiz" %>
<%@ page import="qwa.domain.Editor" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>
        <%=((Quiz) request.getAttribute("quiz")).getName()%>
    </title>

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

<nav class="navbar justify-content-end animated fadeIn">
    <%
        Object user = request.getSession().getAttribute("user");
        if (user == null) {
    %>
    <button type="button" class="btn blue-gradient btn-rounded btn-sm"
            onclick="window.location='<%=request.getContextPath()%>/login'">
        Log In
    </button>
    <% } else if (user instanceof Editor) { %>
    <span><%=((Editor) user).getUsername()%></span>
    <% } else { %>
    <span><%=(String) user%></span>
    <% } %>
</nav>

<div id="particles"></div>

<div class="container wrapper">
    <div class="row">

        <div class="col flex-center animated fadeInDown" id="quiz-view">
            <%@ include file="/include/quiz-view.jsp" %>
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
<script type="module">

    import View from '<%=request.getContextPath()%>/js/modules/view.js';
    import Controller from '<%=request.getContextPath()%>/js/modules/controller.js';


    let view = new View('quiz-view', <%=((Quiz) request.getAttribute("quiz")).getQuestions().size()%>);
    let controller = new Controller(<%=((Quiz) request.getAttribute("quiz")).getId()%>, view);

    $('.start-button').click(function () {
        controller.start();
    });

    $('.next-button').click(function () {
        controller.next();
    });

    $('.skip-button').click(function () {
        controller.skip();
    });

    $('.submit-button').click(function () {
        controller.submit();
    });

    $('.question-answers :checkbox').change(function () {
        view.handle_checkbox(this.checked);
    });

    view.subscribe_revisit((question) => controller.revisit(question));


    $(window).on('beforeunload', function () {
        controller.terminate();
        socket.close();
    });


    let socket = new WebSocket("ws://<%=request.getServerName()%>:<%=request.getServerPort()%>/players");

    socket.onmessage = function (event) {
        console.log(event.data);
    };

</script>

</body>
</html>