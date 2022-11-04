import { Component, Input } from '@angular/core';
import { TaskDto } from 'src/app/model/generic/task';

@Component({
  selector: 'app-task-list-item',
  template: `
    <strong style="font-weight: 500;">{{ taskDto.name }}</strong>
    <br />
    {{ formatDate() }}
  `,
  styleUrls: ['./task-list-item.component.css'],
})
export class TaskListItemComponent {
  @Input() taskDto: TaskDto;

  constructor() {}

  formatDate(): string {
    if (this.taskDto.created instanceof Date) {
      const year = this.taskDto.created.getFullYear();
      const month = this.taskDto.created.getMonth();
      const day = this.taskDto.created.getDay();

      const hours = this.taskDto.created.getHours();
      const minutes = this.taskDto.created.getMinutes();
      const seconds = this.taskDto.created.getSeconds();

      return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
    } else {
      return '';
    }
  }
}
