export interface Visit {
    id?: string | number;
    name: string;                
    date: string;                
    time: string;                
    immobile: string;             
    status: 'agendada' | 'em_andamento' | 'concluida' | 'cancelada';
    notes?: string;              
    createdAt?: string;           
    updatedAt?: string;      
}

export interface CreateVisitData {
    name: string;                 
    date: string;                 
    time: string;                
    immobile: string;          
    status?: 'agendada' | 'em_andamento' | 'concluida' | 'cancelada';
    notes?: string;
}

export interface ApiResponse<T> {
    success: boolean;             
    data: T;                      
    message?: string;      
}
