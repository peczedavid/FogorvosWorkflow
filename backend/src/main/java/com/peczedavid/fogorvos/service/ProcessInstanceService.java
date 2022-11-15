package com.peczedavid.fogorvos.service;

import com.peczedavid.fogorvos.model.db.User;
import com.peczedavid.fogorvos.model.network.MessageResponse;
import com.peczedavid.fogorvos.model.network.StartProcessRequest;
import com.peczedavid.fogorvos.model.process.VariablePayload;
import com.peczedavid.fogorvos.repository.UserRepository;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.exception.NullValueException;
import org.camunda.bpm.engine.runtime.ProcessInstanceWithVariables;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class ProcessInstanceService {

    private static final Logger logger = LoggerFactory.getLogger(ProcessInstanceService.class);

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private UserRepository userRepository;

    // TODO: automatikusan beosza a többi résztvevőt
    public ResponseEntity<MessageResponse> getCleanProcess(StartProcessRequest startProcessRequest) {
        User user = userRepository.findByName(startProcessRequest.getPatientName()).orElse(null);
        if (user == null)
            return new ResponseEntity<>(new MessageResponse("User '" + startProcessRequest.getPatientName() + "' not found."), HttpStatus.NOT_FOUND);

        ProcessInstanceWithVariables processInstance = runtimeService.createProcessInstanceByKey("Process_Fogorvos")
                .setVariable("beteg", user.getId().toString())
                .setVariable("recepcios", "14")
                .setVariable("orvos", "14")
                .setVariable("rontgenes", "14")
                .setVariable("szakorvos", "14")
                .setVariable("rontgen", false)
                .setVariable("szakorvosiVizsgalat", false)
                .setVariable("fogszabalyzo", false)
                .setVariable("elmarad", false)
                .executeWithVariablesInReturn();

        logger.info("Process instance " + processInstance.getProcessInstanceId() + " started");
        return new ResponseEntity<>(new MessageResponse(processInstance.getProcessInstanceId()), HttpStatus.OK);
    }

    public ResponseEntity<MessageResponse> setVariable(String id, String varName, VariablePayload variablePayload) {
        Object variable;
        try {
            if ((variable = runtimeService.getVariable(id, varName)) == null) {
                logger.warn("Variable '" + varName + "' not found");
                return new ResponseEntity<>(new MessageResponse("Variable '" + varName + "' not found"), HttpStatus.NOT_FOUND);
            }
        } catch (NullValueException e) {
            logger.info("Process instance '" + id + "' not found");
            return new ResponseEntity<>(new MessageResponse("Process instance '" + id + "' not found"), HttpStatus.NOT_FOUND);
        }
        runtimeService.setVariable(id, varName, variablePayload.getValue());
        if (!variable.equals(runtimeService.getVariable(id, varName))) {
            logger.info("Variable '" + varName + "' value changed.");
            return new ResponseEntity<>(new MessageResponse("Variable '" + varName + "' value changed."), HttpStatus.OK);
        } else {
            logger.warn("Couldn't change variable value for '" + varName + "'.");
            return new ResponseEntity<>(new MessageResponse("Couldn't change variable value for '" + varName + "'."), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
