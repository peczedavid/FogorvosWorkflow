import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Role } from '../model/role';

@Injectable({
  providedIn: 'root',
})
export class RoleService {
  constructor(private http: HttpClient) {}

  // TODO: export into constants.ts
  private _backendAddress = 'http://localhost:8080/api';

  private _getRolesUrl = this._backendAddress + '/role';
  getRoles(): Observable<Role[]> {
    const url = this._getRolesUrl;
    return this.http.get<Role[]>(url, { withCredentials: true });
  }
}
