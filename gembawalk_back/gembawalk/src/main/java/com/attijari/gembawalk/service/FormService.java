package com.attijari.gembawalk.service;

import com.attijari.gembawalk.dto.ChecklistItemDto;
import com.attijari.gembawalk.dto.FormDto;
import com.attijari.gembawalk.dto.QuestionDto;
import com.attijari.gembawalk.dto.RubriqueDto;
import com.attijari.gembawalk.entity.Form;
import com.attijari.gembawalk.entity.Question;
import com.attijari.gembawalk.repository.FormRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class FormService {

    private final FormRepository formRepository;

    public FormService(FormRepository formRepository) {
        this.formRepository = formRepository;
    }
    @Transactional
    public FormDto getFormWithRubriques(Long formId) {
        Form form = formRepository.findById(formId)
                .orElseThrow(() -> new EntityNotFoundException("Form not found: " + formId));
        return mapToDto(form);
    }

    private FormDto mapToDto(Form form) {
        FormDto dto = new FormDto();
        dto.setId(form.getId());
        dto.setName(form.getName());
        dto.setDescription(form.getDescription());

        List<RubriqueDto> rubriqueDtos = form.getRubriques().stream().map(rubrique -> {
            RubriqueDto rubriqueDto = new RubriqueDto();
            rubriqueDto.setId(rubrique.getId());
            rubriqueDto.setName(rubrique.getName());
            rubriqueDto.setType(rubrique.getType().name());
            rubriqueDto.setOrder(rubrique.getRubrique_order());

            if (rubrique.getChecklistItems() != null) {
                rubriqueDto.setChecklistItems(rubrique.getChecklistItems().stream()
                        .map(checklistItem -> {
                            ChecklistItemDto checklistItemDto = new ChecklistItemDto();
                            checklistItemDto.setId(checklistItem.getId());
                            checklistItemDto.setName(checklistItem.getName());
                            //checklistItemDto.setOrder(checklistItem.getRubrique_order());
                            return checklistItemDto;
                        })
                        .collect(Collectors.toList()));
            }
            if (rubrique.getQuestions() != null){
                rubriqueDto.setQuestions(rubrique.getQuestions().stream()
                        .map(Question -> {
                            QuestionDto QuestionDto = new QuestionDto();
                            QuestionDto.setId(Question.getId());
                            QuestionDto.setQuestionText(Question.getQuestionText());
                            return QuestionDto;
                        })
                        .collect(Collectors.toList()));
            }


            return rubriqueDto;
        }).collect(Collectors.toList());

        dto.setRubriques(rubriqueDtos);
        return dto;
    }



}
