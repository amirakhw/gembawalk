package com.attijari.gembawalk.controller;

import com.attijari.gembawalk.dto.ChecklistResponseDto;
import com.attijari.gembawalk.entity.ChecklistResponse;
import com.attijari.gembawalk.service.ChecklistResponseService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/checklist")
public class ChecklistResponseController {

    private final ChecklistResponseService checklistResponseService;


    public ChecklistResponseController(ChecklistResponseService checklistResponseService) {
        this.checklistResponseService = checklistResponseService;
    }

    @GetMapping("/{id}")
    public List<ChecklistResponseDto> getByVisit(@PathVariable Long id){
        return checklistResponseService.getByVisit(id);
    }
}
