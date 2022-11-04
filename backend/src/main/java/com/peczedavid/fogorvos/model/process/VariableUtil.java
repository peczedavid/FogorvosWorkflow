package com.peczedavid.fogorvos.model.process;

import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

public class VariableUtil {

    static Logger logger = LoggerFactory.getLogger(VariableUtil.class);

    public static Object getValue(List<VariableInstanceDto> taskVariables, String variableName) {
        var varInstance = taskVariables
                .stream()
                .filter(variable -> variable.getName().equals(variableName))
                .findFirst();
        if (varInstance.isPresent()) {
            return varInstance.get().getValue();
        } else {
            logger.error("Couldn't get value from variable '" + variableName + "'");
            return null;
        }
    }

}
