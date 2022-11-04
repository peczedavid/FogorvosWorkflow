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
  private _backendAddress = 'http://localhost:8080';

  private _setVariableUrl =
    this._backendAddress +
    '/process-instance/#processInstanceId#/variables/#variableName#';
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

  private _startCleanProcessUrl =
    this._backendAddress + '/process-instance/new';
  startCleanProcess(): Observable<HttpResponse<any>> {
    const url = this._startCleanProcessUrl;
    return this.http.post<HttpResponse<any>>(url, {});
  }

  private _completeTaskUrl = this._backendAddress + '/task/#taskId#/complete';
  completeTask(taskId: string): Observable<HttpResponse<any>> {
    const url = this._completeTaskUrl.replace('#taskId#', taskId);
    return this.http.post<HttpResponse<any>>(url, {});
  }
}
