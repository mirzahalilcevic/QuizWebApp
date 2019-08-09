package qwa.domain;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "questions")
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Column(name = "text", nullable = false)
    private String text;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "question_id", nullable = false)
    private List<Answer> answers;

    @Column(name = "time", nullable = false)
    private int time; // in seconds

    @Column(name = "points", nullable = false)
    private int points;

    public Question() {
    }

    public int getId() {
        return id;
    }

    public String getText() {
        return text;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public int getTime() {
        return time;
    }

    public int getPoints() {
        return points;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }

    public void setTime(int time) {
        this.time = time;
    }

    public void setPoints(int points) {
        this.points = points;
    }
}
