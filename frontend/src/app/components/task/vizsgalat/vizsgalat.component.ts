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
import { VizsgalatDto } from 'src/app/model/implementation/concrete-tasks';
import {
  selectTasksState,
  TasksState,
} from 'src/app/state/task/task.state.model';

@Component({
  selector: 'app-vizsgalat',
  template: `
    <app-variable-checkbox
      [processInstanceId]="vizsgalatDto.taskDto.processInstanceId"
      [name]="'rontgen'"
      [displayName]="'Röntgen'"
      [value]="vizsgalatDto.rontgen"
    ></app-variable-checkbox>
  `,
  styleUrls: ['./vizsgalat.component.css'],
})
export class VizsgalatComponent implements OnDestroy {
  private tasksSubscription: any;
  protected vizsgalatDto: VizsgalatDto;

  constructor(private ngrxStore: Store) {
    this.tasksSubscription = this.ngrxStore
      .select(selectTasksState)
      .subscribe((tasksState: TasksState) => {
        this.vizsgalatDto = tasksState.selectedTask as VizsgalatDto;
      });
  }

  ngOnDestroy(): void {
    this.tasksSubscription.unsubscribe();
  }
}
