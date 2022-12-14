export interface Role {
  id: string;
  name: string;
}

export const ROLE_USER = 'ROLE_USER';
export const ROLE_RECEPTIONIST = 'ROLE_RECEPTIONIST';
export const ROLE_ADMIN = 'ROLE_ADMIN';

export function mapRoleToReadableName(role: string): string {
  switch (role) {
    case ROLE_USER:
      return 'Felhasználó';
    case ROLE_RECEPTIONIST:
      return 'Recepciós';
    case ROLE_ADMIN:
      return 'Admin';
  }
  return 'Hibás szerepkör';
}