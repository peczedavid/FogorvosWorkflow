import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Role } from '../model/role';
import { BACKEND_ADDRESS } from '../constants/network.constants';
@Injectable({
  providedIn: 'root',
})
export class RoleService {
  constructor(private http: HttpClient) {}

  private _getRolesUrl = BACKEND_ADDRESS + '/role';
  getRoles(): Observable<Role[]> {
    const url = this._getRolesUrl;
    return this.http.get<Role[]>(url, { withCredentials: true });
  }
}
