import { HttpErrorResponse } from '@angular/common/http';
import { Component, Inject, OnDestroy } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Store } from '@ngrx/store';
import { SNACK_BAR_MSG } from 'src/app/constants/message.constants';
import { TaskPayload, TaskTipus } from 'src/app/model/generic/task';
import { ROLE_ADMIN, ROLE_RECEPTIONIST } from 'src/app/model/role';
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
  selectUserState,
  UserState,
} from 'src/app/state/user/user.state.model';

@Component({
  selector: 'app-task-detail',
  template: `
    <div *ngIf="task !== undefined">
      <h4 style="display: inline;">{{ task.taskDto.name }}</h4>
      <button
        style="margin-left: 4rem; width: fit-content; float: right;"
        mat-raised-button
        color="danger"
        (click)="onClosePanel()"
      >
        <mat-icon fontIcon="close"></mat-icon>
      </button>
      <br />
      {{ formatDate() }}
      <p>
        {{ task.taskDto.id }}
      </p>
      <div
        style="margin-top: 1rem; margin-bottom: 1rem"
        [ngSwitch]="task!.taskTipus"
      >
        <app-megjelenes-idoponton
          *ngSwitchCase="TaskTipus.TASK_MEGJELENES_IDOPONTON"
        ></app-megjelenes-idoponton>
        <app-beteg-ertesitese
          *ngSwitchCase="TaskTipus.TASK_BETEG_ERTESITESE"
        ></app-beteg-ertesitese>
        <app-vizsgalat *ngSwitchCase="TaskTipus.TASK_VIZSGALAT"></app-vizsgalat>
        <app-rontgen *ngSwitchCase="TaskTipus.TASK_RONTGEN"></app-rontgen>
        <app-felulvizsgalat
          *ngSwitchCase="TaskTipus.TASK_FELULVIZSGALAT"
        ></app-felulvizsgalat>
        <app-szakorvosi-vizsgalat
          *ngSwitchCase="TaskTipus.TASK_SZAKORVOSI_VIZSGALAT"
        ></app-szakorvosi-vizsgalat>
        <app-fogszabalyzo-felrakasa
          *ngSwitchCase="TaskTipus.TASK_FOGSZABALYZO_FELRAKASA"
        ></app-fogszabalyzo-felrakasa>
        <div *ngSwitchDefault>Ismeretlen task</div>
      </div>
      <button
        mat-raised-button
        color="accent"
        (click)="onCompleteTask()"
        style="margin-right: 1rem;"
      >
        Befejez
      </button>
      <button
        mat-raised-button
        color="warn"
        (click)="onDeleteProcessInstance()"
        *ngIf="checkDeleteRole()"
      >
        Megszakít
      </button>
    </div>
  `,
  styleUrls: ['./task-detail.component.css'],
})
export class TaskDetailComponent implements OnDestroy {
  TaskTipus = TaskTipus;

  private tasksSubscription: any;
  private userSubscription: any;

  protected task?: TaskPayload;
  protected currentUser?: UserData;

  constructor(
    private snackBar: MatSnackBar,
    private ngrxStore: Store,
    @Inject(taskActionFactoryToken)
    private taskActionFactory: TaskActionFactory
  ) {
    this.tasksSubscription = this.ngrxStore
      .select(selectTasksState)
      .subscribe((tasksState: TasksState) => {
        this.task = tasksState.selectedTask;
      });
    this.userSubscription = this.ngrxStore
      .select(selectUserState)
      .subscribe((userState: UserState) => {
        this.currentUser = userState.currentUser;
      });
  }

  onDeleteProcessInstance(): void {
    if (this.task === undefined) return;
    this.taskActionFactory
      .deleteProcessInstance(this.task.taskDto.processInstanceId)
      .subscribe({
        next: () => {
          this.taskActionFactory.getTasks(this.currentUser!.id).subscribe();
          this.snackBar.open(
            SNACK_BAR_MSG.PROCESS_INSTANCE_DELETED_SUCCESS,
            SNACK_BAR_MSG.ACTION_TEXT,
            {
              duration: 2000,
              panelClass: ['success-snackbar'],
            }
          );
        },
        error: (error: HttpErrorResponse) => {
          console.log(error);
          this.snackBar.open(
            SNACK_BAR_MSG.PROCESS_INSTANCE_DELETED_FAILED,
            SNACK_BAR_MSG.ACTION_TEXT,
            {
              duration: 2000,
              panelClass: ['danger-snackbar'],
            }
          );
        },
      });
  }

  onCompleteTask(): void {
    if (this.task == undefined) return;
    this.taskActionFactory.completeTask(this.task.taskDto.id).subscribe({
      next: () => {
        this.taskActionFactory.getTasks(this.currentUser!.id).subscribe();
        this.snackBar.open(
          SNACK_BAR_MSG.TASK_FINISHED_SUCCESS,
          SNACK_BAR_MSG.ACTION_TEXT,
          {
            duration: 2000,
            panelClass: ['success-snackbar'],
          }
        );
      },
      error: (error: HttpErrorResponse) => {
        console.log(error);
        this.snackBar.open(
          SNACK_BAR_MSG.TASK_FINISHED_FAILED,
          SNACK_BAR_MSG.ACTION_TEXT,
          {
            duration: 2000,
            panelClass: ['danger-snackbar'],
          }
        );
      },
    });
  }

  checkDeleteRole(): boolean {
    return (
      this.currentUser?.role == ROLE_ADMIN ||
      this.currentUser?.role == ROLE_RECEPTIONIST
    );
  }

  onClosePanel(): void {
    this.taskActionFactory.setSelectedTask(undefined).subscribe();
  }

  formatDate(): string {
    if (this.task !== undefined && this.task.taskDto.created instanceof Date) {
      const year = this.task.taskDto.created.getFullYear();
      const month = this.task.taskDto.created.getMonth() + 1;
      const day = this.task.taskDto.created.getDate();

      const hours = this.task.taskDto.created.getHours();
      const minutes = this.task.taskDto.created.getMinutes();
      const seconds = this.task.taskDto.created.getSeconds();

      return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
    } else {
      return '';
    }
  }

  ngOnDestroy(): void {
    this.tasksSubscription.unsubscribe();
    this.userSubscription.unsubscribe();
  }
}
