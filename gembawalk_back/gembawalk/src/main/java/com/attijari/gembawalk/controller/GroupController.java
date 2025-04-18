package com.attijari.gembawalk.controller;

import com.attijari.gembawalk.dto.GroupDto;
import com.attijari.gembawalk.service.GroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/groups")
public class GroupController {

    private final GroupService groupService;

    @Autowired
    public GroupController(GroupService groupService) {
        this.groupService = groupService;
    }

    @GetMapping
    public ResponseEntity<List<GroupDto>> getGroupsByRegionId(@RequestParam("regionId") Long regionId) {
        List<GroupDto> groups = groupService.getGroupsByRegion(regionId);
        return new ResponseEntity<>(groups, HttpStatus.OK);
    }
}