import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-header',
  template: `
    <mat-toolbar class="navbar" color="primary">
      <mat-icon style="margin-right: 10px;">local_hospital</mat-icon>
      <button [routerLink]="['/']" mat-button style="font-size: 1.25rem;">
        Online klinika
      </button>
      <span class="example-spacer"></span>
      <button
        [routerLink]="['/workflow']"
        style="margin-right: 15px;"
        mat-raised-button
      >
        Folyamat
      </button>
      <button
        [routerLink]="['/tasks']"
        style="margin-right: 15px;"
        mat-raised-button
      >
        Feladatok
      </button>
    </mat-toolbar>
  `,
  styleUrls: ['./header.component.css'],
})
export class HeaderComponent {
  title: string = 'Fogorvos frontend';

  constructor() {}
}
