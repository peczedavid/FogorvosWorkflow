import { createReducer, on } from "@ngrx/store";
import { TaskPayload } from "src/app/model/generic/task";
import { loadTasks, selectTask } from "./task.actions";

export interface TasksState {
    tasks: TaskPayload[],
    selectedTask: TaskPayload | undefined,
}

export const initialState: TasksState = {
    tasks: [],
    selectedTask: undefined
};

export const tasksReducer = createReducer(
    initialState,
    
    on(loadTasks, (state, { tasks }) => ({ ...state, tasks: tasks })),
);