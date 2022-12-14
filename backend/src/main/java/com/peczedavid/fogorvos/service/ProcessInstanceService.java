package com.peczedavid.fogorvos.service;

import com.peczedavid.fogorvos.exception.processinstance.notfound.ProcessInstanceNotFoundException;
import com.peczedavid.fogorvos.exception.user.notfound.UserNotFoundException;
import com.peczedavid.fogorvos.exception.variable.notfound.VariableNotFoundException;
import com.peczedavid.fogorvos.model.db.User;
import com.peczedavid.fogorvos.model.network.MessageResponse;
import com.peczedavid.fogorvos.model.network.StartProcessRequest;
import com.peczedavid.fogorvos.model.process.VariablePayload;
import com.peczedavid.fogorvos.repository.UsedClinicServiceRepository;
import com.peczedavid.fogorvos.repository.UserRepository;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.exception.NullValueException;
import org.camunda.bpm.engine.runtime.ProcessInstance;
import org.camunda.bpm.engine.runtime.ProcessInstanceWithVariables;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

import static com.peczedavid.fogorvos.constants.CamundaConstants.*;

@Service
public class ProcessInstanceService {

    private static final Logger logger = LoggerFactory.getLogger(ProcessInstanceService.class);

    private final RuntimeService runtimeService;
    private final UserRepository userRepository;
    private final UsedClinicServiceRepository usedClinicServiceRepository;

    public ProcessInstanceService(
            RuntimeService runtimeService,
            UserRepository userRepository,
            UsedClinicServiceRepository usedClinicServiceRepository) {
        this.runtimeService = runtimeService;
        this.userRepository = userRepository;
        this.usedClinicServiceRepository = usedClinicServiceRepository;
    }

    public ResponseEntity<MessageResponse> deleteProcess(String id) {
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(id).singleResult();

        if (processInstance == null) {
            logger.error("Process instance with id: " + id + " not found");
            throw new ProcessInstanceNotFoundException("Folyamat nem tal??lhat??", id);
        }

        usedClinicServiceRepository.removeByProcessInstanceId(id);
        runtimeService.deleteProcessInstance(id, "Manually deleted");

        logger.info("Process instance with id: " + id + " deleted successfully");
        return new ResponseEntity<>(new MessageResponse("Folyamat sikeresen t??r??lve"), HttpStatus.OK);
    }

    public ResponseEntity<MessageResponse> startCleanProcess(StartProcessRequest startProcessRequest) {
        User user = userRepository.findByName(startProcessRequest.getPatientName()).orElse(null);
        if (user == null) {
            final String username = startProcessRequest.getPatientName();
            logger.error("Cannot find user with name " + username);
            throw new UserNotFoundException("Nem tal??lhat?? a felhaszn??l??", username);
        }

        Map<String, Object> variables = setUpVariables(user);

        ProcessInstanceWithVariables processInstance = runtimeService.createProcessInstanceByKey(PROCESS_NAME)
                .setVariables(variables)
                .executeWithVariablesInReturn();

        logger.info("Process instance " + processInstance.getProcessInstanceId() + " started");
        return new ResponseEntity<>(new MessageResponse(processInstance.getProcessInstanceId()), HttpStatus.OK);
    }

    public ResponseEntity<MessageResponse> setVariable(String id, String varName, VariablePayload variablePayload) {
        Object variable;
        try {
            if ((variable = runtimeService.getVariable(id, varName)) == null) {
                logger.error("Variable '" + varName + "' not found");
                throw new VariableNotFoundException("V??ltoz?? '" + varName + "' nem tal??lhat??", varName);
            }
        } catch (NullValueException e) {
            logger.error("Process instance with id: " + id + " not found");
            throw new ProcessInstanceNotFoundException("Folyamat nem tal??lhat??", id);
        }

        runtimeService.setVariable(id, varName, variablePayload.getValue());
        if (!variable.equals(runtimeService.getVariable(id, varName))) {
            logger.info("Variable '" + varName + "' value changed");
            return new ResponseEntity<>(new MessageResponse("'" + varName + "' v??ltoz?? ??rt??ke megv??ltozott"), HttpStatus.OK);
        } else {
            logger.warn("Couldn't change variable value for '" + varName + "'");
            //return new ResponseEntity<>(new MessageResponse("Couldn't change variable value for '" + varName + "'."), HttpStatus.INTERNAL_SERVER_ERROR);
            return new ResponseEntity<>(new MessageResponse("Nem siker??lt megv??ltoztatni '" + varName + "' v??ltoz?? ??rt??k??t"), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private Map<String, Object> setUpVariables(User user) {
        Map<String, Object> variables = new HashMap<>();

        variables.put(VARIABLE_ROLE_BETEG_NAME, user.getId().toString());
        variables.put(VARIABLE_ROLE_RECEPCIOS_NAME, "14");
        variables.put(VARIABLE_ROLE_ORVOS_NAME, "14");
        variables.put(VARIABLE_ROLE_RONTGENES_NAME, "14");
        variables.put(VARIABLE_ROLE_SZAKORVOS_NAME, "14");
        variables.put(VARIABLE_RONTGEN_NAME, false);
        variables.put(VARIABLE_SZAKORVOSI_VIZSGALAT_NAME, false);
        variables.put(VARIABLE_FOGSZABALYZO_NAME, false);
        variables.put(VARIABLE_ELMARAD_NAME, false);

        return variables;
    }


}
