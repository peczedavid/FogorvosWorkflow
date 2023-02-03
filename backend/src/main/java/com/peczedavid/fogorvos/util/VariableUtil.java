package com.peczedavid.fogorvos.util;

import lombok.extern.slf4j.Slf4j;
import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;

import java.util.List;

@Slf4j
public class VariableUtil {

    private VariableUtil() {
    }

    public static Object getValue(List<VariableInstanceDto> taskVariables, String variableName) {
        VariableInstanceDto variableInstanceDto = taskVariables
                .stream()
                .filter(variable -> variable.getName().equals(variableName))
                .findFirst()
                .orElse(null);
        if (variableInstanceDto == null) {
            log.error("Couldn't get value from variable '{}'", variableName);
            return null;
        }
        return variableInstanceDto.getValue();
    }

}
