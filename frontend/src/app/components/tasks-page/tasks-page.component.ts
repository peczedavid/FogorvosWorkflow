import { Component, OnInit } from '@angular/core';

import { TaskPayload, TaskTipus } from '../../model/generic/task';
import { MatSelectionListChange } from '@angular/material/list';
import { TaskService } from 'src/app/services/task.service';
import { HttpResponse } from '@angular/common/http';

@Component({
  selector: 'app-tasks-page',
  template: `
    <div
      fxLayout.sm="column"
      fxLayout.gt-sm="row"
      style="padding-left: 3rem; padding-right: 3rem"
    >
      <div fxFlex="35%" style="padding-top: 0.5rem">
        <button style="margin-right: 1rem;" (click)="newTask()" mat-raised-button>Új folyamat</button>
        <button
          mat-raised-button
          (click)="onRefreshTasks()"
        >
          <mat-icon fontIcon="refresh"></mat-icon>
        </button>
        <mat-selection-list
          id="task-list"
          (selectionChange)="onSelectionChanged($event)"
          #tasklist
          [multiple]="false"
        >
          <mat-list-option *ngFor="let task of tasks" [value]="task">
            {{ task.taskDto.name }}
          </mat-list-option>
        </mat-selection-list>
      </div>
      <div fxFlex="65%" style="padding-top: 3rem; padding-left: 1rem">
        <app-task-detail
          [task]="selectedTask"
          (completeTask)="onTaskComplete()"
          (closePanel)="onTaskPanelClosed()"
        ></app-task-detail>
      </div>
    </div>
  `,
  styleUrls: ['./tasks-page.component.css'],
})
export class TasksPageComponent implements OnInit {
  constructor(private taskService: TaskService) {}

  tasks: TaskPayload[] = [];
  selectedTask: TaskPayload | undefined;

  newTask() {
    this.taskService
      .startCleanProcess()
      .subscribe((response: HttpResponse<any>) => this.getTasks());
  }

  onSelectionChanged(event: MatSelectionListChange) {
    this.selectedTask = undefined;
    setTimeout(() => {
      this.selectedTask = event.options[0].value;
    }, 0);
  }

  getTasks() {
    this.taskService.getTasks('fogorvosdemo').subscribe((tasks) => {
      this.tasks = tasks;
    });
    this.selectedTask = undefined;
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
