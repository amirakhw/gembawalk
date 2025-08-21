package com.attijari.gembawalk.dto;

public class ChecklistItemDto {
    private Long id;
    private String name;
    private int order;

    public ChecklistItemDto() {}

    public ChecklistItemDto(Long id, String name, int order) {
        this.id = id;
        this.name = name;
        this.order = order;
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

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

}
