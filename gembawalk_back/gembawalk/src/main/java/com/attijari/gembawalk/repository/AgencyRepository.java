package com.attijari.gembawalk.repository;

import com.attijari.gembawalk.dto.AgencyDto;
import com.attijari.gembawalk.entity.Agency;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AgencyRepository extends JpaRepository<Agency, Long> {
    List<Agency> findByGroupId(Long groupId);
    }