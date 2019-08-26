package qwa.servlet.admin;

import com.google.gson.Gson;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;
import qwa.dao.AbstractDao;
import qwa.dao.EditorDao;
import qwa.dao.QuizDao;
import qwa.domain.Editor;
import qwa.domain.Quiz;
import qwa.domain.Score;
import qwa.messages.Ack;
import qwa.servlet.LoginServlet;

import javax.persistence.NoResultException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(description = "QuizServlet", urlPatterns = {"/admin/quiz/*"})
public class QuizServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            if (req.getPathInfo() != null && !req.getPathInfo().equals("/")) {

                int id = id(req.getPathInfo());
                var quiz = (Quiz) AbstractDao.get(Quiz.class, id);

                req.setAttribute("quiz", quiz);
                req.getRequestDispatcher("/admin/quiz.jsp").forward(req, resp);

                return;
            }

            req.getRequestDispatcher("/admin/quizzes.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } catch (NoResultException e) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (req.getPathInfo() != null && !req.getPathInfo().equals("/")) {
            doPut(req, resp);
            return;
        }

        var image = req.getParameter("image");

        var name = req.getParameter("name");
        if (name == null || name.isEmpty()) {
            sendJson(resp, gson.toJson(new Ack(false, "Name can't be empty.")));
            return;
        }

        var description = req.getParameter("description");

        var questionsParam = req.getParameter("questions");
        if (questionsParam == null || questionsParam.isEmpty()) {
            sendJson(resp, gson.toJson(new Ack(false, "Questions can't be empty.")));
            return;
        }

        var questions = getQuestions(resp, questionsParam);
        if (questions == null)
            return;

        var editor = req.getParameter("username");

        var quiz = new Quiz(editor, image, name, description, questions, true);

        AbstractDao.save(quiz);
        sendJson(resp, gson.toJson(new Ack(true, Integer.toString(quiz.getId()))));
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            var image = req.getParameter("image");

            var name = req.getParameter("name");
            if (name != null && name.isEmpty()) {
                sendJson(resp, gson.toJson(new Ack(false, "Name can't be empty.")));
                return;
            }

            var description = req.getParameter("description");

            var questionsParam = req.getParameter("questions");
            if (questionsParam != null && questionsParam.isEmpty()) {
                sendJson(resp, gson.toJson(new Ack(false, "Questions can't be empty.")));
                return;
            }

            var active = req.getParameter("active");

            int id = id(req.getPathInfo());
            var quiz = (Quiz) AbstractDao.get(Quiz.class, id);

            var export = req.getParameter("export");
            if (export != null) {
                sendCsv(resp, quiz.getScores(), id);
                return;
            }

            if (image != null)
                quiz.setImage(image);
            if (name != null)
                quiz.setName(name);
            if (description != null)
                quiz.setDescription(description);
            if (active != null) {
                if (active.equals("true"))
                    quiz.activate();
                else if (active.equals("false"))
                    quiz.deactivate();
                else {
                    sendJson(resp, gson.toJson(new Ack(false, "Invalid active value.")));
                    return;
                }
            }
            if (questionsParam != null) {
                var questions = getQuestions(resp, questionsParam);
                if (questions != null)
                    quiz.setQuestions(questions);
                else
                    return;
            }

            AbstractDao.update(quiz);
            sendJson(resp, gson.toJson(new Ack(true, null)));

        } catch (NumberFormatException | NoResultException ignored) {
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            int id = id(req.getPathInfo());
            var quiz = (Quiz) AbstractDao.get(Quiz.class, id);

            AbstractDao.update(quiz);
            AbstractDao.delete(quiz);

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

    private void sendCsv(HttpServletResponse resp, List<Score> scores, int id) throws IOException {

        var stringWriter = new StringWriter();
        var csvPrinter = new CSVPrinter(stringWriter, CSVFormat.DEFAULT.withHeader("FirstName", "LastName", "Email", "Score"));

        for (var score : scores)
            csvPrinter.printRecord(score.getPlayer().getFirstName(), score.getPlayer().getLastName(),
                    score.getPlayer().getEmail(), score.getScore());

        csvPrinter.flush();

        resp.setContentType("text/csv");
        resp.setCharacterEncoding("UTF-8");
        resp.setHeader("Content-Disposition", "attachment; filename=\"inbox" + id + ".csv\"");

        var out = resp.getWriter();
        out.print(stringWriter.toString());
        out.flush();
    }

    private List<qwa.domain.Question> getQuestions(HttpServletResponse resp, String questionsParam) throws IOException {

        var questionsArray = gson.fromJson(questionsParam, Question[].class);
        if (questionsArray == null || questionsArray.length == 0) {
            sendJson(resp, gson.toJson(new Ack(false, "There must be at least one question.")));
            return null;
        }

        var questions = new ArrayList<qwa.domain.Question>();
        for (var question : questionsArray) {

            if (question.text == null || question.text.isEmpty()) {
                sendJson(resp, gson.toJson(new Ack(false, "Question text can't be empty.")));
                return null;
            }

            if (question.time <= 0 || question.time > 60) {
                sendJson(resp, gson.toJson(new Ack(false, "Question time must be in reange (0, 60].")));
                return null;
            }

            if (question.points <= 0) {
                sendJson(resp, gson.toJson(new Ack(false, "Question points must be positive")));
                return null;
            }

            if (question.answers == null || question.answers.size() == 0) {
                sendJson(resp, gson.toJson(new Ack(false, "There must be at least one answer.")));
                return null;
            } else if (question.answers.size() > 5) {
                sendJson(resp, gson.toJson(new Ack(false, "There can't be more than 5 answers.")));
                return null;
            } else {

                var answers = new ArrayList<qwa.domain.Answer>();

                int correct = 0;
                for (var answer : question.answers) {

                    if (answer.text == null || answer.text.isEmpty()) {
                        sendJson(resp, gson.toJson(new Ack(false, "Answer text can't be empty.")));
                        return null;
                    }

                    if (answer.correctness)
                        correct++;

                    answers.add(new qwa.domain.Answer(answer.text, answer.correctness));
                }

                if (correct == 0) {
                    sendJson(resp, gson.toJson(new Ack(false, "There must be at least one correct answer.")));
                    return null;
                }

                questions.add(new qwa.domain.Question(question.text, answers, question.time, question.points));
            }
        }

        return questions;
    }

    private class Question {
        String text;
        List<Answer> answers;
        int time;
        int points;
    }

    private class Answer {
        String text;
        boolean correctness;
    }
}
