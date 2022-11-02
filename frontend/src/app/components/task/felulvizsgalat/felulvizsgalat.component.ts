import { Component, EventEmitter, Input, OnChanges, OnInit, Output } from '@angular/core';
import { TaskPayload } from 'src/app/model/generic/task';
import { FelulVizsgalatDto } from 'src/app/model/implementation/concrete-tasks';

@Component({
  selector: 'app-felulvizsgalat',
  template: `
    <app-variable-checkbox
      [processInstanceId]="felulvizsgalatDto.taskDto.processInstanceId"
      [name]="'szakorvosiVizsgalat'"
      [displayName]="'Szakorvosi vizsgálat'"
      [value]="felulvizsgalatDto.szakorvosiVizsgalat"
      (valueChanged)="variableChanged.emit($event)"
    ></app-variable-checkbox>
  `,
  styleUrls: ['./felulvizsgalat.component.css'],
})
export class FelulvizsgalatComponent implements OnChanges {
  @Input() taskPayload: TaskPayload;
  @Output() variableChanged = new EventEmitter();

  felulvizsgalatDto: FelulVizsgalatDto;

  constructor() {}

  ngOnChanges(): void {
    this.felulvizsgalatDto = this.taskPayload as FelulVizsgalatDto;
  }
}
