package qwa.messages;

import java.util.List;

public class Summary {

    public Summary(int score, List<Integer> correct) {
        this.score = score;
        this.correct = correct;
    }

    private final String type = "summary";

    private int score;
    private List<Integer> correct;
}
