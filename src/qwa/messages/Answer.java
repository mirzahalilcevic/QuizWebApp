package qwa.messages;

import java.util.ArrayList;
import java.util.List;

public class Answer {

    public Answer(List<qwa.domain.Answer> answers) {
        this.answers = new ArrayList<>();
        for (var answer : answers)
            this.answers.add(answer.isCorrect());
    }

    private List<Boolean> answers;
}
