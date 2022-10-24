import { Component, OnInit } from '@angular/core';

import { TaskPayload } from '../../model/generic/task';
import { MatSelectionListChange } from '@angular/material/list';
import { TaskService } from 'src/app/services/task.service';

@Component({
  selector: 'app-tasks-page',
  templateUrl: './tasks-page.component.html',
  styleUrls: ['./tasks-page.component.css'],
})
export class TasksPageComponent implements OnInit {
  constructor(private _taskService: TaskService) {}

  tasks: TaskPayload[] = [];
  selectedTask: TaskPayload;

  onSelectionChanged(event: MatSelectionListChange) {
    this.selectedTask = event.options[0].value;
  }

  onRefreshTasks() {
    this._taskService
      .getTasks('fogorvosdemo')
      .subscribe((data: TaskPayload[]) => (this.tasks = data));
  }
  ngOnInit() {
    this._taskService
      .getTasks('fogorvosdemo')
      .subscribe((data: TaskPayload[]) => (this.tasks = data));
  }
}
