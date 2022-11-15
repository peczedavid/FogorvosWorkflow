import { Routes } from '@angular/router';

import { LoginComponent } from './components/login/login.component';
import { WorkflowComponent } from './components/workflow/workflow.component';
import { TasksPageComponent } from './components/tasks-page/tasks-page.component';
import { HomeComponent } from './components/home/home.component';

export const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'workflow', component: WorkflowComponent },
  { path: 'tasks', component: TasksPageComponent },
  { path: 'login', component: LoginComponent }
];
