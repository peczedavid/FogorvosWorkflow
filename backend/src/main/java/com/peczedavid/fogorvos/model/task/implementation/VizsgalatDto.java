package com.peczedavid.fogorvos.model.task.implementation;

import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import com.peczedavid.fogorvos.model.task.generic.TaskTipus;
import com.peczedavid.fogorvos.util.VariableUtil;
import lombok.Getter;
import lombok.Setter;
import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.camunda.bpm.engine.rest.dto.task.TaskDto;

import java.util.List;

import static com.peczedavid.fogorvos.constants.CamundaConstants.VARIABLE_RONTGEN_NAME;

@Getter
@Setter
public class VizsgalatDto extends TaskPayload {

    private boolean rontgen;

    public VizsgalatDto(TaskDto taskDto, TaskTipus taskTipus, List<VariableInstanceDto> taskVariables) {
        this.taskDto = taskDto;
        this.taskTipus = taskTipus;
        this.rontgen = (boolean) VariableUtil.getValue(taskVariables, VARIABLE_RONTGEN_NAME);
    }

}
