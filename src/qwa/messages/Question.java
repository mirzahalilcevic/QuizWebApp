package qwa.messages;

import java.util.ArrayList;
import java.util.List;

public class Question {

    public static final String type = "question";

    public Question(qwa.domain.Quiz quiz, int number, int remaining) {

        this.number = number + 1;
        var question = quiz.getQuestions().get(number);

        this.text = question.getText();
        this.time = remaining == 0 ? question.getTime() : remaining;
        this.points = question.getPoints();

        this.answers = new ArrayList<>();
        for (var answer : question.getAnswers())
            this.answers.add(answer.getText());
    }

    private int number;

    private String text;
    private List<String> answers;
    private int time;
    private int points;
}
