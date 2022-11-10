import {
  HttpClient,
  HttpErrorResponse,
  HttpResponse,
} from '@angular/common/http';
import {
  Component,
  EventEmitter,
  Inject,
  Input,
  OnInit,
  Output,
} from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Store } from '@ngrx/store';
import { TaskService } from 'src/app/services/task.service';
import {
  TaskActionFactory,
  taskActionFactoryToken,
} from 'src/app/state/task/task.action.factory';
import {
  selectTasksState,
  TasksState,
} from 'src/app/state/task/task.state.model';

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

  private tasksSubscription: any;

  constructor(
    private snackBar: MatSnackBar,
    private ngrxStore: Store,
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
