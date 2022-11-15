import { createFeatureSelector } from '@ngrx/store';
import { UserData } from 'src/app/model/UserData';

export const USER_STATE_NAME = 'user';

export interface UserState {
  currentUser?: UserData;
}

export const selectUserState =
  createFeatureSelector<UserState>(USER_STATE_NAME);
