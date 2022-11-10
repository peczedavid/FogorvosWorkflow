import { HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Store } from '@ngrx/store';
import { Observable, Subscriber } from 'rxjs';
import { TaskPayload } from 'src/app/model/generic/task';
import { MessageResponse } from 'src/app/model/MessageResponse';
import { TaskService } from 'src/app/services/task.service';
import { UserService } from 'src/app/services/user.service';
import {
  GET_TASKS_RESPONSE,
  NEW_PROCESS_RESPONSE,
  SET_SELECTED_TASK_RESPONSE,
  TaskActionFactory,
} from './task.action.factory';

@Injectable()
export class TaskActionFactoryImpl implements TaskActionFactory {
  constructor(
    private userService: UserService,
    private taskService: TaskService,
    private ngrxStore: Store<any>
  ) {}

  newProcess(): Observable<HttpResponse<MessageResponse>> {
    return new Observable<HttpResponse<MessageResponse>>((subscriber: Subscriber<any>) => {
      this.taskService.startCleanProcess().subscribe((response: HttpResponse<MessageResponse>) => {
          this.ngrxStore.dispatch({
            type: NEW_PROCESS_RESPONSE,
            payload: response
          });
        subscriber.next(response);
        subscriber.complete();
      });
      
      return function unsubscribe() {};
    });
  }

  setSelectedTask(task: TaskPayload): Observable<TaskPayload> {
    return new Observable<TaskPayload>((subscriber: Subscriber<any>) => {
      this.ngrxStore.dispatch({
        type: SET_SELECTED_TASK_RESPONSE,
        payload: task,
      });
      subscriber.next(task);
      subscriber.complete();

      return function unsubscribe() {};
    });
  }

  getTasks(id: string): Observable<TaskPayload[]> {
    return new Observable<TaskPayload[]>((subscriber: Subscriber<any>) => {
      this.userService.getTasks(id).subscribe((tasks: TaskPayload[]) => {
        // Create the date objects from date string
        tasks.map((task) => {
          task.taskDto.created = new Date(task.taskDto.created);
        });
        // Order by the date DESC
        tasks.sort((t1, t2) => {
          if (t1.taskDto.created > t2.taskDto.created) return -1;
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
