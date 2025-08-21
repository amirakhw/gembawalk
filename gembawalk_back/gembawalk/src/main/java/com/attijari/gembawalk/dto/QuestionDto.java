package com.attijari.gembawalk.dto;

public class QuestionDto {
    private Long id;
    private String questionText;
    private int order;

    public QuestionDto() {}

    public QuestionDto(Long id, String questionText, int order) {
        this.id = id;
        this.questionText = questionText;
        this.order = order;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

}
