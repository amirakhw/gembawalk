package com.attijari.gembawalk.dto;

public class ChecklistResponseDto {
    private Long rubriqueId;
    private Long itemId;
    private String status; // 'conform' or 'non_conform'
    private String ticketNumber;
    private String comment;
    private String photoUrl;

    public ChecklistResponseDto() {}

    public ChecklistResponseDto(Long rubriqueId, Long itemId, String status,
                                String ticketNumber, String comment, String photoUrl) {
        this.rubriqueId = rubriqueId;
        this.itemId = itemId;
        this.status = status;
        this.ticketNumber = ticketNumber;
        this.comment = comment;
        this.photoUrl = photoUrl;
    }

    public Long getRubriqueId() {
        return rubriqueId;
    }

    public void setRubriqueId(Long rubriqueId) {
        this.rubriqueId = rubriqueId;
    }

    public Long getItemId() {
        return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
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

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

}
