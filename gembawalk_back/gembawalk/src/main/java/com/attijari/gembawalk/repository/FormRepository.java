package com.attijari.gembawalk.repository;

import com.attijari.gembawalk.entity.Form;
import com.attijari.gembawalk.entity.Rubrique;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

public interface FormRepository extends JpaRepository<Form, Long> {
    @Query("SELECT r FROM Rubrique r JOIN FETCH r.checklistItems WHERE r.form.id = :formId")
    List<Rubrique> findRubriquesWithChecklistItems(@Param("formId") Long formId);

}
