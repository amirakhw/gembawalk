package com.attijari.gembawalk.service;

import com.attijari.gembawalk.dto.ChecklistResponseDto;
import com.attijari.gembawalk.entity.*;
import com.attijari.gembawalk.repository.ChecklistItemRepository;
import com.attijari.gembawalk.repository.ChecklistResponseRepository;
import com.attijari.gembawalk.repository.RubriqueRepository;
import com.attijari.gembawalk.repository.VisitRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ChecklistResponseService {

    private final RubriqueRepository rubriqueRepository;
    private final ChecklistItemRepository checklistItemRepository;
    private final ChecklistResponseRepository checklistResponseRepository;
    private final VisitRepository visitRepository;

    public ChecklistResponseService(RubriqueRepository rubriqueRepository,
                                    ChecklistItemRepository checklistItemRepository,
                                    ChecklistResponseRepository checklistResponseRepository, VisitRepository visitRepository) {
        this.rubriqueRepository = rubriqueRepository;
        this.checklistItemRepository = checklistItemRepository;
        this.checklistResponseRepository = checklistResponseRepository;
        this.visitRepository = visitRepository;
    }

    @Transactional
    public void saveChecklistResponse(Visit visit, ChecklistResponseDto dto) {
        Rubrique rubrique = rubriqueRepository.findById(dto.getRubriqueId())
                .orElseThrow(() -> new IllegalArgumentException("Rubrique not found: " + dto.getRubriqueId()));

        ChecklistItem item = checklistItemRepository.findById(dto.getItemId())
                .orElseThrow(() -> new IllegalArgumentException("ChecklistItem not found: " + dto.getItemName()));

        ChecklistResponse response = new ChecklistResponse();
        response.setVisit(visit);
        response.setRubrique(rubrique);
        response.setItem(item);
        response.setStatus(ChecklistResponse.Status.fromString(dto.getStatus()));
        response.setTicketNumber(dto.getTicketNumber());
        response.setComment(dto.getComment());
        response.setCreatedAt(LocalDateTime.now());

        checklistResponseRepository.save(response);
    }

    public List<ChecklistResponseDto> getByVisit(long visitId){
        Visit visit = visitRepository.findById(visitId)
                .orElseThrow(() -> new RuntimeException("Visit not found with id: " + visitId));
        List<ChecklistResponse> checklistResponses = checklistResponseRepository.findByVisitId(visitId);
        return checklistResponses.stream()
                .map(clr -> new ChecklistResponseDto(
                        clr.getId(),
                        clr.getRubrique().getId(),
                        clr.getRubrique().getName(),
                        clr.getItem().getId(),
                        clr.getItem().getName(),
                        clr.getStatus().name(),
                        clr.getTicketNumber(),
                        clr.getComment()
                        ))
                .collect(Collectors.toList());
    }
}
