package qwa.servlet;

import com.google.gson.Gson;
import qwa.dao.EditorDao;
import qwa.messages.Ack;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(description = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    public static final String superAdminUsername = "admin";
    public static final String superAdminPassword = "admin";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        var username = req.getParameter("username");
        if (username == null || username.isEmpty()) {
            sendJson(resp, gson.toJson(new Ack(false, "Username can't be empty.")));
            return;
        }

        var password = req.getParameter("password");
        if (password == null || password.isEmpty()) {
            sendJson(resp, gson.toJson(new Ack(false, "Password can't be empty.")));
            return;
        }

        if (username.equals(superAdminUsername)) {

            if (password.equals(superAdminPassword)) {
                req.getSession().setAttribute("user", superAdminUsername);
                resp.sendRedirect("/admin/home");
            } else
                sendJson(resp, gson.toJson(new Ack(false, "Incorrect password.")));

            return;
        }

        var editor = dao.get(username);
        if (editor == null) {
            sendJson(resp, gson.toJson(new Ack(false, "User doesn't exist.")));
            return;
        }

        if (!editor.getPassword().equals(password)) {
            sendJson(resp, gson.toJson(new Ack(false, "Incorrect password.")));
            return;
        }

        req.getSession().setAttribute("user", editor);
        resp.sendRedirect("/admin/home");
    }

    private final Gson gson = new Gson();
    private final EditorDao dao = new EditorDao();

    private void sendJson(HttpServletResponse resp, String json) throws IOException {

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        var out = resp.getWriter();
        out.print(json);
        out.flush();
    }
}
