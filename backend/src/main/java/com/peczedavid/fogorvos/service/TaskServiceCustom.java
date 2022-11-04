package com.peczedavid.fogorvos.service;

import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.camunda.bpm.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TaskServiceCustom {

    @Autowired
    private TaskService taskService;

    @Autowired
    private RuntimeService runtimeService;

    public TaskPayload getTask(String id) {
        Task task = taskService.createTaskQuery().taskId(id).list().get(0);

        List<VariableInstanceDto> taskVariables = runtimeService
                .createVariableInstanceQuery()
                .processInstanceIdIn(task.getProcessInstanceId())
                .list()
                .stream()
                .map(VariableInstanceDto::fromVariableInstance)
                .collect(Collectors.toList());

        return TaskPayload.fromTask(task, taskVariables);
    }

    public void complete(String id) {
        taskService.complete(id);
    }
}
