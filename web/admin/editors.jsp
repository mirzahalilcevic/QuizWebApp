<%@ page import="qwa.domain.Editor" %>
<%@ page import="java.util.List" %>
<%@ page import="qwa.dao.AbstractDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>Editors</title>

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
    <style>
        body {
            color: #b0b0b1;
            background: #17141f;
        }
    </style>

</head>
<body>

<div class="modal fade" id="editor-modal" tabindex="-1" role="dialog" aria-labelledby="editor-modal" aria-hidden="true">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content form-elegant">

            <div class="modal-body text-center">

                <h4 class="modal-title"><strong>New editor</strong></h4>
                <br>
                <div class="form-row">

                    <div class="col">
                        <div class="md-form">
                            <input type="text" id="first-name" class="form-control text-white">
                            <label for="first-name">First name</label>
                        </div>
                    </div>

                    <div class="col">
                        <div class="md-form">
                            <input type="text" id="last-name" class="form-control text-white">
                            <label for="last-name">Last name</label>
                        </div>
                    </div>

                </div>

                <div class="md-form">
                    <input type="text" id="username" class="form-control text-white" required>
                    <label for="username">Username</label>
                    <div class="invalid-feedback">
                        Pleas choose a username.
                    </div>
                </div>

                <div class="md-form">
                    <input type="text" id="password" class="form-control text-white" required>
                    <label for="password">Password</label>
                    <div class="invalid-feedback">
                        Please choose a password.
                    </div>
                </div>
                <br>
                <div class="text-center">
                    <button type="button" class="btn blue-gradient btn-rounded btn-block" id="save-button">Save</button>
                    <br>
                    <button type="button" class="btn btn-outline-info btn-rounded btn-block" data-dismiss="modal">
                        Cancel
                    </button>
                </div>

            </div>

        </div>
    </div>
</div>

<div class="container wrapper">
    <div class="row">

        <div class="col flex-center">
            <div class="table-responsive table-borderless text-nowrap">

                <table class="table text-white" id="editor-table">
                    <caption>List of editors</caption>
                    <thead>
                    <tr>
                        <th scope="col" class="align-middle">First name</th>
                        <th scope="col" class="align-middle">Last name</th>
                        <th scope="col" class="align-middle">Username</th>
                        <th scope="col" class="align-middle">Password</th>
                        <th scope="col" class="text-right">
                            <button type="button" class="btn btn-sm btn-primary btn-rounded waves-effect"
                                    id="add-button" data-toggle="modal" data-target="#editor-modal">
                                <i class="fas fa-plus"></i> Add
                            </button>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Object> editors = AbstractDao.get(Editor.class);
                        for (Object editor : editors) {
                    %>
                    <tr>
                        <td class="align-middle">
                            <div class="md-form">
                                <input type="text" id="first-name-<%=((Editor) editor).getId()%>"
                                       class="form-control text-white" value="<%=((Editor) editor).getFirstName()%>">
                                <label for="first-name-<%=((Editor) editor).getId()%>">First name</label>
                            </div>
                        </td>
                        <td class="align-middle">
                            <div class="md-form">
                                <input type="text" id="last-name-<%=((Editor) editor).getId()%>"
                                       class="form-control text-white" value="<%=((Editor) editor).getLastName()%>">
                                <label for="last-name-<%=((Editor) editor).getId()%>">Last name</label>
                            </div>
                        </td>
                        <td class="align-middle">
                            <div class="md-form">
                                <input type="text" id="username-<%=((Editor) editor).getId()%>"
                                       class="form-control text-white" value="<%=((Editor) editor).getUsername()%>">
                                <label for="username-<%=((Editor) editor).getId()%>">Username</label>
                            </div>
                        </td>
                        <td class="align-middle">
                            <div class="md-form">
                                <input type="text" id="password-<%=((Editor) editor).getId()%>"
                                       class="form-control text-white" value="<%=((Editor) editor).getPassword()%>">
                                <label for="password-<%=((Editor) editor).getId()%>">Password</label>
                            </div>
                        </td>
                        <td class="text-right align-middle" data-id="<%=((Editor) editor).getId()%>">
                            <button type="button" class="btn btn-sm btn-secondary btn-rounded waves-effect edit-button">
                                <i class="fas fa-magic mr-1"></i> Edit
                            </button>
                            <button type="button" class="btn btn-sm btn-danger btn-rounded waves-effect delete-button">
                                <i class="fas fa-times"></i> Delete
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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/admin/editors.js"></script>
<script>
    $(document).ready(function () {
        $('#editor-table').DataTable({
            "ordering": false,
            "searching": false
        });
        $('.dataTables_length').addClass('bs-select');
    });
</script>

</body>
</html>
