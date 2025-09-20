import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '/../../app.dart';  

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedUserType = 'inquilino';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            
            Future.delayed(const Duration(seconds: 2), () {
              MyApp.router.go('/verify');
            });
          } else if (state is RegisterError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) => (value?.isEmpty ?? true) || !value!.contains('@') ? 'Email inválido' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Nome Completo'),
                      validator: (value) => (value?.isEmpty ?? true) ? 'Nome obrigatório' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedUserType,
                      decoration: const InputDecoration(labelText: 'Tipo de Usuário'),
                      items: const [
                        DropdownMenuItem(value: 'inquilino', child: Text('Inquilino')),
                        DropdownMenuItem(value: 'proprietario', child: Text('Proprietário')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedUserType = value!;
                        });
                      },
                      validator: (value) => value == null ? 'Selecione um tipo' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Senha'),
                      validator: (value) => (value?.isEmpty ?? true) || (value!.length < 6) ? 'Senha mínima 6 caracteres' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                      validator: (value) => (value != _passwordController.text) ? 'Senhas não conferem' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          final userData = {
                            'email': _emailController.text.trim(),
                            'name': _nameController.text.trim(),
                            'password': _passwordController.text,
                            'user_type': _selectedUserType,
                          };
                          
                          context.read<AuthBloc>().add(
                                RegisterSubmitted(userData),
                              );
                        }
                      },
                      child: const Text('Registrar'),
                    ),
                    TextButton(
                      onPressed: () => MyApp.router.go('/login'),
                      child: const Text('Já tem conta? Faça login'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}