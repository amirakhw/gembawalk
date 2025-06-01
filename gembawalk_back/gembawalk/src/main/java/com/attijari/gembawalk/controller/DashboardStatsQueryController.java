package com.attijari.gembawalk.controller;


import com.attijari.gembawalk.dto.DashboardStatsDto;
import com.attijari.gembawalk.dto.VisitDetailDto;
import com.attijari.gembawalk.service.DashboardStatsQueryService;
import org.apache.coyote.Response;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/dashboard")
public class DashboardStatsQueryController {
    private final DashboardStatsQueryService dashboardStatsQueryService;

    public DashboardStatsQueryController(DashboardStatsQueryService dashboardStatsQueryService) {
        this.dashboardStatsQueryService = dashboardStatsQueryService;
    }

    @GetMapping("/stats")
    public ResponseEntity<DashboardStatsDto>  getStats() {
        return ResponseEntity.ok(dashboardStatsQueryService.getDashboardStats());
    }

    @GetMapping("/recent_visits")
    public ResponseEntity<List<VisitDetailDto>> getRecentVisits(){
        return ResponseEntity.ok(dashboardStatsQueryService.getRecentVisit());
    }
}
