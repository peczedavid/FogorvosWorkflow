package com.peczedavid.fogorvos.model.task.implementation;

import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import com.peczedavid.fogorvos.model.task.generic.TaskTipus;
import org.camunda.bpm.engine.rest.dto.task.TaskDto;

public class MegjelenesIdopontonDto extends TaskPayload {

    public MegjelenesIdopontonDto(TaskDto taskDto, TaskTipus taskTipus) {
        this.taskDto = taskDto;
        this.taskTipus = taskTipus;
    }

}
