import { Component, Input, OnInit } from '@angular/core';
import { TaskPayload } from 'src/app/model/generic/task';
import { VizsgalatDto } from 'src/app/model/implementation/concrete-tasks';

@Component({
  selector: 'app-vizsgalat',
  template: `
    <app-variable-checkbox
      [processInstanceId]="vizsgalatDto.taskDto.processInstanceId"
      [name]="'rontgen'"
      [displayName]="'Röntgen'"
      [value]="vizsgalatDto.rontgen"
    ></app-variable-checkbox>
  `,
  styleUrls: ['./vizsgalat.component.css'],
})
export class VizsgalatComponent implements OnInit {
  @Input() taskPayload: TaskPayload;

  vizsgalatDto: VizsgalatDto;

  constructor() {}

  ngOnInit(): void {
    this.vizsgalatDto = this.taskPayload as VizsgalatDto;
  }
}
