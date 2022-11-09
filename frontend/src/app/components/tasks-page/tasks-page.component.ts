import { Component, Inject, OnDestroy, OnInit } from '@angular/core';
import { Observable } from 'rxjs';

import { TaskPayload } from '../../model/generic/task';
import { MatSelectionListChange } from '@angular/material/list';
import { TaskService } from 'src/app/services/task.service';
import { HttpErrorResponse, HttpResponse } from '@angular/common/http';
import { Store } from '@ngrx/store';
import { UserService } from 'src/app/services/user.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import {
  TaskActionFactory,
  taskActionFactoryToken,
} from 'src/app/state/task/task.action.factory';
import {
  selectTasksState,
  TasksState,
} from 'src/app/state/task/task.state.model';

@Component({
  selector: 'app-tasks-page',
  template: `
    <div
      fxLayout.sm="column"
      fxLayout.gt-sm="row"
      style="padding-left: 3rem; padding-right: 3rem"
    >
      <div fxFlex="35%" style="padding-top: 0.5rem">
        <button
          style="margin-right: 1rem;"
          (click)="newTask()"
          mat-raised-button
        >
          Új folyamat
        </button>
        <button mat-raised-button (click)="onRefreshTasks()">
          <mat-icon fontIcon="refresh"></mat-icon>
        </button>
        <mat-selection-list
          id="task-list"
          [compareWith]="taskCompare"
          (selectionChange)="onSelectionChanged($event)"
          #tasklist
          [multiple]="false"
        >
          <mat-list-option
            style="margin-bottom: 0.5rem;"
            *ngFor="let task of tasks"
            [value]="task"
          >
            <app-task-list-item [taskDto]="task.taskDto"></app-task-list-item>
          </mat-list-option>
        </mat-selection-list>
      </div>
      <div fxFlex="65%" style="padding-top: 3rem; padding-left: 1rem">
        <app-task-detail
          [task]="selectedTask"
          (completeTask)="onTaskComplete()"
          (closePanel)="onTaskPanelClosed()"
          (variableChanged)="onVariableChanged($event)"
        ></app-task-detail>
      </div>
    </div>
  `,
  styleUrls: ['./tasks-page.component.css'],
})
export class TasksPageComponent implements OnInit, OnDestroy {
  tasks$: Observable<TaskState>;

  private tasksSubscription: any;

  constructor(
    private taskService: TaskService,
    private snackBar: MatSnackBar,
    private ngrxStore: Store,
    @Inject(taskActionFactoryToken)
    private taskActionFactory: TaskActionFactory
  ) {
    this.tasksSubscription = this.ngrxStore
      .select(selectTasksState)
      .subscribe((tasksState: TasksState) => {
        this.tasks = this.convertToDate(tasksState.tasks);
      });
  }
  ngOnDestroy(): void {
    this.tasksSubscription.unsubscribe();
  }

  tasks: TaskPayload[] = [];
  selectedTask: TaskPayload | undefined;

  newTask() {
    this.taskService
      .startCleanProcess()
      .subscribe((response: HttpResponse<any>) => this.getTasks());
  }

  taskCompare(object1: any, object2: any): boolean {
    return object1 && object2 && object1.taskDto.id === object2.taskDto.id;
  }

  onSelectionChanged(event: MatSelectionListChange) {
    this.selectedTask = event.options[0].value;
  }

  onVariableChanged(event: Event) {
    const selectedId = this.selectedTask?.taskDto.id;
    this.taskActionFactory.getTasks('fogorvosdemo').subscribe({
      next: (tasks) => {
        this.tasks = this.convertToDate(tasks);
        this.tasks.map((task) => {
        if (task.taskDto.id === selectedId) this.selectedTask = task;
      });
      },
    });
  }

  public clone(): any {
    var cloneObj = new (this.constructor() as any);
    for (var attribut in this) {
        if (typeof this[attribut] === "object") {
            cloneObj[attribut] = (this[attribut] as any).clone();
        } else {
            cloneObj[attribut] = this[attribut];
        }
    }
    return cloneObj;
}

  convertToDate(tasks: TaskPayload[]): TaskPayload[] {
    return tasks;
    return tasks.map((task) => {
      //let taskNew: TaskPayload = {};
      //Object.assign({}, ta)
      const taskNewDate: TaskPayload = {
        taskDto: {
          assignee: task.taskDto.assignee,
          created: new Date(task.taskDto.created),
          description: task.taskDto.description,
          id: task.taskDto.id,
          name: task.taskDto.name,
          processInstanceId: task.taskDto.processInstanceId
        },
        taskTipus: task.taskTipus
      };
      return taskNewDate;

      // Kell, különben string marad
      // let taskNewDate: TaskPayload = {
      //   taskDto: {
      //     created: new Date(task.taskDto.created)
      //   }
      // };
      //return Object.assign({}, task, {});
      //task.taskDto.created = new Date(task.taskDto.created);
      //return task;
    });
  }

  getTasks() {
    this.selectedTask = undefined;

    this.taskActionFactory.getTasks('fogorvosdemo').subscribe({
      next: (tasks) => {
        this.tasks = this.convertToDate(tasks);
      },
      error: (error: HttpErrorResponse) => {
        console.log(error);
        this.snackBar.open('Nem vagy bejelentkezve', 'Bezár', {
          duration: 2000,
          panelClass: ['danger-snackbar'],
        });
      },
    });

    // this.userService.getTasks('fogorvosdemo').subscribe((tasks) => {
    //   this.tasks = this.convertToDate(tasks);
    // }, (error: HttpErrorResponse) => {
    //   console.log(error);
    //   this.snackBar.open('Nem vagy bejelentkezve', 'Bezár', {
    //     duration: 2000,
    //     panelClass: ['danger-snackbar']
    //   });
    // });
  }

  onRefreshTasks() {
    this.getTasks();
  }

  onTaskPanelClosed() {
    this.getTasks();
  }

  onTaskComplete() {
    this.getTasks();
  }

  ngOnInit() {
    this.getTasks();
  }
}
