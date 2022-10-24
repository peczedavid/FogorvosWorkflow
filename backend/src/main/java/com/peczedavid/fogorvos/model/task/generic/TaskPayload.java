package com.peczedavid.fogorvos.model.task.generic;

import com.peczedavid.fogorvos.model.task.implementation.*;
import lombok.Getter;
import lombok.Setter;
import org.camunda.bpm.engine.rest.dto.task.TaskDto;
import org.camunda.bpm.engine.task.Task;

// Bármi konkrét task-nak a dto-ja ebből származik le
// A frontend felé TaskPayload típusú objektumot küldünk
@Getter
@Setter
public abstract class TaskPayload {

    protected TaskTipus taskTipus;

    protected TaskDto taskDto;

    public static TaskPayload fromTask(Task task) {
        TaskDto taskDto = TaskDto.fromEntity(task);
        TaskTipus taskTipus = TaskTipus.fromTaskDefinitionKey(taskDto.getTaskDefinitionKey());
        return switch (taskTipus) {
            case TASK_MEGJELENES_IDOPONTON -> new MegjelenesIdopontonDto(taskDto, taskTipus);
            case TASK_BETEG_ERTESITESE -> new BetegErtesiteseDto(taskDto, taskTipus);
            case TASK_VIZSGALAT -> new VizsgalatDto(taskDto, taskTipus);
            case TASK_RONTGEN -> new RontgenDto(taskDto, taskTipus);
            case TASK_FELULVIZSGALAT -> new FelulVizsgalatDto(taskDto, taskTipus);
            case TASK_SZAKORVOSI_VIZSGALAT -> new SzakorvosiVizsgalatDto(taskDto, taskTipus);
            case TASK_FOGSZABALYZO_FELRAKASA -> new FogszabalyzoFelrakasaDto(taskDto, taskTipus);
            default -> null;
        };
    }

}
