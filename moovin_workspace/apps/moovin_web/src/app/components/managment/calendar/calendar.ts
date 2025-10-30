import { Component, inject, Input, Output, EventEmitter, OnInit, OnChanges, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { ButtonModule } from 'primeng/button';
import { FormsModule } from '@angular/forms';


export interface DayData {
  date: string; 
  status?: string;
  color?: string;
}

export interface CalendarDay {
  date: Date;
  dayNumber: number;
  isCurrentMonth: boolean;
  isToday: boolean;
  isSelected: boolean;
  dayData?: DayData;
}

type StartOfWeek = 0 | 1;

@Component({
    selector: 'app-calendar',
    standalone: true,
    imports: [CommonModule, ButtonModule, FormsModule],
    templateUrl: './calendar.html',
    styleUrls: ['./calendar.scss']
})
export class Calendar implements OnInit, OnChanges {
    private router = inject(Router);

    // Inputs do componente
    @Input() dayData: DayData[] = [];
    @Input() startOfWeek: StartOfWeek = 1; // Padrão: Segunda-feira

    // Outputs do componente
    @Output() dayClick = new EventEmitter<string>();
    @Output() monthChange = new EventEmitter<{ month: number; year: number }>();

    // Propriedades do calendário
    currentMonth: number = new Date().getMonth();
    currentYear: number = new Date().getFullYear();
    today: Date = new Date();
    selectedDay: string | null = null;

    // Matriz de semanas (6x7 = 42 dias)
    weeks: CalendarDay[][] = [];

    // Arrays para dropdowns
    months = [
        { label: 'Janeiro', value: 0 },
        { label: 'Fevereiro', value: 1 },
        { label: 'Março', value: 2 },
        { label: 'Abril', value: 3 },
        { label: 'Maio', value: 4 },
        { label: 'Junho', value: 5 },
        { label: 'Julho', value: 6 },
        { label: 'Agosto', value: 7 },
        { label: 'Setembro', value: 8 },
        { label: 'Outubro', value: 9 },
        { label: 'Novembro', value: 10 },
        { label: 'Dezembro', value: 11 }
    ];

    years = Array.from({ length: 11 }, (_, i) => {
        const y = new Date().getFullYear() - 5 + i;
        return { label: y.toString(), value: y };
    });

    // Nomes dos dias da semana
    weekDays = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];

    ngOnInit(): void {
        this.generateCalendar(this.currentYear, this.currentMonth);
    }

    ngOnChanges(changes: SimpleChanges): void {
        if (changes['dayData']) {
            this.generateCalendar(this.currentYear, this.currentMonth);
        }
    }
    
    get monthName(): string {
        return this.months[this.currentMonth].label;
    }

    /**
     * Getter para o ano atual
     */
    get year(): number {
        return this.currentYear;
    }

    /**
     * Gera a matriz de calendário para o mês e ano especificados
     */
    generateCalendar(year: number, month: number): void {
        this.weeks = [];
        
        // Primeiro dia do mês
        const firstDay = new Date(year, month, 1);
        
        // Calcular o primeiro dia a ser exibido no calendário
        const startDate = new Date(firstDay);
        const firstDayOfWeek = firstDay.getDay();
        const daysToSubtract = this.startOfWeek === 0 
            ? firstDayOfWeek 
            : (firstDayOfWeek === 0 ? 6 : firstDayOfWeek - 1);
        
        startDate.setDate(firstDay.getDate() - daysToSubtract);

        // Gerar 6 semanas (42 dias)
        for (let week = 0; week < 6; week++) {
            const weekDays: CalendarDay[] = [];
            
            for (let day = 0; day < 7; day++) {
                const currentDate = new Date(startDate);
                currentDate.setDate(startDate.getDate() + (week * 7) + day);
                
                const calendarDay: CalendarDay = {
                    date: currentDate,
                    dayNumber: currentDate.getDate(),
                    isCurrentMonth: currentDate.getMonth() === month,
                    isToday: this.isSameDay(currentDate, this.today),
                    isSelected: this.selectedDay === this.formatDate(currentDate),
                    dayData: this.getDayData(currentDate)
                };
                
                weekDays.push(calendarDay);
            }
            
            this.weeks.push(weekDays);
        }
    }

    /**
     * Avança para o próximo mês
     */
    nextMonth(): void {
        if (this.currentMonth === 11) {
            this.currentMonth = 0;
            this.currentYear++;
        } else {
            this.currentMonth++;
        }
        
        this.updateCalendar();
    }

    /**
     * Retrocede para o mês anterior
     */
    previousMonth(): void {
        if (this.currentMonth === 0) {
            this.currentMonth = 11;
            this.currentYear--;
        } else {
            this.currentMonth--;
        }
        
        this.updateCalendar();
    }

    /**
     * Seleciona um dia e emite o evento
     */
    selectDay(day: CalendarDay): void {
        if (!day.isCurrentMonth) return;
        
        const dateString = this.formatDate(day.date);
        
        // Otimização: só regenera se a seleção mudou
        if (this.selectedDay !== dateString) {
            this.selectedDay = dateString;
            this.updateCalendar();
        }
        
        this.dayClick.emit(dateString);
    }

    /**
     * Muda o mês via dropdown
     */
    onMonthChange(selectedMonth: number): void {
        this.currentMonth = selectedMonth;
        this.updateCalendar();
    }

    /**
     * Muda o ano via dropdown
     */
    onYearChange(selectedYear: number): void {
        this.currentYear = selectedYear;
        this.updateCalendar();
    }

    /**
     * Atualiza o calendário e emite eventos - método centralizado
     */
    private updateCalendar(): void {
        this.generateCalendar(this.currentYear, this.currentMonth);
        this.emitMonthChange();
    }

    /**
     * Emite o evento de mudança de mês
     */
    private emitMonthChange(): void {
        this.monthChange.emit({ 
            month: this.currentMonth, 
            year: this.currentYear 
        });
    }

    /**
     * Verifica se duas datas são o mesmo dia
     */
    private isSameDay(date1: Date, date2: Date): boolean {
        return date1.getDate() === date2.getDate() &&
               date1.getMonth() === date2.getMonth() &&
               date1.getFullYear() === date2.getFullYear();
    }

    /**
     * Formata uma data no formato YYYY-MM-DD
     */
    private formatDate(date: Date): string {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    }

    /**
     * Obtém os metadados para uma data específica
     */
    private getDayData(date: Date): DayData | undefined {
        const dateString = this.formatDate(date);
        return this.dayData.find(data => data.date === dateString);
    }

    /**
     * Obtém as classes CSS para um dia
     */
    getDayClasses(day: CalendarDay): string {
        const classes = [
            'w-12 h-12 flex items-center justify-center rounded-full cursor-pointer transition-all duration-200',
            'hover:bg-gray-100 text-base font-medium'
        ];

        if (!day.isCurrentMonth) {
            classes.push('text-gray-300');
        } else {
            classes.push('text-gray-700');
        }

        if (day.isToday) {
            classes.push('ring-2 ring-emerald-500/60 bg-emerald-50');
        }

        if (day.isSelected) {
            classes.push('bg-blue-500 text-white hover:bg-blue-600');
        }

        return classes.join(' ');
    }

    /**
     * Obtém o estilo inline para um dia
     */
    getDayStyle(day: CalendarDay): { [key: string]: string } {
        const style: { [key: string]: string } = {};
        
        if (day.dayData?.color && !day.isSelected && !day.isToday) {
            style['background-color'] = day.dayData.color;
            style['color'] = this.getContrastColor(day.dayData.color);
        }
        
        return style;
    }

    /**
     * Calcula a cor do texto baseada no contraste com a cor de fundo
     */
    private getContrastColor(backgroundColor: string): string {
        // Remove o # se presente
        const color = backgroundColor.replace('#', '');
        
        // Converte para RGB
        const r = parseInt(color.substr(0, 2), 16);
        const g = parseInt(color.substr(2, 2), 16);
        const b = parseInt(color.substr(4, 2), 16);
        
        // Calcula a luminância
        const luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255;
        
        return luminance > 0.5 ? '#000000' : '#ffffff';
    }

    /**
     * Obtém dados únicos para exibir na legenda
     */
    getUniqueDayData(): DayData[] {
        const uniqueData: DayData[] = [];
        const seenStatuses = new Set<string>();

        this.dayData.forEach(data => {
            if (data.status && !seenStatuses.has(data.status)) {
                seenStatuses.add(data.status);
                uniqueData.push(data);
            }
        });

        return uniqueData;
    }

}
