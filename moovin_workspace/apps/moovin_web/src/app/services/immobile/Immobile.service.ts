import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, tap } from 'rxjs';
import { env } from '@env';
import { Immobile } from '../../interfaces/immobile/immobile.interface';

@Injectable({ providedIn: 'root' })
export class ImmobileService {
    private apiUrl = `${env.apiUrl}/immobile`;
    private http = inject(HttpClient);

    private getAuthToken(): string | null {
        if (typeof window !== 'undefined') {
            return localStorage.getItem('accessToken');
        }
        return null;
    }
    private getAuthHeaders(): HttpHeaders {
        const token = this.getAuthToken();
        let headers = new HttpHeaders({
            'Content-Type': 'application/json' 
        });
        if (token) {
            headers = headers.set('Authorization', `Bearer ${token}`);
        }
        return headers;
    }
    getMyImmobiles(): Observable<Immobile[]> {
        const headers = this.getAuthHeaders();
        return this.http.get<Immobile[]>(`${this.apiUrl}/me`, { headers }).pipe(
            tap(response => console.log('Meus imóveis carregados:', response))
        );
    }
}