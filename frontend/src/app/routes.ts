import { Routes } from '@angular/router';

import { LoginComponent } from './components/login/login.component';
import { TasksPageComponent } from './components/tasks-page/tasks-page.component';
import { HomeComponent } from './components/home/home.component';
import { RegisterComponent } from './components/register/register.component';
import { NewProcessComponent } from './components/new-process/new-process.component';

export const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'tasks', component: TasksPageComponent },
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'new-process', component: NewProcessComponent },
];
