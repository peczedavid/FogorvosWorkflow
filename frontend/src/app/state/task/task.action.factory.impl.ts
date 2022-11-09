import { Injectable } from '@angular/core';
import { Store } from '@ngrx/store';
import { Observable, Subscriber } from 'rxjs';
import { TaskPayload } from 'src/app/model/generic/task';
import { UserService } from 'src/app/services/user.service';
import { GET_TASKS_RESPONSE, TaskActionFactory } from './task.action.factory';

@Injectable()
export class TaskActionFactoryImpl implements TaskActionFactory {
  constructor(
    private userService: UserService,
    private ngrxStore: Store<any>
  ) {}

  getTasks(id: string): Observable<TaskPayload[]> {
    return new Observable<TaskPayload[]>((subscriber: Subscriber<any>) => {
      this.userService.getTasks(id).subscribe((tasks: TaskPayload[]) => {
        const modifiedTasks = tasks.map((task) => { task.taskDto.created = new Date(task.taskDto.created) });
        this.ngrxStore.dispatch({
          type: GET_TASKS_RESPONSE,
          payload: modifiedTasks,
        });
        subscriber.next(tasks);
        subscriber.complete();
      });
      // TODO: törölni? xd
      return function unsubscribe() {};
    });
  }
}
