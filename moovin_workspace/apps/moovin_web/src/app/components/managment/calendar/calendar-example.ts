import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Calendar, DayData } from './calendar';
import { VisitsService } from '../../../services/visits/visits.service';
import { Visit } from '../../../interfaces/calendar/visits/visits.interface';
import { take } from 'rxjs';

/**
 * Interface estendida para informações do dia selecionado
 */
interface SelectedDayInfo extends DayData {
  name?: string;
  time?: string;
  immobile?: string;
  notes?: string;
}

@Component({
  selector: 'app-calendar-example',
  standalone: true,
  imports: [CommonModule, Calendar],
  template: `
    <div class="p-8 max-w-4xl mx-auto">
      <app-calendar
        [dayData]="calendarData"
        [startOfWeek]="1"
        (dayClick)="onDayClick($event)"
        (monthChange)="onMonthChange($event)"
      ></app-calendar>

      <div class="mt-8 p-6 bg-gray-100 rounded-lg" *ngIf="selectedDayInfo">
        <h3 class="text-lg font-semibold mb-3">Dia Selecionado:</h3>
        <p class="mb-2"><strong>Data:</strong> {{ selectedDayInfo.date }}</p>
        <p class="mb-2"><strong>Cliente:</strong> {{ selectedDayInfo.name || 'Nenhum' }}</p>
        <p class="mb-2"><strong>Horário:</strong> {{ selectedDayInfo.time || 'Não definido' }}</p>
        <p class="mb-2"><strong>Imóvel:</strong> {{ selectedDayInfo.immobile || 'Não informado' }}</p>
        <p class="mb-2"><strong>Status:</strong> {{ selectedDayInfo.status || 'Não definido' }}</p>
        <p class="mb-2"><strong>Observações:</strong> {{ selectedDayInfo.notes || 'Nenhuma' }}</p>
      </div>
    </div>
  `
})
export class CalendarExample implements OnInit {
  calendarData: DayData[] = [];
  selectedDayInfo: SelectedDayInfo | null = null;
  currentMonth = new Date().getMonth();
  currentYear = new Date().getFullYear();

  private visits: Visit[] = [];
  private visitsService = inject(VisitsService);

  ngOnInit() {
    this.loadAllVisits();
  }

  onDayClick(dateString: string): void {
    console.log('Dia clicado:', dateString);

    const selectedVisit = this.visits.find(visit => visit.date === dateString);
    
    if (selectedVisit) {
      this.selectedDayInfo = {
        date: dateString,
        status: selectedVisit.status,
        name: selectedVisit.name,
        time: selectedVisit.time,
        immobile: selectedVisit.immobile,
        notes: selectedVisit.notes
      };
    } else {
      this.selectedDayInfo = {
        date: dateString,
        status: undefined,
        name: undefined,
        time: undefined,
        immobile: undefined,
        notes: undefined
      };
    }
  }

  onMonthChange(monthInfo: { month: number; year: number }): void {
    console.log(` Mês alterado para ${monthInfo.month + 1}/${monthInfo.year}`);
    this.currentMonth = monthInfo.month;
    this.currentYear = monthInfo.year;
    this.updateCalendarForMonth(monthInfo.month, monthInfo.year);
  }

  private updateCalendarForMonth(month: number, year: number): void {
    this.calendarData = this.mapVisitsToDayData(this.visits, month, year);
    console.log('📅 Dados do calendário atualizados:', this.calendarData);
  }
 
  private loadAllVisits(): void {
    console.log('🔄 Carregando visitas do backend...');
    this.visitsService.getVisits().pipe(take(1)).subscribe({
      next: (response) => {
        this.visits = response;
        console.log(`✅ ${this.visits.length} visitas carregadas.`);
        this.updateCalendarForMonth(this.currentMonth, this.currentYear);
      },
      error: (err) => console.error('❌ Erro ao carregar visitas:', err)
    });
  }


  /**
   * Converte Visit[] -> DayData[]
   */
  private mapVisitsToDayData(visits: Visit[], month: number, year: number): DayData[] {
    return visits
      .filter(v => {
        const [y, m] = v.date.split('-').map(Number);
        return m - 1 === month && y === year;
      })
      .map(v => ({
        date: v.date,
        status: this.normalizeStatus(v.status),
        name: v.name,
        color: this.getColorByStatus(v.status)
      }));
  }

  /**
   * Define cores baseadas no status
   */
  private getColorByStatus(status?: string): string {
    switch (status) {
      case 'pending': return '#f59e0b';  
      case 'confirmed': return '#22c55e';     
      case 'canceled': return '#ef4444';     
      default: return '#9ca3af';             
    }
  }
  private normalizeStatus(status?: string): string {
    switch (status) {
      case 'confirmed': return 'confirmada';
      case 'in_progress': return 'em andamento';
      case 'done': return 'concluída';
      case 'cancelled': return 'cancelada';
      default: return status || 'indefinido';
    }
  }
}
