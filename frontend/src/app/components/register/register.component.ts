import { Component, OnInit } from '@angular/core';
import {
  Role,
  ROLE_ADMIN,
  ROLE_RECEPTIONIST,
  ROLE_USER
} from 'src/app/model/role';
import { RoleService } from 'src/app/services/role.service';
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
            <input matInput name="somethingAutofillDoesntKnow" />
          </mat-form-field>
          <mat-form-field appearance="fill">
            <mat-label>Jelszó</mat-label>
            <input
              matInput
              name="somethingAutofillDoesntKnow"
              type="password"
            />
          </mat-form-field>
          <mat-form-field appearance="fill">
            <mat-label>Szerepkör</mat-label>
            <mat-select>
              <mat-option *ngFor="let role of roles" [value]="role.name">
                {{ mapRoleToReadableName(role.name) }}
              </mat-option>
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
export class RegisterComponent implements OnInit {
  protected roles: Role[];

  // TODO: into own state?
  constructor(private roleService: RoleService) {}

  protected mapRoleToReadableName(role: string): string {
    switch (role) {
      case ROLE_USER:
        return 'Felhasználó';
      case ROLE_RECEPTIONIST:
        return 'Recepciós';
      case ROLE_ADMIN:
        return 'Admin';
    }
    return 'Hibás szerepkör';
  }

  ngOnInit(): void {
    this.roleService.getRoles().subscribe({
      next: (roles: Role[]) => {
        this.roles = roles;
      },
      error: (error) => {
        console.log(error);
      },
    });
  }
}
