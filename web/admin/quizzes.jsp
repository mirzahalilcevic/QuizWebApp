<%@ page import="java.util.List" %>
<%@ page import="qwa.dao.AbstractDao" %>
<%@ page import="qwa.domain.Quiz" %>
<%@ page import="qwa.domain.Editor" %>
<%@ page import="qwa.dao.EditorDao" %>
<%@ page import="qwa.dao.QuizDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%! private final QuizDao dao = new QuizDao(); %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>My quizzes</title>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <!-- Bootstrap core CSS -->
    <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="<%=request.getContextPath()%>/css/mdb.min.css" rel="stylesheet">
    <!-- MDBootstrap Datatables  -->
    <link href="<%=request.getContextPath()%>/css/addons/datatables.min.css" rel="stylesheet">
    <!-- Custom styles -->
    <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">

</head>
<body>

<div class="animated fadeIn fast">
    <%@ include file="/include/navigation.jsp" %>
</div>

<div class="container wrapper animated fadeIn fast">
    <div class="row">

        <div class="col flex-center">
            <div class="table-responsive table-borderless text-nowrap">

                <table class="table text-white" id="quiz-table" style="margin-top: 3%;">
                    <caption>List of quizzes</caption>
                    <thead>
                    <tr>
                        <th scope="col" class="align-middle">Image</th>
                        <th scope="col" class="align-middle">Title</th>
                        <th scope="col" class="align-middle">Description</th>
                        <th scope="col" class="align-middle text-center">Active</th>
                        <th scope="col" class="align-middle text-right"></th>
                        <th scope="col" class="text-right">
                            <button type="button" class="btn btn-sm btn-primary btn-rounded waves-effect"
                                    onclick="window.location='<%=request.getContextPath()%>/admin/quiz/new'">
                                <i class="fas fa-plus mr-1"></i>&nbsp; Add
                            </button>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Quiz> quizzes = null;
                        user = (String) request.getSession().getAttribute("user");
                        if (user.equals(LoginServlet.superAdminUsername))
                            quizzes = (List<Quiz>) (List<?>) AbstractDao.get(Quiz.class);
                        else {
                            quizzes = dao.get(user);
                        }
                        for (Quiz quiz : quizzes) {
                    %>
                    <tr>
                        <td class="align-middle">
                            <img src="<%=quiz.getImage() != null && !quiz.getImage().isEmpty() ? quiz.getImage() : "https://icon-library.net/images/no-image-available-icon/no-image-available-icon-6.jpg"%>"
                                 alt="thumbnail" class="img-thumbnail" style="width: 150px">
                        </td>
                        <td class="align-middle">
                            <span class="d-inline-block text-truncate" style="max-width: 100px;">
                                <%=quiz.getName()%>
                            </span>
                        </td>
                        <td class="align-middle">
                            <span class="d-inline-block text-truncate" style="max-width: 200px;">
                                <%=quiz.getDescription()%>
                            </span>
                        </td>
                        <td class="align-middle text-center">
                            <div class="switch">
                                <label>
                                    <input type="checkbox"
                                           data-id="<%=quiz.getId()%>" <%=quiz.isActive() ? "checked" : ""%>>
                                    <span class="lever"></span>
                                </label>
                            </div>
                        </td>
                        <td class="text-right align-middle">
                            <form action="<%=request.getContextPath()%>/admin/quiz/<%=quiz.getId()%>" method="post">
                                <input type="hidden" name="export">
                                <button type="submit" class="btn btn-sm btn-default btn-rounded waves-effect"
                                        onclick="">
                                    <i class="fas fa-file-export mr-1"></i>&nbsp; INBOX
                                </button>
                            </form>
                        </td>
                        <td class="text-right align-middle">
                            <button type="button" class="btn btn-sm btn-secondary btn-rounded waves-effect"
                                    onclick="window.location='<%=request.getContextPath()%>/admin/quiz/<%=quiz.getId()%>'">
                                <i class="fas fa-magic mr-1"></i>&nbsp; EDIT
                            </button>
                            <button type="button" class="btn btn-sm btn-danger btn-rounded waves-effect delete-button"
                                    data-id="<%=quiz.getId()%>">
                                <i class="fas fa-times mr-1"></i>&nbsp; Delete
                            </button>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>

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
<!-- MDBootstrap Datatables  -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/addons/datatables.min.js"></script>
<!-- Custom scripts -->
<script>

    $(document).ready(function () {
        $('#quiz-table').DataTable({
            "ordering": false,
            "searching": false,
            "scrollX": false
        });
        $('.dataTables_length').addClass('bs-select');
    });

    $('.switch input').change(function () {
        $.post('<%=request.getContextPath()%>/admin/quiz/' + $(this).attr('data-id'),
            'active=' + this.checked, data => console.log(data));
    });

    $('.delete-button').click(function () {

        let id = $(this).attr('data-id');
        if (!confirm('Are you sure?'))
            return;

        $(this).html('<span class="spinner-border spinner-border-sm mr-2" role="status" aria-hidden="true"></span>').addClass('disabled');
        $.ajax({
            url: '/admin/quiz/' + id,
            method: 'DELETE',
            success: data => {
                if (data.success)
                    $(this).parent().parent().fadeOut(300, () => {
                        toastr.success("Done.");
                        $(this).parent().parent().remove()
                    });
                else {
                    toastr.error(data.message);
                    $(this).html('<i class="fas fa-times"></i> Delete').removeClass('disabled');
                }
            }
        });
    });


    let socket = new WebSocket("ws://<%=request.getServerName()%>:<%=request.getServerPort()%>/players");

    socket.onmessage = function (event) {
        $('#player-count').text('Players: ' + event.data);
    };

</script>


</body>
</html>
