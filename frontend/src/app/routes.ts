import { Routes } from '@angular/router';

import { LoginComponent } from './components/login/login.component';
import { WorkflowComponent } from './components/workflow/workflow.component';
import { TasksPageComponent } from './components/tasks-page/tasks-page.component';

export const routes: Routes = [
  { path: '', component: LoginComponent },
  { path: 'workflow', component: WorkflowComponent },
  { path: 'tasks', component: TasksPageComponent },
];
