import { Component, OnInit } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { UserData } from 'src/app/model/UserData';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-login',
  template: `
    <div fxLayoutAlign="center center" style="margin-top: 100px">
      <mat-card class="login-card">
        <mat-toolbar color="primary">Bejelentkezés</mat-toolbar>
        <form class="login-form" fxLayoutalign="stretch" fxLayout="column">
          <mat-form-field appearance="fill">
            <mat-label>Felhasználónév</mat-label>
            <input [(ngModel)]="username" matInput [ngModelOptions]="{standalone: true}"/>
          </mat-form-field>
          <mat-form-field appearance="fill">
            <mat-label>Jelszó</mat-label>
            <input [(ngModel)]="password" matInput type="password" [ngModelOptions]="{standalone: true}"/>
          </mat-form-field>
          <button type="submit" (click)="login($event)" mat-raised-button color="accent">Belépés</button>
        </form>
      </mat-card>
    </div>
  `,
  styleUrls: ['./login.component.css'],
})
export class LoginComponent implements OnInit {
  constructor(private userService: UserService, private snackBar: MatSnackBar) {}

  protected username: string = "";
  protected password: string = "";

  login(e: Event) : void {
    e.preventDefault();
    this.userService.login(this.username, this.password)
    .subscribe((userData: UserData) => {
      console.log(userData);
      this.snackBar.open('Sikeres bejelentkezés', 'Bezár', {
        duration: 2000,
        panelClass: ['success-snackbar']
      });
    });
  }

  ngOnInit(): void {}
}
