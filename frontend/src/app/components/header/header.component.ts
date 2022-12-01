import { Component, Inject, OnDestroy, OnInit } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { Store } from '@ngrx/store';
import { SNACK_BAR_MSG } from 'src/app/constants/message.constants';
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
      <p style="font-size: 0.875em; margin-right: 1rem;" mat-button>
        {{ currentUser?.username + ' (' + currentUser?.role + ')' }}
      </p>
      <button
        [routerLink]="['/tasks']"
        style="margin-right: 1rem; padding-right: 0.65rem;"
        mat-raised-button
        *ngIf="currentUser !== undefined"
      >
        Feladatok
        <mat-icon style="margin-left: 0.5rem;" fontIcon="list_alt"></mat-icon>
      </button>
      <button
        [routerLink]="['/login']"
        style="margin-right: 1rem; padding-right: 0.65rem;"
        mat-raised-button
        *ngIf="currentUser === undefined"
      >
        Belépés
        <mat-icon style="margin-left: 0.15rem;" fontIcon="login"></mat-icon>
      </button>
      <button
        [routerLink]="['/']"
        style="margin-right: 1rem; padding-right: 0.55rem;"
        mat-raised-button
        (click)="logout()"
        *ngIf="currentUser !== undefined"
      >
        Kilépés
        <mat-icon style="margin-left: 0.35rem;" fontIcon="logout"></mat-icon>
      </button>
    </mat-toolbar>
  `,
  styleUrls: ['./header.component.css'],
})
export class HeaderComponent implements OnInit, OnDestroy {
  private userSubscription: any;

  protected currentUser?: UserData;

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
    this.userActionFactory.logout().subscribe((_: MessageResponse) => {
      this.router.navigateByUrl('/');
      this.snackBar.open(SNACK_BAR_MSG.LOGGED_OUT, SNACK_BAR_MSG.ACTION_TEXT, {
        duration: 2000,
        panelClass: ['success-snackbar'],
      });
    });
  }
}
