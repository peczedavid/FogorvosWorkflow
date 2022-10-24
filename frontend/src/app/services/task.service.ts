import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

import { TaskPayload } from '../model/generic/task';

@Injectable({
  providedIn: 'root'
})
export class TaskService {

  constructor(private http: HttpClient) { }

  getTasks(userId: string): any {
    return this.http
    .get<TaskPayload[]>(`http://localhost:8080/user/${userId}/task`)
    // .subscribe((data) => {
    //   console.log(data);
    //   return data;
    // });
  }
}
