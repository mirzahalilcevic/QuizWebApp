package qwa.messages;

import java.util.ArrayList;
import java.util.List;

public class Question {

    public Question(qwa.domain.Quiz quiz, int number, int remaining) {

        this.number = number;
        var question = quiz.getQuestions().get(number);

        this.text = question.getText();
        this.time = remaining == 0 ? question.getTime() : remaining;
        this.points = question.getPoints();

        answers = new ArrayList<>();
        for (var answer : question.getAnswers())
            answers.add(answer.getText());
    }

    private int number;

    private String text;
    private List<String> answers;
    private int time;
    private int points;
}
