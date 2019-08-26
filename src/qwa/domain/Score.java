package qwa.domain;

import javax.persistence.*;
import javax.xml.stream.FactoryConfigurationError;

@Entity
@Table(name = "scores")
public class Score {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "quiz_id", nullable = false)
    private Quiz quiz;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "player_id", nullable = false)
    private Player player;

    @Column(name = "score", nullable = false)
    private int score;

    public Score() {
    }

    public Score(Quiz quiz, Player player, int score) {
        this.quiz = quiz;
        this.player = player;
        this.score = score;
    }

    public int getId() {
        return id;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public Player getPlayer() {
        return player;
    }

    public int getScore() {
        return score;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public void setPlayer(Player player) {
        this.player = player;
    }

    public void setScore(int score) {
        this.score = score;
    }
}
