import { Component, OnInit } from '@angular/core';

import { TaskPayload, TaskTipus } from '../../model/generic/task';
import { MatSelectionListChange } from '@angular/material/list';
import { HttpClient } from '@angular/common/http';

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
          style="width: fit-content"
          mat-button
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
  constructor(private http: HttpClient) {}

  tasks: TaskPayload[] = [];
  selectedTask: TaskPayload | undefined;

  onSelectionChanged(event: MatSelectionListChange) {
    this.selectedTask = undefined;
    setTimeout(() =>{
      this.selectedTask = event.options[0].value;
    }, 1);
    
    //console.log(this.selectedTask);
  }

  getTasks() {
    this.http
      .get<TaskPayload[]>('http://localhost:8080/user/fogorvosdemo/task')
      .subscribe((data) => {
        this.tasks = data;
      });
  }

  onRefreshTasks() {
    this.getTasks();
  }

  onTaskPanelClosed() {
    this.getTasks(); // Frissül a tasks tömb -> nem lesz kijelölve egy sem
    this.selectedTask = undefined;
  }

  onTaskComplete() {
    this.getTasks();
    this.selectedTask = undefined;
  }

  ngOnInit() {
    this.getTasks();
    this.selectedTask = undefined;
  }
}
