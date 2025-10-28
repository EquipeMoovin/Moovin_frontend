import { Injectable,inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, tap } from 'rxjs';
import { env } from '@env';
import { TokenResponse } from '../../interfaces/auth/TokenResponse';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private apiUrl = `${env.apiUrl}/users/token`;

  private http = inject(HttpClient);

  login(credentials: { email: string; password: string }): Observable<TokenResponse> {
    return this.http.post<TokenResponse>(this.apiUrl, credentials).pipe(
      tap((tokens) => {
        this.saveTokens(tokens);
      })
    );
  }

  saveTokens(tokens: TokenResponse): void {
    localStorage.setItem('access_token', tokens.access);
    localStorage.setItem('refresh_token', tokens.refresh);
  }

  getAccessToken(): string | null {
    return localStorage.getItem('access_token');
  }

  getRefreshToken(): string | null {
    return localStorage.getItem('refresh_token');
  }

  logout(): void {
    localStorage.removeItem('access_token');
    localStorage.removeItem('refresh_token');
  }

  refreshToken(): Observable<TokenResponse> {
    const refresh = this.getRefreshToken();
    return this.http.post<TokenResponse>(`${this.apiUrl}/users/token/refresh`, { refresh }).pipe(
      tap((tokens) => {
        if (tokens.access) {
          localStorage.setItem('access_token', tokens.access);
        }
      })
    );
  }
}
