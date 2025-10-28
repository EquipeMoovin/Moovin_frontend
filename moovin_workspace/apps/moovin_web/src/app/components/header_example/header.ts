import { Component, inject,HostBinding } from '@angular/core';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { MenubarModule } from 'primeng/menubar';
import { MenuItem } from 'primeng/api'
@Component({
  selector: 'app-header-example',
  standalone: true,
  imports: [CommonModule,MenubarModule],
  templateUrl: './header.html',
})
export class Header_example {
    router = inject(Router);
    items = [
        { label: 'Home', command: () => { console.log('Home clicked'); } },
        { label: 'Saiba mais', command: () => { console.log('Profile clicked'); } },
        { label: 'Serviços', command: () => { console.log('Services clicked'); } },
        { label: 'Contato', command: () => { console.log('contact clicked'); }}
    ];
    
    @HostBinding('class.dark-mode') get darkMode() {
        return window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
    }
}
