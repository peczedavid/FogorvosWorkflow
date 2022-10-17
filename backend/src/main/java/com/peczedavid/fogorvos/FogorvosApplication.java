package com.peczedavid.fogorvos;

import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.runtime.ProcessInstanceWithVariables;
import org.camunda.bpm.spring.boot.starter.annotation.EnableProcessApplication;
import org.camunda.bpm.spring.boot.starter.event.PostDeployEvent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.event.EventListener;

@EnableProcessApplication
@SpringBootApplication
public class FogorvosApplication {

	@Autowired
	private RuntimeService runtimeService;

	@EventListener
	private void processPostDeploy(PostDeployEvent event) {
		ProcessInstanceWithVariables instance = runtimeService.createProcessInstanceByKey("Process_Fogorvos")
				.setVariable("beteg", "beteg-uri-123")
				.executeWithVariablesInReturn();
	}

	public static void main(String[] args) {
		SpringApplication.run(FogorvosApplication.class, args);
	}

}
