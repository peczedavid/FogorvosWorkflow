export interface UserData {
  username: string;
}

export interface CheckResponse {
  userData: UserData;
  loggedIn: boolean;
}

export interface LoginRequest {
  username: string;
  password: string;
}
