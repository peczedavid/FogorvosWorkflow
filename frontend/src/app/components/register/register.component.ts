import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-register',
  template: `
    <div fxLayoutAlign="center center" style="margin-top: 100px">
      <mat-card class="register-card">
        <mat-toolbar color="primary" [class.mat-elevation-z3]="true"
          >Regisztrálás</mat-toolbar
        >
        <form class="register-form" autocomplete="off" fxLayoutalign="stretch" fxLayout="column">
          <mat-form-field appearance="fill">
            <mat-label>Felhasználónév</mat-label>
            <input matInput name="somethingAutofillDoesntKnow"/>
          </mat-form-field>
          <mat-form-field appearance="fill">
            <mat-label>Jelszó</mat-label>
            <input matInput name="somethingAutofillDoesntKnow" type="password" />
          </mat-form-field>
          <mat-form-field appearance="fill">
            <mat-label>Szerepkör</mat-label>
            <mat-select>
              <mat-option [value]="'ROLE_USER'">Felhasználó</mat-option>
              <mat-option [value]="'ROLE_RECEPTIONIST'">Recepciós</mat-option>
              <mat-option [value]="'ROLE_ADMIN'">Admin</mat-option>
            </mat-select>
          </mat-form-field>
          <button type="submit" mat-raised-button color="accent">
            Regisztrálás
          </button>
        </form>
      </mat-card>
    </div>
  `,
  styleUrls: ['./register.component.css'],
})
export class RegisterComponent {
  constructor() {}
}
