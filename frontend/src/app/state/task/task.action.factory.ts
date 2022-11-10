import { HttpResponse } from '@angular/common/http';
import { InjectionToken } from '@angular/core';
import { Observable } from 'rxjs';
import { TaskPayload } from 'src/app/model/generic/task';
import { MessageResponse } from 'src/app/model/MessageResponse';

const DESC = 'task_factory_desc';

export const GET_TASKS_RESPONSE = "GET_TASKS_RESPONSE";
export const SET_SELECTED_TASK_RESPONSE = "SET_SELECTED_TASK_RESPONSE";
export const NEW_PROCESS_RESPONSE = "NEW_PROCESS_RESPONSE";

export const taskActionFactoryToken: InjectionToken<TaskActionFactory> =
  new InjectionToken<TaskActionFactory>(DESC);

export interface TaskActionFactory {
  getTasks(userId: string): Observable<TaskPayload[]>;
  setSelectedTask(task?: TaskPayload): Observable<TaskPayload>;
  newProcess(): Observable<HttpResponse<MessageResponse>>;
}
