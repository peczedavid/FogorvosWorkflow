import { Component, Input, OnInit } from '@angular/core';
import { TaskPayload } from 'src/app/model/generic/task';
import { SzakorvosiVizsgalatDto } from 'src/app/model/implementation/concrete-tasks';

@Component({
  selector: 'app-szakorvosi-vizsgalat',
  templateUrl: './szakorvosi-vizsgalat.component.html',
  styleUrls: ['./szakorvosi-vizsgalat.component.css']
})
export class SzakorvosiVizsgalatComponent implements OnInit {
  @Input() taskPayload: TaskPayload;

  szakorvosiVizsgalatDto: SzakorvosiVizsgalatDto;

  constructor() { }

  ngOnInit(): void {
    this.szakorvosiVizsgalatDto = this.taskPayload as SzakorvosiVizsgalatDto;
  }

}
