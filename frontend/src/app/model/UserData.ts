export interface UserData {
  id: string,
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
