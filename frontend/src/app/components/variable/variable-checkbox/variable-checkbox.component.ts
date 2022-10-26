import { HttpClient } from '@angular/common/http';
import { Component, Input, OnInit } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';

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
  @Input() processInstanceId: String;
  @Input() name: String;
  @Input() displayName: String;
  @Input() value: boolean;

  constructor(private http: HttpClient, private _snackBar: MatSnackBar) {}

  onEdited() {
    const url = `http://localhost:8080/process-instance/${this.processInstanceId}/variables/${this.name}`;
    this.http
      .post<any>(url, {
        type: 'elvileg-mindegy',
        value: this.value,
      })
      .subscribe((response) => {
        if (response === null) {
          this._snackBar.open('Változó átállítva', 'Bezár');
        }
      });
  }

  ngOnInit(): void {}
}
