package com.attijari.gembawalk.repository;

import com.attijari.gembawalk.entity.Rubrique;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RubriqueRepository extends JpaRepository<Rubrique, Long> {
    List<Rubrique> findByFormId(Long formId); // Useful to get rubriques of a form
}
