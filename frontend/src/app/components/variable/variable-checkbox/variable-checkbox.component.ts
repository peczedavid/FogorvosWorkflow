import { HttpErrorResponse } from '@angular/common/http';
import { Component, Inject, Input } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import {
  TaskActionFactory,
  taskActionFactoryToken,
} from 'src/app/state/task/task.action.factory';

@Component({
  selector: 'app-variable-checkbox',
  template: `
    <mat-checkbox (change)="onEdited()" [(ngModel)]="value">
      {{ displayName }}
    </mat-checkbox>
  `,
  styleUrls: ['./variable-checkbox.component.css'],
})
export class VariableCheckboxComponent {
  @Input() processInstanceId: string;
  @Input() name: string;
  @Input() displayName: string;
  @Input() value: boolean;

  constructor(
    private snackBar: MatSnackBar,
    @Inject(taskActionFactoryToken)
    private taskActionFactory: TaskActionFactory
  ) {}

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
            .getTasksKeepSelected('fogorvosdemo')
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
}
