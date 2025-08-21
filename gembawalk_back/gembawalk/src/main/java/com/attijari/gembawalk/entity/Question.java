package com.attijari.gembawalk.entity;

import jakarta.persistence.*;
@Entity
public class Question {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "rubrique_id")
    private Rubrique rubrique;

    private String questionText;
    private Integer question_order;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Rubrique getRubrique() {
        return rubrique;
    }

    public void setRubrique(Rubrique rubrique) {
        this.rubrique = rubrique;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public Integer getQuestion_order() {
        return question_order;
    }

    public void setQuestion_order(Integer question_order) {
        this.question_order = question_order;
    }
}

