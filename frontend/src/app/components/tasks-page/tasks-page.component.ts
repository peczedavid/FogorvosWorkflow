import {
  Component,
  Inject,
  OnChanges,
  OnDestroy,
  OnInit,
  SimpleChanges,
} from '@angular/core';

import { HttpErrorResponse } from '@angular/common/http';
import { MatSelectionListChange } from '@angular/material/list';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Store } from '@ngrx/store';
import { MessageResponse } from 'src/app/model/MessageResponse';
import {
  TaskActionFactory,
  taskActionFactoryToken,
} from 'src/app/state/task/task.action.factory';
import {
  selectTasksState,
  TasksState,
} from 'src/app/state/task/task.state.model';
import { TaskPayload } from '../../model/generic/task';
import { selectUserState, UserState } from 'src/app/state/user/user.state.model';
import { UserData } from 'src/app/model/UserData';

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
        <app-task-detail></app-task-detail>
      </div>
    </div>
  `,
  styleUrls: ['./tasks-page.component.css'],
})
export class TasksPageComponent implements OnInit, OnDestroy {
  private tasksSubscription: any;
  private userSubscription: any;

  protected currentUser?: UserData
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
      this.userSubscription = this.ngrxStore
      .select(selectUserState)
      .subscribe((userState: UserState) => {
        this.currentUser = userState.currentUser;
      });
  }

  ngOnInit(): void {
    // Ha taszkot megnyitva lépünk el másik oldalra és visszakattintunk, akkor egy pillanatra
    // felvillanna a details ablak
    this.taskActionFactory.setSelectedTask(undefined).subscribe();

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

  onSelectionChanged(event: MatSelectionListChange): void {
    const selected: TaskPayload = event.options[0].value;
    this.taskActionFactory.setSelectedTask(selected.taskDto.id).subscribe();
  }

  getTasksKeepSelected() {
    if(this.currentUser === undefined) return;
    this.taskActionFactory.getTasksKeepSelected(this.currentUser.id).subscribe({
      error: (error: HttpErrorResponse) => {
        console.log(error);
        this.snackBar.open('Nem vagy bejelentkezve', 'Bezár', {
          duration: 2000,
          panelClass: ['danger-snackbar'],
        });
      },
    });
  }

  getTasks() {
    if(this.currentUser === undefined) return;
    this.taskActionFactory.getTasks(this.currentUser.id).subscribe({
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
