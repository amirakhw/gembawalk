package com.attijari.gembawalk.controller;

import com.attijari.gembawalk.dto.AgencyDto;
import com.attijari.gembawalk.service.AgencyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/agencies")
public class AgencyController {

    private final AgencyService agencyService;

    @Autowired
    public AgencyController(AgencyService agencyService) {
        this.agencyService = agencyService;
    }

    @GetMapping
    public ResponseEntity<List<AgencyDto>> getAgenciesByGroupId(@RequestParam("groupId") Long groupId) {
        List<AgencyDto> agencies = agencyService.getAgenciesByGroup(groupId);
        return new ResponseEntity<>(agencies, HttpStatus.OK);
    }
}