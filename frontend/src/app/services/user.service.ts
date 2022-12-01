import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/internal/Observable';
import { TaskPayload } from '../model/generic/task';
import { MessageResponse } from '../model/MessageResponse';
import { LoginRequest, UserData } from '../model/UserData';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  constructor(private http: HttpClient) {}

  private _backendAddress = 'http://localhost:8080/api/user';

  private _getTasksUrl: string = this._backendAddress + '/#userId#/task';
  getTasks(userId: string): Observable<TaskPayload[]> {
    const url = this._getTasksUrl.replace('#userId#', userId);
    return this.http.get<TaskPayload[]>(url, { withCredentials: true });
  }

  private _checkUrl: string = this._backendAddress + '/check';
  check(): Observable<UserData> {
    const url = this._checkUrl;
    return this.http.get<UserData>(url, {
      withCredentials: true,
    });
  }

  private _loginUrl: string = this._backendAddress + '/login';
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

  private _registerUrl: string = this._backendAddress + '/register';
  register(
    username: string,
    password: string,
    role: string
  ): Observable<UserData> {
    const url = this._registerUrl;
    return this.http.post<UserData>(
      url,
      {
        username: username,
        password: password,
        role: role,
      },
      { withCredentials: true }
    );
  }

  private _logoutUrl: string = this._backendAddress + '/logout';
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
