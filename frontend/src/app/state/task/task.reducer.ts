import { CoreStateAction } from 'src/app/model/CoreStateAction';
import { TaskPayload } from 'src/app/model/generic/task';
import { MessageResponse } from 'src/app/model/MessageResponse';
import {
  COMPLETE_TASK_RESPONSE,
  DELETE_PROCESS_INSTANCE_RESPONSE,
  GET_TASKS_KEEP_SELECTED_RESPONSE,
  GET_TASKS_RESPONSE,
  SET_SELECTED_TASK_RESPONSE,
  SET_VARIABLE_RESPONSE,
  START_NEW_PROCESS_RESPONSE,
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
    case GET_TASKS_KEEP_SELECTED_RESPONSE:
      return getTasksKeepSelectedResponse(tasksState, action.payload);
    case SET_SELECTED_TASK_RESPONSE:
      return setSelectedTaskRespone(tasksState, action.payload);
    case START_NEW_PROCESS_RESPONSE:
      return startNewProcessResponse(tasksState, action.payload);
    case COMPLETE_TASK_RESPONSE:
      return completeTaskResponse(tasksState, action.payload);
    case SET_VARIABLE_RESPONSE:
      return setVariableResponse(tasksState, action.payload);
      case DELETE_PROCESS_INSTANCE_RESPONSE:
        return deleteProcessInstanceResponse(tasksState, action.payload);
    default:
      return tasksState;
  }
}

function setVariableResponse(
  tasksState: TasksState,
  message: MessageResponse
): TasksState {
  const changes: TasksState = {
    tasks: tasksState.tasks,
    selectedTask: tasksState.selectedTask,
  };
  return changeState(tasksState, changes);
}

function  deleteProcessInstanceResponse(tasksState: TasksState, payload: MessageResponse): TasksState {
  const changes: TasksState = {
    tasks: tasksState.tasks,
    selectedTask: tasksState.selectedTask,
  };
  return changeState(tasksState, changes);
}

function completeTaskResponse(
  tasksState: TasksState,
  message: MessageResponse
): TasksState {
  const changes: TasksState = {
    tasks: tasksState.tasks,
    selectedTask: undefined,
  };
  return changeState(tasksState, changes);
}

function startNewProcessResponse(
  tasksState: TasksState,
  message: MessageResponse
): TasksState {
  const changes: TasksState = {
    tasks: tasksState.tasks,
    selectedTask: tasksState.selectedTask,
  };
  return changeState(tasksState, changes);
}

function setSelectedTaskRespone(
  tasksState: TasksState,
  taskId?: string
): TasksState {
  if (taskId === undefined) {
    const changes: TasksState = {
      tasks: tasksState.tasks,
      selectedTask: undefined,
    };
    return changeState(tasksState, changes);
  } else {
    const changes: TasksState = {
      tasks: tasksState.tasks,
      selectedTask: tasksState.tasks.find((task: TaskPayload) => {
        return task.taskDto.id === taskId;
      }),
    };
    return changeState(tasksState, changes);
  }
}

function getTasksKeepSelectedResponse(
  tasksState: TasksState,
  tasks: TaskPayload[]
): TasksState {
  if (tasksState.selectedTask === undefined) {
    const changes: TasksState = {
      tasks: tasks,
      selectedTask: undefined,
    };
    return changeState(tasksState, changes);
  } else {
    const changes: TasksState = {
      tasks: tasks,
      selectedTask: tasks.find((task: TaskPayload) => {
        return task.taskDto.id === tasksState.selectedTask?.taskDto.id;
      }),
    };
    return changeState(tasksState, changes);
  }
}

function getTasksResponse(
  tasksState: TasksState,
  tasks: TaskPayload[]
): TasksState {
  const changes: TasksState = {
    tasks: tasks,
    selectedTask: undefined,
  };
  return changeState(tasksState, changes);
}

function changeState(
  originalState: TasksState,
  changes: TasksState
): TasksState {
  return Object.assign({}, originalState, changes);
}
