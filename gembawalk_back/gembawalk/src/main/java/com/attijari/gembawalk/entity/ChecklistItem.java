package com.attijari.gembawalk.entity;

import jakarta.persistence.*;

@Entity
public class ChecklistItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @ManyToOne
    @JoinColumn(name = "rubrique_id")
    private Rubrique rubrique;


    private String name;
    //private Integer rubrique_order;



    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Rubrique getRubrique() {
        return rubrique;
    }

    public void setRubrique(Rubrique rubrique) {
        this.rubrique = rubrique;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    /*public Integer getRubrique_order() {
        return rubrique_order;
    }

    //public void setRubrique_order(Integer rubrique_order) {
        this.rubrique_order = rubrique_order;
    }
    */

}
