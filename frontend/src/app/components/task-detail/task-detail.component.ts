import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TaskPayload, TaskTipus } from 'src/app/model/generic/task';
import { TaskService } from 'src/app/services/task.service';

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
          [taskPayload]="task!"
          *ngSwitchCase="TaskTipus.TASK_BETEG_ERTESITESE"
          (variableChanged)="onVariableChanged($event)"
        ></app-beteg-ertesitese>
        <app-vizsgalat
          [taskPayload]="task!"
          (variableChanged)="onVariableChanged($event)"
          *ngSwitchCase="TaskTipus.TASK_VIZSGALAT"
        ></app-vizsgalat>
        <app-rontgen *ngSwitchCase="TaskTipus.TASK_RONTGEN"></app-rontgen>
        <app-felulvizsgalat
          [taskPayload]="task!"
          (variableChanged)="onVariableChanged($event)"
          *ngSwitchCase="TaskTipus.TASK_FELULVIZSGALAT"
        ></app-felulvizsgalat>
        <app-szakorvosi-vizsgalat
          [taskPayload]="task!"
          (variableChanged)="onVariableChanged($event)"
          *ngSwitchCase="TaskTipus.TASK_SZAKORVOSI_VIZSGALAT"
        ></app-szakorvosi-vizsgalat>
        <app-fogszabalyzo-felrakasa
          *ngSwitchCase="TaskTipus.TASK_FOGSZABALYZO_FELRAKASA"
        ></app-fogszabalyzo-felrakasa>
        <div *ngSwitchDefault>Ismeretlen task</div>
      </div>
      <button mat-raised-button color="accent" (click)="onCompleteTask()">
        Befejez
      </button>
    </div>
  `,
  styleUrls: ['./task-detail.component.css'],
})
export class TaskDetailComponent {
  @Input() task: TaskPayload | undefined;
  @Output() completeTask = new EventEmitter();
  @Output() closePanel = new EventEmitter();
  @Output() variableChanged = new EventEmitter();

  TaskTipus = TaskTipus;

  constructor(
    private taskService: TaskService,
    private snackBar: MatSnackBar
  ) {}

  onVariableChanged(event: Event) {
    this.variableChanged.emit(event);
  }

  onClosePanel(): void {
    this.closePanel.emit();
  }

  onCompleteTask(): void {
    if (this.task?.taskDto.id !== undefined)
      this.taskService.completeTask(this.task?.taskDto.id).subscribe(
        (_) => {
          this.completeTask.emit();
          this.snackBar.open('Feladat befejezve', 'Bezár', {
            duration: 2000,
            panelClass: ['success-snackbar'],
          });
        },
        (error: HttpErrorResponse) => {
          console.log(error);
          this.snackBar.open('A feladatot nem sikerült befejezni', 'Bezár', {
            duration: 2000,
            panelClass: ['danger-snackbar'],
          });
        }
      );
  }

  formatDate(): string {
    return '';
    // if (this.task !== undefined) {
    //   const year = this.task.taskDto.created.getFullYear();
    //   const month = this.task.taskDto.created.getMonth() + 1;
    //   const day = this.task.taskDto.created.getDate();

    //   const hours = this.task.taskDto.created.getHours();
    //   const minutes = this.task.taskDto.created.getMinutes();
    //   const seconds = this.task.taskDto.created.getSeconds();

    //   return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
    // } else {
    //   return '';
    // }
  }
}
