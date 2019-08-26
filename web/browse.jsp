<%@ page import="qwa.domain.Quiz" %>
<%@ page import="java.util.List" %>
<%@ page import="qwa.dao.QuizDao" %>
<%@ page import="qwa.session.CompletedQuizHelper" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%! private final QuizDao dao = new QuizDao(); %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>Browse</title>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <!-- Bootstrap core CSS -->
    <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="<%=request.getContextPath()%>/css/mdb.min.css" rel="stylesheet">
    <!-- Custom styles -->
    <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">
    <style>
        .card {
            color: #b0b0b1 !important;
            background-color: #181724 !important;
        }
    </style>

</head>
<body>

<div class="animated fadeIn fast">
    <%@ include file="/include/navigation.jsp" %>
</div>

<div id="particles" class="animated fadeIn fast"></div>

<div class="container wrapper animated fadeIn fast">

    <div class="row">
        <div class="col flex-center" style="margin-top: -3%; margin-bottom: 5%;">

            <form class="form-inline md-form" action="<%=request.getContextPath()%>/quiz/browse" method="get">
                <i class="fas fa-search" aria-hidden="true"></i>
                <input class="form-control form-control-sm ml-3 w-75 text-white" type="text"
                       placeholder="Search" aria-label="Search" name="search">
            </form>

        </div>
    </div>

    <div class="row">
        <%
            CompletedQuizHelper.print(request);
            List<Integer> completed = CompletedQuizHelper.get(request);
            String search = request.getParameter("search");
            List<Quiz> quizzes = search != null ? dao.search(search) : dao.get();
            for (int i = 0; i < quizzes.size(); i++) {
                if (completed != null && completed.contains(quizzes.get(i).getId()))
                    continue;
        %>
        <div class="col flex-center" style="margin-bottom: 5%">
            <div class="card card-cascade narrower" style="width: 300px">

                <div class="view view-cascade overlay">
                    <img class="card-img-top"
                         src="<%=quizzes.get(i).getImage() != null && !quizzes.get(i).getImage().isEmpty() ? quizzes.get(i).getImage() : "https://icon-library.net/images/no-image-available-icon/no-image-available-icon-6.jpg"%>"
                         alt="quiz image">
                    <a href="<%=request.getContextPath()%>/quiz/<%=quizzes.get(i).getId()%>">
                        <div class="mask rgba-white-slight"></div>
                    </a>
                </div>

                <div class="card-body card-body-cascade text-center">

                    <h4 class="card-title"><strong>
                        <%=quizzes.get(i).getName()%>
                    </strong></h4>

                    <p class="card-text">
                        <%=quizzes.get(i).getDescription() != null && !quizzes.get(i).getDescription().isEmpty() ? quizzes.get(i).getDescription() : "<span class=\"text-mute\">No description available</span>"%>
                    </p>

                </div>

            </div>
        </div>
        <% } %>
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
