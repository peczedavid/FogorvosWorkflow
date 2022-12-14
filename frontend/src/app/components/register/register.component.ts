import { Component, Inject, OnInit } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { SNACK_BAR_MSG } from 'src/app/constants/message.constants';
import { MessageResponse } from 'src/app/model/MessageResponse';
import { mapRoleToReadableName } from 'src/app/model/role';
import {
  Role,
} from 'src/app/model/role';
import { UserData } from 'src/app/model/UserData';
import { RoleService } from 'src/app/services/role.service';
import {
  UserActionFactory,
  userActionFactoryToken
} from 'src/app/state/user/user.action.factory';
@Component({
  selector: 'app-register',
  template: `
    <div fxLayoutAlign="center center" style="margin-top: 100px">
      <mat-card class="register-card">
        <mat-toolbar color="primary" [class.mat-elevation-z3]="true"
          >Regisztrálás</mat-toolbar
        >
        <form
          class="register-form"
          autocomplete="off"
          fxLayoutalign="stretch"
          fxLayout="column"
        >
          <mat-form-field appearance="fill">
            <mat-label>Felhasználónév</mat-label>
            <input
              matInput
              name="somethingAutofillDoesntKnow"
              [(ngModel)]="username"
              [ngModelOptions]="{ standalone: true }"
            />
          </mat-form-field>
          <mat-form-field appearance="fill">
            <mat-label>Jelszó</mat-label>
            <input
              matInput
              name="somethingAutofillDoesntKnow"
              type="password"
              [(ngModel)]="password"
              [ngModelOptions]="{ standalone: true }"
            />
          </mat-form-field>
          <mat-form-field appearance="fill">
            <mat-label>Szerepkör</mat-label>
            <mat-select (selectionChange)="selectValueChanged($event.value)">
              <mat-option *ngFor="let role of roles" [value]="role.name">
                {{ getRoleName(role.name) }}
              </mat-option>
            </mat-select>
          </mat-form-field>
          <button
            type="submit"
            (click)="register($event)"
            mat-raised-button
            color="accent"
          >
            Regisztrálás
          </button>
        </form>
      </mat-card>
    </div>
  `,
  styleUrls: ['./register.component.css'],
})
export class RegisterComponent implements OnInit {
  protected roles: Role[];

  protected username: string = '';
  protected password: string = '';
  protected role: string = '';

  constructor(
    private roleService: RoleService,
    private router: Router,
    @Inject(userActionFactoryToken)
    private userActionFactory: UserActionFactory,
    private snackBar: MatSnackBar
  ) {}

  selectValueChanged(value: string) {
    this.role = value;
  }

  register(e: Event): void {
    e.preventDefault();
    this.userActionFactory
      .register(this.username, this.password, this.role)
      .subscribe({
        next: (_: UserData) => {
          this.snackBar.open(
            SNACK_BAR_MSG.REGISTERED,
            SNACK_BAR_MSG.ACTION_TEXT,
            {
              duration: 2000,
              panelClass: ['success-snackbar'],
            }
          );
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

  getRoleName(role: string): string {
    return mapRoleToReadableName(role);
  }

  handleAuthNext(userData: UserData): void {
    if (userData === null) {
      this.snackBar.open(
        SNACK_BAR_MSG.NOT_LOGGED_IN,
        SNACK_BAR_MSG.ACTION_TEXT,
        {
          duration: 2000,
          panelClass: ['danger-snackbar'],
        }
      );
      this.router.navigateByUrl('/login', { skipLocationChange: true });
    } else {
      this.initRoles();
    }
  }

  handleAuthError(error: any): void {
    console.log(error);
  }

  initRoles(): void {
    this.roleService.getRoles().subscribe({
      next: (roles: Role[]) => {
        this.roles = roles;
      },
      error: (error) => {
        console.log(error);
      },
    });
  }

  ngOnInit(): void {
    this.userActionFactory.check().subscribe({
      next: (userData: UserData) => this.handleAuthNext(userData),
      error: (error: any) => this.handleAuthError(error),
    });
  }
}
