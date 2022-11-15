import { Component, Inject, OnDestroy, OnInit } from '@angular/core';
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
        *ngIf="currentUser !== undefined"
      >
        Feladatok
      </button>
      <button
        [routerLink]="['/login']"
        style="margin-right: 15px;"
        mat-raised-button
        *ngIf="currentUser === undefined"
      >
        Belépés
      </button>
      <button
        [routerLink]="['/']"
        style="margin-right: 15px;"
        mat-raised-button
        (click)="logout()"
        *ngIf="currentUser !== undefined"
      >
        Kilépés
      </button>
    </mat-toolbar>
  `,
  styleUrls: ['./header.component.css'],
})
export class HeaderComponent implements OnInit, OnDestroy {
  private userSubscription: any;

  protected currentUser?: UserData;
  protected title: string = 'Fogorvos frontend';

  constructor(
    private router: Router,
    private ngrxStore: Store,
    @Inject(userActionFactoryToken)
    private userActionFactory: UserActionFactory,
    private snackBar: MatSnackBar
  ) {
    this.userSubscription = this.ngrxStore
      .select(selectUserState)
      .subscribe((userState: UserState) => {
        this.currentUser = userState.currentUser;
      });
  }
  ngOnInit(): void {
    this.userActionFactory.check().subscribe();
  }

  ngOnDestroy(): void {
    this.userSubscription.unsubscribe();
  }

  logout(): void {
    this.userActionFactory.logout().subscribe((response: MessageResponse) => {
      console.log(response.message);
      this.router.navigateByUrl('/');
      this.snackBar.open('Kijelentkezve', 'Bezár', {
        duration: 2000,
        panelClass: ['success-snackbar'],
      });
    });
  }
}
