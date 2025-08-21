package com.attijari.gembawalk.service;

import com.attijari.gembawalk.dto.AgencyDto;
import com.attijari.gembawalk.entity.Agency;
import com.attijari.gembawalk.entity.Group;
import com.attijari.gembawalk.repository.AgencyRepository;
import com.attijari.gembawalk.repository.GroupRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class AgencyService {

    private final AgencyRepository agencyRepository;
    private final GroupRepository groupRepository;

    @Autowired
    public AgencyService(AgencyRepository agencyRepository, GroupRepository groupRepository) {
        this.agencyRepository = agencyRepository;
        this.groupRepository = groupRepository;
    }

    public List<AgencyDto> getAgenciesByGroup(Long groupId) {
        Group group = groupRepository.findById(groupId)
                .orElseThrow(() -> new RuntimeException("Group not found with id: " + groupId));
        List<Agency> agencies = agencyRepository.findByGroupId(groupId);
        return agencies.stream()
                .map(agency -> new AgencyDto(agency.getId(), agency.getName(), agency.getGroup().getId()))
                .collect(Collectors.toList());
    }

    public List<Agency> getAllAgencies(){
        return agencyRepository.findAll();
    }
}