package com.attijari.gembawalk.repository;

import com.attijari.gembawalk.entity.QuestionResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionResponseRepository extends JpaRepository<QuestionResponse, Long> {
    List<QuestionResponse> findByVisitId(Long visitId);
}
