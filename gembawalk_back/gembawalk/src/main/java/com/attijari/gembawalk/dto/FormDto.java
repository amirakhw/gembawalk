package com.attijari.gembawalk.dto;

import java.util.List;

public class FormDto {
    private Long id;
    private String name;
    private String description;
    private List<RubriqueDto> rubriques;

    public FormDto() {}

    public FormDto(Long id, String name, String description, List<RubriqueDto> rubriques) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.rubriques = rubriques;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<RubriqueDto> getRubriques() {
        return rubriques;
    }

    public void setRubriques(List<RubriqueDto> rubriques) {
        this.rubriques = rubriques;
    }
}
