package qwa.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonParseException;
import qwa.dao.AbstractDao;
import qwa.domain.Quiz;
import qwa.events.*;
import qwa.session.QuizStateMachine;

import javax.persistence.NoResultException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@WebServlet(description = "QuizServlet", urlPatterns = {"/quiz/*"})
public class QuizServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            int id = id(req.getPathInfo());
            var quiz = (Quiz) AbstractDao.get(Quiz.class, id);

            req.setAttribute("quiz", quiz);
            req.getRequestDispatcher("/quiz.jsp").forward(req, resp);

        } catch (NumberFormatException | NoResultException e) {
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            var active = (Map<Integer, QuizStateMachine>) req.getSession().getAttribute("active");
            if (active == null) {
                active = new ConcurrentHashMap<>();
                req.getSession().setAttribute("active", active);
            }

            int id = id(req.getPathInfo());
            var sm = active.get(id);
            if (sm == null) {
                sm = new QuizStateMachine((Quiz) AbstractDao.get(Quiz.class, id));
                active.put(id, sm);
            }

            var message = dispatch(sm, req);
            if (message != null) {

                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");

                var out = resp.getWriter();
                out.print(message);
                out.flush();
            }

            if (sm.submitted()) {
                // TODO cookies
            }

            if (sm.done())
                active.remove(id);

        } catch (NumberFormatException | NoResultException | JsonParseException ignored) {
        }
    }

    private int id(String path) throws NumberFormatException {
        return Integer.parseInt(path.substring(1));
    }

    private String dispatch(QuizStateMachine sm, HttpServletRequest req) throws JsonParseException {

        var event = req.getParameter("event");
        if (event == null || event.isEmpty())
            return null;

        switch (event) {
            case "start":
                return sm.process(new Start());
            case "answer":
                var answers = req.getParameter("answers");
                if (answers == null)
                    return null;
                else
                    return sm.process(gson.fromJson(answers, Answer.class));
            case "next":
                return sm.process(new Next());
            case "skip":
                var remaining = req.getParameter("remaining");
                if (remaining == null)
                    return null;
                else
                    return sm.process(gson.fromJson(remaining, Skip.class));
            case "revisit":
                var question = req.getParameter("question");
                if (question == null)
                    return null;
                else
                    return sm.process(gson.fromJson(question, Revisit.class));
            case "submit":
                var info = req.getParameter("info");
                if (info == null)
                    return null;
                else
                    return sm.process(gson.fromJson(info, Submit.class));
            case "terminate":
                return sm.process(new Terminate());
            default:
                return null;
        }
    }

    private static final Gson gson = new Gson();
}
