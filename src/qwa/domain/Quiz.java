package qwa.domain;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "quizzes")
public class Quiz {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Column(name = "image")
    private String image;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "description")
    private String description;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "quiz_id", nullable = false)
    private List<Question> questions;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "quiz_id")
    private List<Score> scores;

    @Column(name = "active", nullable = false)
    private boolean active;

    @Column(name = "editor")
    private String editor;

    public Quiz() {
    }

    public Quiz(String editor, String image, String name, String description, List<Question> questions, boolean active) {
        this.editor = editor;
        this.image = image;
        this.name = name;
        this.description = description;
        this.questions = questions;
        this.active = active;
    }

    public int getId() {
        return id;
    }

    public String getImage() {
        return image;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public List<Score> getScores() {
        return scores;
    }

    public boolean isActive() {
        return active;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }

    public void setScores(List<Score> scores) {
        this.scores = scores;
    }

    public void activate() {
        this.active = true;
    }

    public void deactivate() {
        this.active = false;
    }
}
