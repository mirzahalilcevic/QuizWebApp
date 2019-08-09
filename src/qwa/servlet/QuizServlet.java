package qwa.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonParseException;
import qwa.dao.AbstractDao;
import qwa.domain.Quiz;
import qwa.events.*;
import qwa.session.QuizAutomaton;

import javax.persistence.NoResultException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(description = "QuizServlet", urlPatterns = {"/quiz/*"})
public class QuizServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            // fetch quiz with given ID
            int id = id(req.getPathInfo());
            var quiz = (Quiz) AbstractDao.get(Quiz.class, id);

            // create collection of active quizzes if it doesn't exist
            var active = (Map<Integer, QuizAutomaton>) req.getSession().getAttribute("active");
            if (active == null) {
                active = new HashMap<>();
                req.getSession().setAttribute("active", active);
            }

            // create state machine for given quiz if it doesn't exist
            if (active.get(id) == null) {
                var automaton = new QuizAutomaton(quiz);
                active.put(id, automaton);
            }

            req.setAttribute("quiz", quiz);
            req.getRequestDispatcher("/quiz.jsp").forward(req, resp);

        } catch (NumberFormatException | NoResultException e) {
            req.getRequestDispatcher("/error.html").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {

            int id = id(req.getPathInfo());

            var active = (Map<Integer, QuizAutomaton>) req.getSession().getAttribute("active");
            if (active == null)
                return;

            // fetch current quiz's state machine
            var automaton = active.get(id);
            if (automaton == null)
                return;

            // dispatch request to state machine and send response if message is not null
            var message = dispatch(automaton, req);
            if (message != null) {

                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");

                var out = resp.getWriter();
                out.print(message);
                out.flush();

                if (automaton.isDone())
                    active.remove(id);
            }

        } catch (NumberFormatException | JsonParseException ignored) {
        }
    }

    // extract quiz ID from path
    private int id(String path) throws NumberFormatException {
        return Integer.parseInt(path.substring(1));
    }

    private String dispatch(QuizAutomaton automaton, HttpServletRequest req) throws JsonParseException {

        var event = req.getParameter("event");
        if (event == null || event.isEmpty())
            return null;

        switch (event) {
            case "start":
                return automaton.process(new Start());
            case "answer":
                var answers = req.getParameter("answers");
                if (answers == null)
                    return null;
                else
                    return automaton.process(gson.fromJson(answers, Answer.class));
            case "next":
                return automaton.process(new Next());
            case "skip":
                var remaining = req.getParameter("remaining");
                if (remaining == null)
                    return null;
                else
                    return automaton.process(gson.fromJson(remaining, Skip.class));
            case "revisit":
                var question = req.getParameter("question");
                if (question == null)
                    return null;
                else
                    return automaton.process(gson.fromJson(question, Revisit.class));
            case "submit":
                return automaton.process(new Submit());
            default:
                return null;
        }
    }

    private static final Gson gson = new Gson();
}
