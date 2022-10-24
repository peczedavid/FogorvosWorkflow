import { Component, Input, OnInit } from '@angular/core';
import { TaskPayload } from 'src/app/model/generic/task';
import { TaskService } from 'src/app/services/task.service';

@Component({
  selector: 'app-task-detail',
  templateUrl: './task-detail.component.html',
  styleUrls: ['./task-detail.component.css'],
})
export class TaskDetailComponent implements OnInit {
  @Input() task: TaskPayload;

  constructor(private _taskService: TaskService) {}

  onCompleteTask(): void {
    this._taskService.completeTask(this.task.taskDto.id).subscribe();
  }

  ngOnInit(): void {}
}
