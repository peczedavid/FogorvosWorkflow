package com.peczedavid.fogorvos.model.task.generic;

import com.peczedavid.fogorvos.model.task.implementation.*;
import lombok.Getter;
import lombok.Setter;
import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.camunda.bpm.engine.rest.dto.task.TaskDto;
import org.camunda.bpm.engine.task.Task;

import java.util.List;

// Bármi konkrét task-nak a dto-ja ebből származik le
// A frontend felé TaskPayload típusú objektumot küldünk
@Getter
@Setter
public abstract class TaskPayload {

    protected String assigneeName;

    protected TaskTipus taskTipus;

    protected TaskDto taskDto;

    public static TaskPayload fromTask(Task task, List<VariableInstanceDto> taskVariables) {
        TaskDto taskDto = TaskDto.fromEntity(task);
        TaskTipus taskTipus = TaskTipus.fromTaskDefinitionKey(taskDto.getTaskDefinitionKey());
        return switch (taskTipus) {
            case TASK_MEGJELENES_IDOPONTON -> new MegjelenesIdopontonDto(taskDto, taskTipus);
            case TASK_BETEG_ERTESITESE -> new BetegErtesiteseDto(taskDto, taskTipus, taskVariables);
            case TASK_VIZSGALAT -> new VizsgalatDto(taskDto, taskTipus, taskVariables);
            case TASK_RONTGEN -> new RontgenDto(taskDto, taskTipus);
            case TASK_FELULVIZSGALAT -> new FelulVizsgalatDto(taskDto, taskTipus, taskVariables);
            case TASK_SZAKORVOSI_VIZSGALAT -> new SzakorvosiVizsgalatDto(taskDto, taskTipus, taskVariables);
            case TASK_FOGSZABALYZO_FELRAKASA -> new FogszabalyzoFelrakasaDto(taskDto, taskTipus);
            default -> null;
        };
    }

}
