package com.attijari.gembawalk.dto;

public class GroupDto {
    private Long id;
    private String name;
    private Long regionId; // To send the associated region's ID

    public GroupDto() {
    }

    public GroupDto(Long id, String name, Long regionId) {
        this.id = id;
        this.name = name;
        this.regionId = regionId;
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

    public Long getRegionId() {
        return regionId;
    }

    public void setRegionId(Long regionId) {
        this.regionId = regionId;
    }
}