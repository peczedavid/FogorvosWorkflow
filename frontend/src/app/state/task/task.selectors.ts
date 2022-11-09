import { createFeatureSelector, createSelector } from "@ngrx/store";
import { TasksState } from "./task.reducer";
import { AppState } from "../app.state";

// 
// export const getTasks = (state: AppState) => state.tasksState.tasks;
// export const getSelectedTasks = createSelector(
//     getTasks,
//     (state: TasksState) => state.selectedTask
// );