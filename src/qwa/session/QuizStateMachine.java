package qwa.session;

import com.google.gson.Gson;
import qwa.dao.AbstractDao;
import qwa.domain.Quiz;
import qwa.domain.Result;
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
                return gson.toJson(new qwa.messages.Question(quiz, current, 0));
            default:
                return null;
        }
    }

    // QUESTION + answer[isCorrect] / (add_correct, send_answer) -> ANSWERED
    // QUESTION + answer[!isCorrect] / send_answer -> ANSWERED
    public String process(Answer event) {
        switch (state) {
            case QUESTION:
                var question = quiz.getQuestions().get(current);
                if (event.check(question.getAnswers())) {
                    correct.add(current);
                    score += question.getPoints();
                }
                state = ANSWERED;
                return gson.toJson(new qwa.messages.Answer(question.getAnswers()));
            default:
                return null;
        }
    }

    // ANSWERED + on_entry<Next> / advance
    // ANSWERED + next[!isLast] / send_question -> QUESTION
    // ANSWERED + next[!hasSkipped] / send_stats -> FINISHED
    // ANSWERED + next / send_skipped -> SKIPPED
    public String process(Next event) {
        switch (state) {
            case ANSWERED:
                advance();
                if (current < quiz.getQuestions().size()) {
                    state = QUESTION;
                    return gson.toJson(new qwa.messages.Question(quiz, current, 0));
                } else if (skipped.isEmpty()) {
                    state = FINISHED;
                    return gson.toJson(new qwa.messages.Stats(score, correct));
                } else {
                    state = SKIPPED;
                    return gson.toJson(new qwa.messages.Skipped(skipped, quiz.getQuestions()));
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
                    return gson.toJson(new qwa.messages.Question(quiz, current, 0));
                state = SKIPPED;
                return gson.toJson(new qwa.messages.Skipped(skipped, quiz.getQuestions()));
            default:
                return null;
        }
    }

    // SKIPPED + on_entry / set_skipped_flag
    // SKIPPED + revisit[isSkipped] / (remove_skipped, set_current, send_question) -> QUESTION
    public String process(Revisit event) {
        switch (state) {
            case SKIPPED:
                partial = true;
                var question = event.question - 1;
                if (!skipped.containsKey(question))
                    return null;
                var remaining = skipped.get(question);
                skipped.remove(question);
                current = question;
                state = QUESTION;
                return gson.toJson(new qwa.messages.Question(quiz, current, remaining));
            default:
                return null;
        }
    }

    // FINISHED + submit / (persist_result, send_ack) -> ZOMBIE
    public String process(Submit event) {

        var result = new Result(event, score);
        quiz.getInbox().add(result);
        state = ZOMBIE;

        try {
            AbstractDao.update(quiz);
            submitted = true;
            return gson.toJson(new qwa.messages.Ack(true));
        } catch (Exception e) {
            return gson.toJson(new qwa.messages.Ack(false));
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

    private int current = 0;

    private List<Integer> correct = new ArrayList<>();
    private int score = 0;

    private Map<Integer, Integer> skipped = new HashMap<>();
    private boolean partial = false;

    private boolean submitted = false;

    private int state = INIT;

    // states
    private static final int INIT = 0;
    private static final int QUESTION = 1;
    private static final int ANSWERED = 2;
    private static final int SKIPPED = 3;
    private static final int FINISHED = 4;
    private static final int ZOMBIE = 5;

    private static final Gson gson = new Gson();

    private void advance() {
        if (partial)
            current = quiz.getQuestions().size();
        else
            current++;
    }
}
