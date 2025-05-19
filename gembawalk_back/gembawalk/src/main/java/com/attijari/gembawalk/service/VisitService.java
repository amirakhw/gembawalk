package com.attijari.gembawalk.service;

import com.attijari.gembawalk.dto.ChecklistResponseDto;
import com.attijari.gembawalk.dto.QuestionResponseDto;
import com.attijari.gembawalk.dto.SubmitVisitDto;
import com.attijari.gembawalk.dto.VisitRequestDto;
import com.attijari.gembawalk.entity.*;
import com.attijari.gembawalk.repository.*;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class VisitService {
    private final ChecklistResponseService checklistResponseService;
    private final QuestionResponseService questionResponseService;
    private final VisitRepository visitRepository;
    private final RubriqueRepository rubriqueRepository;
    private final ChecklistItemRepository checklistItemRepository;
    private final ChecklistResponseRepository checklistResponseRepository;
    private final QuestionRepository questionRepository;
    private final QuestionResponseRepository questionResponseRepository;
    private final FormRepository formRepository;
    private final AgencyRepository agencyRepository;
    private final UserRepository userRepository;

    public VisitService(
            VisitRepository visitRepository,
            RubriqueRepository rubriqueRepository,
            ChecklistItemRepository checklistItemRepository,
            ChecklistResponseRepository checklistResponseRepository,
            QuestionRepository questionRepository,
            QuestionResponseRepository questionResponseRepository,
            FormRepository formRepository,
            AgencyRepository agencyRepository,
            UserRepository userRepository,
            ChecklistResponseService checklistResponseService,
            QuestionResponseService questionResponseService
    ) {
        this.visitRepository = visitRepository;
        this.rubriqueRepository = rubriqueRepository;
        this.checklistItemRepository = checklistItemRepository;
        this.checklistResponseRepository = checklistResponseRepository;
        this.questionRepository = questionRepository;
        this.questionResponseRepository = questionResponseRepository;
        this.formRepository = formRepository;
        this.agencyRepository = agencyRepository;
        this.userRepository = userRepository;
        this.checklistResponseService = checklistResponseService;
        this.questionResponseService = questionResponseService;
    }


    @Transactional
    public void saveVisit(VisitRequestDto dto) {
        Visit visit = new Visit();
        visit.setForm(formRepository.findById(dto.getFormId()).orElseThrow());
        visit.setAgence(agencyRepository.findById(dto.getAgenceId()).orElseThrow());
        visit.setUser(userRepository.findById(dto.getUserId()).orElseThrow());
        visit.setDate(LocalDate.now());
        visitRepository.save(visit);

        List<ChecklistResponse> checklistResponses = dto.getChecklistResponses().stream().map(cr -> {
            ChecklistResponse response = new ChecklistResponse();
            response.setVisit(visit);
            response.setRubrique(rubriqueRepository.findById(cr.getRubriqueId()).orElseThrow());
            response.setItem(checklistItemRepository.findById(cr.getItemId()).orElseThrow());
            response.setStatus(ChecklistResponse.Status.fromString(cr.getStatus()));

            response.setTicketNumber(cr.getTicketNumber());
            response.setComment(cr.getComment());
            response.setPhotoUrl(cr.getPhotoUrl());
            return response;
        }).collect(Collectors.toList());

        checklistResponseRepository.saveAll(checklistResponses);

        List<QuestionResponse> questionResponses = dto.getQuestionResponses().stream().map(qr -> {
            QuestionResponse response = new QuestionResponse();
            response.setVisit(visit);
            response.setRubrique(rubriqueRepository.findById(qr.getRubriqueId()).orElseThrow());
            response.setQuestion(questionRepository.findById(qr.getQuestionId()).orElseThrow());
            response.setResponseText(qr.getResponseText());
            return response;
        }).collect(Collectors.toList());

        questionResponseRepository.saveAll(questionResponses);
    }
    @Transactional
    public Visit createVisitWithResponses(SubmitVisitDto dto) {
        Visit visit = new Visit();
        visit.setForm(formRepository.findById(dto.getFormId())
                .orElseThrow(() -> new EntityNotFoundException("Form not found")));
        visit.setUser(userRepository.findById(dto.getUserId())
                .orElseThrow(() -> new EntityNotFoundException("User not found")));
        visit.setAgence(agencyRepository.findById(dto.getAgenceId())
                .orElseThrow(() -> new EntityNotFoundException("Agency not found")));
        visit.setDate(LocalDate.now());
        visit.setCreatedAt(LocalDateTime.now());

        Visit savedVisit = visitRepository.save(visit);

        for (ChecklistResponseDto cr : dto.getChecklistResponses()) {
            checklistResponseService.saveChecklistResponse(savedVisit, cr);
        }

        for (QuestionResponseDto qr : dto.getQuestionResponses()) {
            questionResponseService.saveQuestionResponse(savedVisit, qr);
        }

        return savedVisit;
    }



}
