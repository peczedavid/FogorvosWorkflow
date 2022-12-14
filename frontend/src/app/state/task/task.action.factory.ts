import { InjectionToken } from '@angular/core';
import { Observable } from 'rxjs';
import { TaskPayload } from 'src/app/model/generic/task';
import { MessageResponse } from 'src/app/model/MessageResponse';

const DESC = 'task_factory_desc';

export const GET_TASKS_RESPONSE = 'GET_TASKS_RESPONSE';
export const GET_TASKS_KEEP_SELECTED_RESPONSE =
  'GET_TASKS_KEEP_SELECTED_RESPONSE';
export const SET_SELECTED_TASK_RESPONSE = 'SET_SELECTED_TASK_RESPONSE';
export const START_NEW_PROCESS_RESPONSE = 'START_NEW_PROCESS_RESPONSE';
export const COMPLETE_TASK_RESPONSE = 'COMPLETE_TASK_RESPONSE';
export const SET_VARIABLE_RESPONSE = 'SET_VARIABLE_RESPONSE';
export const DELETE_PROCESS_INSTANCE_RESPONSE = 'DELETE_PROCESS_INSTANCE_RESPONSE'; 

export const taskActionFactoryToken: InjectionToken<TaskActionFactory> =
  new InjectionToken<TaskActionFactory>(DESC);

export interface TaskActionFactory {
  getTasks(userId: string): Observable<TaskPayload[]>;
  getTasksKeepSelected(userId: string): Observable<TaskPayload[]>;
  setSelectedTask(taskId?: string): Observable<TaskPayload>;
  startNewProcess(patientId: string): Observable<MessageResponse>;
  completeTask(taskName: string): Observable<MessageResponse>;
  setVariable(
    processId: string,
    variableName: string,
    variableValue: any
  ): Observable<MessageResponse>;
  deleteProcessInstance(processInstanceId: string): Observable<MessageResponse>;
}
