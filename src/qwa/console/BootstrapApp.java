package qwa.console;

import qwa.dao.AbstractDao;
import qwa.domain.Answer;
import qwa.domain.Editor;
import qwa.domain.Question;
import qwa.domain.Quiz;

import java.util.ArrayList;
import java.util.List;

public class BootstrapApp {

    public static void main(String[] args) {

        var editor = new Editor();
        editor.setFirstName("Mirza");
        editor.setLastName("Halilcevic");
        editor.setUsername("mirza");
        editor.setPassword("mirza");

        AbstractDao.save(editor);

        for (int i = 0; i < 10; ++i) {

            var quiz = new Quiz();
            quiz.setEditor(editor);
            quiz.setName("Quiz " + i);
            quiz.setDescription(quiz.getName() + " description");
            quiz.setQuestions(createQuestions(5));
            quiz.activate();

            AbstractDao.save(quiz);
        }
    }

    private static List<Question> createQuestions(int n) {

        var questions = new ArrayList<Question>();
        for (int i = 0; i < n; ++i) {

            var question = new Question();
            question.setText("Question " + i);
            question.setAnswers(createAnswers(3));
            question.setTime(60);
            question.setPoints(5);

            questions.add(question);
        }

        return questions;
    }

    private static List<Answer> createAnswers(int n) {

        var answers = new ArrayList<Answer>();
        for (int i = 0; i < n; ++i) {

            var answer = new Answer();
            answer.setText("Answer " + i);
            answer.setCorrectness(i % 2 != 0);

            answers.add(answer);
        }

        return answers;
    }
}
