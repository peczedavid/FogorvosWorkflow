import { Component } from '@angular/core';

@Component({
  selector: 'app-delete-process-dialog',
  template: `
    <h2 mat-dialog-title>Folyamat megszakítása</h2>
    <mat-dialog-content>
      Biztosan megszakítja a folyamatot?
    </mat-dialog-content>
    <mat-dialog-actions align="end">
      <button mat-raised-button mat-dialog-close>Mégse</button>
      <button mat-raised-button color="warn" [mat-dialog-close]="true">
        Megszakít
      </button>
    </mat-dialog-actions>
  `,
  styleUrls: ['./delete-process-dialog.component.css'],
})
export class DeleteProcessDialogComponent {
}
