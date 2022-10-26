import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-login',
  template: `
    <div fxLayoutAlign="center center" style="margin-top: 100px">
      <mat-card class="login-card">
        <mat-toolbar color="primary">Bejelentkezés</mat-toolbar>
        <form class="login-form" fxLayoutalign="stretch" fxLayout="column">
          <mat-form-field appearance="fill">
            <mat-label>Felhasználónév</mat-label>
            <input matInput />
          </mat-form-field>
          <mat-form-field appearance="fill">
            <mat-label>Jelszó</mat-label>
            <input matInput type="password" />
          </mat-form-field>
          <button mat-raised-button color="accent">Belépés</button>
        </form>
      </mat-card>
    </div>
  `,
  styleUrls: ['./login.component.css'],
})
export class LoginComponent implements OnInit {
  constructor() {}

  ngOnInit(): void {}
}
