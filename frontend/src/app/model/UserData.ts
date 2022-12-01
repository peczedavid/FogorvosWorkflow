export interface UserData {
  id: string;
  username: string;
  role: string;
}

export interface LoginRequest {
  username: string;
  password: string;
}

export const ROLE_USER = 'ROLE_USER';
export const ROLE_RECEPTIONIST = 'ROLE_RECEPTIONIST';
export const ROLE_AMDIN = 'ROLE_AMDIN';
