package com.attijari.gembawalk.service;

import com.attijari.gembawalk.entity.Visit;
import com.attijari.gembawalk.repository.VisitRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class VisitQueryService {

    private final VisitRepository visitRepository;

    public VisitQueryService(VisitRepository visitRepository) {
        this.visitRepository = visitRepository;
    }

    @Transactional(readOnly = true)
    public Visit getVisitById(Long id) {
        return visitRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Visit not found with id: " + id));
    }

    @Transactional(readOnly = true)
    public List<Visit> getVisitsByAgency(Long agencyId) {
        return visitRepository.findByAgence_Id(agencyId);
    }

    @Transactional(readOnly = true)
    public List<Visit> getVisitsByUser(Long userId) {
        return visitRepository.findByUserId(userId);
    }

    @Transactional(readOnly = true)
    public List<Visit> getActiveVisits() {
        return visitRepository.findByActive(true);
    }

    @Transactional(readOnly = true)
    public List<Visit> getAllVisits() {
        return visitRepository.findAll();
    }
}
