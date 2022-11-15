package com.peczedavid.fogorvos.service;

import com.peczedavid.fogorvos.model.db.ClinicService;
import com.peczedavid.fogorvos.model.db.UsedClinicService;
import com.peczedavid.fogorvos.model.db.User;
import com.peczedavid.fogorvos.model.network.MessageResponse;
import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import com.peczedavid.fogorvos.model.task.generic.TaskTipus;
import com.peczedavid.fogorvos.repository.ClinicServiceRepository;
import com.peczedavid.fogorvos.repository.UsedClinicServiceRepository;
import com.peczedavid.fogorvos.repository.UserRepository;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.camunda.bpm.engine.rest.dto.task.TaskDto;
import org.camunda.bpm.engine.task.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

import static com.peczedavid.fogorvos.model.db.ClinicService.*;

@Service
public class TaskServiceCustom {

    private static final Logger logger = LoggerFactory.getLogger(TaskServiceCustom.class);

    @Autowired
    private TaskService taskService;

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ClinicServiceRepository clinicServiceRepository;

    @Autowired
    private UsedClinicServiceRepository usedClinicServiceRepository;

    public ResponseEntity<?> getTask(String id) {
        Task task = taskService.createTaskQuery().taskId(id).singleResult();
        if (task == null) {
            logger.error("Task " + id + " not found");
            return new ResponseEntity<>(new MessageResponse("Task " + id + " not found!"), HttpStatus.NOT_FOUND);
        }
        List<VariableInstanceDto> taskVariables = runtimeService.createVariableInstanceQuery().processInstanceIdIn(task.getProcessInstanceId()).list().stream().map(VariableInstanceDto::fromVariableInstance).collect(Collectors.toList());

        return new ResponseEntity<>(TaskPayload.fromTask(task, taskVariables), HttpStatus.OK);
    }

    public ResponseEntity<?> complete(String id) {
        Task task = taskService.createTaskQuery().taskId(id).singleResult();
        if (task == null) {
            logger.error("Cannot find task with id " + id);
            return new ResponseEntity<>(new MessageResponse("Cannot find task with id " + id), HttpStatus.NOT_FOUND);
        }

        String patientId = (String) runtimeService.getVariable(task.getProcessInstanceId(), "beteg");
        User user = userRepository.findById(Long.valueOf(patientId)).orElse(null);
        if (user == null) {
            logger.error("Cannot find user with id " + patientId);
            return new ResponseEntity<>(new MessageResponse("Cannot find user with id " + patientId), HttpStatus.NOT_FOUND);
        }

        ClinicService clinicService;
        UsedClinicService usedClinicService;
        TaskDto taskDto = TaskDto.fromEntity(task);
        TaskTipus taskTipus = TaskTipus.fromTaskDefinitionKey(taskDto.getTaskDefinitionKey());
        switch (taskTipus) {
            case TASK_VIZSGALAT ->
                    clinicService = clinicServiceRepository.findByName(CLINIC_SERVICE_VIZSGALAT).orElse(null);
            case TASK_RONTGEN ->
                    clinicService = clinicServiceRepository.findByName(CLINIC_SERVICE_RONTGEN).orElse(null);
            case TASK_SZAKORVOSI_VIZSGALAT ->
                    clinicService = clinicServiceRepository.findByName(CLINIC_SERVICE_SZAKORVOSI_VIZSGALAT).orElse(null);
            case TASK_FOGSZABALYZO_FELRAKASA ->
                    clinicService = clinicServiceRepository.findByName(CLINIC_SERVICE_FOGSZABALYZO_FELRAKASA).orElse(null);
            default -> clinicService = null;
        }
        // Fizetős szolgáltatás
        if (clinicService != null) {
            usedClinicService = new UsedClinicService();
            usedClinicService.setClinicService(clinicService);
            usedClinicService.setUser(user);
            usedClinicServiceRepository.save(usedClinicService);
        }

        taskService.complete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
