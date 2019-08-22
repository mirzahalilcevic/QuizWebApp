<%@ page import="qwa.domain.Quiz" %>
<%@ page import="qwa.service.QuizService" %>
<%@ page import="java.util.List" %>
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

<div id="particles"></div>

<div class="container wrapper">
    <div class="row">

        <%
            List<Quiz> quizzes = service.getTwoRandomQuizzes();
        %>

        <div class="col flex-center animated fadeInDown" id="quiz-view-1">

            <!-- Quiz Home-->
            <div class="card card-cascade wider quiz-home">

                <!-- Image -->
                <div class="view view-cascade overlay">
                    <img class="card-img-top" src="https://mdbootstrap.com/img/Photos/Others/photo6.jpg"
                         alt="quiz image">
                </div>

                <!-- Info -->
                <div class="card-body card-body-cascade text-center">

                    <!-- Name -->
                    <h4 class="card-title quiz-name"><strong>
                        <%=quizzes.get(0).getName()%>
                    </strong></h4>

                    <!-- Description -->
                    <p class="card-text quiz-desc">
                        <%=quizzes.get(0).getDescription()%>
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
            <div class="card quiz-question" style="display: none">
                <div class="card-body card-body-cascade">

                    <!-- Question -->
                    <h5 class="card-header question-text">Question text</h5>

                    <!-- Answers -->
                    <div class="form-check question-answers checkbox-custom">
                        <br>
                        <input type="checkbox" class="form-check-input answer-0" id="checkbox1">
                        <label class="form-check-label answer-label-0" for="checkbox1">Answer 1</label>
                        <br>
                        <input type="checkbox" class="form-check-input answer-1" id="checkbox2">
                        <label class="form-check-label answer-label-1" for="checkbox2">Answer 2</label>
                        <br>
                        <input type="checkbox" class="form-check-input answer-2" id="checkbox3">
                        <label class="form-check-label answer-label-2" for="checkbox3">Answer 3</label>
                        <br>
                        <input type="checkbox" class="form-check-input answer-3" id="checkbox4">
                        <label class="form-check-label answer-label-3" for="checkbox4">Answer 4</label>
                        <br>
                        <input type="checkbox" class="form-check-input answer-4" id="checkbox5">
                        <label class="form-check-label answer-label-4" for="checkbox5">Answer 5</label>
                    </div>

                    <!-- Controls -->
                    <p class="card-text text-right">
                        <br>
                        <!-- Next -->
                        <button type="button" class="btn btn-sm btn-outline-yellow btn-rounded waves-effect next-button"
                                disabled>
                            Next
                        </button>
                        <!-- Skip -->
                        <button type="button"
                                class="btn btn-sm btn-outline-yellow btn-rounded waves-effect skip-button">
                            Skip
                        </button>
                    </p>

                    <!-- Progress -->
                    <div class="progress md-progress time-progress" style="height: 20px">
                        <div class="progress-bar progress-bar-striped progress-bar-animated bg-success time-progress-bar"
                             role="progressbar" style="width: 100%; height: 20px" aria-valuenow="0" aria-valuemin="0"
                             aria-valuemax="100">
                            60s
                        </div>
                    </div>

                    <!-- Counter -->
                    <div class="card-footer text-muted text-center question-counter">1/10</div>

                </div>
            </div>
            <!-- Quiz Question -->

            <!-- Quiz Skipped -->
            <div class="card quiz-skipped" style="display: none">
                <div class="card-body card-body-cascade text-center">

                    <h4 class="card-title"><strong>Skipped questions</strong></h4>

                    <!-- Skipped -->
                    <div class="list-group skipped-questions">
                        <button type="button"
                                class="list-group-item list-group-item-action waves-effect d-flex justify-content-between align-items-center"
                                title="Tooltip">
                            <span class="d-inline-block text-truncate">Skipped question</span>&nbsp;&nbsp;
                            <span class="badge badge-success badge-pill">50s</span>
                        </button>
                    </div>

                </div>
            </div>
            <!-- Quiz Skipped -->

            <!-- Quiz Summary -->
            <div class="card quiz-summary" style="display: none">
                <div class="card-body card-body-cascade text-center">

                    <!-- Result -->
                    <span class="min-chart summary-chart" data-percent="100"><span
                            class="percent"></span></span>
                    <h5><span class="label success-color badge summary-badge">
                        <span class="summary-correct">correct/num</span> <i class="fas fa-check"></i> &nbsp;
                        <span class="summary-points">score/total</span> points</span></h5>

                    <br>

                    <!-- Form -->
                    <form class="text-center">

                        <div class="form-row">
                            <div class="col">
                                <!-- First name -->
                                <div class="md-form">
                                    <input type="text" id="input-1" class="form-control first-name">
                                    <label for="input-1">First name</label>
                                </div>
                            </div>
                            <div class="col">
                                <!-- Last name -->
                                <div class="md-form">
                                    <input type="email" id="input-2" class="form-control last-name">
                                    <label for="input-2">Last name</label>
                                </div>
                            </div>
                        </div>

                        <!-- E-mail -->
                        <div class="md-form mt-0">
                            <input type="email" id="input-3" class="form-control email">
                            <label for="input-3">E-mail</label>
                        </div>

                        <!-- Send button -->
                        <button type="button"
                                class="btn blue-gradient btn-rounded btn-block my-4 waves-effect z-depth-0 submit-button">
                            Send
                        </button>

                    </form>

                </div>
            </div>
            <!-- Quiz Summary -->

        </div>

        <div class="col flex-center animated fadeInDown" id="quiz-view-2">

            <!-- Quiz Home-->
            <div class="card card-cascade wider quiz-home">

                <!-- Image -->
                <div class="view view-cascade overlay">
                    <img class="card-img-top" src="https://mdbootstrap.com/img/Photos/Others/photo6.jpg"
                         alt="quiz image">
                </div>

                <!-- Info -->
                <div class="card-body card-body-cascade text-center">

                    <!-- Name -->
                    <h4 class="card-title quiz-name"><strong>
                        <%=quizzes.get(1).getName()%>
                    </strong></h4>

                    <!-- Description -->
                    <p class="card-text quiz-desc">
                        <%=quizzes.get(1).getDescription()%>
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
            <div class="card quiz-question" style="display: none">
                <div class="card-body card-body-cascade">

                    <!-- Question -->
                    <h5 class="card-header question-text">Question text</h5>

                    <!-- Answers -->
                    <div class="form-check question-answers checkbox-custom">
                        <br>
                        <input type="checkbox" class="form-check-input answer-0" id="checkbox6">
                        <label class="form-check-label answer-label-0" for="checkbox6">Answer 1</label>
                        <br>
                        <input type="checkbox" class="form-check-input answer-1" id="checkbox7">
                        <label class="form-check-label answer-label-1" for="checkbox7">Answer 2</label>
                        <br>
                        <input type="checkbox" class="form-check-input answer-2" id="checkbox8">
                        <label class="form-check-label answer-label-2" for="checkbox8">Answer 3</label>
                        <br>
                        <input type="checkbox" class="form-check-input answer-3" id="checkbox9">
                        <label class="form-check-label answer-label-3" for="checkbox9">Answer 4</label>
                        <br>
                        <input type="checkbox" class="form-check-input answer-4" id="checkbox10">
                        <label class="form-check-label answer-label-4" for="checkbox10">Answer 5</label>
                    </div>

                    <!-- Controls -->
                    <p class="card-text text-right">
                        <br>
                        <!-- Next -->
                        <button type="button" class="btn btn-sm btn-outline-yellow btn-rounded waves-effect next-button"
                                disabled>
                            Next
                        </button>
                        <!-- Skip -->
                        <button type="button"
                                class="btn btn-sm btn-outline-yellow btn-rounded waves-effect skip-button">
                            Skip
                        </button>
                    </p>

                    <!-- Progress -->
                    <div class="progress md-progress time-progress" style="height: 20px">
                        <div class="progress-bar progress-bar-striped progress-bar-animated bg-success time-progress-bar"
                             role="progressbar" style="width: 100%; height: 20px" aria-valuenow="0" aria-valuemin="0"
                             aria-valuemax="100">
                            60s
                        </div>
                    </div>

                    <!-- Counter -->
                    <div class="card-footer text-muted text-center question-counter">1/10</div>

                </div>
            </div>
            <!-- Quiz Question -->

            <!-- Quiz Skipped -->
            <div class="card quiz-skipped" style="display: none">
                <div class="card-body card-body-cascade text-center">

                    <h4 class="card-title"><strong>Skipped questions</strong></h4>

                    <!-- Skipped -->
                    <div class="list-group skipped-questions">
                        <button type="button"
                                class="list-group-item list-group-item-action waves-effect d-flex justify-content-between align-items-center"
                                title="Tooltip">
                            <span class="d-inline-block text-truncate">Skipped question</span>&nbsp;&nbsp;
                            <span class="badge badge-success badge-pill">50s</span>
                        </button>
                    </div>

                </div>
            </div>
            <!-- Quiz Skipped -->

            <!-- Quiz Summary -->
            <div class="card quiz-summary" style="display: none">
                <div class="card-body card-body-cascade text-center">

                    <!-- Result -->
                    <span class="min-chart summary-chart" data-percent="100"><span
                            class="percent"></span></span>
                    <h5><span class="label success-color badge summary-badge">
                        <span class="summary-correct">correct/num</span> <i class="fas fa-check"></i> &nbsp;
                        <span class="summary-points">score/total</span> points</span></h5>

                    <br>

                    <!-- Form -->
                    <form class="text-center">

                        <div class="form-row">
                            <div class="col">
                                <!-- First name -->
                                <div class="md-form">
                                    <input type="text" id="input-4" class="form-control first-name">
                                    <label for="input-4">First name</label>
                                </div>
                            </div>
                            <div class="col">
                                <!-- Last name -->
                                <div class="md-form">
                                    <input type="email" id="input-5" class="form-control last-name">
                                    <label for="input-5">Last name</label>
                                </div>
                            </div>
                        </div>

                        <!-- E-mail -->
                        <div class="md-form mt-0">
                            <input type="email" id="input-6" class="form-control email">
                            <label for="input-6">E-mail</label>
                        </div>

                        <!-- Send button -->
                        <button type="button"
                                class="btn blue-gradient btn-rounded btn-block my-4 waves-effect z-depth-0 submit-button">
                            Send
                        </button>

                    </form>

                </div>
            </div>
            <!-- Quiz Summary -->

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

    let view_1 = new View('quiz-view-1', <%=quizzes.get(0).getQuestions().size()%>);
    let controller_1 = new Controller(<%=quizzes.get(0).getId()%>, view_1);

    $('#quiz-view-1 .start-button').click(function () {
        controller_1.start();
    });

    $('#quiz-view-1 .next-button').click(function () {
        controller_1.next();
    });

    $('#quiz-view-1 .skip-button').click(function () {
        controller_1.skip();
    });

    $('#quiz-view-1 .question-answers :checkbox').change(function () {
        view_1.handle_checkbox(this.checked);
    });

    $('#quiz-view-1 .submit-button').click(function () {
        controller_1.submit();
    });

    view_1.subscribe_revisit((question) => controller_1.revisit(question));

    let view_2 = new View('quiz-view-2', <%=quizzes.get(1).getQuestions().size()%>);
    let controller_2 = new Controller(<%=quizzes.get(1).getId()%>, view_2);

    $('#quiz-view-2 .start-button').click(function () {
        controller_2.start();
    });

    $('#quiz-view-2 .next-button').click(function () {
        controller_2.next();
    });

    $('#quiz-view-2 .skip-button').click(function () {
        controller_2.skip();
    });

    $('#quiz-view-2 .question-answers :checkbox').change(function () {
        view_2.handle_checkbox(this.checked);
    });

    $('#quiz-view-2 .submit-button').click(function () {
        controller_2.submit();
    });

    view_2.subscribe_revisit((question) => controller_2.revisit(question));

    $(window).on('beforeunload', function () {
        controller_1.terminate();
        controller_2.terminate();
    });

</script>

</body>
</html>
