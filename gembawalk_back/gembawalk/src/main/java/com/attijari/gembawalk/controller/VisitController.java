package com.attijari.gembawalk.controller;

import com.attijari.gembawalk.dto.FormDto;
import com.attijari.gembawalk.dto.SubmitVisitDto;
import com.attijari.gembawalk.service.FormService;
import com.attijari.gembawalk.service.VisitService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/visits")
public class VisitController {

    private final VisitService visitService;
    private final FormService formService;
    public VisitController(FormService formService , VisitService visitService) {
        this.visitService = visitService;
        this.formService = formService;
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public void submitVisit(@RequestBody SubmitVisitDto dto) {
        visitService.createVisitWithResponses(dto);
    }

    @PostMapping("/terminate/{visitId}")
    @ResponseStatus(HttpStatus.OK)
    public void terminateVisit(@PathVariable long visitId){
        visitService.terminate(visitId);
    }

    @GetMapping("/{formId}")
    public FormDto getForm(@PathVariable Long formId) {
        return formService.getFormWithRubriques(formId);
    }

}
