import { inject, Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
  HttpErrorResponse,
} from '@angular/common/http';
import { Observable, throwError, BehaviorSubject } from 'rxjs';
import { catchError, filter, switchMap, take } from 'rxjs/operators';
import { Router } from '@angular/router';
import { AuthService } from './auth.service';
import { env } from '@env';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {
  private authService = inject(AuthService);
  private router = inject(Router);

  private isRefreshing = false;
  private refreshTokenSubject = new BehaviorSubject<string | null>(null);

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    const token = this.authService.getAccessToken();

    const publicEndpoints = [`${env.apiUrl}/users/token`];
    const isPublic = publicEndpoints.some(url => request.url.startsWith(url));

    const headers: Record<string, string> = {};
    if (!(request.body instanceof FormData)) headers['Content-Type'] = 'application/json';
    if (!isPublic && token) headers['Authorization'] = `Bearer ${token}`;

    const modifiedRequest = Object.keys(headers).length > 0
      ? request.clone({ setHeaders: headers })
      : request;

    return next.handle(modifiedRequest).pipe(
      catchError((error: HttpErrorResponse) => {
        if (error.status === 401 && !isPublic) {
          return this.handle401Error(modifiedRequest, next);
        }
        return throwError(() => error);
      })
    );
  }

  private handle401Error(request: HttpRequest<any>, next: HttpHandler) {
    if (!this.isRefreshing) {
      this.isRefreshing = true;
      this.refreshTokenSubject.next(null);

      return this.authService.refreshToken().pipe(
        switchMap((tokens) => {
          this.isRefreshing = false;
          this.refreshTokenSubject.next(tokens.access);
          return next.handle(
            request.clone({
              setHeaders: { Authorization: `Bearer ${tokens.access}` },
            })
          );
        }),
        catchError((error) => {
          this.isRefreshing = false;
          this.authService.logout();
          this.router.navigate(['/login'], { queryParams: { expired: true } });
          return throwError(() => error);
        })
      );
    } else {
      // Espera até que o refresh complete antes de continuar
      return this.refreshTokenSubject.pipe(
        filter((token) => token !== null),
        take(1),
        switchMap((token) =>
          next.handle(
            request.clone({
              setHeaders: { Authorization: `Bearer ${token}` },
            })
          )
        )
      );
    }
  }
}
