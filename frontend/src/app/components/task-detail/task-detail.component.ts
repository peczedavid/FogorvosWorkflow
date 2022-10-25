import { HttpClient } from '@angular/common/http';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { TaskPayload, TaskTipus } from 'src/app/model/generic/task';

@Component({
  selector: 'app-task-detail',
  templateUrl: './task-detail.component.html',
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
    //console.log(this.task);
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
