package qwa.domain;

import javax.persistence.*;

@Entity
@Table(name = "answers")
public class Answer {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Column(name = "text", nullable = false)
    private String text;

    @Column(name = "correctness", nullable = false)
    private boolean correctness;

    public Answer() {
    }

    public int getId() {
        return id;
    }

    public String getText() {
        return text;
    }

    public boolean isCorrect() {
        return correctness;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setCorrectness(boolean correctness) {
        this.correctness = correctness;
    }
}