package qwa.session;

import com.google.gson.Gson;
import qwa.domain.Quiz;
import qwa.events.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class QuizAutomaton {

    public QuizAutomaton(Quiz quiz) {
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
                boolean isCorrect = event.check(question.getAnswers());
                if (isCorrect) correct.add(current);
                state = ANSWERED;
                return gson.toJson(new qwa.messages.Answer(question.getAnswers()));
            default:
                return null;
        }
    }

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
                    return gson.toJson(new qwa.messages.Stats(quiz.getQuestions(), correct));
                } else {
                    state = STOPPED;
                    stopped = true;
                    return gson.toJson(skipped);
                }
            default:
                return null;
        }
    }

    // QUESTION + skip[!isLast] / (add_skipped, send_question) -> QUESTION
    // QUESTION + skip / add_skipped -> SKIPPED
    public String process(Skip event) {
        switch (state) {
            case QUESTION:
                skipped.put(current, event.remaining); // TODO validate remaining time
                advance();
                if (current < quiz.getQuestions().size())
                    return gson.toJson(new qwa.messages.Question(quiz, current, 0));
                state = STOPPED;
                stopped = true;
                return gson.toJson(skipped);
            default:
                return null;
        }
    }

    // STOPPED + revisit[isSkipped] / send_question -> QUESTION
    public String process(Revisit event) {
        switch (state) {
            case STOPPED:
                if (!skipped.containsKey(event.question))
                    return null;
                current = event.question;
                state = QUESTION;
                return gson.toJson(new qwa.messages.Question(quiz, current, skipped.get(event.question)));
            default:
                return null;
        }
    }

    public String process(Submit event) {
        // TODO
        state = ZOMBIE;
        return null;
    }

    public boolean isStarted() {
        return state != INIT;
    }

    public boolean isDone() {
        return state == ZOMBIE;
    }

    private final Quiz quiz;

    private int current = 0;
    private Map<Integer, Integer> skipped = new HashMap<>();
    private List<Integer> correct = new ArrayList<>();
    private boolean stopped = false;

    private int state = INIT;

    // states
    private static final int INIT = 0;
    private static final int QUESTION = 1;
    private static final int ANSWERED = 2;
    private static final int STOPPED = 3;
    private static final int FINISHED = 4;
    private static final int ZOMBIE = 5;

    private static final Gson gson = new Gson();

    private void advance() {
        if (stopped)
            current = quiz.getQuestions().size();
        else
            current++;
    }
}
