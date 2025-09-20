import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/injection.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '/../app.dart'; // Para MyApp.router

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificação de Email'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is EmailVerified) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Verificação concluída! Redirecionando...')),
            );
            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                MyApp.router.go('/dashboard');
              }
            });
          } else if (state is EmailVerificationError) {
            // Erro na verificação, exibe SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Insira o código de 6 dígitos recebido no email',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _codeController,
                      decoration: const InputDecoration(
                        labelText: 'Código de Verificação',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Código é obrigatório';
                        }
                        if (value.length != 6) {
                          return 'Código deve ter 6 dígitos';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    state is Verifying
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<AuthBloc>().add(
                                      VerifyEmailSubmitted(_codeController.text.trim()),
                                    );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6D472F), // Cor do botão
                              foregroundColor: Colors.white, // Cor do texto
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text('Verificar'),
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
}