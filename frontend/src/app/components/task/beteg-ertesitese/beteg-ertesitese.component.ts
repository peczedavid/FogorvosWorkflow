import { Component, OnDestroy } from '@angular/core';
import { Store } from '@ngrx/store';
import { BetegErtesiteseDto } from 'src/app/model/implementation/concrete-tasks';
import {
  selectTasksState,
  TasksState,
} from 'src/app/state/task/task.state.model';

@Component({
  selector: 'app-beteg-ertesitese',
  template: `
    <app-variable-checkbox
      [processInstanceId]="betegErtesiteseDto.taskDto.processInstanceId"
      [name]="'elmarad'"
      [displayName]="'Elmarad'"
      [value]="betegErtesiteseDto.elmarad"
    ></app-variable-checkbox>
  `,
  styleUrls: ['./beteg-ertesitese.component.css'],
})
export class BetegErtesiteseComponent implements OnDestroy {
  private tasksSubscription: any;
  protected betegErtesiteseDto: BetegErtesiteseDto;

  constructor(private ngrxStore: Store) {
    this.tasksSubscription = this.ngrxStore
      .select(selectTasksState)
      .subscribe((tasksState: TasksState) => {
        this.betegErtesiteseDto = tasksState.selectedTask as BetegErtesiteseDto;
      });
  }

  ngOnDestroy(): void {
    this.tasksSubscription.unsubscribe();
  }
}
