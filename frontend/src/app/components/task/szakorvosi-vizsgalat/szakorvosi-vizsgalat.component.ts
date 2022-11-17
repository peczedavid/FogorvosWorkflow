import { Component, OnDestroy } from '@angular/core';
import { Store } from '@ngrx/store';
import { SzakorvosiVizsgalatDto } from 'src/app/model/implementation/concrete-tasks';
import {
  selectTasksState,
  TasksState,
} from 'src/app/state/task/task.state.model';

@Component({
  selector: 'app-szakorvosi-vizsgalat',
  template: `
    <app-variable-checkbox
      [processInstanceId]="szakorvosiVizsgalatDto.taskDto.processInstanceId"
      [name]="'fogszabalyzo'"
      [displayName]="'Fogszabályzó'"
      [value]="szakorvosiVizsgalatDto.fogszabalyzo"
    ></app-variable-checkbox>
  `,
  styleUrls: ['./szakorvosi-vizsgalat.component.css'],
})
export class SzakorvosiVizsgalatComponent implements OnDestroy {
  private tasksSubscription: any;
  protected szakorvosiVizsgalatDto: SzakorvosiVizsgalatDto;

  constructor(private ngrxStore: Store) {
    this.tasksSubscription = this.ngrxStore
      .select(selectTasksState)
      .subscribe((tasksState: TasksState) => {
        this.szakorvosiVizsgalatDto =
          tasksState.selectedTask as SzakorvosiVizsgalatDto;
      });
  }

  ngOnDestroy(): void {
    this.tasksSubscription.unsubscribe();
  }
}
