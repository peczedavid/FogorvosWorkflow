import { Action } from '@ngrx/store';

export interface CoreStateAction<T> extends Action {
  type: string;
  payload?: T;
}
