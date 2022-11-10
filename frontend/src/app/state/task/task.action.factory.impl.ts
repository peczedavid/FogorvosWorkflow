import { Injectable } from '@angular/core';
import { Store } from '@ngrx/store';
import { Observable, Subscriber } from 'rxjs';
import { TaskPayload } from 'src/app/model/generic/task';
import { MessageResponse } from 'src/app/model/MessageResponse';
import { TaskService } from 'src/app/services/task.service';
import { UserService } from 'src/app/services/user.service';
import {
  COMPLETE_TASK_RESPONSE,
  GET_TASKS_KEEP_SELECTED_RESPONSE,
  GET_TASKS_RESPONSE,
  SET_SELECTED_TASK_RESPONSE,
  SET_VARIABLE_RESPONSE,
  START_NEW_PROCESS_RESPONSE,
  TaskActionFactory,
} from './task.action.factory';

@Injectable()
export class TaskActionFactoryImpl implements TaskActionFactory {
  constructor(
    private taskService: TaskService,
    private userService: UserService,
    private ngrxStore: Store<any>
  ) {}

  setVariable(processId: string, variableName: string, variableValue: any): Observable<MessageResponse> {
    return new Observable<MessageResponse>((subscriber: Subscriber<any>) => {
      this.taskService.setVariable(processId, variableName, variableValue).subscribe((response: MessageResponse) => {
        this.ngrxStore.dispatch({
          type: SET_VARIABLE_RESPONSE,
          payload: response,
        });
        subscriber.next(response);
        subscriber.complete();
      });
      return function unsubscribe() {};
    });
  }

  getTasksKeepSelected(userId: string): Observable<TaskPayload[]> {
    return new Observable<TaskPayload[]>((subscriber: Subscriber<any>) => {
      this.userService.getTasks(userId).subscribe((tasks: TaskPayload[]) => {
        tasks.map((task) => {
          task.taskDto.created = new Date(task.taskDto.created);
        });
        tasks.sort((t1, t2) => {
          if(t1.taskDto.created > t2.taskDto.created) return -1;
          else return 1;
        });
        this.ngrxStore.dispatch({
          type: GET_TASKS_KEEP_SELECTED_RESPONSE,
          payload: tasks,
        });
        subscriber.next(tasks);
        subscriber.complete();
      });
      return function unsubscribe() {};
    });
  }

  completeTask(taskId: string): Observable<MessageResponse> {
    return new Observable<MessageResponse>((subscriber: Subscriber<any>) => {
      this.taskService
        .completeTask(taskId)
        .subscribe((message: MessageResponse) => {
          this.ngrxStore.dispatch({
            type: COMPLETE_TASK_RESPONSE,
            payload: message,
          });
          subscriber.next(message);
          subscriber.complete();
        });
      return function unsubscribe() {};
    });
  }

  startNewProcess(): Observable<MessageResponse> {
    return new Observable<MessageResponse>((subscriber: Subscriber<any>) => {
      this.taskService
        .startCleanProcess()
        .subscribe((message: MessageResponse) => {
          this.ngrxStore.dispatch({
            type: START_NEW_PROCESS_RESPONSE,
            payload: message,
          });
          subscriber.next(message);
          subscriber.complete();
        });
      return function unsubscribe() {};
    });
  }

  setSelectedTask(taskId?: string): Observable<TaskPayload> {
    return new Observable<TaskPayload>((subscriber: Subscriber<any>) => {
      this.ngrxStore.dispatch({
        type: SET_SELECTED_TASK_RESPONSE,
        payload: taskId,
      });
      subscriber.next(taskId);
      subscriber.complete();
      return function unsubscribe() {};
    });
  }

  getTasks(id: string): Observable<TaskPayload[]> {
    return new Observable<TaskPayload[]>((subscriber: Subscriber<any>) => {
      this.userService.getTasks(id).subscribe((tasks: TaskPayload[]) => {
        tasks.map((task) => {
          task.taskDto.created = new Date(task.taskDto.created);
        });
        tasks.sort((t1, t2) => {
          if(t1.taskDto.created > t2.taskDto.created) return -1;
          else return 1;
        });
        this.ngrxStore.dispatch({
          type: GET_TASKS_RESPONSE,
          payload: tasks,
        });
        subscriber.next(tasks);
        subscriber.complete();
      });
      return function unsubscribe() {};
    });
  }
}
