import { CoreStateAction } from 'src/app/model/CoreStateAction';
import { MessageResponse } from 'src/app/model/MessageResponse';
import { UserData } from 'src/app/model/UserData';
import {
  CHECK_RESPONSE,
  LOGIN_RESPONSE,
  LOGOUT_RESPONSE
} from './user.action.factory';
import { UserState } from './user.state.model';

export function userReducer(
  userState: UserState,
  action: CoreStateAction<any>
): UserState {
  if (!userState) {
    userState = {
      currentUser: undefined,
    };
  }
  switch (action.type) {
    case LOGIN_RESPONSE:
      return loginResponse(userState, action.payload);
    case LOGOUT_RESPONSE:
      return logoutRespone(userState, action.payload);
    case CHECK_RESPONSE:
      return checkResponse(userState, action.payload);
    default:
      return userState;
  }
}

function loginResponse(userState: UserState, userData: UserData): UserState {
  const changes: UserState = {
    currentUser: userData,
  };
  return changeState(userState, changes);
}

function logoutRespone(
  userState: UserState,
  messageResponse: MessageResponse
): UserState {
  const changes: UserState = {
    currentUser: undefined,
  };
  return changeState(userState, changes);
}

function checkResponse(userState: UserState, userData: UserData): UserState {
  const changes: UserState = {
    currentUser: userData == null ? undefined : userData,
  };
  return changeState(userState, changes);
}

function changeState(originalState: UserState, changes: UserState): UserState {
  return Object.assign({}, originalState, changes);
}
