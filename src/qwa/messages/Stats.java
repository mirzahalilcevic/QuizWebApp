package qwa.messages;

import java.util.List;

public class Stats {

    public static final String type = "stats";

    public Stats(int score, List<Integer> correct) {
        this.score = score;
        this.correct = correct;
    }

    private int score;
    private List<Integer> correct;
}
