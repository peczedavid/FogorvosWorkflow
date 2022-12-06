import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/internal/Observable';
import { BACKEND_ADDRESS } from '../constants/network.constants';
import { MessageResponse } from '../model/MessageResponse';
@Injectable({
  providedIn: 'root',
})
export class TaskService {
  constructor(private http: HttpClient) {}

  private _setVariableUrl =
    BACKEND_ADDRESS +
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

  private _deleteProcessInstanceUrl = BACKEND_ADDRESS + '/process-instance/#id#';
  deleteProcessInstance(processInstanceId: string): Observable<MessageResponse> {
    const url = this._deleteProcessInstanceUrl.replace('#id#', processInstanceId);
    return this.http.delete<MessageResponse>(url, { withCredentials: true});
  }

  private _startCleanProcessUrl = BACKEND_ADDRESS + '/process-instance/new';
  startCleanProcess(patientName: string): Observable<MessageResponse> {
    const url = this._startCleanProcessUrl;
    return this.http.post<MessageResponse>(
      url,
      {
        patientName: patientName,
      },
      { withCredentials: true }
    );
  }

  private _completeTaskUrl = BACKEND_ADDRESS + '/task/#taskId#/complete';
  completeTask(taskId: string): Observable<MessageResponse> {
    const url = this._completeTaskUrl.replace('#taskId#', taskId);
    return this.http.post<MessageResponse>(url, {}, { withCredentials: true });
  }
}
