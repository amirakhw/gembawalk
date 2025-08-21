package com.attijari.gembawalk.repository;

import com.attijari.gembawalk.entity.ChecklistResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ChecklistResponseRepository extends JpaRepository<ChecklistResponse, Long> {
    List<ChecklistResponse> findByVisitId(Long visitId);
}
