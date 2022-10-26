import { Component, OnInit } from '@angular/core';
import { Location } from '@angular/common';

@Component({
  selector: 'app-workflow',
  template: `
    <div fxLayoutAlign="center center" fxLayout="column">
      <img
        src="../../../assets/fogszabalyzo-folyamat.png"
        alt=""
        style="width: 50%; margin: 50px"
      />
      <button (click)="back()" mat-raised-button color="accent">Vissza</button>
    </div>
  `,
  styleUrls: ['./workflow.component.css'],
})
export class WorkflowComponent implements OnInit {
  constructor(private location: Location) {}

  back(): void {
    this.location.back();
  }

  ngOnInit(): void {}
}
