import { InjectionToken } from '@angular/core';
import { Observable } from 'rxjs';
import { TaskPayload } from 'src/app/model/generic/task';

const DESC = 'task_factory_desc';

export const GET_TASKS_RESPONSE = "GET_TASKS_RESPONSE";

export const taskActionFactoryToken: InjectionToken<TaskActionFactory> =
  new InjectionToken<TaskActionFactory>(DESC);

export interface TaskActionFactory {
  getTasks(id: string): Observable<TaskPayload[]>;
}
