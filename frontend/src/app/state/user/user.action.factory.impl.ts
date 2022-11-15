import { Injectable } from '@angular/core';
import { Store } from '@ngrx/store';
import { Observable, Subscriber } from 'rxjs';
import { MessageResponse } from 'src/app/model/MessageResponse';
import { UserData } from 'src/app/model/UserData';
import { UserService } from 'src/app/services/user.service';
import {
  CHECK_RESPONSE,
  LOGIN_RESPONSE,
  LOGOUT_RESPONSE,
  UserActionFactory
} from './user.action.factory';

@Injectable()
export class UserActionFactoryImpl implements UserActionFactory {
  constructor(
    private userService: UserService,
    private ngrxStore: Store<any>
  ) {}

  login(username: string, passwod: string): Observable<UserData> {
    return new Observable<UserData>((subscriber: Subscriber<any>) => {
      this.userService
        .login(username, passwod)
        .subscribe((userData: UserData) => {
          this.ngrxStore.dispatch({
            type: LOGIN_RESPONSE,
            payload: userData,
          });
          subscriber.next(userData);
          subscriber.complete();
        });
      return function unsubscribe() {};
    });
  }

  logout(): Observable<MessageResponse> {
    return new Observable<MessageResponse>((subscriber: Subscriber<any>) => {
      this.userService
        .logout()
        .subscribe((messageResponse: MessageResponse) => {
          this.ngrxStore.dispatch({
            type: LOGOUT_RESPONSE,
            payload: messageResponse,
          });
          subscriber.next(messageResponse);
          subscriber.complete();
        });
      return function unsubscribe() {};
    });
  }

  check(): Observable<UserData> {
    return new Observable<UserData>((subscriber: Subscriber<any>) => {
      this.userService.check().subscribe((userData: UserData) => {
        this.ngrxStore.dispatch({
          type: CHECK_RESPONSE,
          payload: userData,
        });
        subscriber.next(userData);
        subscriber.complete();
      });
      return function unsubscribe() {};
    });
  }
}
