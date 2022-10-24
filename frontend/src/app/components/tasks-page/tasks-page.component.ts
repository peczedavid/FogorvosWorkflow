import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';

import { TaskPayload } from '../../model/generic/task';
import { MatSelectionListChange } from '@angular/material/list';

@Component({
  selector: 'app-tasks-page',
  templateUrl: './tasks-page.component.html',
  styleUrls: ['./tasks-page.component.css'],
})
export class TasksPageComponent implements OnInit {
  constructor(private http: HttpClient) {}

  tasks: TaskPayload[] = [];
  selectedTask: TaskPayload;

  onSelectionChanged(event: MatSelectionListChange) {
    this.selectedTask = this.tasks.find(
      (task) => task.taskDto.id == event.options[0].value
    )!;
  }

  ngOnInit(): void {
    this.http
      .get<TaskPayload[]>('http://localhost:8080/user/fogorvosdemo/task')
      .subscribe((data) => {
        this.tasks = data;
      });
  }
}
