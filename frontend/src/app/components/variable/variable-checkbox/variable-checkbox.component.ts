import { HttpErrorResponse } from '@angular/common/http';
import { Component, Inject, Input, OnDestroy } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Store } from '@ngrx/store';
import { UserData } from 'src/app/model/UserData';
import {
  TaskActionFactory,
  taskActionFactoryToken
} from 'src/app/state/task/task.action.factory';
import {
  selectUserState,
  UserState
} from 'src/app/state/user/user.state.model';

@Component({
  selector: 'app-variable-checkbox',
  template: `
    <mat-checkbox (change)="onEdited()" [(ngModel)]="value">
      {{ displayName }}
    </mat-checkbox>
  `,
  styleUrls: ['./variable-checkbox.component.css'],
})
export class VariableCheckboxComponent implements OnDestroy {
  @Input() processInstanceId: string;
  @Input() name: string;
  @Input() displayName: string;
  @Input() value: boolean;

  protected currentUser?: UserData;

  private userSubscription: any;

  constructor(
    private snackBar: MatSnackBar,
    private ngrxStore: Store,
    @Inject(taskActionFactoryToken)
    private taskActionFactory: TaskActionFactory
  ) {
    this.userSubscription = this.ngrxStore
      .select(selectUserState)
      .subscribe((userState: UserState) => {
        this.currentUser = userState.currentUser;
      });
  }

  onEdited() {
    this.taskActionFactory
      .setVariable(this.processInstanceId, this.name, this.value)
      .subscribe({
        next: (response) => {
          if (response) {
            this.snackBar.open('Változó átállítva', 'Bezár', {
              duration: 2000,
              panelClass: ['success-snackbar'],
            });
          }
          this.taskActionFactory
            .getTasksKeepSelected(this.currentUser!.id)
            .subscribe();
        },
        error: (error: HttpErrorResponse) => {
          console.log(error);
          this.snackBar.open('A változó nem sikerült átállítani', 'Bezár', {
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
