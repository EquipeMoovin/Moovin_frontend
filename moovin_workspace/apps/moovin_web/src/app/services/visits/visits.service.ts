import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, tap } from 'rxjs';
import { env } from '@env';
import { Visit, CreateVisitData, ApiResponse  } from '../../interfaces/calendar/visits/visits.interface';

@Injectable({ providedIn: 'root' })
export class VisitsService {
    private apiUrl = `${env.apiUrl}/visits/visits`;
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

    getVisits(): Observable<Visit[]> {
        const headers = this.getAuthHeaders();
        
        return this.http.get<Visit[]>(this.apiUrl, { headers }).pipe(
            tap(response => console.log('Visitas carregadas:', response))
        );
    }

    postVisit(visitData: CreateVisitData): Observable<ApiResponse<Visit>> {
        const headers = this.getAuthHeaders();
        return this.http.post<ApiResponse<Visit>>(this.apiUrl, visitData, { headers }).pipe(
            tap(response => console.log('Visita criada:', response))
        );
    }

    getVisitById(id: string | number): Observable<ApiResponse<Visit>> {
        const headers = this.getAuthHeaders();
        
        return this.http.get<ApiResponse<Visit>>(`${this.apiUrl}/${id}`, { headers }).pipe(
            tap(response => console.log('Visita carregada:', response))
        );
    }

    updateVisit(id: string | number, visitData: Partial<CreateVisitData>): Observable<ApiResponse<Visit>> {
        const headers = this.getAuthHeaders();
        
        return this.http.put<ApiResponse<Visit>>(`${this.apiUrl}/${id}`, visitData, { headers }).pipe(
            tap(response => console.log('Visita atualizada:', response))
        );
    }
    
    deleteVisit(id: string | number): Observable<ApiResponse<{ deleted: boolean }>> {
        const headers = this.getAuthHeaders();
        
        return this.http.delete<ApiResponse<{ deleted: boolean }>>(`${this.apiUrl}/${id}`, { headers }).pipe(
            tap(response => console.log('Visita removida:', response))
        );
    }
}
    