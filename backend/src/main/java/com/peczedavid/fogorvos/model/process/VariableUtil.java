package com.peczedavid.fogorvos.model.process;

import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;

import java.util.List;

public class VariableUtil {

    public static Object getValue(List<VariableInstanceDto> taskVariables, String variableName) {
        return taskVariables
                .stream().filter(variable -> variable.getName().equals(variableName))
                .findFirst()
                .get()
                .getValue();
    }

}
