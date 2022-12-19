package com.peczedavid.fogorvos.delegate;

import com.peczedavid.fogorvos.model.db.UsedClinicService;
import com.peczedavid.fogorvos.model.db.User;
import com.peczedavid.fogorvos.repository.UsedClinicServiceRepository;
import com.peczedavid.fogorvos.repository.UserRepository;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.List;

import static com.peczedavid.fogorvos.constants.CamundaConstants.VARIABLE_ROLE_BETEG_NAME;

@Component
public class Szamlazas implements JavaDelegate {
    private static final Logger logger = LoggerFactory.getLogger(Szamlazas.class);

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
            logger.error("Cannot send bill, user with id " + userId + " not found");
        } else {
            List<UsedClinicService> usedClinicServices = usedClinicServiceRepository
                    .findAllByUserAndProcessInstanceId(user, processInstanceId);
            Double costSum = 0.0;
            for (UsedClinicService usedClinicService : usedClinicServices) {
                if (!usedClinicService.getHandled()) {
                    Double cost = usedClinicService.getClinicService().getCost();
                    costSum += cost;
                    logger.info("   " + cost + "Ft");
                    usedClinicService.setHandled(true);
                }
            }
            logger.info("----------");
            logger.info(" + " + costSum + "Ft");
            logger.info("Billing " + costSum + "Ft to " + user.getName());
            logger.info("");
        }
    }
}
