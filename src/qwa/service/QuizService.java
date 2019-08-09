package qwa.service;

import qwa.dao.AbstractDao;
import qwa.domain.Quiz;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class QuizService {

    public List<Quiz> getTwoRandomQuizzes() {

        int count = (int) AbstractDao.count(Quiz.class), i = random.nextInt(count), j;
        do j = random.nextInt(count); while (j == i);

        var quizzes = new ArrayList<Quiz>();
        quizzes.add((Quiz) AbstractDao.get(Quiz.class, 1, i).get(0));
        quizzes.add((Quiz) AbstractDao.get(Quiz.class, 1, j).get(0));

        return quizzes;
    }

    private final Random random = new Random();
}
