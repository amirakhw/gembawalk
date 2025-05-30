package com.attijari.gembawalk.repository;

import com.attijari.gembawalk.entity.Group;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GroupRepository extends JpaRepository<Group, Long> {
    List<Group> findByRegionId(Long regionId);
}