import { Component, EventEmitter, Input, OnChanges, OnInit, Output } from '@angular/core';
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
      (valueChanged)="variableChanged.emit($event)"
    ></app-variable-checkbox>
  `,
  styleUrls: ['./vizsgalat.component.css'],
})
export class VizsgalatComponent implements OnChanges {
  @Input() taskPayload: TaskPayload;
  @Output() variableChanged = new EventEmitter();

  vizsgalatDto: VizsgalatDto;

  constructor() {}

  ngOnChanges(): void {
    this.vizsgalatDto = this.taskPayload as VizsgalatDto;
  }
}
