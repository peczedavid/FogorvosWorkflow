package com.peczedavid.fogorvos.delegate;

import com.peczedavid.fogorvos.model.db.UsedClinicService;
import com.peczedavid.fogorvos.model.db.User;
import com.peczedavid.fogorvos.repository.UsedClinicServiceRepository;
import com.peczedavid.fogorvos.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import org.springframework.stereotype.Component;

import java.util.List;

import static com.peczedavid.fogorvos.constants.CamundaConstants.VARIABLE_ROLE_BETEG_NAME;

@Component
@Slf4j
public class Szamlazas implements JavaDelegate {
    private final UsedClinicServiceRepository usedClinicServiceRepository;
    private final UserRepository userRepository;
    private final RuntimeService runtimeService;

    public Szamlazas(
            UsedClinicServiceRepository usedClinicServiceRepository,
            UserRepository userRepository,
            RuntimeService runtimeService
    ) {
        this.usedClinicServiceRepository = usedClinicServiceRepository;
        this.userRepository = userRepository;
        this.runtimeService = runtimeService;
    }

    @Override
    public void execute(DelegateExecution delegateExecution) throws Exception {
        String processInstanceId = delegateExecution.getProcessInstanceId();
        String userId = (String) runtimeService.getVariable(processInstanceId, VARIABLE_ROLE_BETEG_NAME);
        User user = userRepository.findById(Long.valueOf(userId)).orElse(null);
        if (user == null) {
            log.error("Cannot send bill, user with id {} not found", userId);
        } else {
            List<UsedClinicService> usedClinicServices = usedClinicServiceRepository
                    .findAllByUserAndProcessInstanceId(user, processInstanceId);
            Double costSum = 0.0;
            for (UsedClinicService usedClinicService : usedClinicServices) {
                if (!usedClinicService.getHandled()) {
                    Double cost = usedClinicService.getClinicService().getCost();
                    costSum += cost;
                    log.info(String.format("   %6.2fFt", cost));
                    usedClinicService.setHandled(true);
                }
            }
            log.info("----------");
            log.info(String.format(" + %6.2fFt", costSum));
            log.info(String.format("Billing %.2fFt to %s", costSum, user.getName()));
            log.info("");
        }
    }
}
