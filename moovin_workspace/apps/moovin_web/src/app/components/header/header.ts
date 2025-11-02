
import { Component, inject,HostBinding } from '@angular/core';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { MenubarModule } from 'primeng/menubar';
import { BadgeModule } from 'primeng/badge';
@Component({
  selector: 'app-header',
  standalone: true,
  imports: [CommonModule,MenubarModule,BadgeModule],
  templateUrl: './header.html',
  styleUrls: ['./header.scss'],
})
export class HeaderComponent{
    router = inject(Router);
    items = [
        { label: 'Adicionar imóvel', command: () => { console.log('Home clicked'); } },
        { label: 'Gerenciar imóveis', command: () => { console.log('Profile clicked'); } },
        { label: 'Relatórios e Estatísticas', command: () => { console.log('Services clicked'); } },

    ];

    immobileDetailsNavigate() {
        this.router.navigate(['/immobile-details']);
    }
    addImmobileNavigate() {
        this.router.navigate(['/add-immobile']);
    }
    chartsNavigate() {
        this.router.navigate(['/charts']);
    }
    
    
    @HostBinding('class.dark-mode') get darkMode() {
        return window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
    }


}