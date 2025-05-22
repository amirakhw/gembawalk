package com.attijari.gembawalk.dto;

public class ChecklistResponseDto {
    private Long id;
    private Long rubriqueId;
    private String rubriqueName;
    private Long itemId;
    private String itemName;
    private String status; // 'conform' or 'non_conform'
    private String ticketNumber;
    private String comment;

    public ChecklistResponseDto() {}

    public ChecklistResponseDto(Long id, Long rubriqueId, String rubriqueName, Long itemId, String itemName, String status,
                                String ticketNumber, String comment) {
        this.id = id;
        this.rubriqueId = rubriqueId;
        this.rubriqueName = rubriqueName;
        this.itemName = itemName;
        this.status = status;
        this.ticketNumber = ticketNumber;
        this.comment = comment;
        this.itemId = itemId;
    }

    public Long getItemId() {
        return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
    }

    public Long getRubriqueId() {
        return rubriqueId;
    }

    public void setRubriqueId(Long rubriqueId) {
        this.rubriqueId = rubriqueId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTicketNumber() {
        return ticketNumber;
    }

    public void setTicketNumber(String ticketNumber) {
        this.ticketNumber = ticketNumber;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getRubriqueName() {
        return rubriqueName;
    }

    public void setRubriqueName(String rubriqueName) {
        this.rubriqueName = rubriqueName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
