import { HttpRequest, HttpResponse } from '@angular/common/http';
import { CoreStateAction } from 'src/app/model/CoreStateAction';
import { TaskPayload } from 'src/app/model/generic/task';
import { MessageResponse } from 'src/app/model/MessageResponse';
import {
  GET_TASKS_RESPONSE,
  NEW_PROCESS_RESPONSE,
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
      return setSelectedTaskResponse(tasksState, action.payload);
    case NEW_PROCESS_RESPONSE:
        return newProcess(tasksState, action.payload);
    default:
      return tasksState;
  }
}

function newProcess(tasksState: TasksState, response: HttpResponse<MessageResponse>) {
    const changes: TasksState = {
        tasks: tasksState.tasks,
        selectedTask: tasksState.selectedTask
    };
    return changeState(tasksState, changes);
}

function setSelectedTaskResponse(
  tasksState: TasksState,
  selectedTask?: TaskPayload
): TasksState {
  const changes: TasksState = {
    selectedTask: selectedTask,
    tasks: tasksState.tasks,
  };
  return changeState(tasksState, changes);
}

function getTasksResponse(
  tasksState: TasksState,
  tasks: TaskPayload[]
): TasksState {
  const changes: TasksState = {
    tasks: tasks,
  };
  return changeState(tasksState, changes);
}

function changeState(
  originalState: TasksState,
  changes: TasksState
): TasksState {
  return Object.assign({}, originalState, changes);
}
