package qwa.service;

import qwa.dao.AbstractDao;
import qwa.domain.Quiz;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class QuizService {

    public List<Quiz> random(int n, List<Integer> completed) {

        List<Integer> ignore = null;

        if (completed == null)
            ignore = new ArrayList<>();
        else
            ignore = new ArrayList<>(completed);

        var quizzes = new ArrayList<Quiz>();
        int count = (int) AbstractDao.count(Quiz.class), rand, j = 0;

        if (count == 0) return null;

        for (int i = 0; i < n; i++) {

            Quiz quiz = null;

            do {

                if (j++ == MAX_RETRIES)
                    break;

                rand = random.nextInt(count);
                quiz = (Quiz) AbstractDao.get(Quiz.class, 1, rand).get(0);

            } while (ignore.contains(quiz.getId()) || !quiz.isActive());

            if (j <= MAX_RETRIES) {
                quizzes.add(quiz);
                ignore.add(quiz.getId());
            }
        }

        return quizzes;
    }

    private final Random random = new Random();

    private final static int MAX_RETRIES = 20;
}
