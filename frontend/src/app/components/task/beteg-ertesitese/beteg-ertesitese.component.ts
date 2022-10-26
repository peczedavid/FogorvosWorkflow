import { Component, Input, OnInit } from '@angular/core';
import { TaskPayload } from 'src/app/model/generic/task';
import { BetegErtesiteseDto } from 'src/app/model/implementation/concrete-tasks';

@Component({
  selector: 'app-beteg-ertesitese',
  template: `
    <app-variable-checkbox
      [processInstanceId]="betegErtesiteseDto.taskDto.processInstanceId"
      [name]="'elmarad'"
      [displayName]="'Elmarad'"
      [value]="betegErtesiteseDto.elmarad"
    ></app-variable-checkbox>
    <p>{{betegErtesiteseDto.taskDto.id}}</p>
  `,
  styleUrls: ['./beteg-ertesitese.component.css'],
})
export class BetegErtesiteseComponent implements OnInit {
  @Input() taskPayload: TaskPayload;

  betegErtesiteseDto: BetegErtesiteseDto;

  constructor() {}

  ngOnInit(): void {
    this.betegErtesiteseDto = this.taskPayload as BetegErtesiteseDto;
  }
}
