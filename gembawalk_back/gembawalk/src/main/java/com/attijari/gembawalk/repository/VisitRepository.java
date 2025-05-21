package com.attijari.gembawalk.repository;

import com.attijari.gembawalk.entity.Visit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VisitRepository extends JpaRepository<Visit, Long> {
    List<Visit> findByUserId(Long userId);
    List<Visit> findByAgence_Id(Long agencyId);
    List<Visit> findByActive(boolean isActive);

}
