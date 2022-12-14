import { Component, Inject, OnDestroy, OnInit } from '@angular/core';

import { HttpErrorResponse } from '@angular/common/http';
import { MatSelectionListChange } from '@angular/material/list';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { Store } from '@ngrx/store';
import { MessageResponse } from 'src/app/model/MessageResponse';
import { UserData } from 'src/app/model/UserData';
import {
  TaskActionFactory,
  taskActionFactoryToken,
} from 'src/app/state/task/task.action.factory';
import {
  selectTasksState,
  TasksState,
} from 'src/app/state/task/task.state.model';
import {
  UserActionFactory,
  userActionFactoryToken,
} from 'src/app/state/user/user.action.factory';
import {
  selectUserState,
  UserState,
} from 'src/app/state/user/user.state.model';
import { TaskPayload } from '../../model/generic/task';
import { SNACK_BAR_MSG } from 'src/app/constants/message.constants';

@Component({
  selector: 'app-tasks-page',
  template: `
    <div
      fxLayout.sm="column"
      fxLayout.gt-sm="row"
      style="padding-left: 5rem; padding-right: 5rem; margin-top: 1.5rem;"
    >
      <div fxFlex="35%" style="margin-top: 0.5rem">
        <button
          style="margin-bottom: 1rem;"
          (click)="onRefreshTasks()"
          color="basic"
          mat-raised-button
        >
          Frissítés
          <mat-icon style="padding-left: 0.35rem" fontIcon="refresh"></mat-icon>
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

  protected currentUser?: UserData;
  protected tasks: TaskPayload[];
  protected selectedTask?: TaskPayload;

  constructor(
    private snackBar: MatSnackBar,
    private router: Router,
    private ngrxStore: Store,
    @Inject(taskActionFactoryToken)
    private taskActionFactory: TaskActionFactory,
    @Inject(userActionFactoryToken)
    private userActionFactory: UserActionFactory
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

  initData(): void {
    // Ha taszkot megnyitva lépünk el másik oldalra és visszakattintunk, akkor egy pillanatra
    // felvillanna a details ablak
    this.taskActionFactory.setSelectedTask(undefined).subscribe();
    this.taskActionFactory.getTasks(this.currentUser!.id).subscribe();
  }

  handleAuthNext(userData: UserData): void {
    if (userData === null) {
      this.snackBar.open(
        SNACK_BAR_MSG.NOT_LOGGED_IN,
        SNACK_BAR_MSG.ACTION_TEXT,
        {
          duration: 2000,
          panelClass: ['danger-snackbar'],
        }
      );
      this.router.navigateByUrl('/login', { skipLocationChange: true });
    } else {
      this.initData();
    }
  }

  handleAuthError(error: any): void {
    console.log(error);
  }

  ngOnInit(): void {
    if (this.currentUser === undefined) {
      this.userActionFactory.check().subscribe({
        next: (userData: UserData) => this.handleAuthNext(userData),
        error: (error: any) => this.handleAuthError(error),
      });
    } else {
      this.initData();
    }
  }

  ngOnDestroy(): void {
    this.tasksSubscription.unsubscribe();
    this.userSubscription.unsubscribe();
  }

  onRefreshTasks() {
    this.taskActionFactory.getTasks(this.currentUser!.id).subscribe();
  }

  onSelectionChanged(event: MatSelectionListChange): void {
    const selected: TaskPayload = event.options[0].value;
    this.taskActionFactory.setSelectedTask(selected.taskDto.id).subscribe();
  }
}
