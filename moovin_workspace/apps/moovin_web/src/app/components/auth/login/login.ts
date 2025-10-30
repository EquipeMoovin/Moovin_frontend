import { Component, inject } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { AuthService } from '../../../services/auth/auth.service'; // <-- import do serviço

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './login.html',
  styleUrls: ['./login.scss']
})
export class Login {
  private router = inject(Router);
  private authService = inject(AuthService);
  private fb = inject(FormBuilder);

  messages: { text: string; type: 'error' | 'success' }[] = [];
  loginForm: FormGroup;
  isLoading = false;

  constructor() {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required]],
    });
  }

  onSubmit() {
    if (this.loginForm.invalid) {
      this.messages = [{ text: 'Preencha todos os campos corretamente.', type: 'error' }];
      this.loginForm.markAllAsTouched();
      return;
    }

    this.isLoading = true;
    const { email, password } = this.loginForm.value;

    this.authService.login({ email, password }).subscribe({
      next: (res) => {
        this.isLoading = false;
        this.messages = [{ text: 'Login realizado com sucesso!', type: 'success' }];
        console.log('Tokens recebidos:', res);

        setTimeout(() => this.router.navigate(['/managment']), 800);
      },
      error: (err) => {
        this.isLoading = false;
        console.error('Erro no login:', err);

        const msg =
          err.status === 401
            ? 'Credenciais inválidas.'
            : 'Erro ao conectar com o servidor.';

        this.messages = [{ text: msg, type: 'error' }];
      },
    });
  }

  isInvalid(fieldName: string): boolean {
    const field = this.loginForm.get(fieldName);
    return !!(field && field.invalid && (field.dirty || field.touched));
  }
}
