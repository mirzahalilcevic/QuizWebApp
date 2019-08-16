package qwa.domain;

import qwa.events.Submit;

import javax.persistence.*;

@Entity
@Table(name = "results")
public class Result {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @ManyToOne
    @JoinColumn(name = "quiz_id", nullable = false)
    private Quiz quiz;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "email", nullable = false)
    private String email;

    @Column(name = "score", nullable = false)
    private int score;

    public Result() {
    }

    public Result(Quiz quiz, Submit event, int score) {
        this.quiz = quiz;
        this.firstName = event.firstName;
        this.lastName = event.lastName;
        this.email = event.email;
        this.score = score;
    }

    public int getId() {
        return id;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getEmail() {
        return email;
    }

    public int getScore() {
        return score;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }
}
