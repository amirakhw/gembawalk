package com.attijari.gembawalk.controller;

import com.attijari.gembawalk.dto.FormDto;
import com.attijari.gembawalk.service.FormService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/forms")
public class FormController {

    private final FormService formService;

    public FormController(FormService formService) {
        this.formService = formService;
    }

    @GetMapping("/{formId}")
    public FormDto getFormWithRubriques(@PathVariable Long formId) {
        return formService.getFormWithRubriques(formId);

    }
}
