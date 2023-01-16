package com.peczedavid.fogorvos.util;

import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

public class VariableUtil {

    private static final Logger logger = LoggerFactory.getLogger(VariableUtil.class);

    private VariableUtil() {
    }

    public static Object getValue(List<VariableInstanceDto> taskVariables, String variableName) {
        VariableInstanceDto variableInstanceDto = taskVariables
                .stream()
                .filter(variable -> variable.getName().equals(variableName))
                .findFirst()
                .orElse(null);
        if (variableInstanceDto == null) {
            logger.error("Couldn't get value from variable '" + variableName + "'");
            return null;
        }
        return variableInstanceDto.getValue();
    }

}
