package qwa.events;

import java.util.List;

public class Answer {

    public List<Boolean> answers;

    public boolean check(List<qwa.domain.Answer> answers) {

        if (answers.size() != this.answers.size())
            return false;

        for (int i = 0; i < answers.size(); ++i)
            if (answers.get(i).getCorrectness() != this.answers.get(i))
                return false;

        return true;
    }
}
