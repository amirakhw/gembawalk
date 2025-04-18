package com.attijari.gembawalk.repository;

import com.attijari.gembawalk.entity.Region;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RegionRepository extends JpaRepository<Region, Long> {
    // You can add custom query methods here if needed
}