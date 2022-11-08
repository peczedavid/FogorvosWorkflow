import { HttpClient, HttpHeaders, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/internal/Observable';
import { TaskPayload } from '../model/generic/task';

@Injectable({
  providedIn: 'root',
})
export class TaskService {
  constructor(private http: HttpClient) {}

  // TODO: Move to user service
  private _getTasksUrl: string = 'http://localhost:8080/api/user/#userId#/task';
  getTasks(userId: string): Observable<TaskPayload[]> {
    const url = this._getTasksUrl.replace('#userId#', userId);
    return this.http.get<TaskPayload[]>(url, { withCredentials: true });
  }
  private _backendAddress = 'http://localhost:8080/api';

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
    return this.http.post<HttpResponse<any>>(
      url,
      {
        type: 'elvileg-mindegy',
        value: variableValue,
      },
      { withCredentials: true }
    );
  }

  private _startCleanProcessUrl =
    this._backendAddress + '/process-instance/new';
  startCleanProcess(): Observable<HttpResponse<any>> {
    const url = this._startCleanProcessUrl;
    return this.http.post<HttpResponse<any>>(
      url,
      {},
      { withCredentials: true }
    );
  }

  private _completeTaskUrl = this._backendAddress + '/task/#taskId#/complete';
  completeTask(taskId: string): Observable<HttpResponse<any>> {
    const url = this._completeTaskUrl.replace('#taskId#', taskId);
    return this.http.post<HttpResponse<any>>(
      url,
      {},
      { withCredentials: true }
    );
  }
}
