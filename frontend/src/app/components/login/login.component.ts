import { Component, Inject } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { SNACK_BAR_MSG } from 'src/app/constants/message.constants';
import { MessageResponse } from 'src/app/model/MessageResponse';
import { UserData } from 'src/app/model/UserData';
import {
  UserActionFactory,
  userActionFactoryToken,
} from 'src/app/state/user/user.action.factory';

@Component({
  selector: 'app-login',
  template: `
    <div fxLayoutAlign="center center" style="margin-top: 100px">
      <mat-card class="login-card">
        <mat-toolbar color="primary" [class.mat-elevation-z3]="true"
          >Bejelentkezés</mat-toolbar
        >
        <form class="login-form" fxLayoutalign="stretch" fxLayout="column">
          <mat-form-field appearance="fill">
            <mat-label>Felhasználónév</mat-label>
            <input
              [(ngModel)]="username"
              matInput
              [ngModelOptions]="{ standalone: true }"
            />
          </mat-form-field>
          <mat-form-field appearance="fill">
            <mat-label>Jelszó</mat-label>
            <input
              [(ngModel)]="password"
              [ngModelOptions]="{ standalone: true }"
              matInput
              type="password"
            />
          </mat-form-field>
          <button
            type="submit"
            (click)="login($event)"
            mat-raised-button
            color="accent"
          >
            Belépés
          </button>
        </form>
      </mat-card>
    </div>
  `,
  styleUrls: ['./login.component.css'],
})
export class LoginComponent {
  constructor(
    private router: Router,
    @Inject(userActionFactoryToken)
    private userActionFactory: UserActionFactory,
    private snackBar: MatSnackBar
  ) {}

  protected username: string = '';
  protected password: string = '';

  login(e: Event): void {
    e.preventDefault();
    this.userActionFactory.login(this.username, this.password).subscribe({
      next: (userData: UserData) => {
        this.router.navigateByUrl('/tasks');
        this.snackBar.open(SNACK_BAR_MSG.LOGGED_IN, SNACK_BAR_MSG.ACTION_TEXT, {
          duration: 2000,
          panelClass: ['success-snackbar'],
        });
      },
      error: (messageResponse: MessageResponse) => {
        // TODO: nem fut le, action factory-ban lehet valami
        console.log(messageResponse.message);
        this.snackBar.open(SNACK_BAR_MSG.ERROR, SNACK_BAR_MSG.ACTION_TEXT, {
          duration: 2000,
          panelClass: ['danger-snackbar'],
        });
      },
    });
  }
}
