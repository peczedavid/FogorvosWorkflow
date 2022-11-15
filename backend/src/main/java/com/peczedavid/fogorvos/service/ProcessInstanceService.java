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

        ProcessInstanceWithVariables processInstance = runtimeService.createProcessInstanceByKey(PROCESS_NAME)
                .setVariable(VARIABLE_ROLE_BETEG_NAME, user.getId().toString())
                .setVariable(VARIABLE_ROLE_RECEPCIOS_NAME, "14")
                .setVariable(VARIABLE_ROLE_ORVOS_NAME, "14")
                .setVariable(VARIABLE_ROLE_RONTGENES_NAME, "14")
                .setVariable(VARIABLE_ROLE_SZAKORVOS_NAME, "14")
                .setVariable(VARIABLE_RONTGEN_NAME, false)
                .setVariable(VARIABLE_SZAKORVOSI_VIZSGALAT_NAME, false)
                .setVariable(VARIABLE_FOGSZBALYZO_NAME, false)
                .setVariable(VARIABLE_ELMARAD_NAME, false)
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

    public static final String PROCESS_NAME = "Process_Fogorvos";

    public static final String VARIABLE_ROLE_BETEG_NAME = "beteg";
    public static final String VARIABLE_ROLE_RECEPCIOS_NAME = "recepcios";
    public static final String VARIABLE_ROLE_ORVOS_NAME = "orvos";
    public static final String VARIABLE_ROLE_RONTGENES_NAME = "rontgenes";
    public static final String VARIABLE_ROLE_SZAKORVOS_NAME = "szakorvos";

    public static final String VARIABLE_RONTGEN_NAME = "rontgen";
    public static final String VARIABLE_SZAKORVOSI_VIZSGALAT_NAME = "szakorvosiVizsgalat";
    public static final String VARIABLE_FOGSZBALYZO_NAME = "fogszabalyzo";
    public static final String VARIABLE_ELMARAD_NAME = "elmarad";

}
