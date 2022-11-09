import { createAction, props } from '@ngrx/store';
import { TaskPayload } from 'src/app/model/generic/task';

export const completeTask = createAction(
  '[Tasks Page] Component',
  props<{ id: string }>()
);

export const loadTasks = createAction(
  '[Tasks Page Component] Load Tasks Success',
  props<{ tasks: TaskPayload[] }>()
);

export const selectTask = createAction('[Tasks Page] Select Task');
