import { HttpClient, HttpErrorResponse, HttpResponse } from '@angular/common/http';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TaskService } from 'src/app/services/task.service';

@Component({
  selector: 'app-variable-checkbox',
  template: `
    <mat-checkbox (change)="onEdited()" [(ngModel)]="value">
      {{ displayName }}
    </mat-checkbox>
  `,
  styleUrls: ['./variable-checkbox.component.css'],
})
export class VariableCheckboxComponent implements OnInit {
  @Input() processInstanceId: string;
  @Input() name: string;
  @Input() displayName: string;
  @Input() value: boolean;
  @Output() valueChanged = new EventEmitter();

  constructor(
    private snackBar: MatSnackBar,
    private taskService: TaskService
  ) {}

  onEdited() {
    this.taskService
      .setVariable(this.processInstanceId, this.name, this.value)
      .subscribe((response: HttpResponse<any>) => {
        this.valueChanged.emit(this.value)
        if (response) {
          this.snackBar.open('Változó átállítva', 'Bezár', {
            duration: 2000,
            panelClass: ['success-snackbar']
          });
        }
      }, (error: HttpErrorResponse) => {
        console.log(error);
        this.snackBar.open('A változó nem sikerült átállítani', 'Bezár', {
          duration: 2000,
          panelClass: ['danger-snackbar']
        });
      });
  }

  ngOnInit(): void {}
}
