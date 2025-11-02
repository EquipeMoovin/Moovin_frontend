import { Route } from '@angular/router';
import { Login } from './components/auth/login/login';
import { Managment } from './components/managment/managment';
import { Visits } from './components/managment/visits/visits';


export const appRoutes: Route[] = [
    { path: 'login', component: Login },
    { path: 'register', component: Login }, // Temporário - substituir pelo componente de registro
    { path: 'managment',component: Managment},
    { path: 'add-visit', component: Visits },
];
