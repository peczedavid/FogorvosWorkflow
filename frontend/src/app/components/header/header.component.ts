import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { UserService } from 'src/app/services/user.service';
import { MessageResponse } from 'src/app/model/MessageResponse';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-header',
  template: `
    <mat-toolbar class="navbar" color="primary" [class.mat-elevation-z5]="true">
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
      <button style="margin-right: 15px;" mat-raised-button (click)="logout()">
        Kilépés
      </button>
    </mat-toolbar>
  `,
  styleUrls: ['./header.component.css'],
})
export class HeaderComponent {
  title: string = 'Fogorvos frontend';

  constructor(
    private userService: UserService,
    private snackBar: MatSnackBar
  ) {}

  logout(): void {
    this.userService.logout().subscribe((response: MessageResponse) => {
      console.log(response.message);
      this.snackBar.open('Sikeres kijelentkezés', 'Bezár', {
        duration: 2000,
        panelClass: ['success-snackbar'],
      });
    });
  }
}
