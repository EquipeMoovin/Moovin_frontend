import { Component } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
@Component({
  selector: 'app-login',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    RouterModule,
  ],
  templateUrl: './login.html',
  styleUrls: ['./login.scss']
})

export class Login {
  
  messages: { text: string; type: 'error' | 'success' }[] = [];
  loginForm: FormGroup;
  // eslint-disable-next-line @angular-eslint/prefer-inject
  constructor(private fb: FormBuilder) {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required]]
    });
  }
  onSubmit() {
    if (this.loginForm.valid) {
      this.messages = [
        { text: 'Login realizado com sucesso!', type: 'success' }
      ];
      console.log('Login data:', this.loginForm.value);
    } else {
      this.messages = [
        { text: 'Preencha todos os campos corretamente.', type: 'error' }
      ];
      this.loginForm.markAllAsTouched();
    }
  }

  isInvalid(fieldName: string): boolean {
    const field = this.loginForm.get(fieldName);
    return !!(field && field.invalid && (field.dirty || field.touched));
  }
}
