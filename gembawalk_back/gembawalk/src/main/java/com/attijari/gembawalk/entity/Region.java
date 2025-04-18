package com.attijari.gembawalk.entity;

import jakarta.persistence.*; // For JPA annotations

@Entity
@Table(name = "regions") // Specify the table name in the database
public class Region {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-incrementing primary key
    private Long id;

    @Column(name = "name", nullable = false, unique = true) // 'name' column, cannot be null, should be unique
    private String name;

    // Default constructor (required by JPA)
    public Region() {
    }

    // Constructor with the 'name' field
    public Region(String name) {
        this.name = name;
    }

    // Getters and setters for 'id'
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    // Getters and setters for 'name'
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Region{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}