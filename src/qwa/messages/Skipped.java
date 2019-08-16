package qwa.messages;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class Skipped {

    public Skipped(Map<Integer, Integer> skipped, List<qwa.domain.Question> questions) {

        this.skipped = skipped;

        this.questions = new ArrayList<>();
        for (var entry : skipped.entrySet())
            this.questions.add(questions.get(entry.getKey()).getText());
    }

    private final String type = "skipped";

    private Map<Integer, Integer> skipped;
    private List<String> questions;
}
