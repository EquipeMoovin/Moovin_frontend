import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Header_example } from '../header_example/header';
import { CalendarExample } from './calendar/calendar-example';


@Component({
    selector: 'app-managment',
    standalone: true,
    imports: [CommonModule,Header_example,CalendarExample],
    templateUrl: './managment.html',
    styleUrls: ['./managment.scss']

})

export class Managment {
    private router = inject(Router);
    constructor(){ /* empty */ }
}