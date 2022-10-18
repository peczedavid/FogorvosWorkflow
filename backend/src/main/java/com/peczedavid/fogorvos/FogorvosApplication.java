package com.peczedavid.fogorvos;

import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;
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

	private void testFogszabalyzoKell() {
		ProcessInstanceWithVariables instance = runtimeService.createProcessInstanceByKey("Process_Fogorvos")
				.setVariable("beteg", "fogorvosdemo")
				.setVariable("recepcios", "fogorvosdemo")
				.setVariable("orvos", "fogorvosdemo")
				.setVariable("rontgenes", "fogorvosdemo")
				.setVariable("szakorvos", "fogorvosdemo")
				.setVariable("rontgen", true)
				.setVariable("szakorvosiVizsgalat", true)
				.setVariable("fogszabalyzo", true)
				.executeWithVariablesInReturn();
	}

	private void testFogszabalyzoNemKell() {
		ProcessInstanceWithVariables instance = runtimeService.createProcessInstanceByKey("Process_Fogorvos")
				.setVariable("beteg", "fogorvosdemo")
				.setVariable("recepcios", "fogorvosdemo")
				.setVariable("orvos", "fogorvosdemo")
				.setVariable("rontgenes", "fogorvosdemo")
				.setVariable("szakorvos", "fogorvosdemo")
				.setVariable("rontgen", false)
				.setVariable("szakorvosiVizsgalat", false)
				.setVariable("fogszabalyzo", false)
				.executeWithVariablesInReturn();
	}

	private void testSzakorvosiNemKellFogszabalyzo() {
		ProcessInstanceWithVariables instance = runtimeService.createProcessInstanceByKey("Process_Fogorvos")
				.setVariable("beteg", "fogorvosdemo")
				.setVariable("recepcios", "fogorvosdemo")
				.setVariable("orvos", "fogorvosdemo")
				.setVariable("rontgenes", "fogorvosdemo")
				.setVariable("szakorvos", "fogorvosdemo")
				.setVariable("rontgen", true)
				.setVariable("szakorvosiVizsgalat", true)
				.setVariable("fogszabalyzo", false)
				.executeWithVariablesInReturn();
	}

	@EventListener
	private void processPostDeploy(PostDeployEvent event) {
		//testFogszabalyzoKell();
		//testFogszabalyzoNemKell();
		//testSzakorvosiNemKellFogszabalyzo();
		testMultipleProcesses();
	}

	public static void main(String[] args) {
		SpringApplication.run(FogorvosApplication.class, args);
	}

	private void testMultipleProcesses() {
		runtimeService.createProcessInstanceByKey("Process_Fogorvos")
				.setVariable("beteg", "beteg-uri-1")
				.setVariable("recepcios", "recepcios-uri-1")
				.setVariable("orvos", "orvos-uri-1")
				.setVariable("rontgenes", "rontgenes-uri-1")
				.setVariable("szakorvos", "szakorvos-uri-1")
				.setVariable("rontgen", true)
				.setVariable("szakorvosiVizsgalat", true)
				.setVariable("fogszabalyzo", true)
				.executeWithVariablesInReturn();
		runtimeService.createProcessInstanceByKey("Process_Fogorvos")
				.setVariable("beteg", "beteg-uri-2")
				.setVariable("recepcios", "recepcios-uri-1")
				.setVariable("orvos", "orvos-uri-1")
				.setVariable("rontgenes", "rontgenes-uri-1")
				.setVariable("szakorvos", "szakorvos-uri-1")
				.setVariable("rontgen", true)
				.setVariable("szakorvosiVizsgalat", true)
				.setVariable("fogszabalyzo", true)
				.executeWithVariablesInReturn();
		runtimeService.createProcessInstanceByKey("Process_Fogorvos")
				.setVariable("beteg", "beteg-uri-2")
				.setVariable("recepcios", "recepcios-uri-1")
				.setVariable("orvos", "orvos-uri-1")
				.setVariable("rontgenes", "rontgenes-uri-1")
				.setVariable("szakorvos", "szakorvos-uri-1")
				.setVariable("rontgen", true)
				.setVariable("szakorvosiVizsgalat", true)
				.setVariable("fogszabalyzo", true)
				.executeWithVariablesInReturn();
	}
}
