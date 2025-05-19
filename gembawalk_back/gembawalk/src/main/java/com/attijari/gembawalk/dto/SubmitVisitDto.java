package com.attijari.gembawalk.dto;

import java.util.List;

public class SubmitVisitDto {
    private Long formId;
    private Long userId;
    private Long agenceId;
    private List<ChecklistResponseDto> checklistResponses;
    private List<QuestionResponseDto> questionResponses;


    public Long getFormId() {
        return formId;
    }

    public void setFormId(Long formId) {
        this.formId = formId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getAgenceId() {
        return agenceId;
    }

    public void setAgenceId(Long agenceId) {
        this.agenceId = agenceId;
    }

    public List<ChecklistResponseDto> getChecklistResponses() {
        return checklistResponses;
    }

    public void setChecklistResponses(List<ChecklistResponseDto> checklistResponses) {
        this.checklistResponses = checklistResponses;
    }

    public List<QuestionResponseDto> getQuestionResponses() {
        return questionResponses;
    }

    public void setQuestionResponses(List<QuestionResponseDto> questionResponses) {
        this.questionResponses = questionResponses;
    }
}
