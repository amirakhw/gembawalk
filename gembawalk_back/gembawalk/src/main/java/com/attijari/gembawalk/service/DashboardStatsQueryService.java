package com.attijari.gembawalk.service;

import com.attijari.gembawalk.dto.DashboardStatsDto;
import com.attijari.gembawalk.dto.VisitDetailDto;
import com.attijari.gembawalk.entity.Visit;
import com.attijari.gembawalk.repository.VisitRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class DashboardStatsQueryService {
    private final VisitRepository visitRepository;

    public DashboardStatsQueryService(VisitRepository visitRepository) {
        this.visitRepository = visitRepository;
    }

    public DashboardStatsDto getDashboardStats(){
        DashboardStatsDto stats = new DashboardStatsDto();
        stats.setTotalVisit(visitRepository.count());
        stats.setVisiteActive(visitRepository.countByActiveTrue());
        stats.setVisitNonActive(visitRepository.countByActiveFalse());

        return stats;
    }

    public List<VisitDetailDto> getRecentVisit() {
        List<Visit> visitList = visitRepository.findTop3ByOrderByCreatedAtDesc();
        List<VisitDetailDto> dto = new ArrayList<VisitDetailDto>();

        for(Visit v : visitList) {
            dto.add(this.mapToDto(v));
        }

        return dto;
    }
    public VisitDetailDto mapToDto(Visit visit){

        return new VisitDetailDto(visit.getId(), visit.getAgence().getName(), visit.isActive(), visit.getCreatedAt());
    }
}
