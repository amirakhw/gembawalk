package com.attijari.gembawalk.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class VisitResponseDto {
    private Long id;
    private Long formId;
    private Long userId;
    private Long agenceId;
    private LocalDate date;
    private LocalDateTime createdAt;

    public VisitResponseDto() {}

    public VisitResponseDto(Long id, Long formId, Long userId, Long agenceId,
                            LocalDate date, LocalDateTime createdAt) {
        this.id = id;
        this.formId = formId;
        this.userId = userId;
        this.agenceId = agenceId;
        this.date = date;
        this.createdAt = createdAt;
    }


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getFormId() {
        return formId;
    }

    public void setFormId(Long formId) {
        this.formId = formId;
    }

    public Long getAgenceId() {
        return agenceId;
    }

    public void setAgenceId(Long agenceId) {
        this.agenceId = agenceId;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
