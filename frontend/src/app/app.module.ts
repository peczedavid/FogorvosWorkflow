import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { StoreModule } from '@ngrx/store';

import { ReactiveFormsModule } from '@angular/forms';

import { FlexLayoutModule } from '@angular/flex-layout';
import { FormsModule } from '@angular/forms';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatButtonModule } from '@angular/material/button';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatIconModule } from '@angular/material/icon';
import { MatTableModule } from '@angular/material/table';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { MatSelectModule } from '@angular/material/select';
import { MatOptionModule } from '@angular/material/core';
import { MatInputModule } from '@angular/material/input';
import { MatCardModule } from '@angular/material/card';
import { MatMenuModule } from '@angular/material/menu';
import { MatListModule } from '@angular/material/list';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatSnackBarModule } from '@angular/material/snack-bar';

import { HeaderComponent } from './components/header/header.component';
import { LoginComponent } from './components/login/login.component';
import { WorkflowComponent } from './components/workflow/workflow.component';

import { HttpClientModule } from '@angular/common/http';
import { RouterModule } from '@angular/router';
import { TasksPageComponent } from './components/tasks-page/tasks-page.component';

import { routes } from './routes';
import { TaskDetailComponent } from './components/task-detail/task-detail.component';
import { MegjelenesIdopontonComponent } from './components/task/megjelenes-idoponton/megjelenes-idoponton.component';
import { VizsgalatComponent } from './components/task/vizsgalat/vizsgalat.component';
import { BetegErtesiteseComponent } from './components/task/beteg-ertesitese/beteg-ertesitese.component';
import { RontgenComponent } from './components/task/rontgen/rontgen.component';
import { FelulvizsgalatComponent } from './components/task/felulvizsgalat/felulvizsgalat.component';
import { SzakorvosiVizsgalatComponent } from './components/task/szakorvosi-vizsgalat/szakorvosi-vizsgalat.component';
import { FogszabalyzoFelrakasaComponent } from './components/task/fogszabalyzo-felrakasa/fogszabalyzo-felrakasa.component';
import { VariableCheckboxComponent } from './components/variable/variable-checkbox/variable-checkbox.component';
import { TaskService } from './services/task.service';
import { TaskListItemComponent } from './components/task-list-item/task-list-item.component';
import { TASKS_STATE_NAME } from './state/task/task.state.model';
import { taskReducer } from './state/task/task.reducer';
import { taskActionFactoryToken } from './state/task/task.action.factory';
import { TaskActionFactoryImpl } from './state/task/task.action.factory.impl';

@NgModule({
  declarations: [
    AppComponent,
    HeaderComponent,
    LoginComponent,
    WorkflowComponent,
    TasksPageComponent,
    TaskDetailComponent,
    MegjelenesIdopontonComponent,
    VizsgalatComponent,
    BetegErtesiteseComponent,
    RontgenComponent,
    FelulvizsgalatComponent,
    SzakorvosiVizsgalatComponent,
    FogszabalyzoFelrakasaComponent,
    VariableCheckboxComponent,
    TaskListItemComponent,
  ],
  imports: [
    BrowserModule,
    RouterModule.forRoot(routes),
    StoreModule.forRoot({}),
    StoreModule.forFeature(TASKS_STATE_NAME, taskReducer),
    BrowserAnimationsModule,
    HttpClientModule,
    FlexLayoutModule,
    FormsModule,
    MatToolbarModule,
    MatInputModule,
    MatCardModule,
    MatMenuModule,
    MatIconModule,
    MatButtonModule,
    MatTableModule,
    MatSlideToggleModule,
    MatSelectModule,
    MatOptionModule,
    MatListModule,
    MatGridListModule,
    MatCheckboxModule,
    MatSnackBarModule,
    ReactiveFormsModule,
  ],
  providers: [
    TaskService,
    { provide: taskActionFactoryToken, useClass: TaskActionFactoryImpl },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
