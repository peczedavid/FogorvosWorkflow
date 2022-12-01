import { InjectionToken } from '@angular/core';
import { Observable } from 'rxjs';
import { MessageResponse } from 'src/app/model/MessageResponse';
import { UserData } from 'src/app/model/UserData';

const DESC = 'user_factory_desc';

export const LOGIN_RESPONSE = 'LOGIN_RESPONSE';
export const LOGOUT_RESPONSE = 'LOGOUT_RESPONSE';
export const CHECK_RESPONSE = 'CHECK_RESPONSE';
export const REGISTER_RESPONSE = 'REGISTER_RESPONSE';

export const userActionFactoryToken: InjectionToken<UserActionFactory> =
  new InjectionToken<UserActionFactory>(DESC);

export interface UserActionFactory {
  login(username: string, passwod: string): Observable<UserData>;
  logout(): Observable<MessageResponse>;
  check(): Observable<UserData>;
  register(username: string, password: string, role: string): Observable<UserData>;
}
