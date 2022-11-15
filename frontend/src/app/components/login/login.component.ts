import { Component, Inject, OnDestroy } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Store } from '@ngrx/store';
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
          <button
            (click)="check()"
            mat-raised-button
            color="primary"
            style="margin-top: 1rem;"
          >
            Ki vagyok?
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

  check(): void {
    this.userActionFactory.check().subscribe((userData: UserData) => {
      console.log(userData);
      if (userData === null) {
        this.snackBar.open('Nem vagy bejelentkezve!', 'Bezár', {
          duration: 2000,
          panelClass: ['warning-snackbar'],
        });
      } else {
        this.snackBar.open(userData.username, 'Bezár', {
          duration: 2000,
          panelClass: ['success-snackbar'],
        });
      }
    });
  }

  login(e: Event): void {
    e.preventDefault();
    this.userActionFactory
      .login(this.username, this.password)
      .subscribe((userData: UserData) => {
        console.log(userData);
        this.snackBar.open('Sikeres bejelentkezés', 'Bezár', {
          duration: 2000,
          panelClass: ['success-snackbar'],
        });
      });
  }

  ngOnDestroy(): void {
    this.userSubscription.unsubscribe();
  }
}
