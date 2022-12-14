export interface TaskPayload {
  taskDto: TaskDto;
  taskTipus: TaskTipus;
}

export interface TaskDto {
  id: string;
  name: string;
  assignee: string;
  description: string;
  processInstanceId: string;
  created: Date;
}

export enum TaskTipus {
  TASK_MEGJELENES_IDOPONTON = 'TASK_MEGJELENES_IDOPONTON',
  TASK_BETEG_ERTESITESE = 'TASK_BETEG_ERTESITESE',
  TASK_VIZSGALAT = 'TASK_VIZSGALAT',
  TASK_RONTGEN = 'TASK_RONTGEN',
  TASK_FELULVIZSGALAT = 'TASK_FELULVIZSGALAT',
  TASK_SZAKORVOSI_VIZSGALAT = 'TASK_SZAKORVOSI_VIZSGALAT',
  TASK_FOGSZABALYZO_FELRAKASA = 'TASK_FOGSZABALYZO_FELRAKASA',
  NONE = 'NONE',
}
