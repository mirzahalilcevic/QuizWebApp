package qwa.servlet.admin;

import com.google.gson.Gson;
import qwa.dao.AbstractDao;
import qwa.dao.EditorDao;
import qwa.domain.Editor;
import qwa.messages.Ack;
import qwa.util.SecurityUtil;

import javax.persistence.NoResultException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(description = "EditorServlet", urlPatterns = {"/admin/editor/*"})
public class EditorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (req.getPathInfo() != null && !req.getPathInfo().equals("/")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        req.getRequestDispatcher("/admin/editors.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (req.getPathInfo() != null && !req.getPathInfo().equals("/")) {
            doPut(req, resp);
            return;
        }

        var firstName = req.getParameter("firstName");
        var lastName = req.getParameter("lastName");

        var username = req.getParameter("username");
        if (username == null || username.isEmpty()) {
            sendJson(resp, gson.toJson(new Ack(false, "Username can't be empty.")));
            return;
        }

        if (dao.get(username) != null) {
            sendJson(resp, gson.toJson(new Ack(false, "Username already taken.")));
            return;
        }

        var password = req.getParameter("password");
        if (password == null || password.isEmpty()) {
            sendJson(resp, gson.toJson(new Ack(false, "Password can't be empty.")));
            return;
        }

        var editor = new Editor(firstName, lastName, username, SecurityUtil.hashPassword(password));
        AbstractDao.save(editor);

        sendJson(resp, gson.toJson(new Ack(true, Integer.toString(editor.getId()))));
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            var firstName = req.getParameter("firstName");
            var lastName = req.getParameter("lastName");

            var username = req.getParameter("username");
            if (username != null && username.isEmpty()) {
                sendJson(resp, gson.toJson(new Ack(false, "Username can't be empty.")));
                return;
            }

            var password = req.getParameter("password");
            if (password != null && password.isEmpty()) {
                sendJson(resp, gson.toJson(new Ack(false, "Password can't be empty.")));
                return;
            }

            int id = id(req.getPathInfo());
            var editor = (Editor) AbstractDao.get(Editor.class, id);

            if (firstName != null)
                editor.setFirstName(firstName);
            if (lastName != null)
                editor.setLastName(lastName);
            if (username != null) {
                var e = dao.get(username);
                if (e != null && e.getId() != editor.getId()) {
                    sendJson(resp, gson.toJson(new Ack(false, "Username already taken.")));
                    return;
                }
                editor.setUsername(username);
            }
            if (password != null)
                editor.setPassword(SecurityUtil.hashPassword(password));

            AbstractDao.update(editor);
            sendJson(resp, gson.toJson(new Ack(true, null)));

        } catch (NumberFormatException | NoResultException ignored) {
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            int id = id(req.getPathInfo());
            var editor = (Editor) AbstractDao.get(Editor.class, id);

            AbstractDao.update(editor);
            AbstractDao.delete(editor);

            sendJson(resp, gson.toJson(new Ack(true, null)));

        } catch (NumberFormatException | NoResultException ignored) {
        }
    }

    private final Gson gson = new Gson();
    private final EditorDao dao = new EditorDao();

    private int id(String path) throws NumberFormatException {
        if (path == null) throw new NumberFormatException();
        return Integer.parseInt(path.substring(1));
    }

    private void sendJson(HttpServletResponse resp, String json) throws IOException {

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        var out = resp.getWriter();
        out.print(json);
        out.flush();
    }
}
