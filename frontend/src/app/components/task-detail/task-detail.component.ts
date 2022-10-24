import { Component, Input, OnInit } from '@angular/core';
import { TaskPayload } from 'src/app/model/generic/task';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-task-detail',
  templateUrl: './task-detail.component.html',
  styleUrls: ['./task-detail.component.css'],
})
export class TaskDetailComponent implements OnInit {
  @Input() task: TaskPayload;

  constructor(private http: HttpClient) {}

  onCompleteTask(): void {
    this.http
    .post<any>(`http://localhost:8080/task/${ this.task.taskDto.id }/complete`, null)
    .subscribe(); // Kell, különben nem működik
  }

  ngOnInit(): void {}
}
