package qwa.messages;

import java.util.List;

public class Summary {

    public Summary(int score, int total, List<Integer> correct) {
        this.score = score;
        this.total = total;
        this.correct = correct;
    }

    private final String type = "summary";

    private int score;
    private int total;
    private List<Integer> correct;
}
