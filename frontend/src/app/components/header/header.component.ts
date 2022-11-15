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
        style="margin-right: 15px; padding-right: 0.65rem;"
        mat-raised-button
      >
        Folyamat
        <mat-icon style="margin-left: 0.5rem;" fontIcon="view_headline"></mat-icon>
      </button>
      <button
        [routerLink]="['/tasks']"
        style="margin-right: 15px; padding-right: 0.65rem;"
        mat-raised-button
        *ngIf="currentUser !== undefined"
      >
        Feladatok
        <mat-icon style="margin-left: 0.5rem;" fontIcon="list_alt"></mat-icon>
      </button>
      <button
        [routerLink]="['/login']"
        style="margin-right: 15px; padding-right: 0.65rem;"
        mat-raised-button
        *ngIf="currentUser === undefined"
      >
        Belépés
        <mat-icon style="margin-left: 0.15rem;" fontIcon="login"></mat-icon>
      </button>
      <button
        [routerLink]="['/']"
        style="margin-right: 15px; padding-right: 0.55rem;"
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
