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
          (variableChanged)="onVariableChanged($event)"
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

  taskCompare(object1: any, object2: any): boolean {
    return object1 && object2 && object1.taskDto.id === object2.taskDto.id;
  }

  onSelectionChanged(event: MatSelectionListChange) {
    this.selectedTask = event.options[0].value;
  }

  onVariableChanged(event: Event) {
    const selectedId = this.selectedTask?.taskDto.id;
    this.taskService.getTasks('fogorvosdemo').subscribe((tasks) => {
      this.tasks = tasks;
      this.tasks.map((task) => {
        if (task.taskDto.id === selectedId) this.selectedTask = task;
      });
    });
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
