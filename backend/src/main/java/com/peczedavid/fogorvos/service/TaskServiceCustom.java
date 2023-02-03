package com.peczedavid.fogorvos.service;

import com.peczedavid.fogorvos.constants.CamundaConstants;
import com.peczedavid.fogorvos.exception.task.notfound.TaskNotFoundException;
import com.peczedavid.fogorvos.exception.user.notfound.UserNotFoundException;
import com.peczedavid.fogorvos.model.db.ClinicService;
import com.peczedavid.fogorvos.model.db.UsedClinicService;
import com.peczedavid.fogorvos.model.db.User;
import com.peczedavid.fogorvos.model.network.MessageResponse;
import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import com.peczedavid.fogorvos.model.task.generic.TaskTipus;
import com.peczedavid.fogorvos.repository.ClinicServiceRepository;
import com.peczedavid.fogorvos.repository.UsedClinicServiceRepository;
import com.peczedavid.fogorvos.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.camunda.bpm.engine.rest.dto.task.TaskDto;
import org.camunda.bpm.engine.task.Task;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static com.peczedavid.fogorvos.constants.CamundaConstants.VARIABLE_FOGSZABALYZO_NAME;
import static com.peczedavid.fogorvos.model.db.ClinicService.*;

@Service
@Slf4j
public class TaskServiceCustom {

    private final TaskService taskService;
    private final RuntimeService runtimeService;
    private final UserRepository userRepository;
    private final ClinicServiceRepository clinicServiceRepository;
    private final UsedClinicServiceRepository usedClinicServiceRepository;

    public TaskServiceCustom(
            TaskService taskService,
            RuntimeService runtimeService,
            UserRepository userRepository,
            ClinicServiceRepository clinicServiceRepository,
            UsedClinicServiceRepository usedClinicServiceRepository
    ) {
        this.taskService = taskService;
        this.runtimeService = runtimeService;
        this.userRepository = userRepository;
        this.clinicServiceRepository = clinicServiceRepository;
        this.usedClinicServiceRepository = usedClinicServiceRepository;
    }

    public ResponseEntity<List<TaskPayload>> getAllTasks() {
        List<Task> taskList = taskService.createTaskQuery().list();
        List<TaskPayload> taskPayloadList = new ArrayList<>(taskList.size());

        for (Task task : taskList) {
            List<VariableInstanceDto> taskVariables = runtimeService
                    .createVariableInstanceQuery()
                    .processInstanceIdIn(task.getProcessInstanceId())
                    .list()
                    .stream()
                    .map(VariableInstanceDto::fromVariableInstance)
                    .toList();

            TaskPayload taskPayload = TaskPayload.fromTask(task, taskVariables);
            final Optional<User> user = userRepository.findById(Long.valueOf(taskPayload.getTaskDto().getAssignee()));
            user.ifPresent(value -> taskPayload.setAssigneeName(value.getName()));

            taskPayloadList.add(taskPayload);
        }
        return new ResponseEntity<>(taskPayloadList, HttpStatus.OK);
    }

    public ResponseEntity<TaskPayload> getTask(String id) {
        Task task = taskService.createTaskQuery().taskId(id).singleResult();
        if (task == null) {
            log.error("Task {} not found", id);
            throw new TaskNotFoundException("Feladat '" + id + "' nem található", id);
        }
        List<VariableInstanceDto> taskVariables = runtimeService
                .createVariableInstanceQuery()
                .processInstanceIdIn(task.getProcessInstanceId())
                .list()
                .stream()
                .map(VariableInstanceDto::fromVariableInstance)
                .toList();

        return new ResponseEntity<>(TaskPayload.fromTask(task, taskVariables), HttpStatus.OK);
    }

    public ResponseEntity<MessageResponse> complete(String id) {
        Task task = taskService.createTaskQuery().taskId(id).singleResult();
        if (task == null) {
            log.error("Task {} not found", id);
            throw new TaskNotFoundException("Feladat '" + id + "' nem található", id);
        }

        // Nem tudom miért ellenőrzöm le, de nem baj
        String processInstanceId = task.getProcessInstanceId();
        String patientId = (String) runtimeService.getVariable(processInstanceId, CamundaConstants.VARIABLE_ROLE_BETEG_NAME);
        User user = userRepository.findById(Long.valueOf(patientId)).orElse(null);
        if (user == null) {
            log.error("Cannot find user with id {}", patientId);
            throw new UserNotFoundException("Nem található a felhasználó.", patientId);
        }

        List<ClinicService> clinicServices = getClinicServices(task);
        for (ClinicService clinicService : clinicServices) {
            usedClinicServiceRepository.save(
                    UsedClinicService.builder()
                            .clinicService(clinicService)
                            .user(user)
                            .handled(false)
                            .processInstanceId(processInstanceId)
                            .build()
            );
        }

        taskService.complete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    private List<ClinicService> getClinicServices(Task task) {
        TaskDto taskDto = TaskDto.fromEntity(task);
        TaskTipus taskTipus = TaskTipus.fromTaskDefinitionKey(taskDto.getTaskDefinitionKey());
        // Fogszabályzó felrakása párhuzamos, egyszerre kell elmenteni a szakorvosi vizsgálattal,
        // mert utána jön közvetlen a számlázás, ezért lesz lista
        List<ClinicService> clinicServices = new ArrayList<>();
        switch (taskTipus) {
            case TASK_VIZSGALAT ->
                    clinicServiceRepository.findByName(CLINIC_SERVICE_VIZSGALAT).ifPresent(clinicServices::add);
            case TASK_RONTGEN ->
                    clinicServiceRepository.findByName(CLINIC_SERVICE_RONTGEN).ifPresent(clinicServices::add);
            case TASK_SZAKORVOSI_VIZSGALAT -> {
                clinicServiceRepository.findByName(CLINIC_SERVICE_SZAKORVOSI_VIZSGALAT).ifPresent(clinicServices::add);
                boolean bracesNeeded = (boolean) runtimeService.getVariable(task.getProcessInstanceId(), VARIABLE_FOGSZABALYZO_NAME);
                if (bracesNeeded)
                    clinicServiceRepository.findByName(CLINIC_SERVICE_FOGSZABALYZO_FELRAKASA).ifPresent(clinicServices::add);
            }
            default -> log.warn("Other services are free of charce");
        }
        return clinicServices;
    }
}
