import { Component, OnInit } from '@angular/core';

import { TaskPayload, TaskTipus } from '../../model/generic/task';
import { MatSelectionListChange } from '@angular/material/list';
import { HttpClient } from '@angular/common/http';
import { delay } from 'rxjs';

@Component({
  selector: 'app-tasks-page',
  templateUrl: './tasks-page.component.html',
  styleUrls: ['./tasks-page.component.css'],
})
export class TasksPageComponent implements OnInit {
  constructor(private http: HttpClient) {}

  tasks: TaskPayload[] = [];
  selectedTask: TaskPayload | undefined;

  onSelectionChanged(event: MatSelectionListChange) {
    this.selectedTask = event.options[0].value;
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

  // Kisebb hackelés, újra lekérdezem a taskokat, hogy frissüljön a tasks tömb, ezért nem lesz kijelölve
  // egy task sem
  onTaskPanelClosed() {
    this.getTasks();
    this.selectedTask = undefined;
  }

  onTaskComplete() {
    this.getTasks();
    this.selectedTask = undefined;
  }

  ngOnInit() {
    this.getTasks();
  }
}
