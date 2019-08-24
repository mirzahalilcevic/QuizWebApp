package qwa.session;

import com.google.gson.Gson;
import qwa.dao.AbstractDao;
import qwa.dao.PlayerDao;
import qwa.domain.Player;
import qwa.domain.Quiz;
import qwa.domain.Score;
import qwa.events.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class QuizStateMachine {

    public QuizStateMachine(Quiz quiz) {
        this.quiz = quiz;
    }

    // INIT + start / send_question -> QUESTION
    public String process(Start event) {
        switch (state) {
            case INIT:
                state = QUESTION;
                return gson.toJson(new qwa.messages.Question(quiz, current, 0, null));
            default:
                return null;
        }
    }

    // QUESTION + answer[isCorrect] / (add_correct, inc_score) -> ANSWERED
    // QUESTION + answer -> ANSWERED
    public String process(Answer event) {
        switch (state) {
            case QUESTION:
                var question = quiz.getQuestions().get(current);
                total += question.getPoints();
                boolean isCorrect = event.check(question.getAnswers());
                if (isCorrect) {
                    correct.add(current);
                    score += question.getPoints();
                }
                state = ANSWERED;
                var next = new Next();
                next.correct = isCorrect;
                return process(next); // trigger next question
            default:
                return null;
        }
    }

    // ANSWERED + on_entry<Next> / advance
    // ANSWERED + next[!isLast] / send_question -> QUESTION
    // ANSWERED + next[!hasSkipped] / send_summary -> FINISHED
    // ANSWERED + next / send_skipped -> SKIPPED
    public String process(Next event) {
        switch (state) {
            case ANSWERED:
                advance();
                if (current < quiz.getQuestions().size()) {
                    state = QUESTION;
                    return gson.toJson(new qwa.messages.Question(quiz, current, 0, event.correct));
                } else if (skipped.isEmpty()) {
                    state = FINISHED;
                    return gson.toJson(new qwa.messages.Summary(score, total, correct, event.correct));
                } else {
                    state = SKIPPED;
                    return gson.toJson(new qwa.messages.Skipped(skipped, quiz.getQuestions(), event.correct));
                }
            default:
                return null;
        }
    }

    // QUESTION + on_entry<Skip> / (add_skipped, advance)
    // QUESTION + skip[!isLast] / send_question
    // QUESTION + skip / send_skipped -> SKIPPED
    public String process(Skip event) {
        switch (state) {
            case QUESTION:
                skipped.put(current, event.remaining);
                advance();
                if (current < quiz.getQuestions().size())
                    return gson.toJson(new qwa.messages.Question(quiz, current, 0, null));
                state = SKIPPED;
                return gson.toJson(new qwa.messages.Skipped(skipped, quiz.getQuestions(), null));
            default:
                return null;
        }
    }

    // SKIPPED + on_entry / set_partial_flag
    // SKIPPED + revisit[isSkipped] / (remove_skipped, set_current, send_question) -> QUESTION
    public String process(Revisit event) {
        switch (state) {
            case SKIPPED:
                partial = true;
                if (!skipped.containsKey(event.question))
                    return null;
                var remaining = skipped.get(event.question);
                skipped.remove(event.question);
                current = event.question;
                state = QUESTION;
                return gson.toJson(new qwa.messages.Question(quiz, current, remaining, null));
            default:
                return null;
        }
    }

    // FINISHED + submit / (persist_result, set_submitted_flag, send_ack) -> ZOMBIE
    public String process(Submit event) {
        switch (state) {
            case FINISHED:
                try {
                    AbstractDao.save(score(event));
                    submitted = true;
                    state = ZOMBIE;
                    return gson.toJson(new qwa.messages.Ack(true, null));
                } catch (Exception e) {
                    return gson.toJson(new qwa.messages.Ack(false, null));
                }
            default:
                return null;
        }
    }

    // _ + terminate -> ZOMBIE
    public String process(Terminate event) {
        state = ZOMBIE;
        return null;
    }

    public boolean done() {
        return state == ZOMBIE;
    }

    public boolean submitted() {
        return submitted;
    }

    private final Quiz quiz;
    private int state = INIT;

    private List<Integer> correct = new ArrayList<>();
    private Map<Integer, Integer> skipped = new HashMap<>();

    private int current = 0;
    private int score = 0;
    private int total = 0;

    private boolean partial = false;
    private boolean submitted = false;

    // states
    private static final int INIT = 0;
    private static final int QUESTION = 1;
    private static final int ANSWERED = 2;
    private static final int SKIPPED = 3;
    private static final int FINISHED = 4;
    private static final int ZOMBIE = 5;

    private final Gson gson = new Gson();
    private final PlayerDao dao = new PlayerDao();

    private void advance() {
        if (partial)
            current = quiz.getQuestions().size();
        else
            current++;
    }

    private Score score(Submit event) {
        var player = dao.get(event.email);
        if (player == null) {
            player = new Player(event);
            AbstractDao.save(player);
        } else {
            player.setFirstName(event.firstName);
            player.setLastName(event.lastName);
        }
        return new Score(quiz, player, score);
    }
}
