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
import { MessageResponse } from 'src/app/model/MessageResponse';

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
          (selectionChange)="onSelectionChanged($event)"
          #tasklist
          [multiple]="false"
        >
          <mat-list-option
            style="margin-bottom: 0.5rem;"
            *ngFor="let task of tasks"
            [value]="task"
            [selected]="selectedTask?.taskDto?.id == task.taskDto.id"
          >
            <app-task-list-item [taskDto]="task.taskDto"></app-task-list-item>
          </mat-list-option>
        </mat-selection-list>
      </div>
      <div fxFlex="65%" style="padding-top: 3rem; padding-left: 1rem">
        <app-task-detail
          [task]="selectedTask"
          (completeTask)="onTaskComplete()"
          (variableChanged)="onVariableChanged($event)"
        ></app-task-detail>
      </div>
    </div>
  `,
  styleUrls: ['./tasks-page.component.css'],
})
export class TasksPageComponent implements OnInit, OnDestroy {
  private tasksSubscription: any;
  protected tasks: TaskPayload[];
  protected selectedTask?: TaskPayload;

  constructor(
    private snackBar: MatSnackBar,
    private ngrxStore: Store,
    @Inject(taskActionFactoryToken)
    private taskActionFactory: TaskActionFactory
  ) {
    this.tasksSubscription = this.ngrxStore
      .select(selectTasksState)
      .subscribe((tasksState: TasksState) => {
        this.tasks = tasksState.tasks;
        this.selectedTask = tasksState.selectedTask;
      });
  }

  ngOnInit() {
    this.getTasks();
  }

  ngOnDestroy(): void {
    this.tasksSubscription.unsubscribe();
  }

  newTask(): void {
    this.taskActionFactory
      .startNewProcess()
      .subscribe((message: MessageResponse) => {
        this.getTasksKeepSelected();
      });
  }

  onRefreshTasks() {
    this.getTasks();
  }

  onTaskComplete() {
    this.getTasks();
  }

  onVariableChanged(event: Event): void {
    this.getTasksKeepSelected();
  }

  onSelectionChanged(event: MatSelectionListChange): void {
    const selected: TaskPayload = event.options[0].value;
    this.taskActionFactory.setSelectedTask(selected.taskDto.id).subscribe();
  }

  getTasksKeepSelected() {
    if (this.selectedTask === undefined) {
      this.getTasks();
    } else {
      const selectedId = this.selectedTask.taskDto.id;
      this.taskActionFactory.getTasks('fogorvosdemo').subscribe({
        next: (_) => {
          this.tasks.map((task) => {
            if (task.taskDto.id === selectedId)
              this.taskActionFactory.setSelectedTask(selectedId).subscribe();
          });
        },
        error: (error: HttpErrorResponse) => {
          console.log(error);
          this.snackBar.open('Nem vagy bejelentkezve', 'Bezár', {
            duration: 2000,
            panelClass: ['danger-snackbar'],
          });
        },
      });
    }
  }

  getTasks() {
    this.taskActionFactory.getTasks('fogorvosdemo').subscribe({
      error: (error: HttpErrorResponse) => {
        console.log(error);
        this.snackBar.open('Nem vagy bejelentkezve', 'Bezár', {
          duration: 2000,
          panelClass: ['danger-snackbar'],
        });
      },
    });
  }

}
