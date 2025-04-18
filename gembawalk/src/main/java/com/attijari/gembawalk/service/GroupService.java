package com.attijari.gembawalk.service;

import com.attijari.gembawalk.dto.GroupDto;
import com.attijari.gembawalk.entity.Group;
import com.attijari.gembawalk.entity.Region;
import com.attijari.gembawalk.repository.GroupRepository;
import com.attijari.gembawalk.repository.RegionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class GroupService {

    private final GroupRepository groupRepository;
    private final RegionRepository regionRepository;

    @Autowired
    public GroupService(GroupRepository groupRepository, RegionRepository regionRepository) {
        this.groupRepository = groupRepository;
        this.regionRepository = regionRepository;
    }

    public List<GroupDto> getGroupsByRegion(Long regionId) {
        Region region = regionRepository.findById(regionId)
                .orElseThrow(() -> new RuntimeException("Region not found with id: " + regionId));
        List<Group> groups = groupRepository.findByRegionId(regionId);
        return groups.stream()
                .map(group -> new GroupDto(group.getId(), group.getName(), group.getRegion().getId()))
                .collect(Collectors.toList());
    }
}