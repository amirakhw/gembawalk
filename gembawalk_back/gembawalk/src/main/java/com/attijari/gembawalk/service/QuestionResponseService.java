package com.attijari.gembawalk.service;

import com.attijari.gembawalk.dto.QuestionResponseDto;
import com.attijari.gembawalk.entity.Question;
import com.attijari.gembawalk.entity.QuestionResponse;
import com.attijari.gembawalk.entity.Rubrique;
import com.attijari.gembawalk.entity.Visit;
import com.attijari.gembawalk.repository.QuestionRepository;
import com.attijari.gembawalk.repository.QuestionResponseRepository;
import com.attijari.gembawalk.repository.RubriqueRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class QuestionResponseService {

    private final RubriqueRepository rubriqueRepository;
    private final QuestionRepository questionRepository;
    private final QuestionResponseRepository questionResponseRepository;

    public QuestionResponseService(
            RubriqueRepository rubriqueRepository,
            QuestionRepository questionRepository,
            QuestionResponseRepository questionResponseRepository
    ) {
        this.rubriqueRepository = rubriqueRepository;
        this.questionRepository = questionRepository;
        this.questionResponseRepository = questionResponseRepository;
    }

    @Transactional
    public void saveQuestionResponse(Visit visit, QuestionResponseDto dto) {
        Rubrique rubrique = rubriqueRepository.findById(dto.getRubriqueId())
                .orElseThrow(() -> new IllegalArgumentException("Rubrique not found: " + dto.getRubriqueId()));
        Question question = questionRepository.findById(dto.getQuestionId())
                .orElseThrow(() -> new IllegalArgumentException("Question not found: " + dto.getQuestionId()));

        QuestionResponse response = new QuestionResponse();
        response.setVisit(visit);
        response.setRubrique(rubrique);
        response.setQuestion(question);
        response.setResponseText(dto.getResponseText());

        questionResponseRepository.save(response);
    }
}
