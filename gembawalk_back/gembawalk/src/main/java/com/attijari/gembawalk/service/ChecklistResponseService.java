package com.attijari.gembawalk.service;

import com.attijari.gembawalk.dto.ChecklistResponseDto;
import com.attijari.gembawalk.entity.ChecklistItem;
import com.attijari.gembawalk.entity.ChecklistResponse;
import com.attijari.gembawalk.entity.Rubrique;
import com.attijari.gembawalk.entity.Visit;
import com.attijari.gembawalk.repository.ChecklistItemRepository;
import com.attijari.gembawalk.repository.ChecklistResponseRepository;
import com.attijari.gembawalk.repository.RubriqueRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class ChecklistResponseService {

    private final RubriqueRepository rubriqueRepository;
    private final ChecklistItemRepository checklistItemRepository;
    private final ChecklistResponseRepository checklistResponseRepository;

    public ChecklistResponseService(RubriqueRepository rubriqueRepository,
                                    ChecklistItemRepository checklistItemRepository,
                                    ChecklistResponseRepository checklistResponseRepository) {
        this.rubriqueRepository = rubriqueRepository;
        this.checklistItemRepository = checklistItemRepository;
        this.checklistResponseRepository = checklistResponseRepository;
    }

    @Transactional
    public void saveChecklistResponse(Visit visit, ChecklistResponseDto dto) {
        Rubrique rubrique = rubriqueRepository.findById(dto.getRubriqueId())
                .orElseThrow(() -> new IllegalArgumentException("Rubrique not found: " + dto.getRubriqueId()));

        ChecklistItem item = checklistItemRepository.findById(dto.getItemId())
                .orElseThrow(() -> new IllegalArgumentException("ChecklistItem not found: " + dto.getItemId()));

        ChecklistResponse response = new ChecklistResponse();
        response.setVisit(visit);
        response.setRubrique(rubrique);
        response.setItem(item);
        response.setStatus(ChecklistResponse.Status.fromString(dto.getStatus()));
        response.setTicketNumber(dto.getTicketNumber());
        response.setComment(dto.getComment());
        response.setPhotoUrl(dto.getPhotoUrl());
        response.setCreatedAt(LocalDateTime.now());

        checklistResponseRepository.save(response);
    }
}
