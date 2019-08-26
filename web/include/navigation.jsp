<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="qwa.servlet.LoginServlet" %>

<nav class="navbar d-flex justify-content-between animated fadeIn" style="z-index: 10;">
    <span>
        <a class="btn-floating blue-gradient btn-sm" href="<%=request.getContextPath()%>/home">
            <i class="fas fa-home"></i>
        </a>
        <button id="player-count" class="btn btn-outline-info btn-rounded btn-sm">N/A</button>
    </span>
    <%
        String user = (String) request.getSession().getAttribute("user");
        if (user == null) {
    %>
    <button type="button" class="btn blue-gradient btn-rounded btn-sm"
            onclick="window.location='<%=request.getContextPath()%>/login'">
        Log In &nbsp;<i class="fas fa-sign-in-alt"></i>
    </button>
    <% } else if (user.equals(LoginServlet.superAdminUsername)) { %>
    <div class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown">
            <strong>
                <%=user%>
            </strong>
        </a>
        <div class="dropdown-menu dropdown-menu-right">
            <a class="dropdown-item" href="<%=request.getContextPath()%>/admin/quiz">Manage quizzes</a>
            <a class="dropdown-item" href="<%=request.getContextPath()%>/admin/editor">Manage editors</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="<%=request.getContextPath()%>/login?logout">Log out</a>
        </div>
        &nbsp;&nbsp;
    </div>
    <% } else { %>

    <div class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown">
            <strong>
                <%=user%>
            </strong>
        </a>
        <div class="dropdown-menu dropdown-menu-right">
            <a class="dropdown-item" href="<%=request.getContextPath()%>/admin/quiz">My quizzes</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="<%=request.getContextPath()%>/login?logout">Log out</a>
        </div>
        &nbsp;&nbsp;
    </div>
    <% } %>
</nav>
