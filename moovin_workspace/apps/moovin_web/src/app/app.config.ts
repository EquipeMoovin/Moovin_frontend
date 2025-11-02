import {
  ApplicationConfig,
  provideBrowserGlobalErrorListeners,
  provideZoneChangeDetection,
} from '@angular/core';
import { provideRouter } from '@angular/router';
import { appRoutes } from './app.routes';
import { HTTP_INTERCEPTORS,provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import { provideAnimations } from '@angular/platform-browser/animations';
import { AuthInterceptor } from './services/auth/auth.interceptor';
import { providePrimeNG } from 'primeng/config';
import  Preset  from '../theme/preset';
export const appConfig: ApplicationConfig = {
  providers: [
    
    { provide: HTTP_INTERCEPTORS, useClass: AuthInterceptor, multi: true },
    provideBrowserGlobalErrorListeners(),
    provideAnimations(),
    provideAnimationsAsync(),
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(appRoutes),
    provideHttpClient(withInterceptorsFromDi()),
    providePrimeNG({
      ripple:true,
      theme:{
        preset: Preset,
        options:{
          darkModeSelector: false,
        }
      }
    }),
  ],
};
