package com.attijari.gembawalk.controller;

import com.attijari.gembawalk.dto.ChecklistResponseDto;
import com.attijari.gembawalk.dto.UpdateConfirmedRequest;
import com.attijari.gembawalk.dto.UpdateResolvedRequest;
import com.attijari.gembawalk.entity.ChecklistResponse;
import com.attijari.gembawalk.service.ChecklistResponseService;
import org.springframework.web.bind.annotation.*;

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
    @PostMapping("/resolve")
    public void updateResolved(@RequestBody UpdateResolvedRequest request) {
        checklistResponseService.updateResolved(request.getResponseId(), request.isResolved());
    }

    @PostMapping("/confirm")
    public void updateConfirmed(@RequestBody UpdateConfirmedRequest request) {
        checklistResponseService.updateConfirmed(request.getResponseId(), request.isConfirmed());
    }
}
