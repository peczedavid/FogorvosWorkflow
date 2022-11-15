import { HttpClient, HttpHeaders, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/internal/Observable';
import { TaskPayload } from '../model/generic/task';
import { MessageResponse } from '../model/MessageResponse';

@Injectable({
  providedIn: 'root',
})
export class TaskService {
  constructor(private http: HttpClient) {}

  private _backendAddress = 'http://localhost:8080/api';

  private _setVariableUrl =
    this._backendAddress +
    '/process-instance/#processInstanceId#/variables/#variableName#';
  setVariable(
    processInstanceId: string,
    variableName: string,
    variableValue: any
  ): Observable<MessageResponse> {
    const url = this._setVariableUrl
      .replace('#processInstanceId#', processInstanceId)
      .replace('#variableName#', variableName);
    return this.http.post<MessageResponse>(
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
  startCleanProcess(patientName: string): Observable<MessageResponse> {
    const url = this._startCleanProcessUrl;
    return this.http.post<MessageResponse>(
      url,
      {
        patientName: patientName
      },
      { withCredentials: true }
    );
  }

  private _completeTaskUrl = this._backendAddress + '/task/#taskId#/complete';
  completeTask(taskId: string): Observable<MessageResponse> {
    const url = this._completeTaskUrl.replace('#taskId#', taskId);
    return this.http.post<MessageResponse>(
      url,
      {},
      { withCredentials: true }
    );
  }
}
