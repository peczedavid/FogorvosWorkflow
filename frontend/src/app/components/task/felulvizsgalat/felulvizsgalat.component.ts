import { Component, Input, OnInit } from '@angular/core';
import { TaskPayload } from 'src/app/model/generic/task';
import { FelulVizsgalatDto } from 'src/app/model/implementation/concrete-tasks';

@Component({
  selector: 'app-felulvizsgalat',
  templateUrl: './felulvizsgalat.component.html',
  styleUrls: ['./felulvizsgalat.component.css'],
})
export class FelulvizsgalatComponent implements OnInit {
  @Input() taskPayload: TaskPayload;

  felulvizsgalatDto: FelulVizsgalatDto;

  constructor() {}

  ngOnInit(): void {
    this.felulvizsgalatDto = this.taskPayload as FelulVizsgalatDto;
  }
}
