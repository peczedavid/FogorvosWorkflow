import { Component, Input, OnInit } from '@angular/core';
import { TaskPayload } from 'src/app/model/generic/task';
import { VizsgalatDto } from 'src/app/model/implementation/concrete-tasks';

@Component({
  selector: 'app-vizsgalat',
  templateUrl: './vizsgalat.component.html',
  styleUrls: ['./vizsgalat.component.css']
})
export class VizsgalatComponent implements OnInit {

  @Input() taskPayload: TaskPayload | undefined;

  private _vizsgalatDto: VizsgalatDto;

  constructor() { }

  ngOnInit(): void {
    this._vizsgalatDto = this.taskPayload as VizsgalatDto;
    console.log(this._vizsgalatDto.rontgen);
  }

}
