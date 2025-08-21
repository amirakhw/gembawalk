package com.attijari.gembawalk.dto;

import com.attijari.gembawalk.entity.Visit;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public class VisitDetailDto {
    private Long id;
    private Long formId;
    private Long userId;
    private Long agenceId;
    private LocalDate date;
    private LocalDateTime createdAt;
    private List<RubriqueDto> rubriques;
    private String aganceName;
    private boolean active;

    public VisitDetailDto(Long id, String aganceName, boolean active, LocalDateTime createdAt) {
        this.id = id;
        this.aganceName = aganceName;
        this.active = active;
        this.createdAt = createdAt;
    }

    public VisitDetailDto(Long id, Long formId, Long userId, Long agenceId, LocalDate date, LocalDateTime createdAt, List<RubriqueDto> rubriques) {
        this.id = id;
        this.formId = formId;
        this.userId = userId;
        this.agenceId = agenceId;
        this.date = date;
        this.createdAt = createdAt;
        this.rubriques = rubriques;
    }


    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getAganceName() {
        return aganceName;
    }

    public void setAganceName(String aganceName) {
        this.aganceName = aganceName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public List<RubriqueDto> getRubriques() {
        return rubriques;
    }

    public void setRubriques(List<RubriqueDto> rubriques) {
        this.rubriques = rubriques;
    }
}