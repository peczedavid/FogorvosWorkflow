import { Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { UserData } from 'src/app/model/UserData';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-users',
  template: `
    <div fxLayoutAlign="center center" style="padding-top: 4rem;">
      <div class="mat-elevation-z8" style="width: 70%;">
        <table style="width: 100%;" mat-table [dataSource]="dataSource">
          <ng-container matColumnDef="id">
            <th mat-header-cell *matHeaderCellDef mat-sort-header>Id</th>
            <td mat-cell *matCellDef="let element">{{ element.id }}</td>
          </ng-container>

          <ng-container matColumnDef="username">
            <th mat-header-cell *matHeaderCellDef mat-sort-header>Name</th>
            <td mat-cell *matCellDef="let element">{{ element.username }}</td>
          </ng-container>

          <ng-container matColumnDef="role">
            <th mat-header-cell *matHeaderCellDef mat-sort-header>Role</th>
            <td mat-cell *matCellDef="let element">{{ element.role }}</td>
          </ng-container>

          <tr mat-header-row *matHeaderRowDef="displayedColumns"></tr>
          <tr mat-row *matRowDef="let row; columns: displayedColumns"></tr>
        </table>

        <mat-paginator [pageSizeOptions]="[5, 10, 15]" showFirstLastButtons>
        </mat-paginator>
      </div>
    </div>
  `,
  styleUrls: ['./users.component.css'],
})
export class UsersComponent implements OnInit {
  protected users: UserData[] = [];
  protected displayedColumns: string[] = ['id', 'username', 'role'];
  protected dataSource = new MatTableDataSource<UserData>();

  constructor(private userService: UserService) {}

  @ViewChild(MatPaginator) paginator: MatPaginator;

  ngOnInit(): void {
    this.userService.getUsers().subscribe({
      next: (users: UserData[]) => {
        this.users = users;
        this.dataSource = new MatTableDataSource(this.users);
        this.dataSource.paginator = this.paginator;
      },
      error: (error) => {
        console.log(error);
      },
    });
  }
}
