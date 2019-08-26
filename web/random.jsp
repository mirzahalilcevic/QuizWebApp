<%@ page import="qwa.domain.Quiz" %>
<%@ page import="qwa.service.QuizService" %>
<%@ page import="java.util.List" %>
<%@ page import="qwa.session.CompletedQuizHelper" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%! private final QuizService service = new QuizService(); %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>Random</title>

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

<div class="animated fadeIn fast">
    <%@ include file="/include/navigation.jsp" %>
</div>

<div id="particles" class="animated fadeIn fast"></div>

<div class="container wrapper animated fadeIn">
    <div class="row">
        <%
            List<Quiz> quizzes;
            try {

                String param = request.getParameter("n");
                int n = param == null ? 1 : Integer.parseInt(param);

                CompletedQuizHelper.print(request);
                quizzes = service.random(n, CompletedQuizHelper.get(request));
                if (quizzes == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }

                for (int i = 0; i < quizzes.size(); i++) {
        %>
        <div class="col flex-center" id="quiz-view-<%=i%>">
            <% request.setAttribute("quiz", quizzes.get(i)); %>
            <%@ include file="/include/quiz-view.jsp" %>
        </div>
        <%
                }

            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
        %>
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


    let socket = new WebSocket("ws://<%=request.getServerName()%>:<%=request.getServerPort()%>/players");

    socket.onopen = function () {
        socket.send('start');
    };

    socket.onmessage = function (event) {
        $('#player-count').text('Players: ' + event.data);
    };

    <% for (int i = 0; i < quizzes.size(); i++) { %>

    let view<%=i%> = new View('quiz-view-<%=i%>', <%=quizzes.get(i).getQuestions().size()%>);
    let controller<%=i%> = new Controller(<%=quizzes.get(i).getId()%>, view<%=i%>);

    $('#quiz-view-<%=i%> .start-button').click(function () {
        controller<%=i%>.start();
    });

    $('#quiz-view-<%=i%> .next-button').click(function () {
        controller<%=i%>.next();
    });

    $('#quiz-view-<%=i%> .skip-button').click(function () {
        controller<%=i%>.skip();
    });

    $('#quiz-view-<%=i%> .submit-button').click(function () {
        controller<%=i%>.submit();
    });

    $('#quiz-view-<%=i%> .question-answers :checkbox').change(function () {
        view<%=i%>.handle_checkbox(this.checked);
    });

    view<%=i%>.subscribe_revisit((question) => controller<%=i%>.revisit(question));

    <% } %>

    $(window).on('beforeunload', function () {
        <% for (int i = 0; i < quizzes.size(); i++) { %>
        controller<%=i%>.terminate();
        <% } %>
    });

</script>

</body>
</html>
