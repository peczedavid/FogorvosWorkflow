import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/internal/Observable';
import { TaskPayload } from '../model/generic/task';
import { MessageResponse } from '../model/MessageResponse';
import { UserData, LoginRequest, CheckResponse } from '../model/UserData';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  constructor(private http: HttpClient) {}

  private _backendAddress = 'http://localhost:8080/api';

  // TODO: automatikusan a bejelentkezett felhasználó task-jait kérje le
  private _getTasksUrl: string = this._backendAddress + '/user/#userId#/task';
  getTasks(userId: string): Observable<TaskPayload[]> {
    const url = this._getTasksUrl.replace('#userId#', userId);
    return this.http.get<TaskPayload[]>(url, { withCredentials: true });
  }

  private _checkUrl: string = this._backendAddress + '/user/check';
  check(): Observable<CheckResponse> {
    const url = this._checkUrl;
    return this.http.get<CheckResponse>(url, {
      withCredentials: true,
    });
  }

  private _loginUrl: string = this._backendAddress + '/user/login';
  login(username: string, password: string): Observable<UserData> {
    const url = this._loginUrl;
    const loginRequest: LoginRequest = {
      username: username,
      password: password,
    };
    return this.http.post<UserData>(url, loginRequest, {
      withCredentials: true,
    });
  }

  private _logoutUrl: string = this._backendAddress + '/user/logout';
  logout(): Observable<MessageResponse> {
    const url = this._logoutUrl;
    return this.http.post<MessageResponse>(
      url,
      {},
      {
        withCredentials: true,
      }
    );
  }
}
