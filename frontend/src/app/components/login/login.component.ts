import { Component, Inject, OnDestroy } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { Store } from '@ngrx/store';
import { MessageResponse } from 'src/app/model/MessageResponse';
import { UserData } from 'src/app/model/UserData';
import {
  UserActionFactory,
  userActionFactoryToken,
} from 'src/app/state/user/user.action.factory';
import {
  selectUserState,
  UserState,
} from 'src/app/state/user/user.state.model';

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
              matInput
              type="password"
              [ngModelOptions]="{ standalone: true }"
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
export class LoginComponent implements OnDestroy {
  private userSubscription: any;

  constructor(
    private router: Router,
    private ngrxStore: Store,
    @Inject(userActionFactoryToken)
    private userActionFactory: UserActionFactory,
    private snackBar: MatSnackBar
  ) {
    // TODO: itt talán nem is kell
    this.userSubscription = this.ngrxStore
      .select(selectUserState)
      .subscribe((userState: UserState) => {});
  }

  protected username: string = '';
  protected password: string = '';

  login(e: Event): void {
    e.preventDefault();
    this.userActionFactory.login(this.username, this.password).subscribe({
      next: (userData: UserData) => {
        console.log(userData);
        this.router.navigateByUrl('/tasks');
        this.snackBar.open('Bejelentkezve', 'Bezár', {
          duration: 2000,
          panelClass: ['success-snackbar'],
        });
      },
      error: (messageResponse: MessageResponse) => {
        // TODO: nem fut le, action factory-ban van valami
        console.log(messageResponse.message);
        this.snackBar.open('Hiba történt', 'Bezár', {
          duration: 2000,
          panelClass: ['danger-snackbar'],
        });
      },
    });
  }

  ngOnDestroy(): void {
    this.userSubscription.unsubscribe();
  }
}
