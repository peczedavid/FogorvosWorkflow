import { HttpClient } from '@angular/common/http';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { TaskPayload, TaskTipus } from 'src/app/model/generic/task';

@Component({
  selector: 'app-task-detail',
  template: `
    <div *ngIf="task !== undefined">
      <h4 style="display: inline">{{ task.taskDto.name }}</h4>
      <p style="display: inline">({{ task.taskDto.id }})</p>
      <button
        style="margin-left: 4rem; width: fit-content"
        mat-raised-button
        color="danger"
        (click)="onClosePanel()"
      >
        <mat-icon fontIcon="close"></mat-icon>
      </button>
      <ng-container *ngTemplateOutlet="vars_templ" #vars_cont></ng-container>
      <button mat-raised-button color="accent" (click)="onCompleteTask()">
        Befejez
      </button>
    </div>

    <ng-template #vars_templ>
      <div
        style="margin-top: 1rem; margin-bottom: 1rem"
        [ngSwitch]="this.task!.taskTipus"
      >
        <app-megjelenes-idoponton
          *ngSwitchCase="TaskTipus.TASK_MEGJELENES_IDOPONTON"
        ></app-megjelenes-idoponton>
        <app-beteg-ertesitese
          [taskPayload]="task!"
          *ngSwitchCase="TaskTipus.TASK_BETEG_ERTESITESE"
        ></app-beteg-ertesitese>
        <app-vizsgalat
          [taskPayload]="task!"
          *ngSwitchCase="TaskTipus.TASK_VIZSGALAT"
        ></app-vizsgalat>
        <app-rontgen *ngSwitchCase="TaskTipus.TASK_RONTGEN"></app-rontgen>
        <app-felulvizsgalat
          [taskPayload]="task!"
          *ngSwitchCase="TaskTipus.TASK_FELULVIZSGALAT"
        ></app-felulvizsgalat>
        <app-szakorvosi-vizsgalat
          [taskPayload]="task!"
          *ngSwitchCase="TaskTipus.TASK_SZAKORVOSI_VIZSGALAT"
        ></app-szakorvosi-vizsgalat>
        <app-fogszabalyzo-felrakasa
          *ngSwitchCase="TaskTipus.TASK_FOGSZABALYZO_FELRAKASA"
        ></app-fogszabalyzo-felrakasa>
        <div *ngSwitchDefault>Ismeretlen task</div>
      </div>
    </ng-template>
  `,
  styleUrls: ['./task-detail.component.css'],
})
export class TaskDetailComponent implements OnInit {
  @Input() task: TaskPayload | undefined;
  @Output() completeTask = new EventEmitter();
  @Output() closePanel = new EventEmitter();

  TaskTipus = TaskTipus;

  constructor(private http: HttpClient) {}

  onClosePanel(): void {
    this.closePanel.emit();
  }

  ngOnChanges() {
    console.log(this.task);
  }

  onCompleteTask(): void {
    this.http
      .post<any>(
        `http://localhost:8080/task/${this.task!.taskDto.id}/complete`,
        null
      )
      .subscribe((_) => this.completeTask.emit());
  }

  ngOnInit(): void {}
}
