import { Injectable } from '@angular/core';
import { Store } from '@ngrx/store';
import { Observable, Subscriber } from 'rxjs';
import { TaskPayload } from 'src/app/model/generic/task';
import { MessageResponse } from 'src/app/model/MessageResponse';
import { TaskService } from 'src/app/services/task.service';
import { UserService } from 'src/app/services/user.service';
import {
  GET_TASKS_RESPONSE,
  SET_SELECTED_TASK_RESPONSE,
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
