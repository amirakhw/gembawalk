package com.attijari.gembawalk.dto;

import java.util.List;

public class RubriqueDto {
    private Long id;
    private String name;
    private String type; // 'checklist' or 'questions'
    private int order;
    private List<ChecklistItemDto> checklistItems;
    private List<QuestionDto> questions;

    public RubriqueDto() {}

    public RubriqueDto(Long id, String name, String type, int order,
                       List<ChecklistItemDto> checklistItems,
                       List<QuestionDto> questions) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.order = order;
        this.checklistItems = checklistItems;
        this.questions = questions;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public List<ChecklistItemDto> getChecklistItems() {
        return checklistItems;
    }

    public void setChecklistItems(List<ChecklistItemDto> checklistItems) {
        this.checklistItems = checklistItems;
    }

    public List<QuestionDto> getQuestions() {
        return questions;
    }

    public void setQuestions(List<QuestionDto> questions) {
        this.questions = questions;
    }
}
