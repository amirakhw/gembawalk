package com.attijari.gembawalk.dto;

public class QuestionResponseDto {
    private Long rubriqueId;
    private Long questionId;
    private String responseText;

    public QuestionResponseDto() {}

    public QuestionResponseDto(Long rubriqueId, Long questionId, String responseText) {
        this.rubriqueId = rubriqueId;
        this.questionId = questionId;
        this.responseText = responseText;
    }

    public Long getRubriqueId() {
        return rubriqueId;
    }

    public void setRubriqueId(Long rubriqueId) {
        this.rubriqueId = rubriqueId;
    }

    public Long getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Long questionId) {
        this.questionId = questionId;
    }

    public String getResponseText() {
        return responseText;
    }

    public void setResponseText(String responseText) {
        this.responseText = responseText;
    }
}
