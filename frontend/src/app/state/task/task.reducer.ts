import { CoreStateAction } from 'src/app/model/CoreStateAction';
import { TaskPayload } from 'src/app/model/generic/task';
import {
  GET_TASKS_RESPONSE,
  SET_SELECTED_TASK_RESPONSE,
} from './task.action.factory';
import { TasksState } from './task.state.model';

export function taskReducer(
  tasksState: TasksState,
  action: CoreStateAction<any>
): TasksState {
  if (!tasksState) {
    tasksState = {
      tasks: [],
    };
  }
  switch (action.type) {
    case GET_TASKS_RESPONSE:
      return getTasksResponse(tasksState, action.payload);
    case SET_SELECTED_TASK_RESPONSE:
      return setSelectedTaskRespone(tasksState, action.payload);
    default:
      return tasksState;
  }
}

function setSelectedTaskRespone(
  tasksState: TasksState,
  taskId: string
): TasksState {
  const changes: TasksState = {
    tasks: tasksState.tasks,
    selectedTask: tasksState.tasks.find((task: TaskPayload) => {
      return task.taskDto.id === taskId;
    }),
  };
  return changeState(tasksState, changes);
}

function getTasksResponse(
  tasksState: TasksState,
  tasks: TaskPayload[]
): TasksState {
  const changes: TasksState = {
    tasks: tasks,
    selectedTask: undefined
  };
  return changeState(tasksState, changes);
}

function changeState(
  originalState: TasksState,
  changes: TasksState
): TasksState {
  return Object.assign({}, originalState, changes);
}
