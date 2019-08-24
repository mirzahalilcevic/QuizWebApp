<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>Log in</title>

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

        <div class="col flex-center animated fadeIn">
            <div class="card" style="margin-top: 10%">

                <div class="card-body text-center">

                    <h4 class="card-title">
                        <strong>Log in</strong>
                    </h4>

                    <%
                        String error = (String) request.getAttribute("error");
                        if (error != null) {
                    %>
                    <span class="text-danger"><%=error%></span>
                    <% } %>

                    <form class="text-center" action="<%=request.getContextPath()%>/login" method="post">

                        <div class="md-form">
                            <input type="text" id="username" class="form-control text-white" name="username">
                            <label for="username">Username</label>
                        </div>

                        <div class="md-form">
                            <input type="password" id="password" class="form-control text-white" name="password">
                            <label for="password">Password</label>
                        </div>

                        <button class="btn blue-gradient btn-rounded btn-block waves-effect z-depth-0"
                                type="submit">
                            Log in
                        </button>

                    </form>
                    <br>
                    <button class="btn btn-outline-info btn-rounded btn-block waves-effect z-depth-0"
                            onclick="window.history.back()">
                        Back
                    </button>

                </div>

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

</body>
</html>
