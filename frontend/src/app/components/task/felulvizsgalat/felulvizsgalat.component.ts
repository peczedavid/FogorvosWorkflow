import {
  Component,
  EventEmitter,
  Input,
  OnChanges,
  OnDestroy,
  OnInit,
  Output,
} from '@angular/core';
import { Store } from '@ngrx/store';
import { TaskPayload } from 'src/app/model/generic/task';
import { FelulVizsgalatDto } from 'src/app/model/implementation/concrete-tasks';
import {
  selectTasksState,
  TasksState,
} from 'src/app/state/task/task.state.model';

@Component({
  selector: 'app-felulvizsgalat',
  template: `
    <app-variable-checkbox
      [processInstanceId]="felulvizsgalatDto.taskDto.processInstanceId"
      [name]="'szakorvosiVizsgalat'"
      [displayName]="'Szakorvosi vizsgálat'"
      [value]="felulvizsgalatDto.szakorvosiVizsgalat"
    ></app-variable-checkbox>
  `,
  styleUrls: ['./felulvizsgalat.component.css'],
})
export class FelulvizsgalatComponent implements OnDestroy {
  private tasksSubscription: any;
  protected felulvizsgalatDto: FelulVizsgalatDto;

  constructor(private ngrxStore: Store) {
    this.tasksSubscription = this.ngrxStore
      .select(selectTasksState)
      .subscribe((tasksState: TasksState) => {
        this.felulvizsgalatDto = tasksState.selectedTask as FelulVizsgalatDto;
      });
  }

  ngOnDestroy(): void {
    this.tasksSubscription.unsubscribe();
  }
}
