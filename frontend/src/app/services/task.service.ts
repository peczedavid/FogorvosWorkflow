import { HttpClient, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/internal/Observable';
import { TaskPayload } from '../model/generic/task';

@Injectable({
  providedIn: 'root',
})
export class TaskService {
  constructor(private http: HttpClient) {}

  private _getTasksUrl: string = 'http://localhost:8080/user/#userId#/task';
  getTasks(userId: string): Observable<TaskPayload[]> {
    const url = this._getTasksUrl.replace('#userId#', userId);
    return this.http.get<TaskPayload[]>(url);
  }

  private _setVariableUrl =
    'http://localhost:8080/process-instance/#processInstanceId#/variables/#variableName#';
  setVariable(
    processInstanceId: string,
    variableName: string,
    variableValue: any
  ): Observable<HttpResponse<any>> {
    const url = this._setVariableUrl
      .replace('#processInstanceId#', processInstanceId)
      .replace('#variableName#', variableName);
    return this.http.post<HttpResponse<any>>(url, {
      type: 'elvileg-mindegy',
      value: variableValue,
    });
  }
}
