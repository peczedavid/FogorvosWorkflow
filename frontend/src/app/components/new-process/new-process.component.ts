import { Component, Inject } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { SNACK_BAR_MSG } from 'src/app/constants/message.constants';
import { MessageResponse } from 'src/app/model/MessageResponse';
import {
  TaskActionFactory,
  taskActionFactoryToken
} from 'src/app/state/task/task.action.factory';

@Component({
  selector: 'app-new-process',
  template: `
    <div fxLayoutAlign="center center" style="margin-top: 100px">
      <mat-card class="new-process-card">
        <mat-toolbar color="primary" [class.mat-elevation-z3]="true"
          >Új folyamat</mat-toolbar
        >
        <form
          class="new-process-form"
          fxLayoutalign="stretch"
          fxLayout="column"
        >
          <mat-form-field appearance="fill">
            <mat-label>Beteg neve</mat-label>
            <input
              [(ngModel)]="patientName"
              matInput
              [ngModelOptions]="{ standalone: true }"
            />
          </mat-form-field>
          <button
            type="submit"
            mat-raised-button
            color="accent"
            (click)="newProcess($event)"
          >
            Folyamat indítása
          </button>
        </form>
      </mat-card>
    </div>
  `,
  styleUrls: ['./new-process.component.css'],
})
export class NewProcessComponent {
  protected patientName: string = '';

  constructor(
    @Inject(taskActionFactoryToken)
    private taskActionFactory: TaskActionFactory,
    private snackBar: MatSnackBar
  ) {}

  newProcess(_: Event): void {
    this.taskActionFactory.startNewProcess(this.patientName).subscribe({
      next: (_: MessageResponse) => {
        this.snackBar.open(
          SNACK_BAR_MSG.NEW_PROCESS_STARTED,
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
}
