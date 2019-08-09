package qwa.messages;

import java.util.List;

public class Stats {

    public Stats(List<qwa.domain.Question> questions, List<Integer> correct) {
        this.correct = correct;
        for (int i : correct)
            score += questions.get(i).getPoints();
    }

    private List<Integer> correct;
    private int score = 0;
}
