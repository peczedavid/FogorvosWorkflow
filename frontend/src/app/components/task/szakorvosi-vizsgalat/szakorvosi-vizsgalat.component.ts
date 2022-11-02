import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { TaskPayload } from 'src/app/model/generic/task';
import { SzakorvosiVizsgalatDto } from 'src/app/model/implementation/concrete-tasks';

@Component({
  selector: 'app-szakorvosi-vizsgalat',
  template: `
    <app-variable-checkbox
      [processInstanceId]="szakorvosiVizsgalatDto.taskDto.processInstanceId"
      [name]="'fogszabalyzo'"
      [displayName]="'Fogszabályzó'"
      [value]="szakorvosiVizsgalatDto.fogszabalyzo"
      (valueChanged)="variableChanged.emit($event)"
    ></app-variable-checkbox>
  `,
  styleUrls: ['./szakorvosi-vizsgalat.component.css'],
})
export class SzakorvosiVizsgalatComponent implements OnInit {
  @Input() taskPayload: TaskPayload;
  @Output() variableChanged = new EventEmitter();

  szakorvosiVizsgalatDto: SzakorvosiVizsgalatDto;

  constructor() {}

  ngOnInit(): void {
    this.szakorvosiVizsgalatDto = this.taskPayload as SzakorvosiVizsgalatDto;
  }
}
