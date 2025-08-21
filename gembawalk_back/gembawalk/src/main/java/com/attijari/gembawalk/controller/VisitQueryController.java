package com.attijari.gembawalk.controller;

import com.attijari.gembawalk.entity.Visit;
import com.attijari.gembawalk.service.VisitQueryService;
import jakarta.validation.constraints.Null;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/visits/query")
public class VisitQueryController {

    private final VisitQueryService visitQueryService;

    public VisitQueryController(VisitQueryService visitQueryService) {
        this.visitQueryService = visitQueryService;
    }

    @GetMapping("/{id}")
    public Visit getVisit(@PathVariable Long id) {
        return visitQueryService.getVisitById(id);
    }

    @GetMapping("/agency/{agencyId}")
    public List<Visit> getByAgency(@PathVariable Long agencyId) {
        return visitQueryService.getVisitsByAgency(agencyId);
    }

    @GetMapping("/user/{userId}")
    public List<Visit> getByUser(@PathVariable Long userId) {
        return visitQueryService.getVisitsByUser(userId);
    }

    @GetMapping("/active")
    public List<Visit> getVisitActive() {
        return visitQueryService.getActiveVisits();
    }

}
