package com.peczedavid.fogorvos.controller;

import com.peczedavid.fogorvos.model.network.MessageResponse;
import com.peczedavid.fogorvos.model.network.StartProcessRequest;
import com.peczedavid.fogorvos.model.process.VariablePayload;
import com.peczedavid.fogorvos.service.ProcessInstanceService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = {"http://localhost:4200"}, maxAge = 3600, allowCredentials = "true")
@Controller
@RequestMapping("/api/process-instance")
public class ProcessInstanceController {

    private final ProcessInstanceService processInstanceService;

    public ProcessInstanceController(ProcessInstanceService processInstanceService) {
        this.processInstanceService = processInstanceService;
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteProcess(@PathVariable String id) {
        return processInstanceService.deleteProcess(id);
    }

    @PostMapping("/new")
    public ResponseEntity<?> startCleanProcess(@RequestBody StartProcessRequest startProcessRequest) {
        return processInstanceService.getCleanProcess(startProcessRequest);
    }

    @PostMapping("/{id}/variables/{varName}")
    public ResponseEntity<MessageResponse> setVariable(
            @PathVariable String id, @PathVariable String varName, @RequestBody VariablePayload variablePayload) {
        return processInstanceService.setVariable(id, varName, variablePayload);
    }

}
