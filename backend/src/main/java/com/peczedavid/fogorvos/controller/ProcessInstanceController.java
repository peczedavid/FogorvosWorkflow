package com.peczedavid.fogorvos.controller;

import com.peczedavid.fogorvos.model.MessageResponse;
import com.peczedavid.fogorvos.model.process.VariablePayload;
import com.peczedavid.fogorvos.service.ProcessInstanceService;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.exception.NullValueException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = {"http://localhost:4200"}, maxAge = 3600, allowCredentials = "true")
@Controller
@RequestMapping("/process-instance")
public class ProcessInstanceController {
    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private ProcessInstanceService processInstanceService;

    @PostMapping("/new")
    public ResponseEntity<?> startCleanProcess() {
        var processInstance = processInstanceService.getCleanProcess();
        return new ResponseEntity<>(new MessageResponse(processInstance.getProcessInstanceId()), HttpStatus.OK);
    }

    @PostMapping("/{id}/variables/{varName}")
    public ResponseEntity<MessageResponse> setVariable(
            @PathVariable String id,
            @PathVariable String varName,
            @RequestBody VariablePayload variablePayload) {
        try {
            if (runtimeService.getVariable(id, varName) == null)
                return new ResponseEntity<>(new MessageResponse("Variable not found"), HttpStatus.NOT_FOUND);
        } catch (NullValueException e) {
            return new ResponseEntity<>(new MessageResponse("Process instance not found"), HttpStatus.NOT_FOUND);
        }

        runtimeService.setVariable(id, varName, variablePayload.getValue());
        // TODO: check if actually changed
        return new ResponseEntity<>(new MessageResponse("Variable set"), HttpStatus.OK);
    }

}
