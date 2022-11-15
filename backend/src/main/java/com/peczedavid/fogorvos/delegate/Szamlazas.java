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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class Szamlazas implements JavaDelegate {

    private static final Logger logger = LoggerFactory.getLogger(Szamlazas.class);

    @Autowired
    private UsedClinicServiceRepository usedClinicServiceRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RuntimeService runtimeService;

    @Override
    public void execute(DelegateExecution delegateExecution) throws Exception {
        String processInstanceId = delegateExecution.getProcessInstanceId();
        String variableName = "beteg";
        String userId = (String) runtimeService.getVariable(processInstanceId, variableName);
        User user = userRepository.findById(Long.valueOf(userId)).orElse(null);
        if (user == null) {
            logger.error("Cannot send bill, user with id " + userId + " not found");
        } else {
            List<UsedClinicService> usedClinicServices = usedClinicServiceRepository.findAllByUser(user);
            Double costSum = 0.0;
            for (UsedClinicService usedClinicService : usedClinicServices) {
                costSum += usedClinicService.getClinicService().getCost();
            }
            logger.info("Billing " + costSum + "Ft to " + user.getName());
        }
    }
}
