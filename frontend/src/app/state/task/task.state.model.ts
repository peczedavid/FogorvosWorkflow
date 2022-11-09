import { createFeatureSelector } from '@ngrx/store';
import { TaskPayload } from '../../model/generic/task';

export const TASKS_STATE_NAME = 'task';

export interface TasksState {
  tasks: TaskPayload[];
}

export const selectTasksState =
  createFeatureSelector<TasksState>(TASKS_STATE_NAME);
