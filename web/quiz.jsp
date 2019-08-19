<%@ page import="qwa.domain.Quiz" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% final Quiz quiz = (Quiz) request.getAttribute("quiz"); %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>
        <%=quiz.getName()%>
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

<div id="particles"></div>

<div class="container wrapper">
    <div class="row">
        <div class="col flex-center" id="quiz-view">

            <!-- Quiz Home-->
            <div class="card card-cascade wider quiz-home">

                <!-- Quiz Image -->
                <div class="view view-cascade overlay">
                    <img class="card-img-top quiz-image" src="https://mdbootstrap.com/img/Photos/Others/photo6.jpg"
                         alt="quiz image">
                    <a href="#!">
                        <div class="mask rgba-white-slight"></div>
                    </a>
                </div>

                <!-- Quiz Info -->
                <div class="card-body card-body-cascade text-center">

                    <!-- Name -->
                    <h4 class="card-title quiz-name"><strong>
                        <%=quiz.getName()%>
                    </strong></h4>
                    <!-- Description -->
                    <p class="card-text quiz-desc">
                        <%=quiz.getDescription()%>
                    </p>
                    <br>
                    <!-- Start -->
                    <button type="button" class="btn btn-outline-yellow btn-rounded waves-effect start-button">
                        Start
                    </button>

                </div>
            </div>
            <!-- Quiz Home -->

            <!-- Quiz Question -->
            <div class="card card-cascade quiz-question" style="display: none">
                <div class="card-body card-body-cascade">

                    <!-- Question -->
                    <h5 class="card-header question-text"></h5>

                    <!-- Answers -->
                    <div class="form-check question-answers">
                        <br>
                        <input type="checkbox" class="form-check-input answer-0" id="checkbox1">
                        <label class="form-check-label answer-label-0" for="checkbox1"></label>
                        <br>
                        <input type="checkbox" class="form-check-input answer-1" id="checkbox2">
                        <label class="form-check-label answer-label-1" for="checkbox2"></label>
                        <br>
                        <input type="checkbox" class="form-check-input answer-2" id="checkbox3">
                        <label class="form-check-label answer-label-2" for="checkbox3"></label>
                        <br>
                        <input type="checkbox" class="form-check-input answer-3" id="checkbox4">
                        <label class="form-check-label answer-label-3" for="checkbox4"></label>
                        <br>
                        <input type="checkbox" class="form-check-input answer-4" id="checkbox5">
                        <label class="form-check-label answer-label-4" for="checkbox5"></label>
                    </div>
                    <br>

                    <!-- Next -->
                    <button type="button" class="btn btn-sm btn-outline-yellow btn-rounded waves-effect next-button"
                            disabled>
                        Next
                    </button>
                    <!-- Skip -->
                    <button type="button" class="btn btn-sm btn-outline-yellow btn-rounded waves-effect skip-button">
                        Skip
                    </button>

                    <!-- Progress -->
                    <div class="progress md-progress time-progress" style="height: 20px">
                        <div class="progress-bar progress-bar-striped progress-bar-animated time-progress-bar bg-success"
                             role="progressbar" style="width: 80%; height: 20px" aria-valuenow="0" aria-valuemin="0"
                             aria-valuemax="100">
                        </div>
                    </div>

                    <div class="card-footer text-muted text-center question-counter"></div>

                </div>
            </div>
            <!-- Quiz Question -->

            <!-- Quiz Skipped -->
            <div class="card card-cascade quiz-skipped" style="display: none">
                <div class="card-body card-body-cascade">

                    <h5 class="card-header"><strong>Skipped questions</strong></h5>
                    <br>

                    <!-- Skipped -->
                    <div class="list-group skipped-questions"></div>
                    <br>

                </div>
            </div>
            <!-- Quiz Question -->

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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/quiz.js"></script>
<script>

    var view = new View('quiz-view', <%=quiz.getQuestions().size()%>);
    var controller = new Controller(<%=quiz.getId()%>, view);

    $(window).on('beforeunload', function () {
        controller.terminate();
    });

    $('.start-button').click(function () {
        controller.start();
    });

    $('.next-button').click(function () {
        controller.next();
    });

    $('.skip-button').click(function () {
        controller.skip();
    });

    $('.question-answers :checkbox').change(function () {
        view.handleCheckboxChange(this.checked);
    });

</script>

</body>
</html>