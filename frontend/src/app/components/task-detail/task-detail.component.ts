import { HttpClient } from '@angular/common/http';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { TaskPayload, TaskTipus } from 'src/app/model/generic/task';

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

  constructor(private http: HttpClient) {}

  onVariableChanged(event: Event) {
    //console.log(event)
    this.variableChanged.emit(event);
  }

  onClosePanel(): void {
    this.closePanel.emit();
  }

  // TODO: to service
  onCompleteTask(): void {
    this.http
      .post<any>(
        `http://localhost:8080/task/${this.task!.taskDto.id}/complete`,
        null
      )
      .subscribe((_) => this.completeTask.emit());
  }

  formatDate(): string {
    if (this.task !== undefined) {
      const year = this.task.taskDto.created.getFullYear();
      const month = this.task.taskDto.created.getMonth();
      const day = this.task.taskDto.created.getDay();

      const hours = this.task.taskDto.created.getHours();
      const minutes = this.task.taskDto.created.getMinutes();
      const seconds = this.task.taskDto.created.getSeconds();

      return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
    } else {
      return '';
    }
  }
}
