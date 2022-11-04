package com.peczedavid.fogorvos.service;

import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.camunda.bpm.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserService {

    @Autowired
    private TaskService taskService;

    @Autowired
    private RuntimeService runtimeService;

    public List<TaskPayload> getTasks(String userId) {
        java.util.List<Task> tasks = taskService.createTaskQuery().list();
        List<TaskPayload> taskPayloads = new ArrayList<>(tasks.size());

        for (Task task : tasks) {
            if (task.getAssignee().equals(userId)) {
                List<VariableInstanceDto> taskVariables = runtimeService
                        .createVariableInstanceQuery()
                        .processInstanceIdIn(task.getProcessInstanceId())
                        .list()
                        .stream()
                        .map(VariableInstanceDto::fromVariableInstance)
                        .collect(Collectors.toList());

                TaskPayload taskPayload = TaskPayload.fromTask(task, taskVariables);
                taskPayloads.add(taskPayload);
            }
        }
        return taskPayloads;
    }

}
