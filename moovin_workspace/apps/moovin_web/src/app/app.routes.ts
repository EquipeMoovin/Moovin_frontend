import { Route } from '@angular/router';
import { Login } from './components/auth/login/login';

export const appRoutes: Route[] = [
    { path: '', redirectTo: '/login', pathMatch: 'full' },
    { path: 'login', component: Login },
    { path: 'register', component: Login }, // Temporário - substituir pelo componente de registro
];
