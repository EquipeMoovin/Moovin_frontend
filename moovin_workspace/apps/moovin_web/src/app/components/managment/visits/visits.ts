import { Component, inject, OnInit} from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';

import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { HeaderComponent } from 'app/components/header/header';

import { VisitsService } from '../../../services/visits/visits.service';
import { ImmobileService } from '../../../services/immobile/Immobile.service';
import { Immobile } from '../../../interfaces/immobile/immobile.interface';

import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { AutoCompleteModule } from 'primeng/autocomplete';
import { MessageModule } from 'primeng/message';

interface ImmobileListItem {
  id: number;
  property_type: string;
  city: string;
  state: string;
  label: string; 
}

@Component({
    selector: 'app-visits',
    standalone: true,
    imports: [HeaderComponent,CommonModule, ButtonModule, ReactiveFormsModule, AutoCompleteModule, MessageModule, InputTextModule],
    templateUrl: './visits.html',
    styleUrls: ['./visits.scss']
})

export class Visits implements OnInit {
    private router = inject(Router);
    private fb = inject(FormBuilder);
    private visitsService = inject(VisitsService);
    private immobileService = inject(ImmobileService);

    immobiles: ImmobileListItem[] = [];
    filteredImmobiles: ImmobileListItem[] = [];
    
    ngOnInit() {
        this.loadImmobiles();
    }

    private loadImmobiles() {
        this.immobileService.getMyImmobiles().subscribe({
        next: (immobiles) => {
            this.immobiles = immobiles.map(i => this.mapToListItem(i));
            this.filteredImmobiles = [...this.immobiles]; // Cópia inicial
        },
        error: (err) => {
            console.error('Error loading immobiles:', err);
        }
        });
    }

    messages: { text: string; type: 'error' | 'success' }[] = [];
    visitForm: FormGroup;
    isLoading = false;
    submitted = false;
   
    constructor () {
        this.visitForm = this.fb.group({
            visitorName: ['', [Validators.required]],
            visitDate: ['', [Validators.required]],
            visitTime: ['', [Validators.required]],
            immobile: ['', [Validators.required]],
            status: ['confirmed'],
            notes: [''],
        });
    }

    onSubmit(){
        this.submitted = true;
        console.log('Form submitted:', this.visitForm.invalid);
        if (this.visitForm.invalid) {
                console.warn('Form invalid, abort submit');
                return;
        }
        const formValue = this.visitForm.value;
        const payload = {
            name: formValue.visitorName,
            date: formValue.visitDate,
            time: formValue.visitTime,
            immobile: typeof formValue.immobile === 'object' ? formValue.immobile.id : Number(formValue.immobile),
            status: formValue.status,
            notes: formValue.notes || null
        };
        console.log('Payload to send:', payload);
        this.isLoading = true;
        this.visitsService.postVisit(payload).subscribe({
            next: () => {
                this.isLoading = false;
                this.messages = [{ text: 'Visita criada com sucesso!', type: 'success' }];
                this.router.navigate(['/managment']);
                this.visitForm.reset();
                this.submitted = false;
            },
            error: (err) => {
                this.isLoading = false;
                console.error('Error creating visit:', err);
                this.messages = [{ text: 'Erro ao criar visita. Tente novamente.', type: 'error' }];
            }
        });
    }

    isInvalid(controlName: string): boolean {
        const control = this.visitForm.get(controlName);
        return !!(this.submitted && control && control.invalid);
    }

    searchImmobile(event: { query: string }) {
        const q = (event.query || '').toLowerCase();
        this.filteredImmobiles = this.immobiles.filter(i => i.label.toLowerCase().includes(q));
    }

    private mapToListItem(i: Immobile): ImmobileListItem {
        const propertyType = i.property_type ?? '';
        const city = i.city ?? '';
        const state = i.state ?? '';
        
        return {
            id: i.id_immobile,
            property_type: propertyType,
            city,
            state,
            label: `${propertyType} em ${this.titleCase(city)} - ${this.titleCase(state)}`
        };
    }

    private titleCase(value: string): string {
        if (!value) return '';
        return value
        .split(' ')
        .filter(p => p.length > 0)
        .map(word => word[0].toUpperCase() + word.slice(1).toLowerCase())
        .join(' ');
    }

}