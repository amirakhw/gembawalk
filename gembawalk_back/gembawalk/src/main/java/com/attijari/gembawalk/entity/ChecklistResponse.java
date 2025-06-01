package com.attijari.gembawalk.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
public class ChecklistResponse {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "visit_id")
    private Visit visit;

    @ManyToOne
    @JoinColumn(name = "rubrique_id")
    private Rubrique rubrique;

    @ManyToOne
    @JoinColumn(name = "item_id")
    private ChecklistItem item;

    @Enumerated(EnumType.STRING)
    private Status status; // 'CONFORM' or 'NON_CONFORM'

    private String ticketNumber;
    private String comment;
    private String photoUrl;
    private LocalDateTime createdAt;

    public boolean isResolved() {
        return resolved;
    }

    public void setResolved(boolean resolved) {
        this.resolved = resolved;
    }

    public boolean isConfirmed() {
        return confirmed;
    }

    public void setConfirmed(boolean confirmed) {
        this.confirmed = confirmed;
    }

    private boolean resolved;
    private boolean confirmed;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Visit getVisit() {
        return visit;
    }

    public void setVisit(Visit visit) {
        this.visit = visit;
    }

    public Rubrique getRubrique() {
        return rubrique;
    }

    public void setRubrique(Rubrique rubrique) {
        this.rubrique = rubrique;
    }

    public ChecklistItem getItem() {
        return item;
    }

    public void setItem(ChecklistItem item) {
        this.item = item;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
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

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    public enum Status {
        CONFORM,
        NON_CONFORM;

        public static Status fromString(String value) {
            try {
                return Status.valueOf(value.toUpperCase());
            } catch (IllegalArgumentException e) {
                throw new IllegalArgumentException("Invalid status value: " + value);
            }
        }
    }
}
