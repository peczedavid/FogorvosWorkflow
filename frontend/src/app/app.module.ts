import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { StoreModule } from '@ngrx/store';

import { ReactiveFormsModule } from '@angular/forms';

import { FlexLayoutModule } from '@angular/flex-layout';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatOptionModule } from '@angular/material/core';
import { MatDialogModule } from '@angular/material/dialog';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatMenuModule } from '@angular/material/menu';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatSelectModule } from '@angular/material/select';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { MatTableModule } from '@angular/material/table';
import { MatToolbarModule } from '@angular/material/toolbar';

import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AppComponent } from './app.component';

import { HeaderComponent } from './components/header/header.component';
import { LoginComponent } from './components/login/login.component';

import { HttpClientModule } from '@angular/common/http';
import { RouterModule } from '@angular/router';
import { TasksPageComponent } from './components/tasks-page/tasks-page.component';

import { DeleteProcessDialogComponent } from './components/delete-process-dialog/delete-process-dialog.component';
import { HomeComponent } from './components/home/home.component';
import { NewProcessComponent } from './components/new-process/new-process.component';
import { RegisterComponent } from './components/register/register.component';
import { TaskDetailComponent } from './components/task-detail/task-detail.component';
import { TaskListItemComponent } from './components/task-list-item/task-list-item.component';
import { BetegErtesiteseComponent } from './components/task/beteg-ertesitese/beteg-ertesitese.component';
import { FelulvizsgalatComponent } from './components/task/felulvizsgalat/felulvizsgalat.component';
import { FogszabalyzoFelrakasaComponent } from './components/task/fogszabalyzo-felrakasa/fogszabalyzo-felrakasa.component';
import { MegjelenesIdopontonComponent } from './components/task/megjelenes-idoponton/megjelenes-idoponton.component';
import { RontgenComponent } from './components/task/rontgen/rontgen.component';
import { SzakorvosiVizsgalatComponent } from './components/task/szakorvosi-vizsgalat/szakorvosi-vizsgalat.component';
import { VizsgalatComponent } from './components/task/vizsgalat/vizsgalat.component';
import { UsersComponent } from './components/users/users.component';
import { VariableCheckboxComponent } from './components/variable/variable-checkbox/variable-checkbox.component';
import { routes } from './routes';
import { TaskService } from './services/task.service';
import { taskActionFactoryToken } from './state/task/task.action.factory';
import { TaskActionFactoryImpl } from './state/task/task.action.factory.impl';
import { taskReducer } from './state/task/task.reducer';
import { TASKS_STATE_NAME } from './state/task/task.state.model';
import { userActionFactoryToken } from './state/user/user.action.factory';
import { UserActionFactoryImpl } from './state/user/user.action.factory.impl';
import { userReducer } from './state/user/user.reducer';
import { USER_STATE_NAME } from './state/user/user.state.model';

@NgModule({
  declarations: [
    AppComponent,
    HeaderComponent,
    LoginComponent,
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
    HomeComponent,
    RegisterComponent,
    NewProcessComponent,
    DeleteProcessDialogComponent,
    UsersComponent,
  ],
  imports: [
    BrowserModule,
    RouterModule.forRoot(routes),
    StoreModule.forRoot(
      {},
      { runtimeChecks: { strictStateImmutability: false } }
    ),
    StoreModule.forFeature(TASKS_STATE_NAME, taskReducer),
    StoreModule.forFeature(USER_STATE_NAME, userReducer),
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
    MatDialogModule,
    ReactiveFormsModule,
    MatPaginatorModule,
    MatSidenavModule,
  ],
  providers: [
    TaskService,
    { provide: taskActionFactoryToken, useClass: TaskActionFactoryImpl },
    { provide: userActionFactoryToken, useClass: UserActionFactoryImpl },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
