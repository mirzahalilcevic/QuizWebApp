<%@ page import="qwa.domain.Quiz" %>
<%@ page import="qwa.domain.Question" %>
<%@ page import="qwa.domain.Answer" %>


<% final Quiz quiz = (Quiz) request.getAttribute("quiz"); %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title><%=quiz != null ? "Edit quiz" : "New quiz"%>
    </title>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <!-- Bootstrap core CSS -->
    <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="<%=request.getContextPath()%>/css/mdb.min.css" rel="stylesheet">
    <!-- Custom styles -->
    <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">
    <style>
        td .md-form {
            margin: -3% auto;
        }
    </style>

</head>
<body>

<div class="modal fade right" id="question-modal" tabindex="-1" role="dialog" aria-labelledby="question-modal"
     aria-hidden="true">
    <div class="modal-dialog modal-full-height modal-right" role="document">
        <div class="modal-content form-elegant">

            <div class="modal-body text-center">

                <h4 class="modal-title"><strong>New question</strong></h4>
                <div class="form-row">

                    <div class="col-md-7">
                        <div class="md-form">
                            <input type="text" id="question-text" class="form-control text-white"></input>
                            <label for="question-text">Text</label>
                        </div>
                    </div>

                    <div class="col">
                        <div class="md-form">
                            <input type="number" id="question-time" class="form-control text-white">
                            <label for="question-time">Time</label>
                        </div>
                    </div>

                    <div class="col">
                        <div class="md-form">
                            <input type="number" id="question-points" class="form-control text-white">
                            <label for="question-points">Points</label>
                        </div>
                    </div>

                </div>

                <div class="form-row">
                    <table class="table table-borderless">
                        <tbody>
                        <tr>
                            <td class="align-middle">
                                <div class="md-form">
                                    <input type="text" id="answer-text-1" class="form-control text-white" value="">
                                    <label for="answer-text-1">Answer 1</label>
                                </div>
                            </td>
                            <td class="align-middle text-right">
                                <div class="form-check question-answers checkbox-custom">
                                    <input type="checkbox" class="form-check-input" id="answer-correct-1">
                                    <label class="form-check-label" for="answer-correct-1"></label>
                                </div>
                            </td>
                            <td class="align-middle text-right">
                                <div class="switch text-right">
                                    <label>
                                        <input type="checkbox" id="answer-active-1">
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="align-middle">
                                <div class="md-form">
                                    <input type="text" id="answer-text-2" class="form-control text-white" value="">
                                    <label for="answer-text-2">Answer 2</label>
                                </div>
                            </td>
                            <td class="align-middle text-right">
                                <div class="form-check question-answers checkbox-custom">
                                    <input type="checkbox" class="form-check-input" id="answer-correct-2">
                                    <label class="form-check-label" for="answer-correct-2"></label>
                                </div>
                            </td>
                            <td class="align-middle text-right">
                                <div class="switch text-right">
                                    <label>
                                        <input type="checkbox" id="answer-active-2">
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="align-middle">
                                <div class="md-form">
                                    <input type="text" id="answer-text-3" class="form-control text-white" value="">
                                    <label for="answer-text-3">Answer 3</label>
                                </div>
                            </td>
                            <td class="align-middle text-right">
                                <div class="form-check question-answers checkbox-custom">
                                    <input type="checkbox" class="form-check-input" id="answer-correct-3">
                                    <label class="form-check-label" for="answer-correct-3"></label>
                                </div>
                            </td>
                            <td class="align-middle text-right">
                                <div class="switch text-right">
                                    <label>
                                        <input type="checkbox" id="answer-active-3">
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="align-middle">
                                <div class="md-form">
                                    <input type="text" id="answer-text-4" class="form-control text-white" value="">
                                    <label for="answer-text-4">Answer 4</label>
                                </div>
                            </td>
                            <td class="align-middle text-right">
                                <div class="form-check question-answers checkbox-custom">
                                    <input type="checkbox" class="form-check-input" id="answer-correct-4">
                                    <label class="form-check-label" for="answer-correct-4"></label>
                                </div>
                            </td>
                            <td class="align-middle text-right">
                                <div class="switch text-right">
                                    <label>
                                        <input type="checkbox" id="answer-active-4">
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="align-middle">
                                <div class="md-form">
                                    <input type="text" id="answer-text-5" class="form-control text-white" value="">
                                    <label for="answer-text-5">Answer 5</label>
                                </div>
                            </td>
                            <td class="align-middle text-right">
                                <div class="form-check question-answers checkbox-custom">
                                    <input type="checkbox" class="form-check-input" id="answer-correct-5">
                                    <label class="form-check-label" for="answer-correct-5"></label>
                                </div>
                            </td>
                            <td class="align-middle text-right">
                                <div class="switch text-right">
                                    <label>
                                        <input type="checkbox" id="answer-active-5">
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <br>
                <div class="text-center">
                    <button type="button" class="btn blue-gradient btn-rounded btn-block" id="save-question-button">
                        Save
                    </button>
                    <br>
                    <button type="button" class="btn btn-outline-info btn-rounded btn-block" data-dismiss="modal">
                        Cancel
                    </button>
                </div>

            </div>

        </div>
    </div>
</div>

<div class="container wrapper animated fadeIn fast" style="width: 500px">
    <div class="row">
        <div class="col-sm text-center">

            <div class="text-right">
                <button type="button" class="btn btn-sm btn-rounded purple-gradient"
                        onclick="window.location='<%=request.getContextPath()%>/admin/quiz'">Cancel
                </button>
                <button type="button" class="btn btn-sm btn-rounded blue-gradient" id="save-quiz-button"
                        data-username="<%=request.getSession().getAttribute("user")%>">Save &nbsp;<i
                        class="far fa-save ml-1"></i></button>
            </div>
            <br>
            <img src="<%=quiz != null && quiz.getImage() != null && !quiz.getImage().isEmpty() ? quiz.getImage() : "https://icon-library.net/images/no-image-available-icon/no-image-available-icon-6.jpg"%>"
                 class="img-fluid" style="width: 400px;">

            <div class="md-form">
                <input type="text" id="quiz-image" class="form-control text-white"
                       value="<%=quiz != null && quiz.getImage() != null ? quiz.getImage() : ""%>">
                <label for="quiz-image">Image URL</label>
            </div>

            <div class="md-form">
                <input type="text" id="quiz-name" class="form-control text-white"
                       value="<%=quiz != null ? quiz.getName() : ""%>">
                <label for="quiz-name">Name</label>
            </div>

            <div class="md-form">
                <textarea id="quiz-desc"
                          class="form-control md-textarea text-white"><%=quiz != null && quiz.getDescription() != null ? quiz.getDescription() : ""%></textarea>
                <label for="quiz-desc">Description</label>
            </div>

            <div class="card">
                <div class="card-body card-body-cascade text-right">

                    <h4 class="card-title text-center"><strong>Questions</strong></h4>

                    <a class="btn-floating btn-sm btn-primary" id="add-question-button">
                        <i class="fas fa-plus mr-1"></i>
                    </a> &nbsp;&nbsp;&nbsp;&nbsp;

                    <ul id="sortable" class="list-group">
                        <%
                            if (quiz != null) {
                                for (Question question : quiz.getQuestions()) {
                                    StringBuilder answers = new StringBuilder("[");
                                    for (Answer answer : question.getAnswers())
                                        answers.append("{'text':'").append(answer.getText()).append("','correctness':").append(answer.getCorrectness()).append("},");
                                    answers = new StringBuilder(answers.substring(0, answers.length() - 1) + "]");
                        %>
                        <li class="list-group-item d-flex justify-content-between align-items-center"
                            data-text="<%=question.getText()%>"
                            data-time="<%=question.getTime()%>"
                            data-points="<%=question.getPoints()%>"
                            data-answers="<%=answers.toString()%>">
                            <span class="d-inline-block text-truncate text" style="max-width: 230px;"><%=question.getText()%></span>
                            <span>
                                <a class="btn-floating btn-sm btn-secondary edit-question-button">
                                    <i class="fas fa-magic mr-1"></i>
                                </a>
                                <a class="btn-floating btn-sm btn-danger delete-question-button">
                                    <i class="fas fa-times mr-1"></i>
                                </a>
                            </span>
                        </li>
                        <%
                                }
                            }
                        %>
                    </ul>

                </div>
            </div>

        </div>
    </div>
</div>

<!-- SCRIPTS -->
<!-- JQuery -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.4.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"
        integrity="sha256-eGE6blurk5sHj+rmkfsGYeKyZx3M4bG+ZlFyA7Kns7E="
        crossorigin="anonymous"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/mdb.min.js"></script>
<!-- Custom scripts -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/admin/quiz.js"></script>
<script>

    $('#sortable').sortable();

    $('#save-quiz-button').click(function () {

        let image = $('#quiz-image').val();
        let name = $('#quiz-name').val();
        let desc = $('#quiz-desc').val();

        let questions = [];
        $('#sortable').children().each((index, child) => {
            let text = $(child).attr('data-text');
            let time = $(child).attr('data-time');
            let points = $(child).attr('data-points');
            let answers = JSON.parse($(child).attr('data-answers').replace(/'/g, '"'));
            questions.push({text: text, answers: answers, time: time, points: points});
        });

        let msg = 'image=' + image
            + '&name=' + name
            + '&description=' + desc
            + '&questions=' + JSON.stringify(questions);

        let username = $(this).attr('data-username');
        if (username !== 'admin')
            msg = msg + '&username=' + username;

        console.log(msg);

        $(this).html('<span class="spinner-border spinner-border-sm mr-2" role="status" aria-hidden="true"></span>').addClass('disabled');
        $.post('<%=request.getContextPath()%>/admin/quiz<%=quiz != null ? "/" + quiz.getId() : ""%>', msg, data => {
            if (data.success) {
                toastr.success('Done.');
                if (data.message == null)
                    $(this).html('Save &nbsp;<i class="far fa-save ml-1"></i>').removeClass('disabled');
                else
                    window.location = '<%=request.getContextPath()%>/admin/quiz';
            } else {
                toastr.error(data.message);
                $(this).html('Save &nbsp;<i class="far fa-save ml-1"></i>').removeClass('disabled');
            }
        }, 'json');
    });

</script>

</body>
</html>
