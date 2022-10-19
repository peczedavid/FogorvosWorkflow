package com.peczedavid.fogorvos.model.task.implementation;

import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import com.peczedavid.fogorvos.model.task.generic.TaskTipus;
import lombok.Getter;
import lombok.Setter;
import org.camunda.bpm.engine.rest.dto.task.TaskDto;

@Getter
@Setter
public class SzakorvosiVizsgalatDto extends TaskPayload {

    private boolean fogszabalyzo;

    public SzakorvosiVizsgalatDto(TaskDto taskDto, TaskTipus taskTipus) {
        this.taskDto = taskDto;
        this.taskTipus = taskTipus;
    }

}