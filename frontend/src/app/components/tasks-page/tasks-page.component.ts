import { Component, Inject, OnDestroy, OnInit, ViewChild } from '@angular/core';

import { MatSelectionListChange } from '@angular/material/list';
import { MatPaginator } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatTableDataSource } from '@angular/material/table';
import { Router } from '@angular/router';
import { Store } from '@ngrx/store';
import { SNACK_BAR_MSG } from 'src/app/constants/message.constants';
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

enum ViewMode {
  LIST,
  TABLE,
}
@Component({
  selector: 'app-tasks-page',
  template: `
    <div
      fxLayout="column"
      fxFlex="100%"
      fxLayoutAlign=" center"
      style="padding-left: 3rem; padding-right: 3rem;"
    >
      <div fxFlexAlign="start" style="padding-top: 1rem; padding-bottom: 1rem;">
        <button
          mat-raised-button
          style="margin-right: 1rem;"
          (click)="onRefreshTasks()"
        >
          Frissítés<mat-icon
            style="padding-left: 0.35rem"
            fontIcon="refresh"
          ></mat-icon>
        </button>
        <button mat-raised-button (click)="changeViewMode()">
          Nézet váltás
        </button>
      </div>
      <div fxLayout="row" fxFlexAlign="start">
        <div>
          <mat-selection-list
            *ngIf="viewMode == ViewMode.LIST"
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
          <table
            *ngIf="viewMode == ViewMode.TABLE"
            style="width: 100%;"
            mat-table
            [dataSource]="dataSource"
          >
            <ng-container matColumnDef="name">
              <th mat-header-cell *matHeaderCellDef mat-sort-header>Név</th>
              <td mat-cell *matCellDef="let element">
                {{ element.taskDto.name }}
              </td>
            </ng-container>

            <ng-container matColumnDef="date">
              <th mat-header-cell *matHeaderCellDef mat-sort-header>Dátum</th>
              <td mat-cell *matCellDef="let element">
                {{ element.taskDto.created.getDate() }}
              </td>
            </ng-container>

            <tr mat-header-row *matHeaderRowDef="displayedColumns"></tr>
            <tr mat-row *matRowDef="let row; columns: displayedColumns"></tr>
          </table>
        </div>
        <div style="padding-top: 1rem; padding-left: 1rem;">
          <app-task-detail></app-task-detail>
        </div>
      </div>
    </div>
    <!-- <div
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
          *ngIf="viewMode == ViewMode.LIST"
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
        <div *ngIf="viewMode == ViewMode.TABLE"></div>
      </div>
      <div fxFlex="65%" style="padding-top: 3rem; padding-left: 1rem">
        <app-task-detail></app-task-detail>
      </div>
    </div> -->
  `,
  styleUrls: ['./tasks-page.component.css'],
})
export class TasksPageComponent implements OnInit, OnDestroy {
  ViewMode = ViewMode;

  private tasksSubscription: any;
  private userSubscription: any;

  protected currentUser?: UserData;
  protected tasks: TaskPayload[];
  protected selectedTask?: TaskPayload;

  protected viewMode: ViewMode;

  protected displayedColumns: string[] = ['name', 'date'];
  protected dataSource = new MatTableDataSource<TaskPayload>();

  constructor(
    private snackBar: MatSnackBar,
    private router: Router,
    private ngrxStore: Store,
    @Inject(taskActionFactoryToken)
    private taskActionFactory: TaskActionFactory,
    @Inject(userActionFactoryToken)
    private userActionFactory: UserActionFactory
  ) {
    this.viewMode = ViewMode.LIST;

    this.tasksSubscription = this.ngrxStore
      .select(selectTasksState)
      .subscribe((tasksState: TasksState) => {
        this.tasks = tasksState.tasks;
        this.selectedTask = tasksState.selectedTask;
        this.dataSource = new MatTableDataSource(this.tasks);
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

  changeViewMode() {
    this.viewMode =
      this.viewMode == ViewMode.LIST ? ViewMode.TABLE : ViewMode.LIST;

    this.taskActionFactory.setSelectedTask(undefined).subscribe();
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
