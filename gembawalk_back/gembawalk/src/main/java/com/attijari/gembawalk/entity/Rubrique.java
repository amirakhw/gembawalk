package com.attijari.gembawalk.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class Rubrique {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "form_id")
    private Form form;

    private String name;

    @Enumerated(EnumType.STRING)
    private RubriqueType type; // 'CHECKLIST' or 'QUESTIONS'

    private Integer rubrique_order;

    @OneToMany(mappedBy = "rubrique", cascade = CascadeType.ALL ,fetch = FetchType.EAGER)
    private List<ChecklistItem> checklistItems;

    @OneToMany(mappedBy = "rubrique", cascade = CascadeType.ALL)
    private List<Question> questions;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Form getForm() {
        return form;
    }

    public void setForm(Form form) {
        this.form = form;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public RubriqueType getType() {
        return type;
    }

    public void setType(RubriqueType type) {
        this.type = type;
    }

    public Integer getRubrique_order() {
        return rubrique_order;
    }

    public void setRubrique_order(Integer rubrique_order) {
        this.rubrique_order = rubrique_order;
    }

    public List<ChecklistItem> getChecklistItems() {
        return checklistItems;
    }

    public void setChecklistItems(List<ChecklistItem> checklistItems) {
        this.checklistItems = checklistItems;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }


    public enum RubriqueType {
        CHECKLIST,
        QUESTIONS
    }
}
