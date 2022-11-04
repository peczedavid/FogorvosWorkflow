package com.peczedavid.fogorvos.model.task.implementation;

import com.peczedavid.fogorvos.model.process.VariableUtil;
import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import com.peczedavid.fogorvos.model.task.generic.TaskTipus;
import lombok.Getter;
import lombok.Setter;
import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.camunda.bpm.engine.rest.dto.task.TaskDto;

import java.util.List;

@Getter
@Setter
public class BetegErtesiteseDto extends TaskPayload {

    private boolean elmarad;

    public BetegErtesiteseDto(TaskDto taskDto, TaskTipus taskTipus, List<VariableInstanceDto> taskVariables) {
        this.taskDto = taskDto;
        this.taskTipus = taskTipus;
        this.elmarad = (boolean) VariableUtil.getValue(taskVariables, "elmarad");
    }

}