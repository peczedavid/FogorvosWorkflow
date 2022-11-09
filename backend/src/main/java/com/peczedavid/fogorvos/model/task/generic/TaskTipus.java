package com.peczedavid.fogorvos.model.task.generic;

public enum TaskTipus {
    TASK_MEGJELENES_IDOPONTON,
    TASK_BETEG_ERTESITESE,
    TASK_VIZSGALAT,
    TASK_RONTGEN,
    TASK_FELULVIZSGALAT,
    TASK_SZAKORVOSI_VIZSGALAT,
    TASK_FOGSZABALYZO_FELRAKASA;

    public static TaskTipus fromTaskDefinitionKey(String taskDefinitionKey) {
        return switch (taskDefinitionKey) {
            case "Activity_MegjelenesIdoponton" -> TASK_MEGJELENES_IDOPONTON;
            case "Activity_BetegErtesitese" -> TASK_BETEG_ERTESITESE;
            case "Activity_Vizsgalat" -> TASK_VIZSGALAT;
            case "Activity_Rontgen" -> TASK_RONTGEN;
            case "Activity_Felulvizsgalat" -> TASK_FELULVIZSGALAT;
            case "Activity_SzakorvosiVizsgalat" -> TASK_SZAKORVOSI_VIZSGALAT;
            case "Activity_FogszabalyzoFelrakasa" -> TASK_FOGSZABALYZO_FELRAKASA;
            default -> null;
        };
    }
}
